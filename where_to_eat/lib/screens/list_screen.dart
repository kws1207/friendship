import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:where_to_eat/domain/classes.dart';

class ListScreen extends StatefulWidget {
  final String uid;

  const ListScreen({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState(uid);
}

class _ListScreenState extends State<ListScreen> {
  final String uid;
  bool korean, bunsik, japanese, western, chinese;
  final items = List<String>.generate(10, (i) => 'Restaurant ${i + 1}');
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  DismissDirection _direction = DismissDirection.endToStart;

  _ListScreenState(this.uid);

  @override
  void initState() {
    korean = true;
    bunsik = true;
    japanese = true;
    western = true;
    chinese = true;
  }

  Widget _koreanCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: korean,
          onChanged: (value) {
            setState(() {
              korean = !korean;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              korean = !korean;
            });
          },
          child: Text(
            '한식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _bunsikCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: bunsik,
          onChanged: (value) {
            setState(() {
              bunsik = !bunsik;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              bunsik = !bunsik;
            });
          },
          child: Text(
            '분식 / 패스트푸드',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _japaneseCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: japanese,
          onChanged: (value) {
            setState(() {
              japanese = !japanese;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              japanese = !japanese;
            });
          },
          child: Text(
            '일본음식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _westernCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: western,
          onChanged: (value) {
            setState(() {
              western = !western;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              western = !western;
            });
          },
          child: Text(
            '아시안 / 양식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _chineseCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: chinese,
          onChanged: (value) {
            setState(() {
              chinese = !chinese;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              chinese = !chinese;
            });
          },
          child: Text(
            '중국음식 (마라요리, 훠궈 등 포함)',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            backgroundColor: Colors.orange,
            title: Text(
              '식당 골라보쇼',
              style: kWhiteLabelStyle,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: Row(
                    children: <Widget>[
                      _koreanCheckBox(),
                      _bunsikCheckBox(),
                      _japaneseCheckBox(),
                      _westernCheckBox(),
                      _chineseCheckBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = items[index];
                return Slidable(
                  key: Key(item),
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        child: Text('$item'),
                        foregroundColor: Colors.white,
                      ),
                      title: Text('Tile $item'),
                      subtitle: Text('SlidableDrawerDelegate'),
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: '찜하기',
                      color: Colors.blue,
                      icon: Icons.star_border_outlined,
                      onTap: () => print('찜하기'),
                    ),
                    IconSlideAction(
                      caption: '공유하기',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () => print('공유하기'),
                    ),
                  ],
                  secondaryActions: <Widget>[
                    /*IconSlideAction(
                      caption: '영구 차단',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () => print('영구 차단'),
                    ),*/
                    IconSlideAction(
                      caption: '숨기기',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => print('숨기기'),
                    ),
                  ],
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(key: Key(item)),
                    onDismissed: (actionType) {
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                    dismissThresholds: <SlideActionType, double>{
                      SlideActionType.primary: 1.0
                    },
                  ),
                );
                /*return Dismissible(
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                  key: Key(item),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  direction: _direction,
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      items.removeAt(index);
                    });

                    // Then show a snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$item dismissed')));
                  },
                  // Show a red background as the item is swiped away.
                  background: Container(color: Colors.red),
                  child: ListTile(title: Text('$item')),
                );*/
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
