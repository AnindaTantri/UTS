import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'DbHelper.dart';
import 'EntryFromDeskripsi.dart';
import 'Deskripsi.dart';

//pendukung program asinkron
class HomeDeskripsi extends StatefulWidget {
  @override
  HomeDeskripsiState createState() => HomeDeskripsiState();
}

class HomeDeskripsiState extends State<HomeDeskripsi> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Deskripsi> deskripsiList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (deskripsiList == null) {
      deskripsiList = [];
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Gudang Jaringan'),
      // ),
      backgroundColor: Colors.red,
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("Tambah Deskripsi"), //button tambah deskripsi
              onPressed: () async {
                var data = await navigateToEntryForm(context, null);
                if (data != null) {
                  int result = await dbHelper.insertDeskripsi(data);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Deskripsi> navigateToEntryForm(
      BuildContext context, Deskripsi data) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(data);
    }));
    return result;
  }

//list view yang akan ditampilkan
  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.deskripsiList[index].name,
              style: textStyle,
            ),
            subtitle: Text(this.deskripsiList[index].keterangan),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                dbHelper.deleteDeskripsi(this.deskripsiList[index].id);
                updateListView();
              },
            ),
            onTap: () async {
              var data =
                  await navigateToEntryForm(context, this.deskripsiList[index]);
              int result = await dbHelper.updateDeskripsi(data);
              if (result > 0) {
                updateListView();
              }
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Deskripsi>> itemListFuture = dbHelper.getDeskripsiList();
      itemListFuture.then((itemList) {
        setState(() {
          this.deskripsiList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
