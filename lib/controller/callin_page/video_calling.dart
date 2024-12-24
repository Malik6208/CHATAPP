import 'package:chat_app/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
class VideoCalling extends StatelessWidget {
  final String userName;
  final String userId;
  final String callId;
   VideoCalling({
     super.key,
     required this.userId,
     required this.userName,
     required this.callId});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: AppConstant.appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: AppConstant.appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userId,
      userName: userName,
      callID: callId,

      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
    Navigator.pop(context);
  }
}
