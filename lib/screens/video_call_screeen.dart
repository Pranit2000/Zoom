import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom/resources/auth_methods.dart';
import 'package:zoom/resources/jitsi_meet_methods.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/meeting_option.dart';

class VideoCallScree extends StatefulWidget {
  const VideoCallScree({Key? key}) : super(key: key);

  @override
  State<VideoCallScree> createState() => _VideoCallScreeState();
}

class _VideoCallScreeState extends State<VideoCallScree> {
  final Authmethod _authmethod = Authmethod();
  final JitsiMeetMethoods _jitsiMeetMethoods = JitsiMeetMethoods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
      text: _authmethod.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting() {
    _jitsiMeetMethoods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Join a Meeting",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Room ID",
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Join",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(
            text: "Mute Audio",
            isMute: isAudioMuted,
            onChanged: onAudioMuted,
          ),
          MeetingOption(
            text: "Turn Off my Video",
            isMute: isVideoMuted,
            onChanged: onVideoMuted,
          ),
        ],
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
