import 'package:flutter/material.dart';
import 'package:hesapmakinam/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HesapMakinasi(),
  ));
}

class HesapMakinasi extends StatefulWidget {
  const HesapMakinasi({Key? key}) : super(key: key);

  @override
  State<HesapMakinasi> createState() => _HesapMakinasiState();
}

class _HesapMakinasiState extends State<HesapMakinasi> {
  //variables
  double firstNum = 0.0;
  double secondNum= 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput= false;
  var outputSize= 34.0;
  onButtonClick(value){

    if(value == 'AC'){
      input = '';
      output = '';
    }else if(value == '<'){
      if(input.isNotEmpty){
      input = input.substring(0, input.length-1);
      }
    }else if(value == '='){
      if(input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if(output.endsWith(".0")){
          output= output.substring(0, output.length -2);
        }
        input =  output;
        hideInput = true;
        outputSize = 52;
      }
    }else{
      input = input + value;
      hideInput= false;
      outputSize= 34.0;
    }
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E2140),
      body: Column(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? ' ': input,
                    style: TextStyle(fontSize: 48, color: Colors.white),),
                    SizedBox(height: 20,),
                    Text(output,
                      style: TextStyle(fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7)),),
                    SizedBox(height: 30,),

                  ],
                ),
          ),
          ),




          //buttons area
          Row(
            children: [
              button(
                  text: "AC", buttonBgColor: operatorColor, tColor: colorum),
              button(
                  text: "<", buttonBgColor: operatorColor, tColor: colorum),
              button(
                  text: "", buttonBgColor: Colors.transparent),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: colorum),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "*",buttonBgColor: operatorColor, tColor: colorum),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-",buttonBgColor: operatorColor, tColor: colorum),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+",buttonBgColor: operatorColor, tColor: colorum),
            ],
          ),
          Row(
            children: [
              button(text: "%",buttonBgColor: operatorColor, tColor: colorum),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonBgColor: colorum,),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(22),
            primary: buttonBgColor),
        onPressed: () => onButtonClick(text),
        child: Text(
          text,
          style: TextStyle(color: tColor, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
