import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pics/src/models/category.dart';

class Bar extends StatelessWidget {

  int cur_idx = 0;
  var onTap;
  late List<BottomNavigationBarItem> itemList = [];
  Bar(this.cur_idx, this.onTap);

  Bar.List(var idx, var tap, List<CategoryProperties> properties) {
    cur_idx = idx;
    onTap = tap;
    for(var item in properties) {
      itemList.add(BottomNavigationBarItem(icon: Icon(item.icon), label : item.name));
    }
  }

  Widget build(context) {
    return BottomNavigationBar(currentIndex: cur_idx,
        onTap: this.onTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: itemList,
    );
  }
}