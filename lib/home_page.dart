import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/add_new_task.dart';
import 'package:firebase/utils.dart';
import 'package:firebase/widgets/date_selector.dart';
import 'package:firebase/widgets/task_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNewTask()),
              );
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const DateSelector(),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance
                      .collection("tasks")
                      .where(
                        'uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('No tasks found'));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(index),
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            await FirebaseFirestore.instance
                                .collection("tasks")
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          } 
                          // else if (direction == DismissDirection.startToEnd) {
                          //   await Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const AddNewTask(),
                          //     ),
                          //   );
                          //   await FirebaseFirestore.instance
                          //       .collection("tasks")
                          //       .doc(snapshot.data!.docs[index].id)
                          //       .update({
                          //         "title":
                          //             snapshot.data!.docs[index]
                          //                 .data()['title'],
                          //       });
                          // }
                        },

                        child: Row(
                          children: [
                            Expanded(
                              child: TaskCard(
                                color: hexToColor(
                                  snapshot.data!.docs[index].data()['color'],
                                ).withOpacity(0.1),
                                headerText:
                                    snapshot.data!.docs[index].data()['title'],
                                descriptionText:
                                    snapshot.data!.docs[index]
                                        .data()['description'],
                                scheduledDate: DateFormat('h:mm a').format(
                                  snapshot.data!.docs[index]
                                      .data()['date']
                                      .toDate(),
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 10,
                            //   width: 10,
                            //   decoration: BoxDecoration(
                            //     color: strengthenColor(
                            //       const Color.fromRGBO(246, 222, 194, 1),
                            //       0.69,
                            //     ),
                            //     shape: BoxShape.circle,
                            //   ),
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.all(12.0),
                            //   child: Text(
                            //     '10:00AM',
                            //     style: TextStyle(fontSize: 17),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
