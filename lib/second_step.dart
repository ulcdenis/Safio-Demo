import 'package:flutter/material.dart';
import 'package:safio_demo/main.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';

class SecondStepPage extends StatefulWidget {
  const SecondStepPage({Key? key}) : super(key: key);

  @override
  State<SecondStepPage> createState() => _SecondStepPageState();
}

class _SecondStepPageState extends State<SecondStepPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final int _setTimer = 60;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            assetsAudioPlayer.open(
              Audio("sounds/bell.mp3"),
            );
            timer.cancel();
            _start = 0;
            _secondDialog();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> _firstDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Krok 1'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nulla non arcu lacinia neque faucibus fringilla. Nam sed tellus id magna elementum tincidunt.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hotovo'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _secondDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Krok 2'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nulla non arcu lacinia neque faucibus fringilla. Nam sed tellus id magna elementum tincidunt.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hotovo'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      _firstDialog();
    });
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
          title: const Text('Second step'),
          automaticallyImplyLeading: false,
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
        )      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
