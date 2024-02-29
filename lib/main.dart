import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab09_firebase/firebase_options.dart';
import 'controller/firebase_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FireBaseController firebaseController = Get.put(FireBaseController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Add new ToDos List"),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: "Todo Title", border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  firebaseController.addToDo(titleController.text);
                  titleController.clear();
                },
                child: Text("Add")),
             Expanded(
               child: StreamBuilder<QuerySnapshot>(
                    stream: firebaseController.GetToDoList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List todolist = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: todolist.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = todolist[index];
                            String docID=document.id;
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;

                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text(data['title']),
                                subtitle: Text("Create at ::}"),
                                trailing: IconButton(
                                  onPressed: (){},icon: Icon(Icons.edit),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      else {
                        return Text("No data in firebase");
                      }
                    },
                  ),
             )
          ],
        ),
      ),
    );
  }
}
