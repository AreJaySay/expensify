import 'package:expensify/models/expenses.dart';
import 'package:expensify/services/routes.dart';
import 'package:expensify/utils/palettes.dart';
import 'package:expensify/views/add_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'landing.dart';

class ViewExpenses extends StatefulWidget {
  @override
  State<ViewExpenses> createState() => _ViewExpensesState();
}

class _ViewExpensesState extends State<ViewExpenses> {
  final Routes _routes = new Routes();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1), () async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        expensesModel.expenses = prefs.getStringList("expenses")!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palettes.primary,
        appBar: AppBar(
          backgroundColor: palettes.primary,
          elevation: 1,
          shadowColor: Colors.white,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text("My expenses",style: TextStyle(fontFamily: "semibold",fontSize: 20),),
          automaticallyImplyLeading: false,
          leading: BackButton(
            onPressed: (){
              _routes.navigator_pushreplacement(context, Landing());
            },
          ),
        ),
      body: expensesModel.expenses.isEmpty ?
      Center(
        child: Text("NO EXPENSES YET",style: TextStyle(fontFamily: "semibold",fontSize: 16,color: Colors.grey),),
      ) :
      ListView.builder(
        itemCount: expensesModel.expenses.length,
        padding: EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index){
          List _details = expensesModel.expenses[index].split("/");
          return Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  onPressed: (context)async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    setState(() {
                      expensesModel.expenses.remove(expensesModel.expenses[index]);
                    });
                    prefs.setStringList('expenses', expensesModel.expenses);
                  },
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context){
                    _routes.navigator_push(context, AddExpenses(icon: _details[0], title: _details[1], details: _details ,currentDetails: expensesModel.expenses[index],));
                  },
                  backgroundColor: palettes.primary,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            child: Card(
              margin: EdgeInsets.only(top: 2),
              shadowColor: Colors.grey.withOpacity(0.3),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/${_details[0]}.png"),
                  foregroundColor: Colors.grey.shade200,
                ),
                title: Text(_details[2],style: TextStyle(fontFamily: "semibold",fontSize: 14),),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_details[3] == "" ? "No description" : _details[3],maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontFamily: "regular")),
                    Text(_details[1],style: TextStyle(fontFamily: "semibold",fontSize: 11))
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("₱${_details[4]}.00",style: TextStyle(fontSize: 14,fontFamily: "bold"),),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Jan 22, 2025 at 11:am",style: TextStyle(fontFamily: "regular",fontSize: 11),),
                    // Text(_details[5] == "" ? "No date" : _details[5],style: TextStyle(fontFamily: "regular",fontSize: 13)),
                  ],
                ),
                onTap: (){

                },
              ),
            ),
          );
        },
      )
    );
  }
}
