import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseFrom extends StatefulWidget {
  const FirebaseFrom({super.key});

  @override
  State<FirebaseFrom> createState() => _FirebaseFromState();
}

class _FirebaseFromState extends State<FirebaseFrom> {
final TextEditingController  _nameCotroller = TextEditingController();

Future<void> _saveName() async {
  final name = _nameCotroller.text;
  if(name.isEmpty) return;

  await FirebaseFirestore.instance.collection('sers').add({
    "name": name,
    "timestamp": FieldValue.serverTimestamp()
  });

  _nameCotroller.clear(); 

  if (mounted) {
  ScaffoldMessenger.of(
    context,)
    .showSnackBar(SnackBar(content: Text('Data Berhasil Tersimpan')));
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore From"),
      ),
      body: Padding(padding: EdgeInsetsGeometry.all(20),
      child: Column(
        children: [
          TextField(
            controller: _nameCotroller,
            decoration: InputDecoration(labelText: "Masukan Nama"),
          ),
          SizedBox(height: 20,),

          ElevatedButton(onPressed: _saveName, child: Text("Simpan ke Firestore"))
        ],
      ),
      ),
    );
  }
}