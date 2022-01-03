import 'peminjaman_page.dart';
import 'package:flutter/material.dart';
import 'Inventaris.dart';
import 'main-page.dart';
import 'Inventaris.dart';
import 'package:christmas_list_flutter25/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.library_add,
              text: 'Tambah Barang',
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainPage();
                  }))),
          _drawerItem(
              icon: Icons.group,
              text: 'Pinjam Barang',
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PinjamPage();
                  }))),
          _drawerItem(
              icon: Icons.access_time,
              text: 'Inventaris',
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InventarisPage();
                  }))),
          Divider(height: 25, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text("Labels",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
          ),
          _drawerItem(icon: Icons.bookmark, text: 'Family', onTap: () async {}),
        ],
      ),
    );
  }
}

Widget _drawerHeader() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User user = auth.currentUser;
  final uid = user.uid;
  final name = user.displayName;
  final email = user.email;

  return UserAccountsDrawerHeader(
    accountName: Text('$name'),
    accountEmail: Text('$email'),
  );
}

Widget _drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
