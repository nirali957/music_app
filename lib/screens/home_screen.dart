import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_app/constant/colors.dart';
import 'package:music_app/constant/text_style.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:music_app/screens/play_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: darkBlack,
        appBar: AppBar(
          backgroundColor: darkBlack,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: whiteColor,
                size: 25,
              ),
              color: lightGrey,
            ),
          ],
          leading: const Icon(
            Icons.sort_rounded,
            color: whiteColor,
            size: 25,
          ),
          title: Text(
            "Music",
            style: ourStyle(
              size: 25,
            ),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL,
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No song found",
                  style: ourStyle(
                    size: 30,
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(() {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tileColor: lightGrey,
                          title: Text(
                            snapshot.data![index].displayNameWOExt,
                            style: ourStyle(size: 18),
                          ),
                          subtitle: Text(
                            "${snapshot.data![index].artist}",
                            style: ourStyle(size: 17),
                          ),
                          trailing: controller.playIndex.value == index && controller.isPlaying.value
                              ? const Icon(
                                  Icons.play_arrow,
                                  color: whiteColor,
                                  size: 32,
                                )
                              : null,
                          onTap: () {
                            Get.to(
                              () => PlayerScreen(
                                data: snapshot.data!,
                              ),
                              transition: Transition.downToUp,
                            );
                            // controller.playSong(snapshot.data![index].uri, index);
                          },
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Icon(
                              Icons.music_note,
                              color: whiteColor,
                              size: 32,
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
