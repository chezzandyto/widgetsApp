import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = 'Progress Screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        SizedBox(height: 30),
        Text('Circular progress indicator'),
        SizedBox(height: 30),
        CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Colors.black45,
        ),
        SizedBox(height: 20),
        Text('Circular and Linear progress indicator controlled'),
        _ControlledProgressIndicator(),
      ],
    ));
  }
}

class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: Stream.periodic(const Duration(milliseconds: 50), (value) {
          return (value) / 100;
        }).takeWhile((value) => value < 100),
        builder: (context, snapshot) {
          final progressValue = snapshot.data ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 2,
                  backgroundColor: Colors.black12,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: LinearProgressIndicator(
                  value: progressValue,
                ))
              ],
            ),
          );
        });
  }
}
