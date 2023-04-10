import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_app/constant/colors.dart';
import 'package:music_app/constant/text_style.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;

  const PlayerScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                  child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: QueryArtworkWidget(
                  // id: 10,
                  id: data[controller.playIndex.value].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    size: 48,
                    color: whiteColor,
                  ),
                ),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      // "fvghb",
                      data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      // "bn",
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                        size: 25,
                        color: darkBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            controller.position.value,
                            style: ourStyle(color: darkBlack),
                          ),
                          Expanded(
                            child: Slider(
                              label: controller.position.value.toString(),
                              thumbColor: sliderColor,
                              inactiveColor: lightGrey,
                              activeColor: sliderColor,
                              min: Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              onChanged: (newValue) {
                                controller.changeDurationToSeconds(newValue.toInt());
                                newValue = newValue;
                              },
                              value: controller.value.value,
                              // value: controller.updatePosition(),
                            ),
                          ),
                          Text(
                            controller.duration.value,
                            style: ourStyle(color: darkBlack),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.playSong(data[controller.playIndex.value - 1].uri, controller.playIndex.value - 1);
                          },
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 30,
                            color: darkBlack,
                          ),
                        ),
                        Obx(
                          () => CircleAvatar(
                            radius: 35,
                            backgroundColor: darkBlack,
                            child: Transform.scale(
                              scale: 2.5,
                              child: IconButton(
                                splashRadius: 25,
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                },
                                icon: controller.isPlaying.value
                                    ? const Icon(
                                        Icons.pause,
                                        color: whiteColor,
                                        size: 22,
                                      )
                                    : const Icon(Icons.play_arrow_rounded, size: 22),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.playSong(data[controller.playIndex.value + 1].uri, controller.playIndex.value + 1);
                          },
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            size: 30,
                            color: darkBlack,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
