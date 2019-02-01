
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Entries extends StatefulWidget {
  @override
  EntriesState createState() => new EntriesState();
}

class EntriesState extends State<Entries>{
  Color azulAppbar = new Color(0xFF26C6DA);
  List<Widget> listCategories = [];
  List listaDB = [];

  @override
  void initState() {
    setState(() {
      this.listaDB = 
        [
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Apple ', 'id':'- 95 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Apple ', 'id':'- 95 calories'}],
          [{'category': 'Dragonfruit ','id': '- 60 calories'}],
          [{'category': 'Apple ','id': '- 95 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}],
          [{'category': 'Dragonfruit ','id': '- 60 calories'}],
          [{'category': 'Banana ','id': '- 105 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Kiwi ','id': '- 42 calories'}],
          [{'category': 'Apple ', 'id':'- 95 calories'}],
          [{'category': 'Banana ','id': '- 105 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Apple ','id': '- 95 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}],
          [{'category': 'Dragonfruit ','id': '- 60 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}]
        ];
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> buildListCategories(List list) {
      this.listCategories = [];

      for(var i in list) {
        var id = i[0]['id'];
        var category = i[0]['category'];

        this.listCategories.add(
          new ItemCategory(
            key: new ObjectKey(i[0]),
            id: id,
            category: category,
            onPressed: () async {
              setState(() {
                this.listaDB = 
                [
                   [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Apple ', 'id':'- 95 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Apple ', 'id':'- 95 calories'}],
          [{'category': 'Dragonfruit ','id': '- 60 calories'}],
          [{'category': 'Apple ','id': '- 95 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}],
          [{'category': 'Dragonfruit ','id': '- 60 calories'}],
          [{'category': 'Banana ','id': '- 105 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Kiwi ','id': '- 42 calories'}],
          [{'category': 'Apple ', 'id':'- 95 calories'}],
          [{'category': 'Banana ','id': '- 105 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Banana ', 'id':'- 105 calories'}],
          [{'category': 'Dragonfruit ', 'id':'- 60 calories'}],
          [{'category': 'Apple ','id': '- 95 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}],
          [{'category': 'Dragonfruit ','id': '- 60 calories'}],
          [{'category': 'Kiwi ', 'id':'- 42 calories'}]
                ];
              });
            }
          )
        );  
      }
      return this.listCategories;
    }

    return  ListView(
        padding: new EdgeInsets.only(top: 20.0, right: 0.0, left: 0.0),
        children: buildListCategories(this.listaDB)
    );
  }
}

class ItemCategory extends StatefulWidget {

  final String id;
  final String category;
  final VoidCallback onPressed;

  ItemCategory({
    Key key,
    this.id,
    this.category,
    this.onPressed}) : super(key: key);

  @override
  ItemCategoryState createState() => new ItemCategoryState();
}

class ItemCategoryState extends State<ItemCategory> with TickerProviderStateMixin {
  ItemCategoryState();

  AnimationController _controller;
  Animation<double> _animation;
  double flingOpening;
  bool startFling = true;

  void initState() {
    super.initState();
    _controller = new AnimationController(duration: 
      const Duration(milliseconds: 246), vsync: this);

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );
  }

  void _move(DragUpdateDetails details) {
    final double delta = details.primaryDelta / 304;
    _controller.value -= delta;
  }

  void _settle(DragEndDetails details) {
    if(this.startFling) {
      _controller.fling(velocity: 1.0);
      this.startFling = false;
    } else if(!this.startFling){
      _controller.fling(velocity: -1.0);
      this.startFling = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;
    this.flingOpening = -(48.0/_width);

    return new GestureDetector(
      onHorizontalDragUpdate: _move,
      onHorizontalDragEnd: _settle,
      child: new Stack(
        children: <Widget>[
          new Positioned.fill(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                    color: new Color(0xFFE57373),
                  ),
                  child: new IconButton(
                    icon: new Icon(Icons.delete),
                    color: new Color(0xFFFFFFFF),
                    onPressed: widget.onPressed
                  )
                ),
              ],
            ),
          ),
          new SlideTransition(
            position: new Tween<Offset>(
              begin:  Offset.zero,
              end: new Offset(this.flingOpening, 0.0),
            ).animate(_animation),
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border(
                  top: new BorderSide(style: BorderStyle.solid, color: Colors.black26),
                ),
                color: new Color(0xFFFFFFFF),
              ),
              margin: new EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          margin: new EdgeInsets.only(left: 16.0),
                          padding: new EdgeInsets.only(right: 40.0, top: 4.5, bottom: 4.5),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                margin: new EdgeInsets.only(right: 16.0),
                                child: new Icon(
                                  Icons.brightness_1,
                                  color: Colors.black,
                                  size: 35.0,
                                ),
                              ),
                              new Text(widget.category+widget.id),
                            ],
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}