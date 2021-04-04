import 'package:flutter/material.dart';
import 'Deskripsi.dart';

class EntryForm extends StatefulWidget {
  final Deskripsi itemdeskripsi;
  EntryForm(this.itemdeskripsi);
  @override
  EntryFormState createState() => EntryFormState(this.itemdeskripsi);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Deskripsi itemdeskripsi;
  EntryFormState(this.itemdeskripsi);
  TextEditingController nameController = TextEditingController();
  TextEditingController serialnumberController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //kondisi

    if (itemdeskripsi != null) {
      serialnumberController.text = itemdeskripsi.serialnumber.toString();
      nameController.text = itemdeskripsi.name;
      keteranganController.text = itemdeskripsi.keterangan;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: itemdeskripsi == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: serialnumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Item',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
//entry  keterangan item/barang
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: keteranganController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: ElevatedButton(
                        // color: Theme.of(context).primaryColorDark,
                        // textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (itemdeskripsi == null) {
                            // tambah data
                            itemdeskripsi = Deskripsi(
                              nameController.text,
                              int.parse(serialnumberController.text),
                              keteranganController.text,
                            );
                          } else {
                            // mengubah data
                            itemdeskripsi.serialnumber =
                                int.parse(serialnumberController.text);
                            itemdeskripsi.name = nameController.text;
                            itemdeskripsi.keterangan =
                                keteranganController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, itemdeskripsi);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: ElevatedButton(
                        // color: Theme.of(context).primaryColorDark,
                        // textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
