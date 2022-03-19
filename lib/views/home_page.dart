import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_fluttter/controllers/player_controller.dart';
import 'package:sizer/sizer.dart';

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
            top: 60.sp,
            left: 10.sp,
            bottom: 10.sp,
            right: 10.sp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.sp, bottom: 15.sp),
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
                    Text(
                      "GitHub/vellt",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: "Segoe UI",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF71B77A),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
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
                            playerController.setCurrentStreamIndex = index;
                            playerController.play();
                          },
                          child: Obx(
                            () => Container(
                              height: 52.sp,
                              decoration: BoxDecoration(
                                color:
                                    (playerController.getCurrentStreamIndex ==
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
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(playerController
                                              .streams[index].picture!),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.sp),
                                        ),
                                      ),
                                      width: 35.sp,
                                      height: 35.sp,
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
                  );
                }),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 15.sp, left: 15.sp, top: 5.sp),
                    child: GetX<PlayerController>(builder: (controller) {
                      return Row(
                        children: [
                          Text(
                            controller.getPositionAsFormatSting,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                                activeColor: Color(0xFF71B77A),
                                inactiveColor: Color(0xFFEFEFEF),
                                value: controller.getPositionAsDouble,
                                min: 0.0,
                                max: controller.getDurationAsDouble,
                                onChanged: (double value) {
                                  controller.setPositionValue = value;
                                }),
                          ),
                          Obx(
                            () => Text(
                              controller.getDurationAsFormatSting,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 10.sp, left: 10.sp, top: 5.sp, bottom: 16.sp),
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
                            )),
                        IconButton(
                            onPressed: () {
                              playerController.smartPlay();
                            },
                            iconSize: 60.sp,
                            icon: Obx(
                              () => Icon(
                                (playerController.isPlay.value)
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            )),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
