import 'package:flutter/material.dart';
import 'package:vpn_app/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vpn App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<bool> _isToConnect = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vpn App'),
      ),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: _isToConnect,
            builder: (_, isToConnect, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isToConnect ? "Connected" : "Ready",
                    style: TextStyle(
                        color: isToConnect ? AppColors.green : AppColors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(78),
                    onTap: () {
                      _isToConnect.value = !_isToConnect.value;
                    },
                    child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isToConnect ? AppColors.green : AppColors.grey),
                        padding: const EdgeInsets.all(13),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: Text(
                            isToConnect ? "Disconnect" : "Connect",
                            style: const TextStyle(
                                color: AppColors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
