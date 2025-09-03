import 'package:flutter/material.dart';
import 'package:pics/src/widgets/imagelist.dart';
import 'models/category.dart';
import 'widgets/bottom_bar.dart';

/*
* Widget is just a component
* Stateless widgets dont have data of their own
* build() must accept context and return a Widget
*/

class App extends StatefulWidget {
  @override
  createState() {
    return AppState();
  }
}

// setState() updates variables and triggers build()

class AppState extends State<App>{
  int counter = 0;
  int cur_idx = 1;
  List <Category> categories = [
    Category("cyberpunk"),
    Category("experimental"),
    Category("music"),
  ];
  Future<void> getImages() async {
    if(categories[cur_idx].images.isEmpty) {
      await categories[cur_idx].init();
    }
    categories[cur_idx].addImage();
  }

  var appBarColor = Colors.amber;
  String appBarLabel = "Photos app baby";

  _onpressed(index) {
    print("Tap Tap $index");
    cur_idx = index;
    appBarColor = categories[cur_idx].properties.color;
    appBarLabel = categories[cur_idx].properties.label;
    setState(() {});
  }

  var processColorValue = (val) => ((val * 255.0).round() & 0xff) as int;
  Color invertColor(Color color) {
  return Color.fromARGB(
    processColorValue(color.a),
    255 - processColorValue(color.r),
    255 - processColorValue(color.g),
    255 - processColorValue(color.b),
  );
}
  Widget build(context) {
    appBarColor = categories[cur_idx].properties.color;
    appBarLabel = categories[cur_idx].properties.label;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor ,
          title: Text(appBarLabel),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: invertColor(appBarColor),
          onPressed: () async {
            print("Hi bitch $counter ${categories[cur_idx].images.length}");
            await getImages();
            setState(() { 
              counter++;
            });
          },
          shape: StadiumBorder(),
          child: Icon(Icons.add_a_photo_outlined, color: appBarColor,),
        ),
        bottomNavigationBar: Bar.List(cur_idx, _onpressed, categories.map((prop) => prop.properties).toList()),
        body: ImageList(categories[cur_idx].images),
      ),
    );
  }
}