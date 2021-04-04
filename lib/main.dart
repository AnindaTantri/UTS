//kode utama Aplikasi tampilan awal
import 'package:flutter/material.dart';
import 'sqlite/HomeDeskripsi.dart';
import 'sqlite/HomeStokan.dart';

//package letak folder Anda
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("Item"),
                ),
                Tab(
                  text: "Stok an",
                ),
              ],
            ),
            backgroundColor: Colors.red,
            title: Text('Gudang Jaringan'),
          ),
          body: TabBarView(
            children: [
              HomeDeskripsi(),
              HomeStokan(),
            ],
          ),
        ),
      ),
    );
  }
}
