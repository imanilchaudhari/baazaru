import 'dart:convert';
import 'package:baazaru/Modules/Search/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;
import 'package:baazaru/conf.dart';
import 'package:baazaru/cons.dart';
import 'package:baazaru/Classes/search.dart';
import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Services/product.dart';
import 'package:baazaru/Widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  bool isExpanded = false;
  double _height;
  double _width;

  List<Product> items;
  Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = getProducts();
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BAAZARU",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState.openDrawer();
          },
          child: Icon(
            Icons.menu, // add custom icons also
          ),
        ),
        actions: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(right: 20.0),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Icon(
          //       Icons.search,
          //       size: 26.0,
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.settings),
            ),
          ),
        ],
        centerTitle: true,
      ),
      key: scaffoldKey,
      drawer: _sidebarWidget(),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo,
          onPressed: () {
            Navigator.pushNamed(context, CREATE_PAGE);
          },
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              searchBox(),
              bannerItems(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Browse Categories', style: TextStyle(fontSize: 16)),
                    GestureDetector(
                        onTap: _expand,
                        child: Text(
                          isExpanded ? "View Less" : "View All",
                          style: TextStyle(
                            color: Colors.indigo[900],
                          ),
                        )),
                    //IconButton(icon: isExpanded? Icon(Icons.arrow_drop_up, color: Colors.indigo[900],) : Icon(Icons.arrow_drop_down, color: Colors.indigo[900],), onPressed: _expand)
                  ],
                ),
              ),
              categoryItems(),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Featured Ads", style: TextStyle(fontSize: 16)),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(FEATURE_PAGE);
                          // Navigator.pushNamed(context, FEATURE_PAGE);
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.indigo[300],
                          ),
                        ))
                  ],
                ),
              ),
              productItems(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _footerWidget(),
    );
  }

  Widget _sidebarWidget() {
    return Drawer(
      child: Column(
        children: <Widget>[
          // Opacity(
          //   opacity: 0.75,
          //   child: Container(
          //     height: _height / 6,
          //     padding: EdgeInsets.only(top: _height / 20),
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [Colors.indigo[900], Colors.indigoAccent],
          //       ),
          //     ),
          //     child: ListTile(
          //       leading: CircleAvatar(
          //         child: Icon(
          //           Icons.person,
          //           size: 40,
          //           color: Colors.black,
          //         ),
          //         radius: 30,
          //         backgroundColor: Colors.white,
          //       ),
          //       title: Text("Anil Chaudhari"),
          //       subtitle: Text(
          //         "imanilchaudhari@gmail.com",
          //         style: TextStyle(fontSize: 13),
          //       ),
          //       trailing: Icon(
          //         Icons.arrow_forward_ios,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/drawer.png'),
              ),
            ),
            child: Stack(children: <Widget>[
              Positioned(
                bottom: 12.0,
                left: 16.0,
                child: Text(
                  "Welcome To Baazaru",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ]),
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text("Contact"),
            onTap: () {
              Navigator.pushNamed(context, CONTACT_PAGE);
            },
          ),
          Visibility(
            visible: true,
            child: ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                Navigator.pushNamed(context, LOGIN_PAGE);
              },
            ),
          ),
          Visibility(
            visible: true,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                //
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              Navigator.pushNamed(context, ABOUT_PAGE);
            },
          ),
        ],
      ),
    );
  }

  Widget _footerWidget() {
    return BottomAppBar(
      notchMargin: 4,
      shape: AutomaticNotchedShape(RoundedRectangleBorder(),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Container(
        height: 70,
        margin: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                print("Home page");
                Navigator.of(context).pushNamed(HOME_PAGE);
              },
            ),
            IconButton(
              icon: Icon(Icons.list_outlined),
              onPressed: () {
                print("My Products");
                Navigator.of(context).pushNamed(PRODUCT_PAGE);
              },
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                print("My Talks");
                Navigator.of(context).pushNamed(CONTACT_PAGE);
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                print("My Account");
                Navigator.of(context).pushNamed(LOGIN_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Material(
            borderRadius: BorderRadius.circular(5.0),
            elevation: 10,
            child: Container(
              child: TextFormField(
                cursorColor: Colors.indigo[900],
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.indigo[900],
                    size: 30,
                  ),
                  hintText: "What're you looking for?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (String value) {
                  print('Value for field saved as "$value"');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: SearchArguments(value),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bannerItems() {
    return Container(
        child: Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: false,
            height: 200,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
          ),
          items: bannerImages
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    elevation: 10.0,
                    shadowColor: Colors.indigoAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(1.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Center(
                            child: Text(
                              '${bannerTitles[_currentIndex]}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerImages.map((urlOfItem) {
            int index = bannerImages.indexOf(urlOfItem);
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Color.fromRGBO(0, 0, 0, 0.8)
                    : Color.fromRGBO(0, 0, 0, 0.3),
              ),
            );
          }).toList(),
        )
      ],
    ));
  }

  Widget categoryItems() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: AnimatedCrossFade(
        firstChild: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(ELECTRONICS_ITEM_LIST);
                    print('Routing to Electronics item list');
                  },
                  child: Image.asset(
                    'assets/images/electronics.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Electronics",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(PROPERTIES_ITEM_LIST);
                      print('Routing to Properties item list');
                    },
                    child: Image.asset(
                      'assets/images/house.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Properties",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(JOBS_ITEM_LIST);
                      print('Routing to Jobs item list');
                    },
                    child: Image.asset(
                      'assets/images/job.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Jobs",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(FURNITURE_ITEM_LIST);
                      print('Routing to Furniture item list');
                    },
                    child: Image.asset(
                      'assets/images/sofa.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Furniture",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(CARS_ITEM_LIST);
                    print('Routing to Cars item list');
                  },
                  child: Image.asset(
                    'assets/images/car.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Cars",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(BIKES_ITEM_LIST);
                    print('Routing to Bikes item list');
                  },
                  child: Image.asset(
                    'assets/images/bike.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Bikes",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(MOBILES_ITEM_LIST);
                      print('Routing to Mobiles item list');
                    },
                    child: Image.asset(
                      'assets/images/smartphone.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Mobiles",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(PETS_ITEM_LIST);
                    print('Routing to Pets item list');
                  },
                  child: Image.asset(
                    'assets/images/pet.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Pets",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
        secondChild: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(CATEGORY_PAGE);
                    print('Routing to Electronics item list');
                  },
                  child: Image.asset(
                    'assets/images/electronics.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Electronics",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(PROPERTIES_ITEM_LIST);
                      print('Routing to Properties item list');
                    },
                    child: Image.asset(
                      'assets/images/house.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Properties",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(JOBS_ITEM_LIST);
                      print('Routing to Jobs item list');
                    },
                    child: Image.asset(
                      'assets/images/job.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Jobs",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(FURNITURE_ITEM_LIST);
                      print('Routing to Furniture item list');
                    },
                    child: Image.asset(
                      'assets/images/sofa.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Furniture",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(CARS_ITEM_LIST);
                    print('Routing to Cars item list');
                  },
                  child: Image.asset(
                    'assets/images/car.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Cars",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(BIKES_ITEM_LIST);
                    print('Routing to Bikes item list');
                  },
                  child: Image.asset(
                    'assets/images/bike.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Bikes",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed(MOBILES_ITEM_LIST);
                      print('Routing to Mobiles item list');
                    },
                    child: Image.asset(
                      'assets/images/smartphone.png',
                      height: _height / 12,
                      width: _width / 12,
                    )),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Mobiles",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(PETS_ITEM_LIST);
                    print('Routing to Pets item list');
                  },
                  child: Image.asset(
                    'assets/images/pet.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Pets",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(FASHION_ITEM_LIST);
                    print('Routing to Fashion item list');
                  },
                  child: Image.asset(
                    'assets/images/dress.png',
                    height: _height / 12,
                    width: _width / 12,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    "Fashion",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
        crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      ),
    );
  }

  Widget productItems() {
    items = [
      Product(
        id: 123,
        createdAt: DateTime(2019, 10, 10, 10, 10, 10),
        name: "Lenovo T450",
        content:
            "Discover the Lenovo ThinkPad T450, a 14-inch thin and light business Ultrabook with the newest Intel Core i processor, backlit keyboard and up to 17 hours battery backup.",
        price: "40000",
        preview: "assets/images/lenovot450.jpg",
      ),
      Product(
        id: 123,
        createdAt: DateTime(2019, 10, 10, 10, 10, 10),
        name: "Asus Laptop",
        content:
            "Ultrabook with the newest Intel Core i processor, backlit keyboard and up to 17 hours battery backup.",
        price: "20000",
        preview: "assets/images/laptop.png",
      ),
    ];

    return Container(
      height: _height / 4.25,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return _item(context, index, items);
        },
      ),
    );
  }

  Widget _item(BuildContext context, int index, List<Product> item) {
    // print(item);
    return GestureDetector(
      child: CustomCard(
        title: '${item[index].name}',
        category: '${item[index].id}',
        price: "Rs. ${item[index].price}",
        dateAdded: "${item[index].createdAt}",
        description: "${item[index].content}",
        image: "${item[index].preview}",
        location: "Kathmandu, Nepal",
      ),
      onTap: () {
        Navigator.of(context).pushNamed(PRODUCT_PAGE);
      },
    );
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.https(Config.url, ProductService.path));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);
      // print(data);
      // return data;
      return List<Product>.from(data.map((json) => Product.fromJson(json)));
    } else {
      throw Exception('Failed to load products');
    }
  }
}

final List<String> bannerImages = [
  'https://cdn.pixabay.com/photo/2014/05/02/21/49/laptop-336373_960_720.jpg',
  'https://cdn.pixabay.com/photo/2014/08/05/10/27/iphone-410311_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
  'https://cdn.pixabay.com/photo/2015/06/08/15/18/steering-wheel-801994_960_720.jpg',
];
final List<String> bannerTitles = [
  'Laptops',
  'Mobiles',
  'Food & Drinks',
  'Automobiles',
];
