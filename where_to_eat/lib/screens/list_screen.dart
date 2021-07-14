import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:kopo/kopo.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:where_to_eat/domain/classes.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'dart:convert';

class ListScreen extends StatefulWidget {
  final String uid;
  final KopoModel kopoModel;

  const ListScreen({
    Key key,
    @required this.uid,
    @required this.kopoModel,
  }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState(uid, kopoModel);
}

class _ListScreenState extends State<ListScreen> {
  final String uid;
  final KopoModel kopoModel;
  String dropdownValue = '없음';
  Position currentLocation;
  bool favorites;
  bool korean, bunsik, japanese, western, chinese;
  //final items = List<String>.generate(10, (i) => 'Restaurant ${i + 1}');
  List<Restaurant> restaurants = [];
  List<Restaurant> koreanRestaurants = [];
  List<Restaurant> bunsikRestaurants = [];
  List<Restaurant> japaneseRestaurants = [];
  List<Restaurant> westernRestaurants = [];
  List<Restaurant> chineseRestaurants = [];
  List<Restaurant> favoriteRestaurants = [];
  List<Restaurant> visibleRestaurants = [];
  // final isFavorite = List<bool>.generate(15, (i) => false);
  bool _pinned = true;
  bool _snap = false;
  bool _floating = true;
  final SlidableController slidableController = SlidableController();

  _ListScreenState(this.uid, this.kopoModel);

  @override
  void initState() {
    super.initState();
    favorites = false;
    korean = true;
    bunsik = false;
    japanese = false;
    western = false;
    chinese = false;
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
              if (korean)
                restaurants += koreanRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(koreanRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              korean = !korean;
              if (korean)
                restaurants += koreanRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(koreanRestaurants.toSet())
                    .toList();
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
              if (bunsik)
                restaurants += bunsikRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(bunsikRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              bunsik = !bunsik;
              if (bunsik)
                restaurants += bunsikRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(bunsikRestaurants.toSet())
                    .toList();
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
              if (japanese)
                restaurants += japaneseRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(japaneseRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              japanese = !japanese;
              if (japanese)
                restaurants += japaneseRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(japaneseRestaurants.toSet())
                    .toList();
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
              if (western)
                restaurants += westernRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(westernRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              western = !western;
              if (western)
                restaurants += westernRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(westernRestaurants.toSet())
                    .toList();
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
              if (chinese)
                restaurants += chineseRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(chineseRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              chinese = !chinese;
              if (chinese)
                restaurants += chineseRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(chineseRestaurants.toSet())
                    .toList();
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

  Widget _buildDropdownBtn() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: kBlackLabelStyle,
      underline: Container(
        height: 2,
        color: Colors.orangeAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          if (dropdownValue == '가까운순') {
            restaurants.sort((a, b) => a.distance.compareTo(b.distance));
          }
        });
      },
      items: <String>[
        '없음',
        '가까운순',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  List<Restaurant> parseRestaurants(String responseBody) {
    final parsed =
        json.decode(responseBody)["documents"].cast<Map<String, dynamic>>();

    return parsed.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
  }

  Future<http.Response> fetchPost(String place) async {
    var url = Uri.parse(
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=' + place);
    var response = await http.post(url,
        headers: {'Authorization': 'KakaoAK 2d1e034b85ed5af50b57147b95bbd43e'});
    //print('Response status: ${response.statusCode}');
    //printWrapped('Response body: ${response.body}');
    String genre = place.substring(place.length - 2);
    setState(() {
      if (genre == '한식' && koreanRestaurants.isEmpty) {
        koreanRestaurants += parseRestaurants(response.body);
        if (korean) restaurants += koreanRestaurants;
      }
      if (genre == '분식' && bunsikRestaurants.isEmpty) {
        bunsikRestaurants += parseRestaurants(response.body);
        if (bunsik) restaurants += bunsikRestaurants;
      }
      if (genre == '일식' && japaneseRestaurants.isEmpty) {
        japaneseRestaurants += parseRestaurants(response.body);
        if (japanese) restaurants += japaneseRestaurants;
      }
      if (genre == '양식' && westernRestaurants.isEmpty) {
        westernRestaurants += parseRestaurants(response.body);
        if (western) restaurants += westernRestaurants;
      }
      if (genre == '중식' && chineseRestaurants.isEmpty) {
        chineseRestaurants += parseRestaurants(response.body);
        if (chinese) restaurants += chineseRestaurants;
      }
    });
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (korean) fetchPost(kopoModel.address + '한식');
    if (bunsik) fetchPost(kopoModel.address + '분식');
    if (japanese) fetchPost(kopoModel.address + '일식');
    if (western) fetchPost(kopoModel.address + '양식');
    if (chinese) fetchPost(kopoModel.address + '중식');
    if (favorites)
      visibleRestaurants = restaurants
          .toSet()
          .intersection(favoriteRestaurants.toSet())
          .toList();
    else
      visibleRestaurants = restaurants;
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
                        SizedBox(width: 20),
                        _buildDropdownBtn(),
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
                final item = visibleRestaurants[index];
                final isfav = favoriteRestaurants.contains(restaurants[index]);
                item.distance = sqrt(
                    pow(currentLocation.latitude - int.parse(item.x), 2) *
                        pow(currentLocation.longitude - int.parse(item.y), 2));
                return Slidable.builder(
                  key: Key(item.id),
                  controller: slidableController,
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        child: Text(item.place_name),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(item.place_name),
                      subtitle: Text(item.category_name),
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
                              if (isfav)
                                favoriteRestaurants.remove(restaurants[index]);
                              else
                                favoriteRestaurants.add(restaurants[index]);
                            }),
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
                    child: SlidableDrawerDismissal(key: Key(item.id)),
                    onDismissed: (actionType) {
                      setState(() {
                        Restaurant deletedItem = restaurants.removeAt(index);
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("\"${deletedItem.place_name}\" 삭제됨"),
                            action: SnackBarAction(
                                label: "되돌리기",
                                onPressed: () => setState(
                                      () => restaurants.insert(
                                          index, deletedItem),
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
                      restaurants.removeAt(index);
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
              childCount: visibleRestaurants.length,
            ),
          ),
        ],
      ),
    );
  }
}
