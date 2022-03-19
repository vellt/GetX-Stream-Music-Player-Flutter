import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_player_fluttter/controllers/stream_controller.dart';
import 'package:music_player_fluttter/models/stream.dart';

class PlayerController extends GetxController {
  final Rx<AudioPlayer> _advancedPlayer = AudioPlayer().obs;
  Rx<Duration> _duration = Duration().obs;
  Rx<Duration> _position = Duration().obs;
  final Rx<int> currentStreamIndex = 0.obs;
  final Rx<bool> isPlay = false.obs;
  var streams = <Stream>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final streamController = Get.put(StreamController());
    streams = streamController.streams;
    _advancedPlayer.value.onDurationChanged.listen((d) => _duration.value = d);
    _advancedPlayer.value.onAudioPositionChanged
        .listen((p) => _position.value = p);
    _advancedPlayer.value.onPlayerStateChanged.listen((PlayerState event) {
      isPlay.value = (event == PlayerState.PLAYING) ? true : false;
    });
  }

  //play
  void smartPlay() async {
    if (isPlay.value) {
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
    int result = await _advancedPlayer.value
        .play(streams[currentStreamIndex.value].music!);
    if (result == 1) ; //success
  }

  //pause
  void pause() async {
    int result = await _advancedPlayer.value.pause();
    if (result == 1) ; //success
  }

  //stop
  void stop() async {
    int result = await _advancedPlayer.value.stop();
    if (result == 1) {
      _position.value = Duration(seconds: 0);
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

  String _format(Duration d) {
    String minute =
        int.parse(d.toString().split('.').first.padLeft(8, "0").split(':')[1])
            .toString();
    String second = d.toString().split('.').first.padLeft(8, "0").split(':')[2];
    return ("$minute:$second");
  }

  set setPositionValue(double value) =>
      _advancedPlayer.value.seek(Duration(seconds: value.toInt()));
  set setCurrentStreamIndex(index) => currentStreamIndex.value = index;
  int get getCurrentStreamIndex => currentStreamIndex.value;
  double get getDurationAsDouble => _duration.value.inSeconds.toDouble();
  String get getDurationAsFormatSting => _format(_duration.value);
  double get getPositionAsDouble => _position.value.inSeconds.toDouble();
  String get getPositionAsFormatSting => _format(_position.value);
}
