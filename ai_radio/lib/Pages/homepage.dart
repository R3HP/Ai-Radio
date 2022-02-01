import 'dart:math';

import 'package:ai_radio/Util/ai_util/ai_util.dart';
import 'package:ai_radio/Util/ai_util/platformDetciton.dart';
import 'package:ai_radio/models/radio.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPlaying = false;
  MyRadio _selectedRadio;
  Color _selectedRadioColor;
  List<MyRadio> radios = [];

  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(radios.isEmpty);
    print(radios.length);
    print(radios == null ? 'null' : 'not null');
    fetchRadios();
    setAlan();

    // audioPlayer.onPlayerStateChanged.listen((event) {
    //   if(event == PlayerState.PAUSED)
    // });
  }

  setAlan() {
    AlanVoice.addButton(
        '3ea1656d9943c263f45649695979c5002e956eca572e1d8b807a3e2338fdd0dc/stage');

    AlanVoice.callbacks.add((command) => handleAlanCallbacks(command.data));
  }

  handleAlanCallbacks(Map<String, dynamic> alanRespone) {
    print(alanRespone);
    print(alanRespone["command"]);
    switch (alanRespone["command"]) {

      case "play":
        playRadio(_selectedRadio.url);
        break;
      case "stop":
        playRadio(_selectedRadio.url);
        break;
      case "next":
        int currntindex =
            radios.indexWhere((element) => element.id == _selectedRadio.id);
        if (currntindex + 1 > radios.length) {
          _selectedRadio = radios[0];
          setState(() {});
          playRadio(_selectedRadio.url);
        } else {
          _selectedRadio = radios[currntindex + 1];
          setState(() {});
          playRadio(_selectedRadio.url);
        }
        break;
      case "prev":
        int currntindex =
            radios.indexWhere((element) => element.id == _selectedRadio.id);
        if (currntindex - 1 < 0) {
          _selectedRadio = radios[radios.lastIndex];
          setState(() {});
          playRadio(_selectedRadio.url);
        } else {
          _selectedRadio = radios[currntindex - 1];
          setState(() {});
          playRadio(_selectedRadio.url);
        }
        break;
      case "playrandom":
        int currentIndex =
            radios.indexWhere((element) => element.id == _selectedRadio.id);
        Random random = Random();
        int randomIndex = random.nextInt(radios.length);
        while (randomIndex == currentIndex) {
          randomIndex = random.nextInt(radios.length);
        }
        _selectedRadio = radios[currentIndex];
        setState(() {});
        playRadio(_selectedRadio.url);
        break;
      case "playID":
        int channelID = alanRespone["id"];
        int index = radios.indexWhere((element) => element.id == channelID);
        _selectedRadio = radios[index];
        setState(() {});
        playRadio(_selectedRadio.url);
        break;
      default:
        print('defualt set alan');
        break;
    }
  }

  fetchRadios() async {
    radios = MyRadioList.fromJson(
            await rootBundle.loadString('assets/radio_list.json'))
        .radios;
    print(radios.isEmpty);
    print(radios.length);
    print(radios == null ? 'null' : 'not null');
    for (MyRadio rad in radios) {
      print(rad.tagLine);
    }
    print('init _selection Radio');
    _selectedRadio = radios[0];
    print('initial selected radio is ${_selectedRadio.name}');
    _selectedRadioColor = Color(int.parse(_selectedRadio.color));
    print(_selectedRadioColor.toString());

    setState(() {});
  }

  playRadio(String url) {
    print('playradio');
    if (_isPlaying) {
      print('is playin should stop');
      _isPlaying = false;
      setState(() {});
      audioPlayer.stop();
    } else {
      print('isnt playing should play');
      _isPlaying = true;
      setState(() {});
      audioPlayer.play(url);
    }
    // if (_isPlaying) {
    //   print('play radio is playing ');
    //   _isPlaying = false;
    //   setState(() {});
    //   audioPlayer.pause();
    // } else {
    //   print('play radio isnt playing   ');
    //   _selectedRadio = radios.firstWhere((element) => element.url == url);
    //   _isPlaying = true;
    //   setState(() {});
    //   if (audioPlayer.state == AudioPlayerState.PAUSED) {
    //     print('play radio isnt playing puased');
    //     audioPlayer.resume().then((value) {});
    //   } else {
    //     print('play radio isnt playing isnt puased');
    //     audioPlayer.play(url).then((value) {});
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: "Ai Radio ".text.xl4.bold.make().shimmer(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          VxAnimatedBox()
              .withGradient(
                LinearGradient(colors: [
                  AIColors.primaryColor2,
                  _selectedRadio == null
                      ? AIColors.primaryColor1
                      : _selectedRadioColor
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              )
              .easeInOut
              .animDuration(Duration(milliseconds: 2))
              .size(context.screenWidth, context.screenHeight)
              .make(),
          radios.isEmpty || radios == null
              ? Container()
              : Align(
                  alignment: Alignment.topCenter,
                  child: VxSwiper.builder(
                    initialPage: radios.indexWhere((element) => element.id == _selectedRadio.id),
                    enlargeCenterPage: true,
                    itemCount: radios.length,
                    aspectRatio: 1.0,
                    itemBuilder: (BuildContext context, int index) {
                      var radio = radios[index];
                      return VxBox(
                        child: ZStack([
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: VxBox(
                                child: radio
                                    .category.text.uppercase.italic.white
                                    .make(),
                              )
                                  .color(AIColors.primaryColor2)
                                  .withRounded(value: 10.0)
                                  .width(80.0)
                                  .alignCenter
                                  .height(40.0)
                                  .make()),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: VStack(
                              [
                                radio.name.text.bold.xl3.white.italic.make(),
                                5.heightBox,
                                radio.tagLine.text.sm.warmGray300.italic.make()
                              ],
                              crossAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: [
                              Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                              ),
                              "Double Tap , To Play !"
                                  .text
                                  .white
                                  .italic
                                  .sm
                                  .make(),
                            ].vStack(),
                          )
                        ]),
                      )
                          .clip(Clip.antiAlias)
                          .bgImage(DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                              image: NetworkImage(radio.image),
                              fit: BoxFit.cover))
                          .withRounded(value: 18)
                          .border()
                          .make()
                          .p16();
                    },
                    onPageChanged: (int index) {
                      print(index);
                      _selectedRadio = radios[index];
                      print(_selectedRadio.name);
                      _selectedRadioColor =
                          Color(int.parse(_selectedRadio.color));
                      print(_selectedRadioColor);
                      setState(() {
                        //   print(index);
                        // _selectedRadio = radios[index];
                        // print(_selectedRadio.name);
                        // _selectedRadioColor = Color(int.parse(_selectedRadio.color));
                        // print(_selectedRadioColor);
                      });
                    },
                  ).pLTRB(0, 85, 0, 0),
                ),
          Align(
                  alignment: Alignment.bottomCenter,
                  child: [
                    _isPlaying
                        ? "Now Playing ${_selectedRadio.name}"
                            .text
                            .white
                            .italic
                            .sm
                            .make()
                        : "Now isnt playing".text.italic.white.sm.make(),
                    Icon(
                            _isPlaying
                                ? Icons.stop_circle_outlined
                                : Icons.play_circle_fill_outlined,
                            size: 65,
                            color: Colors.white)
                        .pLTRB(0, 0, 0, 0)
                        .onInkTap(() {
                      print('icon ink tap');
                      print(_selectedRadio == null);
                      print('selected radio ${_selectedRadio.name}');
                      playRadio(_selectedRadio.url);
                    }),
                  ].vStack())
              .pLTRB(0, 0, 0, 100)
        ],
      ),
    );
  }
}
