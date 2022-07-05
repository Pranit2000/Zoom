import 'package:flutter/material.dart';
import 'package:zoom/resources/firestore_methods.dart';

class HistoryMeetingSceen extends StatefulWidget {
  const HistoryMeetingSceen({Key? key}) : super(key: key);

  @override
  State<HistoryMeetingSceen> createState() => _HistoryMeetingSceenState();
}

class _HistoryMeetingSceenState extends State<HistoryMeetingSceen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingsHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              "Room Name: ${(snapshot.data! as dynamic).docs[index]['meetingName']}",
            ),
            subtitle: Text(
              'Joined on: ${((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
            ),
          ),
        );
      },
    );
  }
}
