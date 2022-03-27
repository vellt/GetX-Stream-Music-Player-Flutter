import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_player_fluttter/controllers/stream_controller.dart';
import 'package:music_player_fluttter/models/stream.dart';

class PlayerController extends GetxController {
  final AudioPlayer _advancedPlayer = AudioPlayer();

  Rx<Duration> duration = Duration(seconds: 0).obs;
  Rx<Duration> position = Duration(seconds: 0).obs;
  final Rx<int> currentStreamIndex = 0.obs;
  final Rx<PlayerState> playState = PlayerState.STOPPED.obs;
  var streams = <Stream>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    final streamController = Get.put(StreamController());
    streams = streamController.streams;

    _advancedPlayer.onDurationChanged.listen((d) => duration.value = d);
    _advancedPlayer.onAudioPositionChanged.listen((p) => position.value = p);
    _advancedPlayer.onPlayerStateChanged
        .listen((PlayerState state) => playState.value = state);
    _advancedPlayer.onPlayerCompletion
        .listen((event) => position.value = duration.value);
  }

  //play
  void smartPlay() async {
    if (playState.value == PlayerState.PLAYING) {
      pause();
    } else {
      resume();
    }
  }

  void play() async {
    stop();
    resume();
  }

  //play
  void resume() async {
    int result =
        await _advancedPlayer.play(streams[currentStreamIndex.value].music!);
    if (result == 1) ; //success
  }

  //pause
  void pause() async {
    int result = await _advancedPlayer.pause();
    if (result == 1) ; //success
  }

  //stop
  void stop() async {
    int result = await _advancedPlayer.stop();
    if (result == 1) {
      position.value = Duration(seconds: 0);
    }
  }

  void next() {
    if (currentStreamIndex.value + 1 != streams.length)
      currentStreamIndex.value++;
    play();
  }

  void back() {
    if (currentStreamIndex.value - 1 != -1) currentStreamIndex.value--;
    play();
  }

  set setPositionValue(double value) =>
      _advancedPlayer.seek(Duration(seconds: value.toInt()));
}
