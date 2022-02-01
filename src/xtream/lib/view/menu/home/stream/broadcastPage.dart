import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:xtream/controller/main/webrtcApi.dart';
import 'package:xtream/util/colors.dart';
import 'dart:html' as html;

import 'package:xtream/util/sizing.dart';
import 'package:xtream/view/menu/home/stream/menu.dart';


class BroadcastPage extends StatefulWidget {
  const BroadcastPage({Key? key}) : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {

  bool isStreaming = true;
  bool isMicOn = true;
  bool isCamOn = true;

  final WebRtcApi webRtcApi = WebRtcApi();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');


  Future<void> createRoom() async{
    String roomId = await webRtcApi.createRoom(_remoteRenderer);
    print("Room id: ${roomId}");
  }

  @override
  void initState() {
    super.initState();
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    webRtcApi.onAddRemoteStream = ((stream){
      _remoteRenderer.srcObject = stream;
      setState(() { });
    });
    webRtcApi.openUserMedia(_localRenderer, _remoteRenderer, isMicOn, isCamOn);
    createRoom();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: PersonalizedColor.black,),
          onPressed: () => Navigator.pop(context)
        ),
        titleSpacing: 0,
        backgroundColor: PersonalizedColor.red,
        title: Text(
          "Streaming",
          style: TextStyle(
              color: PersonalizedColor.black
          ),
        ),
      ),
      body: Stack(
        children: [

          Container(
            color: PersonalizedColor.black,
            child: Center(
              child: Column(
                children: [

                  Stack(
                    children: <Widget>[

                      Container(
                          width: Sizing.getScreenWidth(context), // MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.height * 0.70,
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: PersonalizedColor.black,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [

                              isCamOn ?
                              RTCVideoView(_localRenderer,
                                  mirror: true,
                                  filterQuality: FilterQuality.high,
                                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover
                              )
                                  :
                              Center(
                                  child: Icon(
                                    isCamOn ?  Icons.videocam : Icons.videocam_off, // Icons.mic
                                    color: Colors.grey,
                                    size: 50.0,
                                  )
                              ),

                              Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Row(
                                    children: [

                                      !isMicOn ?
                                      const Icon(
                                        Icons.mic_off,
                                        color: Colors.grey,
                                        size: 20.0,
                                      )
                                          :
                                      Container(),

                                      !isCamOn ?
                                      const Icon(
                                        Icons.videocam_off,
                                        color: Colors.grey,
                                        size: 20.0,
                                      )
                                          :
                                      Container(),

                                    ],
                                  )
                              )

                            ],
                          )
                      ),

                    ],
                  ),

                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        RawMaterialButton(
                          onPressed: () {
                            setState(() => isMicOn = !isMicOn );
                            webRtcApi.updateMic(isMicOn);
                          },
                          child:  Icon(
                            isMicOn ?  Icons.mic : Icons.mic_off,
                            color: Colors.white, // color.blueaccent
                            size: 20.0,
                          ),
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.blueAccent,
                          padding: const EdgeInsets.all(12.0),
                        ),


                        RawMaterialButton(
                          onPressed: (){},
                          child: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          padding: const EdgeInsets.all(15.0),
                        ),


                        RawMaterialButton(
                          onPressed: () {
                            setState(() => isCamOn = !isCamOn);
                            webRtcApi.updateVideo(_localRenderer, isCamOn);
                          },
                          child: Icon(
                            isCamOn ?  Icons.videocam : Icons.videocam_off, // Icons.mic
                            color: Colors.white,
                            size: 20.0,
                          ),
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.blueAccent,
                          padding: const EdgeInsets.all(12.0),
                        ),

                      ],
                    ),
                  )

                ],
              ),
            ),
          ),

          getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.desktop ?
            Positioned(
              bottom: 0,
              right: 20,
              child: Container(
                width: (MediaQuery.of(context).size.width - Sizing.getScreenWidth(context)) / 2.5,
                padding: const EdgeInsets.only(right: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                ),
                child: const StreamMenu()
              ),
            )
          : Container()

        ],
      ),
      floatingActionButton: getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.mobile || getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.tablet ?
        Padding(
          padding: const EdgeInsets.only(right: 35, bottom: 10),
          child: FloatingActionButton(
            child: const Icon(Icons.more_horiz),
            onPressed: () async {
              await showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  builder: (context) {
                    return Container(
                        width: (MediaQuery.of(context).size.width - Sizing.getScreenWidth(context)) / 2.5,
                        padding: const EdgeInsets.only(right: 5),
                        decoration:  BoxDecoration(
                            color: PersonalizedColor.black,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                        ),
                        child: const StreamMenu()
                    );
                  }
              );
            },
          ),
        ) : null,
    );
  }

}
