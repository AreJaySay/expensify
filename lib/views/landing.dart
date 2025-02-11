import 'dart:ui';

import 'package:expensify/services/routes.dart';
import 'package:expensify/utils/palettes.dart';
import 'package:expensify/views/add_expenses.dart';
import 'package:expensify/views/view_expenses.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../widgets/material_button.dart';

class Landing extends StatefulWidget {
  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final Buttons _buttons = new Buttons();
  final Routes _routes = new Routes();
  List<String> _icons = ["food_grocery","transportation","bills","other"];
  List<String> _title = ["Food & Grocery","Transportation","Bills & Utilities","Other Expenses"];
  int _selected = 0;
  String _selectedIcon = "food_grocery";
  String _selectedTitle = "Food & Grocery";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: palettes.primary,
      body: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            image: NetworkImage("https://www.idfcfirstbank.com/content/dam/idfcfirstbank/images/webstories/savings-account/all-you-need-to-know-about-expense-tracking-for-effective-money-management-02.jpg"),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.3),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text("EXPENSIFY",style: TextStyle(fontFamily: "bold",color: Colors.white,fontSize: 25),),
                    Text("Manage your expenses effortlessly",style: TextStyle(fontFamily: "regular",color: Colors.white),),
                    SizedBox(
                      height: 50,
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (itemWidth / itemHeight),
                      controller: new ScrollController(keepScrollOffset: false),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        for(int x = 0; x < _icons.length; x++)...{
                          ZoomTapAnimation(
                            end: 0.99,
                            onTap: (){
                              setState(() {
                                _selected = x;
                                _selectedIcon = _icons[x];
                                _selectedTitle = _title[x];
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(
                                  color: palettes.secondary.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                children: [
                                  _selected == x ?
                                  Icon(Icons.radio_button_checked,color: palettes.primary,) :
                                  Icon(Icons.circle_outlined,color: palettes.primary,),
                                  Spacer(),
                                  Center(
                                    child: Image(
                                      image: AssetImage("assets/icons/${_icons[x]}.png"),
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(child: Text(_title[x],style: TextStyle(fontFamily: "semibold",color: palettes.primary),textAlign: TextAlign.center,)),
                                  Spacer(),
                                  SizedBox(),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          )
                        }
                      ]
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: _buttons.button(text: "View", ontap: (){
                            _routes.navigator_push(context, ViewExpenses());
                          },color: Colors.white, radius: 1000,fontColor: palettes.primary),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _buttons.button(text: "Add", ontap: (){
                            _routes.navigator_push(context, AddExpenses(icon: _selectedIcon, title: _selectedTitle, details: [],currentDetails: "",));
                          },color: palettes.secondary, radius: 1000,fontColor: palettes.primary),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
