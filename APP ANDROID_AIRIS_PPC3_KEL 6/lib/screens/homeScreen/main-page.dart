import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'item_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController kondisiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    final name = user.displayName;
    final email = user.email;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Tambah Barang'),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                //// VIEW DATA HERE
                StreamBuilder<QuerySnapshot>(
                    stream: users.snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data.docs
                              .map((e) => ItemCard(
                                    e.data()['name'],
                                    e.data()['age'],
                                    e.data()['kondisi'],
                                    e.data()['Inven'],
                                    onUpdate: () {
                                      users.doc(e.id).update(
                                          {'kondisi': 'dipinjam oleh $email'});
                                    },
                                    onUpdate1: () {
                                      users
                                          .doc(e.id)
                                          .update({'kondisi': 'Tersedia'});
                                    },
                                    onDelete: () {
                                      users.doc(e.id).delete();
                                    },
                                  ))
                              .toList(),
                        );
                      } else {
                        return Text('Loading');
                      }
                    }),
                SizedBox(
                  height: 150,
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 150,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: nameController,
                              decoration: InputDecoration(hintText: "Name"),
                            ),
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: ageController,
                              decoration: InputDecoration(hintText: "No Alat"),
                              keyboardType: TextInputType.number,
                            ),
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: kondisiController,
                              decoration: InputDecoration(hintText: "Kondisi"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 130,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.blue[900],
                            child: Text(
                              'Add Data',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              //// ADD DATA HERE
                              users.add({
                                'name': nameController.text,
                                'age': int.tryParse(ageController.text),
                                'kondisi': kondisiController.text
                              });
                              nameController.text = '';
                              ageController.text = '';
                              kondisiController.text = '';
                            }),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
