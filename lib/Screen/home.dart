import 'package:clipit/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:clipit/Screen/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:clipit/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  DataModel dataModel = DataModel();

  String copiedText = '';
  String dataText = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(user!.uid).get().then((
        value) {
      this.loggedInUser =
          UserModel.fromMap(value.data() as Map<String, dynamic>);
      setState(() {});
    });
    FirebaseFirestore.instance.collection("Copied Data").doc(user!.uid).get().then((
        value) {
      this.dataModel =
          DataModel.fromMap(value.data() as Map<String, dynamic>);
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    readDataFromDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text("Clip It"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.name}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              ActionChip(
                label: Text("Logout"),
                onPressed: () {
                  logout(context);
                },
              ),
              SizedBox(
                height: 50, // Set a suitable height for the container
                child: ListView(
                  children: [
                    Text(
                      'Copied Text: $copiedText',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              // Scrollable Text for Data Text
              SizedBox(
                height: 50, // Set a suitable height for the container
                child: ListView(
                  children: [
                    Text(
                      'Data Text: $dataText',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _pasteFromClipboard();
                },
                child: Text('Paste from Clipboard'),
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> _pasteFromClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData != null && clipboardData.text != null) {
        setState(() {
          copiedText = clipboardData.text!;
          sendDataToDatabase();
        });
      } else {
        setState(() {
          copiedText = 'No text in clipboard';
        });
      }
    } catch (e) {
      print('Error getting clipboard data: $e');
    }
  }

  void readDataFromDatabase() {
    // Replace 'databaseReference' with your actual reference
    databaseReference.child("Copied Data").child(user!.uid).once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        try {
          final Map<dynamic, dynamic> dataMap = snapshot.value as Map<dynamic, dynamic>;
          if (dataMap.containsKey('data')) {
            final String newData = dataMap['data'] as String;
            setState(() {
              if (dataText != newData) {
                dataText = newData;
                Clipboard.setData(ClipboardData(text: dataText));
              }
            });
          } else {
            // Handle data column not found case
            print("Data column not found for user ${user!.uid}");
          }
        } catch (e) {
          print("Error casting data: $e");
        }
      } else {
        // Handle user data not found case
        print("User data not found for ID ${user!.uid}");
      }
    }).catchError((error) {
      print("Error reading data: $error");
    });
  }



  /*void readDataFromDatabase() {
    // Replace 'databaseReference' with your actual reference
    databaseReference.child("Copied Data").child(user!.uid).once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        try {
          final Map<dynamic, dynamic> dataMap = snapshot.value as Map<dynamic, dynamic>;
          if (dataMap.containsKey('data')) {
            setState(() {
              final newDataText = dataMap['data'] as String;
              if (newDataText != dataText) {
                dataText = newDataText;
                Clipboard.setData(ClipboardData(text: dataText));
              }
            });

          } else {
            // Handle data column not found case
            print("Data column not found for user ${user!.uid}");
          }
        } catch (e) {
          print("Error casting data: $e");
        }
      } else {
        // Handle user data not found case
        print("User data not found for ID ${user!.uid}");
      }
    }).catchError((error) {
      print("Error reading data: $error");
    });

  }*/






  /*sendDetailstoFirestore(String data) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    DataModel dataModel = DataModel();
    UserModel userModel = UserModel();

    dataModel.data = copiedText;
    userModel.uid = user!.uid;


    await firebaseFirestore
        .collection("Copied Data")
        .doc(user.uid)
        .set(dataModel.toMap());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied Succesfully"),
        duration: Duration(seconds: 2),
      ),
    );
  }*/
  void sendDataToDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref("Copied Data");
    databaseReference.child(user!.uid).set({
      'data': copiedText,
      // Add other key-value pairs as needed
    });

  }



}
