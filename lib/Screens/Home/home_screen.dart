import 'package:firebase/Screens/Home/create_user.dart';
import 'package:firebase/Styles/customColors.dart';
import 'package:firebase/Widgets/custom_icon_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fb = FirebaseDatabase.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var l;
  var g;
  var k;
  @override
  Widget build(BuildContext context) {
    const title = "Home Page";
    final ref = fb.ref().child('user');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreateUser(),
                      ),
                    );
                  },
                  buttonIcon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 6),
                      borderRadius: BorderRadius.circular(16)),
                  height: 675,
                  width: 350,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          FirebaseAnimatedList(
                            query: ref,
                            shrinkWrap: true,
                            itemBuilder: (context, snapshot, animation, index) {
                              var v = snapshot.value.toString();

                              g = v.replaceAll(RegExp("{|}|password: |title: "),
                                  ""); // webfun, subscribe
                              g.trim();

                              l = g.split(','); // [webfun,  subscribe}]

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    k = snapshot.key;
                                  });

                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        child: TextField(
                                          controller: emailController,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: 'Email',
                                          ),
                                        ),
                                      ),
                                      content: Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        child: TextField(
                                          controller: passwordController,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: 'Password',
                                          ),
                                          obscureText: true,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          color: Colors.orange,
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () async {
                                            await upd();
                                            Navigator.of(ctx).pop();
                                          },
                                          color: Colors.orange,
                                          child: Text(
                                            "Update",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      tileColor: Colors.indigo[100],
                                      trailing: IconButton(
                                        onPressed: () {
                                          ref.child(snapshot.key!).remove();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(255, 255, 0, 0),
                                        ),
                                      ),
                                      title: Text(
                                        l[1],
                                        //'dd',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        l[0],
                                        //'dd'
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 = FirebaseDatabase.instance.ref("user/$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "Email": emailController.text,
      "Password": passwordController.text,
    });
    emailController.clear();
    passwordController.clear();
  }
}
