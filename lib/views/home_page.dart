import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:music_player_fluttter/controllers/player_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:music_player_fluttter/extensions/duration_extensions.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1C1B1B),
        body: Padding(
          padding: EdgeInsets.only(
            top: 5.h,
            left: 16.sp,
            bottom: 10.sp,
            right: 16.sp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.sp, bottom: 20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Music Player",
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontFamily: "Segoe UI",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (await canLaunch("https://github.com/vellt"))
                          await launch("https://github.com/vellt");
                      },
                      child: Text(
                        "GitHub/vellt",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: "Segoe UI",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF71B77A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Obx(
                  () => ListView.builder(
                    itemCount: playerController.streams.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.sp),
                          ),
                          onTap: () {
                            playerController.currentStreamIndex.value = index;
                            playerController.play();
                          },
                          child: Obx(
                            () => Container(
                              height: 52.sp,
                              decoration: BoxDecoration(
                                color: (playerController
                                            .currentStreamIndex.value ==
                                        index)
                                    ? Color(0xFF2A2A2A)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.sp),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 13.sp),
                                    child: Container(
                                      height: 35.sp,
                                      width: 35.sp,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.sp)),
                                        child: Image.network(
                                          playerController
                                              .streams[index].picture!,
                                          frameBuilder: (BuildContext context,
                                              Widget child,
                                              int? frame,
                                              bool wasSynchronouslyLoaded) {
                                            return (frame != null)
                                                ? child
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.all(8.sp),
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 5.sp,
                                                      color: Color(0xFF71B77A),
                                                    ),
                                                  );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Color(0xFF71B77A),
                                              child: Center(
                                                child: Text("404"),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              playerController
                                                  .streams[index].composer!,
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Color(0xFFACACAC),
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Segoe UI",
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 15.sp),
                                              child: Text(
                                                playerController
                                                    .streams[index].long!,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Color(0xFFACACAC),
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: "Segoe UI",
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          playerController
                                              .streams[index].title!,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Segoe UI",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFF1C1B1B),
                      blurRadius: 15.sp,
                      offset: Offset(0, 0),
                      spreadRadius: 30.sp,
                    ),
                  ],
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.sp, left: 15.sp),
                        child: Row(
                          children: [
                            Text(
                              playerController.position.value.timeFormat,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                  activeColor: Color(0xFF71B77A),
                                  inactiveColor: Color(0xFFEFEFEF),
                                  value: playerController
                                      .position.value.inSeconds
                                      .toDouble(),
                                  min: 0.0,
                                  max: playerController.duration.value.inSeconds
                                          .toDouble() +
                                      1.0,
                                  onChanged: (double value) {
                                    playerController.setPositionValue = value;
                                  }),
                            ),
                            Text(
                              playerController.duration.value.timeFormat,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10.sp,
                            left: 10.sp,
                            top: 5.sp,
                            bottom: 16.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                playerController.back();
                              },
                              iconSize: 35.sp,
                              icon: Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                playerController.smartPlay();
                              },
                              iconSize: 60.sp,
                              icon: Icon(
                                (playerController.playState.value ==
                                        PlayerState.PLAYING)
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  playerController.next();
                                },
                                iconSize: 35.sp,
                                icon: Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
