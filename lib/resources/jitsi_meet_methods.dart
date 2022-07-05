import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom/resources/auth_methods.dart';
import 'package:zoom/resources/firestore_methods.dart';

class JitsiMeetMethoods {
  final Authmethod _authmethod = Authmethod();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (username.isEmpty) {
        name = _authmethod.user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = _authmethod.user.email
        ..userAvatarURL = _authmethod.user.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
