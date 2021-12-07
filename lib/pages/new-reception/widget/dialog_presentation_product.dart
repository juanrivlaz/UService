import 'package:flutter/material.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';
import 'package:video_player/video_player.dart';

bool isVideo(String path) {
  var extention = path.split('.').last;

  return ['mp4'].contains(extention);
}

double calculateHight(double width, { int denominador = 16,  int divisor = 9 }) {
  return (width / denominador) * divisor;
}

Widget dialogPresentationProduct(
  BuildContext context,
  Function close,
  String pathFile,
  ReceptionBloc bloc
) {

  if (isVideo(pathFile)) {
    var controller = VideoPlayerController.network(pathFile, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    controller.addListener(() {
      bloc.changePlayingPresentation(bloc.videoPlayer.value.isPlaying);
    });
    controller.initialize().then((value) {
      bloc.changeVideoPlayer(controller);
    });
  }

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width * .8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: calculateHight(MediaQuery.of(context).size.width * .8),
            child: StreamBuilder(
              stream: bloc.videoPlayerStream,
              builder: (BuildContext ctxvideo, AsyncSnapshot<VideoPlayerController> snpvideo) {
                if (isVideo(pathFile) && (!snpvideo.hasData || (snpvideo.hasData && !snpvideo.data.value.isInitialized))) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Center(
                  child: isVideo(pathFile) ?
                    Stack(
                      children: [
                        VideoPlayer(snpvideo.data),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: StreamBuilder(
                            stream: bloc.playingPresentationStream,
                            builder: (BuildContext ctxplaying, AsyncSnapshot snpplaying) {
                              return IconButton(
                                onPressed: () {
                                  snpplaying.hasData && snpplaying.data ? snpvideo.data.pause() : snpvideo.data.play();
                                  bloc.changeVideoPlayer(snpvideo.data);
                                }, 
                                icon: Opacity(
                                  opacity: snpvideo.data.value.isPlaying ? .3 : 1,
                                  child: Icon(snpvideo.data.value.isPlaying ? Icons.pause_circle : Icons.play_circle, color: Colors.white, size: 100,),
                                )
                              );
                            },
                          ),
                        )
                      ],
                    ) :
                    FadeInImage(
                      image: NetworkImage(pathFile),
                      placeholder: AssetImage(
                          'assets/images/loading.gif'),
                      fit: BoxFit.cover,
                      imageErrorBuilder:
                          (BuildContext ctxError, Object obj,
                              StackTrace stack) {
                        return Container(
                            child: Image(
                                image: AssetImage(
                                    'assets/images/loading.gif')));
                      },
                    ),
                );
              },
            ),
          ),
          Positioned(
              top: -10,
              right: -10,
              child: GestureDetector(
                onTap: close,
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.redAccent
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.close, color: Colors.white),
              ),
              )
          )
        ],
      ),
    ),
  );
}