import 'package:flutter/material.dart';
import 'package:pedometer_app/repositories/health_repository.dart';
import 'package:pedometer_app/widgets/custom_steps_info.dart';
import 'package:pedometer_app/widgets/painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HealthRepository repository = HealthRepository();
  bool toggleButton = false;
  bool? isAuth;
  @override
  void initState() {
    super.initState();

    initRepo();
  }

  Future<void> initRepo() async {
    try {
      isAuth = await repository.requestAuth();
      setState(() {
        isAuth;
      });
    } catch (e) {
      throw ArgumentError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Шагометр'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: repository.fetchSteps(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CustomStepsInfo(
                      width: width,
                      height: height,
                      snapshot: snapshot,
                      labelText: "Шаги",
                      textColor: const Color(0xFFFD7C00),
                      labelIcon: 'assets/icons/footsteps.png',
                      infoSteps: 'шага',
                      infoWidget: Image.asset(
                        'assets/icons/walk.png',
                        width: width * 0.2,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
              StreamBuilder(
                stream: repository.fetchSteps(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CustomStepsInfo(
                      width: width,
                      height: height,
                      snapshot: snapshot,
                      labelIcon: 'assets/icons/goal.png',
                      labelText: "Цель",
                      textColor: const Color(0xFFE10555),
                      infoSteps: '/10000',
                      infoWidget: Painter(
                        currentSteps: snapshot.data ?? 0,
                        totalSteps: 10000,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              StreamBuilder(
                stream: repository.fetchStepsDistance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CustomStepsInfo(
                      width: width,
                      height: height,
                      snapshot: snapshot,
                      labelIcon: 'assets/icons/route.png',
                      labelText: 'Дистанция ходьбы',
                      textColor: const Color(0xFF5A00D1),
                      infoSteps: 'KM',
                      infoWidget: Image.asset(
                        'assets/icons/distance.png',
                        width: width * 0.2,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              StreamBuilder(
                stream: repository.fetchStepsDuration(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CustomStepsInfo(
                      width: width,
                      height: height,
                      snapshot: snapshot,
                      labelIcon: 'assets/icons/time.png',
                      labelText: 'Время ходьбы',
                      textColor: const Color(0xFF023A88),
                      infoSteps: 'минуты',
                      infoWidget: Image.asset(
                        'assets/icons/prime-time.png',
                        width: width * 0.2,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (toggleButton == true) {
            repository.resume();
          } else {
            repository.pause();
          }
          setState(() {
            toggleButton = !toggleButton;
          });
        },
        child: toggleButton ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
      ),
    );
  }
}
