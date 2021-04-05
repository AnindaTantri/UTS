import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'DbHelper.dart';
import 'EntryFormStokan.dart';
import 'Stok.dart';

//pendukung program asinkron
class HomeStokan extends StatefulWidget {
  @override
  HomeStokanState createState() => HomeStokanState();
}

class HomeStokanState extends State<HomeStokan> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Stok> stokList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (stokList == null) {
      stokList = [];
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
              child: Text("Tambah Stok"), //untuk button tambah stokkan
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  int result = await dbHelper.insertStok(item);
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

  Future<Stok> navigateToEntryForm(BuildContext context, Stok item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

//tampilan pada home stokan list data
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
              this.stokList[index].id.toString() +
                  "-" +
                  this.stokList[index].name,
              style: textStyle,
            ),
            subtitle: Text(this.stokList[index].name),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                dbHelper.deleteStok(this.stokList[index].id);

                updateListView();
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.stokList[index]);
              int result = await dbHelper.updateStok(item);
              if (result > 0) {
                updateListView();
              }
            },
          ),
        );
      },
    );
  }

  //untuk mengupdate List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Stok>> itemListFuture = dbHelper.getStokList();
      itemListFuture.then((itemList) {
        setState(() {
          this.stokList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
