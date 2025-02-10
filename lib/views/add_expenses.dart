import 'package:expensify/models/expenses.dart';
import 'package:expensify/services/routes.dart';
import 'package:expensify/utils/palettes.dart';
import 'package:expensify/utils/snackbars/snackbar_message.dart';
import 'package:expensify/views/view_expenses.dart';
import 'package:expensify/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpenses extends StatefulWidget {
  final String icon,title;
  final List details;
  final String currentDetails;
  AddExpenses({required this.icon, required this.title, required this.details, required this.currentDetails});
  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final Buttons _buttons = new Buttons();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _desc = new TextEditingController();
  final TextEditingController _price = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.details.isNotEmpty){
      _name.text = widget.details[2];
      _desc.text = widget.details[3];
      _price.text = widget.details[4];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: palettes.primary,
        appBar: AppBar(
          backgroundColor: palettes.primary,
          elevation: 1,
          shadowColor: Colors.white,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text("Add expenses",style: TextStyle(fontFamily: "semibold",fontSize: 20),),
          actions: [
            IconButton(
              icon: Icon(Icons.menu_open_outlined),
              onPressed: (){},
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Category",style: TextStyle(fontFamily: "semibold",color: Colors.white,fontSize: 15),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(1000)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/icons/${widget.icon}.png"),
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(widget.title,style: TextStyle(fontFamily: "medium",color: Colors.white),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Expenses name",style: TextStyle(fontFamily: "semibold",color: Colors.white,fontSize: 15),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(1000)
                  ),
                  child: TextField(
                    controller: _name,
                    style: TextStyle(fontFamily: "regular",color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter name",
                      hintStyle: TextStyle(fontFamily: "regular",color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Description",style: TextStyle(fontFamily: "semibold",color: Colors.white,fontSize: 15),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey.shade500),
                     borderRadius: BorderRadius.circular(1000)
                  ),
                  child: TextField(
                    controller: _desc,
                    style: TextStyle(fontFamily: "regular",color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter description (optional)",
                      hintStyle: TextStyle(fontFamily: "regular",color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Amount",style: TextStyle(fontFamily: "semibold",color: Colors.white,fontSize: 15),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(1000)
                  ),
                  child: TextField(
                    style: TextStyle(fontFamily: "regular",color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter amount",
                        hintStyle: TextStyle(fontFamily: "regular",color: Colors.grey),
                        labelStyle: TextStyle(fontFamily: "regular",color: Colors.grey),
                        // prefix: Text("₱ ",style: TextStyle(color: Colors.white),)
                    ),
                    controller: _price,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      ThousandsFormatter(allowFraction: true)
                    ],
                  ),
                ),
                Spacer(),
                _buttons.button(text: "Save", ontap: ()async{
                  if(_name.text.isEmpty || _price.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "Expenses name and amount are required", is_error: true);
                  }else{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    setState(() {
                      if(widget.details.isNotEmpty){
                        expensesModel.expenses.remove(widget.currentDetails);
                      }
                      expensesModel.expenses.add("${widget.icon}/${widget.title}/${_name.text}/${_desc.text}/${_price.text}/${DateTime.now()}");
                    });
                    prefs.setStringList('expenses', expensesModel.expenses);
                    if(widget.details.isNotEmpty){
                      _routes.navigator_pushreplacement(context, ViewExpenses());
                    }else{
                      Navigator.of(context).pop(null);
                    }
                    _snackbarMessage.snackbarMessage(context, message: "Added new expenses!");
                  }
                },radius: 1000,color: Colors.white,fontColor: palettes.primary),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
