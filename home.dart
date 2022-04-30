import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String  _userDaily;
  List dailyList = [];

  void initFarebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    initFarebase();

    dailyList.addAll(['Пресс','Скакалка']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Меню'),),
          body: Row(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

              }, child: Text('На главную')),
              Padding(padding: EdgeInsets.only(left: 25)),
              Text('Хочу на курсы AVADA Media')
            ],
          )
        );

      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[900],
      appBar: AppBar(
        title: Text('Тренировочка'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _menuOpen,
              icon: Icon(Icons.menu),
          )
        ],

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return Text('Нет записей');
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext text, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data?.docs[index].get('item')),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            dailyList.removeAt(index);
                          });
                        },
                      ),
                    ),

                  ),
                  onDismissed: (direction) {
                    setState(() {
                      dailyList.removeAt(index);
                    });
                  },
                );
              }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellowAccent,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Добавить задание'),
              content: TextField(
                onChanged: (String value) {
                  _userDaily = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  FirebaseFirestore.instance.collection('items').add({'item': _userDaily});
                  Navigator.of(context).pop();
                }, child: Text('Добавить'))
              ],
            );

          });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.black,
        ),
      ),
     );
  }
}
