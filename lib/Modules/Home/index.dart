import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:baazaru/conf.dart';
import 'package:baazaru/cons.dart';
import 'package:baazaru/Models/category.dart';
import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Providers/product.dart';
import 'package:baazaru/Services/product.dart';
import 'package:baazaru/Widgets/custom_shape.dart';
import 'package:baazaru/Widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isExpanded = false;
  List<Category> categoryItems;
  List<Product> featuredItems;
  double _height;
  double _width;
  List<Product> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    featuredItems = [
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
            "Discover the Lenovo ThinkPad T450, a 14-inch thin and light business Ultrabook with the newest Intel Core i processor, backlit keyboard and up to 17 hours battery backup.",
        price: "40000",
        preview: "assets/images/laptop.png",
      ),
    ];

//    categoryItems = [
//      Category("Electronics", "assets/images/gadget.png"),
//      Category("Properties", "assets/images/house.png"),
//      Category("Jobs", "assets/images/job.png"),
//      Category("Furniture", "assets/images/sofa.png"),
//      Category("Cars", "assets/images/car.png"),
//      Category("Bikes", "assets/images/bike.png"),
//      Category("Mobiles", "assets/images/smartphone.png"),
//      Category("Pets", "assets/images/pet.png"),
//      Category("Fashion", "assets/images/dress.png"),
//    ];
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
      bottomNavigationBar: _footerWidget(),
      key: scaffoldKey,
      drawer: _sidebarWidget(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 3,
        onPressed: () {
          Navigator.pushNamed(context, LOGIN_PAGE);
        },
        backgroundColor: Colors.deepPurple[200],
        icon: Icon(Icons.add),
        label: Text(
          "List An Ads",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Shop for', style: TextStyle(fontSize: 16)),
                    GestureDetector(
                        onTap: _expand,
                        child: Text(
                          isExpanded ? "View Less" : "View All",
                          style: TextStyle(
                            color: Colors.deepPurple[200],
                          ),
                        )),
                    //IconButton(icon: isExpanded? Icon(Icons.arrow_drop_up, color: Colors.deepPurple[200],) : Icon(Icons.arrow_drop_down, color: Colors.deepPurple[200],), onPressed: _expand)
                  ],
                ),
              ),
              expandList(),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Featured Ads", style: TextStyle(fontSize: 16)),
                    GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(FEATURE_PAGE);
                          Navigator.pushNamed(context, FEATURE_PAGE);
                          print('Showing all');
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.deepPurple[300],
                          ),
                        ))
                  ],
                ),
              ),
              featuredProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sidebarWidget() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: 0.75,
            child: Container(
              height: _height / 6,
              padding: EdgeInsets.only(top: _height / 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[200], Colors.deepPurpleAccent],
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black,
                  ),
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                title: Text("Anil Chaudhari"),
                subtitle: Text(
                  "imanilchaudhari@gmail.com",
                  style: TextStyle(fontSize: 13),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text("Contact"),
            onTap: () {
              Navigator.pushNamed(context, CONTACT_PAGE);
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Login"),
            onTap: () {
              Navigator.pushNamed(context, LOGIN_PAGE);
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
              icon: Icon(Icons.message),
              onPressed: () {
                print("Contact page");
                Navigator.of(context).pushNamed(CONTACT_PAGE);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[200], Colors.deepPurpleAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[200], Colors.deepPurpleAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.25,
          child: ClipPath(
            clipper: CustomShapeClipper3(),
            child: Container(
              height: _height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[200], Colors.deepPurpleAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: _height / 3.75),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 8,
            child: Container(
              child: TextFormField(
                cursorColor: Colors.deepPurple[200],
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search,
                      color: Colors.deepPurple[200], size: 30),
                  hintText: "What're you looking for?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                ),
                onTap: () {},
                // onSaved: (String? value) {
                //   print('Value for field saved as "$value"');
                // },
              ),
            ),
          ),
        ),
        Container(
            //color: Colors.blue,
            margin: EdgeInsets.only(left: 20, right: 20, top: _height / 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                        onTap: () {
                          scaffoldKey.currentState.openDrawer();
                        },
                        child: Image.asset(
                          'assets/images/menubutton.png',
                          height: _height / 40,
                        )),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: _height / 20,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print('Editing location');
                          },
                          child: Icon(
                            Icons.edit_location,
                            color: Colors.white,
                            size: _height / 40,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text('Kathmandu',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _height / 50),
                                // overflow: TextOverflow.fade,
                                softWrap: false)),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: _height / 30,
                      )),
                ),
              ],
            )),
      ],
    );
  }

  Widget expandList() {
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
                    'assets/images/gadget.png',
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
                    'assets/images/gadget.png',
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

  Widget featuredProducts() {
    return Container(
      height: _height / 4.25,
      //width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: featuredItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return _buildFeaturedItems(context, index, featuredItems);
        },
      ),
    );
  }

  Widget _buildFeaturedItems(
      BuildContext context, int index, List<Product> listItem) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PRODUCT_PAGE);
        print("Routing to product page");
      },
      child: CustomCard(
        title: '${listItem[index].name}',
        category: '${listItem[index].id}',
        price: "₹${listItem[index].price}",
        dateAdded: "${listItem[index].createdAt}",
        description: "${listItem[index].content}",
        image: "${listItem[index].preview}",
        location: "Kathmandu, Nepal",
      ),
    );
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.https(Config.url, ProductService.path));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);
      print(data);
      // return data;
      return List<Product>.from(data.map((e) => Product.fromJson(e)));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
