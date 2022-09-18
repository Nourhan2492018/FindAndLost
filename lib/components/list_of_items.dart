import 'package:find_and_lost/src/app_color.dart';
import 'package:flutter/material.dart';

class ListOfAvailableItems extends StatefulWidget {
  bool isLost;
  ListOfAvailableItems({required this. isLost});

  @override
  State<ListOfAvailableItems> createState() => _ListOfAvailableItemsState();
}

class _ListOfAvailableItemsState extends State<ListOfAvailableItems> {
  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  bool isNewItem = false;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'New Item',
  ];
  @override
  Widget build(BuildContext context) {
    var textController = new TextEditingController();

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.textBoxBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 20,),
          Visibility(
            visible: !isNewItem,
              child: Expanded(
                child: Text(
                  widget.isLost ? "What have you lost ?" : "What have you found ?",
                  style: TextStyle(
                    color: AppColor.txtShade,
                  ),
                ),
              ),
          ),
          Visibility(
            visible: isNewItem ,
            child: Expanded(
                child:TextFormField(
                  controller: textController,
                  autofocus: true,
                  cursorColor: AppColor.defaultColor,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.textBoxBackgroundColor),
                    ),
                  ),
                  onFieldSubmitted: (value){
                    items.removeLast();
                    items.add(value);
                    print(value);
                    dropdownvalue = value;
                    items.add('New Item');
                    textController.text = value;
                    isNewItem = false;
                    setState(() {
                    });
                  },
                )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.textBoxBackgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 17,),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
                value: dropdownvalue,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {

                  setState(() {
                    if(newValue == 'New Item')
                    {
                      isNewItem = true;
                      dropdownvalue = newValue!;
                    }
                    else {
                      isNewItem = false;
                      dropdownvalue = newValue!;
                    }
                  });
                },
              ),
            ),
          ),

        ],
      ),
    );

  }
}
