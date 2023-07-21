import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sixth_app/data/categories.dart';
import 'package:sixth_app/data/dummy_items.dart';
import 'package:sixth_app/models/grocery_item.dart';
import 'package:sixth_app/screen/new_item.dart';
import 'package:http/http.dart' as http;

class Groceries extends ConsumerStatefulWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  ConsumerState<Groceries> createState() => _GroceriesState();
}

class _GroceriesState extends ConsumerState<Groceries> {
  late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https('project-practice-57f49-default-rtdb.firebaseio.com',
        'shopping-list.json');

      final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch grocery items.');
    }

    if(response.body == 'null'){
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> _loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere((element) => element.value.kind == item.value['category'])
          .value;
      _loadedItems.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category),
      );
    }
    return _loadedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newItem = await Navigator.of(context).push<GroceryItem>(
                  MaterialPageRoute(builder: (ctx) => const NewItemScreen()));
              if (newItem == null) {
                return;
              }
              setState(() {
                groceryItems.add(newItem);
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems, 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }

        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        }
        
        if(snapshot.data!.isEmpty){
          return  const Center(child: Text('No items added yet.'));
        }
        else{
          return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (ctx, index) {
            final item = snapshot.data![index];
            return Dismissible(
                /**
               * Key 클래스는 위젯이나 앨리먼트 등을 식별할 때 사용한다.
               * Dismissible은 반드시 유니크한 key 값을 가져야 한다.
               * Key 생성자는 String값을 아규먼트로 받아서 고유한 키를 생성한다.
               */
                key: Key(item.id),
                // Dismissible의 배경색 설정
                background: Container(color: Colors.red),
                // Dismissible이 Swipe될 때 호출. Swipe된 방향을 아규먼트로 수신
                onDismissed: (direction) async{
                                    setState(() {
                    groceryItems.removeAt(index);
                  });
                  final url = Uri.https(
                      'project-practice-57f49-default-rtdb.firebaseio.com',
                      'shopping-list/${item.id}.json');
                      //슬래시 하나 추가해야함
                  final response = await http.delete(url);
                  // 해당 index의 item을 리스트에서 삭제
                  if(response.statusCode >= 400){
                    setState(() {
                      snapshot.data!.insert(index, item);
                    });
                  }
                },
                // Dismissible의 자식으로 리스트타일을 생성. 리스튜뷰에 타일로 등록
                child: ListTile(
                  title: Text(snapshot.data![index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: snapshot.data![index].category.color,
                  ),
                  trailing: Text(snapshot.data![index].quantity.toString()),
                ));
          });
        }
      },),
    );
  }
}
