import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../blocs/post/post_cubit.dart';

enum ItemType { Found, Lost }

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

@override
  State<FilterView> createState() => _FilterViewState();
}
var filterType ;
class _FilterViewState extends State<FilterView> {
  ItemType? _Type = ItemType.Found;
  Map<String, bool?> Items = {
    'Wallet': false,
    'Keys': false,
    'Laptop': false,
    'Phone': false,
  };

  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.defaultColor,
        elevation: 0.0,
        title:Text('Filters', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500,color: Colors.white),),
      ),
            // this is the  UI of filters screen only , it needs updates
      body :Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent, Colors.white38])),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              Row(children:[
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.location_on_sharp,size: 20,color: Colors.white,),
                 Text(' Location', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300,color: Colors.white),),
                 Expanded(
                   child: const Divider(
                     color: Colors.black,
                    thickness: 2,
                    indent: 200,
                    endIndent: 200,),
                 ),
              ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent[200],
                ),
                child: TextButton(onPressed: (){},
                    child: Text('Choose on map',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,color: Colors.white),),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children:[
                  SizedBox(
                    width: 20.0,
                  ),
                Icon(Icons.flag,size: 20,color: Colors.white,),
                Text(' Type', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300,color: Colors.white),),
                Expanded(
                  child: const Divider(
                    color: Colors.black,
                    thickness: 2,
                    indent: 200,
                    endIndent: 200,),
                ),
              ],
              ),
              ListTile(
                title: const Text('Found',style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),),
                leading: Radio(
                  value: ItemType.Found,
                  groupValue: _Type,
                  onChanged: (ItemType? value) {
                    setState(() {
                      _Type= value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Lost', style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),),
                leading: Radio(
                  value: ItemType.Lost,
                  groupValue: _Type,
                  onChanged: (ItemType? value) {
                    setState(() {
                      _Type= value;
                    });
                  },
                ),
              ),
              Row (children:[
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.account_balance_wallet_sharp,size: 20,color: Colors.white,),
                Text(' Item', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300,color: Colors.white),),
                Expanded(
                  child: const Divider(
                    color: Colors.black,
                    thickness: 2,
                    indent: 200,
                    endIndent: 200,),
                ),
              ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckboxListTile(
                    title: Text('Wallet',style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),),
                    value: Items['Wallet'],
                    onChanged: (bool? value) {
                      setState(() {
                        Items['Wallet'] = value;
                      });
                    },
                  ),
                    CheckboxListTile(
                      title: Text('Laptop',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),),
                      value: Items['Laptop'],
                      onChanged: (bool? value) {
                        setState(() {
                          Items['Laptop'] = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Keys',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),),
                      value: Items['Keys'],
                      onChanged: (bool? value) {
                        setState(() {
                          Items['Keys'] = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Phone',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),),
                      value: Items['Phone'],
                      onChanged: (bool? value) {
                        setState(() {
                          Items['Phone'] = value;
                        });
                      },
                    )],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent[200],
                ),
                child: TextButton(onPressed: (){},
                  child: Text('Done',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
