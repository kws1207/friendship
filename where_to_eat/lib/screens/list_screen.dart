import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:kpostal/kpostal.dart';
import 'package:kpostal/src/kpostal_model.dart';
import 'package:where_to_eat/utilities/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:where_to_eat/domain/classes.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:where_to_eat/screens/roulette_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:where_to_eat/utilities/functions.dart';

class ListScreen extends StatefulWidget {
  final String uid;
  final Kpostal kopoModel;

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
  final Kpostal kopoModel;
  String dropdownValue = '기본순';
  Position currentLocation;
  bool favorites, initialized;
  bool korean, bunsik, japanese, western, chinese, asian, fastfood, cafe;
  //final items = List<String>.generate(10, (i) => 'Restaurant ${i + 1}');
  List<Restaurant> restaurants = [];
  List<Restaurant> koreanRestaurants = [];
  List<Restaurant> bunsikRestaurants = [];
  List<Restaurant> japaneseRestaurants = [];
  List<Restaurant> westernRestaurants = [];
  List<Restaurant> chineseRestaurants = [];
  List<Restaurant> asianRestaurants = [];
  List<Restaurant> fastfoodRestaurants = [];
  List<Restaurant> cafeRestaurants = [];
  List<Restaurant> favoriteRestaurants = [];
  List<Restaurant> visibleRestaurants = [];
  // final isFavorite = List<bool>.generate(15, (i) => false);
  bool _pinned = true;
  bool _snap = false;
  bool _floating = true;
  final SlidableController slidableController = SlidableController();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool _isListLoading = false;

  _ListScreenState(this.uid, this.kopoModel);

  @override
  void initState() {
    super.initState();
    //getCurrentLocation();
    initialized = false;
    favorites = false;
    korean = true;
    bunsik = false;
    japanese = false;
    western = false;
    chinese = false;
    asian = false;
    fastfood = false;
    cafe = false;
    asyncMethod();
  }

  void asyncMethod() async {
    setState(() {
      _isListLoading = true;
    });
    await getCurrentLocation();
    await loadFavorites();
    await fetchPost(kopoModel.address + ' 한식');
    await fetchPost(kopoModel.address + ' 분식');
    await fetchPost(kopoModel.address + ' 일식');
    await fetchPost(kopoModel.address + ' 양식');
    await fetchPost(kopoModel.address + ' 중식');
    await fetchPost(kopoModel.address + ' 아시아음식');
    await fetchPost(kopoModel.address + ' 패스트푸드');
    await fetchPost(kopoModel.address + ' 카페');
    setState(() {
      _isListLoading = false;
    });
  }

