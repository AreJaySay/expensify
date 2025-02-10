import 'package:expensify/services/routes.dart';
import 'package:expensify/utils/palettes.dart';
import 'package:expensify/views/landing.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final Routes _routes = new Routes();
  List<String> _icons = ["welcome1", "welcome2", "welcome3"];
  List<String> _title = ["Track your expenses", "Set your budget", "Manage your bills"];
  List<String> _subTitle = [
    "All your spends, bills, credit card and E-wallet money all at one place",
    "You can set your daily budget with this app",
    "Manage your Bills easily withing you mobile device"];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palettes.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            _selected == 2 ?
            SizedBox() :
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text("Skip",style: TextStyle(fontFamily: "semibold",color: Colors.white,fontSize: 15),),
                onPressed: (){
                  _routes.navigator_pushreplacement(context, Landing());
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Image(
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              image: AssetImage("assets/images/${_icons[_selected]}.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(_title[_selected],style: TextStyle(fontFamily: "bold",fontSize: 20,color: palettes.secondary),),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(_subTitle[_selected],style: TextStyle(fontFamily: "regular",color: Colors.white),textAlign: TextAlign.center,),
            ),
            Spacer(),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                for(int x = 0; x < 3; x++)...{
                  _selected == x ?
                  Icon(Icons.radio_button_checked,color: Colors.white,) :
                  Icon(Icons.circle,color: Colors.white,),
                  SizedBox(
                    width: 10,
                  )
                },
                Spacer(),
                TextButton(
                  child: Text(_selected == 2 ? "Let's Go" : "Next",style: TextStyle(fontFamily: "semibold",color: Colors.white,fontSize: 15),),
                  onPressed: (){
                    if(_selected == 2){
                      _routes.navigator_pushreplacement(context, Landing());
                    }else{
                      setState(() {
                        _selected++;
                      });
                    }
                  },
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
