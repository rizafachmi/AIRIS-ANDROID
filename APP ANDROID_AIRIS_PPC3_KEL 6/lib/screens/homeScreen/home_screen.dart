import 'package:christmas_list_flutter25/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'nav-drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _myController = TextEditingController();
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final name = user.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('AIRIS'),
        backgroundColor: Colors.red[600],
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: _openSettings)
        ],
      ),
      drawer: DrawerWidget(),
      endDrawer: DrawerWidget(),
      body: Center(
          child: Image(
        image: AssetImage('assets/2.jpg'),
        repeat: ImageRepeat.repeat,
      )),
    );
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
              backgroundColor: Colors.red[600],
            ),
            body: Container(
              color: Colors.green[300],
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      width: 225.0,
                      child: RaisedButton(
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red[500],
                        onPressed: () {
                          _signOut();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      width: 225.0,
                      child: RaisedButton(
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red[500],
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 225.0,
                      child: RaisedButton(
                        child: Text(
                          'Delete User',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red[500],
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
