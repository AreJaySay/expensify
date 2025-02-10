import 'package:expensify/services/routes.dart';
import 'package:expensify/utils/palettes.dart';
import 'package:expensify/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Chattly',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Routes _routes = new Routes();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 10), () async{
      _routes.navigator_pushreplacement(context, Welcome());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: palettes.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                width: 270,
                image: AssetImage("assets/logos/logo1_transparent.png"),
              ),
              SizedBox(
                height: 80,
              ),
              CircularProgressIndicator(color: palettes.secondary,)
            ],
          ),
        )
    );
  }
}