  void pushRoulettePage() {
    if (visibleRestaurants.length < 6) {
      showNativeDialog('메뉴 개수가 부족합니다. (6개 필요)', context);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        List<Restaurant> rouletteRestaurants =
            List<Restaurant>.from(visibleRestaurants);
        rouletteRestaurants.shuffle();
        print(rouletteRestaurants.sublist(0, 6).map((e) => e.place_name));
        return RouletteScreen(rouletteList: rouletteRestaurants.sublist(0, 6));
      }));
    }
  }

  void _launchURL(String url) async {
    //print(url);
    if (await canLaunch(Uri.encodeFull(url))) {
      await launch(Uri.encodeFull(url));
    } else {
      throw 'Could not launch $url';
    }
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
            '분식',
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
            '양식',
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
            '중식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _asianCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: asian,
          onChanged: (value) {
            setState(() {
              asian = !asian;
              if (asian)
                restaurants += asianRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(asianRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              asian = !asian;
              if (asian)
                restaurants += asianRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(asianRestaurants.toSet())
                    .toList();
            });
          },
          child: Text(
            '아시아음식',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _fastfoodCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: fastfood,
          onChanged: (value) {
            setState(() {
              fastfood = !fastfood;
              if (fastfood)
                restaurants += fastfoodRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(fastfoodRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              fastfood = !fastfood;
              if (fastfood)
                restaurants += fastfoodRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(fastfoodRestaurants.toSet())
                    .toList();
            });
          },
          child: Text(
            '패스트푸드',
            style: kBlackLabelStyle,
          ),
        )
      ],
    );
  }

  Widget _cafeCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: cafe,
          onChanged: (value) {
            setState(() {
              cafe = !cafe;
              if (cafe)
                restaurants += cafeRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(cafeRestaurants.toSet())
                    .toList();
            });
          },
          checkColor: Colors.white,
          activeColor: Colors.orange,
        ),
        InkWell(
          onTap: () {
            setState(() {
              cafe = !cafe;
              if (cafe)
                restaurants += cafeRestaurants;
              else
                restaurants = restaurants
                    .toSet()
                    .difference(cafeRestaurants.toSet())
                    .toList();
            });
          },
          child: Text(
            '카페',
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
      onChanged: (String newValue) async {
        await getCurrentLocation();
        setState(() {
          dropdownValue = newValue;
          if (favorites)
            visibleRestaurants = List.of(restaurants)
                .toSet()
                .intersection(favoriteRestaurants.toSet())
                .toList();
          else {
            visibleRestaurants = List.of(restaurants);
          }
        });
      },
      items: <String>[
        '기본순',
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

    getCurrentLocation();

    return parsed
        .map<Restaurant>((json) => Restaurant.fromJson(json, currentLocation))
        .toList();
  }

  void fetchPost(String place) async {
    print('fetchpost: ' + place);
    var url = Uri.parse(
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=' + place);
    var response = await http.post(url,
        headers: {'Authorization': 'KakaoAK f7fe1cb54eecf69fc022ce8035f1e369'});
    //print('Response status: ${response.statusCode}');
    //printWrapped('Response body: ${response.body}');
    String genre = place.substring(place.length - 2);
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
    if (genre == '음식' && asianRestaurants.isEmpty) {
      asianRestaurants += parseRestaurants(response.body);
      if (asian) restaurants += asianRestaurants;
    }
    if (genre == '푸드' && fastfoodRestaurants.isEmpty) {
      fastfoodRestaurants += parseRestaurants(response.body);
      if (fastfood) restaurants += fastfoodRestaurants;
    }
    if (genre == '카페' && cafeRestaurants.isEmpty) {
      cafeRestaurants += parseRestaurants(response.body);
      if (cafe) restaurants += cafeRestaurants;
    }
  }

  /*
  Future<http.Response> getKopoLocation() async {
    var url = Uri.parse(
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=' +
            kopoModel.address);
    var response = await http.post(url,
        headers: {'Authorization': 'KakaoAK f7fe1cb54eecf69fc022ce8035f1e369'});
    final parsed =
        json.decode(response.body)["documents"].cast<Map<String, dynamic>>();

    //print(response.body);
    List<Restaurant> list = parsed
        .map<Restaurant>((json) => Restaurant.fromJsonInit(json))
        .toList();

    setState(() {
      kopoLocation = list.first;
    });
  }
  */

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = position;
    });
    //print(currentLocation.latitude);
    //print(currentLocation.longitude);
  }

  void saveFavorites() async {
    print(uid);
    favoriteRestaurants.forEach(
      (restaurant) async {
        await _firestore.collection('favorites').doc(uid).set(
          {
            'array': FieldValue.arrayUnion([
              {
                'place_name': restaurant.place_name,
                'category_name': restaurant.category_name,
                'x': restaurant.x,
                'y': restaurant.y,
                'id': restaurant.id,
                'phone': restaurant.phone,
                'distance': restaurant.distance,
              }
            ])
          },
          SetOptions(merge: true),
        ).onError((error, stackTrace) => null);
      },
    );
  }

  void deleteFavorites() async {
    await FirebaseFirestore.instance
        .collection('favorites')
        .doc(uid)
        .delete()
        .onError((error, stackTrace) => null);
  }

  void refreshFavorites() async {
    deleteFavorites();
    saveFavorites();
  }

  void loadFavorites() async {
    await FirebaseFirestore.instance
        .collection('favorites')
        .doc(uid)
        .get()
        .then((DocumentSnapshot ds) {
      List<dynamic> _list = ds['array'];
      _list.forEach((e) {
        if (favoriteRestaurants.any((f) => (e['id'] == f.id))) {
          print('already exists');
        } else {
          favoriteRestaurants.add(Restaurant(
            place_name: e['place_name'],
            category_name: e['category_name'],
            x: e['x'],
            y: e['y'],
            id: e['id'],
            phone: e['phone'],
            distance: e['distance'],
          ));
        }
        initialized = true;
      });
      //print(e['place_name']);
    }).onError((error, stackTrace) {
      print('failed to load favorites');
      initialized = true;
    });
  }

  Widget _itemIconBuilder(Restaurant item) {
    if (koreanRestaurants.contains(item)) return Icon(Icons.rice_bowl);
    if (bunsikRestaurants.contains(item)) return Icon(Icons.restaurant);
    if (japaneseRestaurants.contains(item)) return Icon(Icons.ramen_dining);
    if (westernRestaurants.contains(item)) return Icon(Icons.dinner_dining);
    if (chineseRestaurants.contains(item)) return Icon(Icons.restaurant_menu);
    if (asianRestaurants.contains(item)) return Icon(Icons.food_bank);
    if (fastfoodRestaurants.contains(item)) return Icon(Icons.fastfood);
    if (cafeRestaurants.contains(item)) return Icon(Icons.emoji_food_beverage);
    return Icon(Icons.error);
  }

  Widget _rouletteFloatingActionBtn() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.orange,
      label: Text(
        '랜덤 룰렛돌리기!',
        style: kWhiteLabelStyle,
      ),
      isExtended: true,
      onPressed: () {
        pushRoulettePage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) refreshFavorites();
    if (favorites)
      visibleRestaurants = List.of(restaurants)
          .toSet()
          .intersection(favoriteRestaurants.toSet())
          .toList();
    else
      visibleRestaurants = List.of(restaurants);

    if (dropdownValue == '가까운순') {
      visibleRestaurants.sort((a, b) => a.distance.compareTo(b.distance));
    }

    //print(favoriteRestaurants.map((e) => e.place_name));
    //print(restaurants.map((e) => e.place_name));
    //print(visibleRestaurants.map((e) => e.place_name));

    if (_isListLoading) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
                            _asianCheckBox(),
                            _fastfoodCheckBox(),
                            _cafeCheckBox(),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1),
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
                  final isfav =
                      favoriteRestaurants.any((e) => (e.id == item.id));
                  return Slidable.builder(
                    key: Key(item.id),
                    controller: slidableController,
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orangeAccent.shade100,
                          child: _itemIconBuilder(item),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(item.place_name),
                        subtitle: Text(item.category_name),
                      ),
                    ),
                    actionDelegate: SlideActionBuilderDelegate(
                      actionCount: 3,
                      builder: (context, actionIndex, animation, mode) {
                        if (actionIndex == 0)
                          return IconSlideAction(
                            caption: '찜하기',
                            color: Colors.blue,
                            icon: isfav ? Icons.star : Icons.star_border,
                            onTap: () => {
                              setState(() {
                                if (isfav) {
                                  favoriteRestaurants.remove(item);
                                } else {
                                  if (!favoriteRestaurants.contains(item))
                                    favoriteRestaurants.add(item);
                                }
                              }),
                            },
                          );
                        else if (actionIndex == 1)
                          return IconSlideAction(
                            caption: '카카오맵',
                            color: Colors.indigo,
                            icon: Icons.open_in_browser,
                            onTap: () => _launchURL(
                                'https://place.map.kakao.com/' + item.id),
                          );
                        else
                          return IconSlideAction(
                            caption: '전화 걸기',
                            color: Colors.green[800],
                            icon: Icons.phone,
                            onTap: () => _launchURL('tel:' + item.phone),
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
                          restaurants.remove(item);
                          favoriteRestaurants.remove(item);

                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("\"${item.place_name}\" 삭제됨"),
                              action: SnackBarAction(
                                  label: "되돌리기",
                                  onPressed: () => setState(
                                        () => restaurants.insert(index, item),
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
                },
                childCount: visibleRestaurants.length,
              ),
            ),
          ],
        ),
        floatingActionButton: _rouletteFloatingActionBtn(),
      );
    }
  }
}
