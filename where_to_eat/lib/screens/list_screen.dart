import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:kopo/kopo.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_kakao_map/flutter_kakao_map.dart';
import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';
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
  bool favorites;
  bool korean, bunsik, japanese, western, chinese;
  final items = List<String>.generate(10, (i) => 'Restaurant ${i + 1}');
  final isFavorite = List<bool>.generate(10, (i) => false);
  bool _pinned = true;
  bool _snap = false;
  bool _floating = true;
  final SlidableController slidableController = SlidableController();

  _ListScreenState(this.uid);

  @override
  void initState() {
    favorites = false;
    korean = true;
    bunsik = true;
    japanese = true;
    western = true;
    chinese = true;
  }

  Widget _favoritesCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: favorites,
          onChanged: (value) {
            setState(() {
              favorites = !favorites;
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              favorites = !favorites;
            });
          },
          child: Text(
            '찜한 식당만 보기',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
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
              height: 100,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _favoritesCheckBox(),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
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
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = items[index];
                final isfav = isFavorite[index];
                return Slidable.builder(
                  key: Key(item),
                  controller: slidableController,
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
                  actionDelegate: SlideActionBuilderDelegate(
                    actionCount: 2,
                    builder: (context, actionIndex, animation, mode) {
                      if (actionIndex == 0)
                        return IconSlideAction(
                          caption: '찜하기',
                          color: Colors.blue,
                          icon: isfav ? Icons.star : Icons.star_border,
                          onTap: () => {
                            setState(() {
                              isFavorite[index] = !isFavorite[index];
                            }),
                            print('찜하기'),
                          },
                        );
                      else
                        return IconSlideAction(
                          caption: '공유하기',
                          color: Colors.indigo,
                          icon: Icons.share,
                          onTap: () => print('공유하기'),
                        );
                    },
                  ),
                  secondaryActionDelegate: SlideActionBuilderDelegate(
                    actionCount: 1,
                    builder: (context, actionIndex, animation, mode) {
                      return IconSlideAction(
                        caption: '숨기기',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          var state = Slidable.of(context);
                          state.dismiss();
                        },
                      );
                    },
                  ),
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(key: Key(item)),
                    onDismissed: (actionType) {
                      setState(() {
                        String deletedItem = items.removeAt(index);
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("\"${deletedItem}\" 삭제됨"),
                            action: SnackBarAction(
                                label: "되돌리기",
                                onPressed: () => setState(
                                      () => items.insert(index, deletedItem),
                                    ) // this is what you needed
                                ),
                          ),
                        );
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
