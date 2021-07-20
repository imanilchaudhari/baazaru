import 'package:flutter/material.dart';

import 'package:baazaru/cons.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: _footerWidget(),
      drawer: _sidebarWidget(),
      appBar: AppBar(
        title: Text("Contact Page"),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 3,
        onPressed: () {
          Navigator.pushNamed(context, CREATE_PAGE);
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
      body: Text(
        'Loading ...',
        textAlign: TextAlign.center,
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
}
