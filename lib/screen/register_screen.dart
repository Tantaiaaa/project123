import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/loginsreen.dart';
import 'package:flutter_application_1/screen/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String? errorMessage;
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final ImagePicker _picker = ImagePicker();
  CollectionReference profileCollection =
      FirebaseFirestore.instance.collection("profile");

  @override
  Widget build(BuildContext context) {
    Widget imageProfile() {
      return Center(
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage("assets/sdsaasd.png"),
              backgroundColor: Colors.white,
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => AppBar()),
                  );
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Color.fromARGB(255, 0, 255, 17),
                  size: 28,
                ),
              ),
            )
          ],
        ),
      );
    }

    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Error"),
                ),
                body: Center(
                  child: Text("${snapshot.error}"),
                ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: firebase,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                        appBar: AppBar(
                          title: Text("Error"),
                        ),
                        body: Center(
                          child: Text("${snapshot.error}"),
                        ));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    final signUpButton = Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                      child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              await profileCollection.add({
                                "email": profile.email,
                                "password": profile.password,
                                "name": profile.name,
                                "id": profile.id,
                                "group": profile.group,
                                "phone": profile.phone,
                              });
                              formKey.currentState?.reset();
                            }
                          },
                          child: Text(
                            "ยืนยันการสมัครสมาชิก",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    );
                    final email = TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                          EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                        ]),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (var email) {
                          profile.email = email;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "email ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));

                    final password = TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกพาสเวิด"),
                        onSaved: (var password) {
                          profile.password = password;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "รหัสผ่าน",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));

                    final firstNameFielf = TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกชื่อนามสกุล"),
                        onSaved: (String? name) {
                          profile.name = name;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "ชื่อ-นามสกุล",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));

                    final idEditingFielf = TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกหรัสประจำตัว"),
                        onSaved: (var id) {
                          profile.id = id;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.drive_file_rename_outline),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "รหัสประจำตัว",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));

                    final subjectEditingFielf = TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: RequiredValidator(errorText: "กรุณากรอกคณะ"),
                        onSaved: (var group) {
                          profile.group = group;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.book),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "คณะ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));

                    final phoneFielf = TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator:
                            RequiredValidator(errorText: "กรุณากรอกเบอร์โทร"),
                        onSaved: (var phone) {
                          profile.phone = phone;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "เบอร์โทรศัพท์",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          "สมัครสมาชิก",
                          textScaleFactor: 1.5,
                          style: TextStyle(
                            fontSize: 23,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        centerTitle: false,
                        backgroundColor: Color.fromARGB(255, 68, 111, 253),
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      backgroundColor: Color.fromARGB(255, 237, 10, 10),
                      body: Center(
                        child: SingleChildScrollView(
                          child: Container(
                            color: Color.fromARGB(255, 253, 253, 253),
                            child: Padding(
                              padding: const EdgeInsets.all(36.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    imageProfile(),
                                    email,
                                    SizedBox(height: 20),
                                    password,
                                    SizedBox(height: 15),
                                    firstNameFielf,
                                    SizedBox(height: 15),
                                    idEditingFielf,
                                    SizedBox(height: 15),
                                    subjectEditingFielf,
                                    SizedBox(height: 15),
                                    phoneFielf,
                                    SizedBox(height: 15),
                                    signUpButton,
                                    SizedBox(height: 200),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                });
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
