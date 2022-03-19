import 'package:get/get.dart';
import 'package:music_player_fluttter/models/stream.dart';

class StreamController extends GetxController {
  var streams = <Stream>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchStreams();
  }

  void fetchStreams() {
    var serverResponse = [
      Stream(
        id: 0,
        music:
            "https://mp3l.jamendo.com/?trackid=1890852&format=mp31&from=izRhaNivMlU8qItY0q5PUQ%3D%3D%7CGAambexECRa2R2IVTq551g%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=457719&width=300&trackid=1890852",
        composer: "Nick Ray",
        title: "Break Away",
        long: "04:01",
      ),
      Stream(
        id: 1,
        music:
            "https://mp3l.jamendo.com/?trackid=1883450&format=mp31&from=c0s9nvpfEfRsUsG67crJOg%3D%3D%7CS7btAC1Vtvt5dLWkhxZNRQ%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=453894&width=300&trackid=1883450",
        composer: "The Silhouet",
        title: "Burnin Down Love",
        long: "03:39",
      ),
      Stream(
        id: 2,
        music:
            "https://mp3l.jamendo.com/?trackid=1436621&format=mp31&from=gP3CPq3BmSQzyrJ5FUUl4Q%3D%3D%7CpVBJX6YFBOF2oxm1usFMyw%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=257320&width=300&trackid=1436621",
        composer: "Alex Cohen",
        title: "Good Old Times",
        long: "02:25",
      ),
      Stream(
        id: 3,
        music:
            "https://mp3l.jamendo.com/?trackid=1783659&format=mp31&from=NGE4zJ9mz4vRnZwmWj%2FQdA%3D%3D%7C6XGo4hVMOuV5wv16tMgh6w%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=195809&width=300&trackid=1783659",
        composer: "Carter Vail",
        title: "Love-15",
        long: "03:19",
      ),
      Stream(
        id: 4,
        music:
            "https://mp3l.jamendo.com/?trackid=1890852&format=mp31&from=izRhaNivMlU8qItY0q5PUQ%3D%3D%7CGAambexECRa2R2IVTq551g%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=457719&width=300&trackid=1890852",
        composer: "Nick Ray",
        title: "Break Away",
        long: "04:01",
      ),
      Stream(
        id: 5,
        music:
            "https://mp3l.jamendo.com/?trackid=1883450&format=mp31&from=c0s9nvpfEfRsUsG67crJOg%3D%3D%7CS7btAC1Vtvt5dLWkhxZNRQ%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=453894&width=300&trackid=1883450",
        composer: "The Silhouet",
        title: "Burnin Down Love",
        long: "03:39",
      ),
      Stream(
        id: 6,
        music:
            "https://mp3l.jamendo.com/?trackid=1436621&format=mp31&from=gP3CPq3BmSQzyrJ5FUUl4Q%3D%3D%7CpVBJX6YFBOF2oxm1usFMyw%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=257320&width=300&trackid=1436621",
        composer: "Alex Cohen",
        title: "Good Old Times",
        long: "02:25",
      ),
      Stream(
        id: 7,
        music:
            "https://mp3l.jamendo.com/?trackid=1783659&format=mp31&from=NGE4zJ9mz4vRnZwmWj%2FQdA%3D%3D%7C6XGo4hVMOuV5wv16tMgh6w%3D%3D",
        picture:
            "https://usercontent.jamendo.com/?type=album&id=195809&width=300&trackid=1783659",
        composer: "Carter Vail",
        title: "Love-15",
        long: "03:19",
      ),
    ];
    streams.value = serverResponse;
  }
}
