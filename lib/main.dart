import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget{

  //Light theme properties
  //ThemeData _lightTheme = ThemeData(
  //    brightness: Brightness.light,
  //    primaryColor: Colors.red
  //);

  //Dark theme properties
  ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey[900],
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber
      )
  );

  //Theme builder function
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: _darkTheme,
      home: SimpleCalulator(),
    );

  }
}

class SimpleCalulator extends StatefulWidget {
  const SimpleCalulator({Key? key}) : super(key: key);

  @override
  State<SimpleCalulator> createState() => _SimpleCalulatorState();
}

class _SimpleCalulatorState extends State<SimpleCalulator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length -1);
        if(equation == ""){
          equation = "0";
        }
      }else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e) {
        result = "Error";
        }

      }else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }

      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor, Color textColor, Color rightShadow, Color leftShadow){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: rightShadow,
            offset: Offset(5,5),
            blurRadius: 15,
            spreadRadius: 1,
          ),

          BoxShadow(
            color: leftShadow,
            offset: Offset(-4,-4),
            blurRadius: 15,
            spreadRadius: 1,
          )
        ],
        color: buttonColor,

      ),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,

      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style:  TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: textColor
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Calculator')),
      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Expanded(
              child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.black38, Colors.redAccent, Colors.black, Colors.grey.shade900),
                        buildButton("⌫", 1, Colors.black38, Colors.redAccent, Colors.black, Colors.grey.shade900),
                        buildButton("÷", 1, Colors.black38, Colors.redAccent, Colors.black, Colors.grey.shade900),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("8", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("9", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("5", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("6", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("2", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("3", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("0", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                          buildButton("00", 1, Colors.black38, Colors.white, Colors.black, Colors.grey.shade900),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.black38, Colors.redAccent, Colors.black, Colors.grey.shade900),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.black38, Colors.redAccent, Colors.black, Colors.grey.shade900),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.black38, Colors.redAccent, Colors.black, Colors.grey.shade900),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.red.shade500, Colors.white, Colors.black, Colors.grey.shade900),
                        ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
