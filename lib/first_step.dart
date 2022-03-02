import 'package:flutter/material.dart';
import 'package:safio_demo/second_step.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';

class FirstStepPage extends StatefulWidget {
  const FirstStepPage({Key? key}) : super(key: key);

  @override
  State<FirstStepPage> createState() => _FirstStepPageState();
}

class _FirstStepPageState extends State<FirstStepPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final int _setTimer = 119;
  int _start = 119;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = _setTimer;
          });
        } else {
          setState(() {
            _start--;
          });
        }
        if (_start == (_setTimer/2).round()) {
          setState(() {
            assetsAudioPlayer.open(
              Audio("sounds/bell.mp3"),
            );
            timer.cancel();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondStepPage()),
            );
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('First step'),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset("images/recipe.jpg"),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    value: _start/_setTimer,
                  ),
                ),
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    color: Colors.black12,
                    strokeWidth: 5,
                    value: 1,
                  ),
                ),
                Text(
                  _start > 59
                      ? '${(_start~/60).toString()}:${(_start-60).toString()}'
                      : '${(_start~/60).toString()}:${(_start).toString()}',
                  // _start.toString(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nulla non arcu lacinia neque faucibus fringilla. ',
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){_firstDialog();},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
