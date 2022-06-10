import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    /*theme: ThemeData (
        primarySwatch: Colors.red,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.indigoAccent)
    ),*/
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
          accentColor: Colors.indigoAccent
      ),
      themeMode: ThemeMode.dark
  ));
}

class SIForm  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupee','Dollar','Pounds','Sterling'];
  final _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController       = TextEditingController();
  TextEditingController termController      = TextEditingController();

  var displayResult = '';
  @override
  Widget build(BuildContext context) {

      TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
      return Scaffold(
     //     resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),

        body: Form(
          key: _formKey,
          child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2.0) ,

         // margin: EdgeInsets.all(_minimumPadding * 2.0),
          child: ListView(
            children: [
            getImageAsset(),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom:_minimumPadding),
              child: TextFormField(
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: principalController,
                validator: (String? value) {
                    if(value!.isEmpty) {
                      return 'Please enter Principal Amount';
                    }
                },
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: "Enter Principle eg: 12000",
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 13.0
                ),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0))
              ),
            )),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiController,
                  validator: (String? value) {
                    if(value!.isEmpty) {
                      return 'Please enter Rate Of Interest';
                    }
                  },
                decoration: InputDecoration(
                    labelText: 'Rate Of Interest',
                    hintText: "In Percent",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 13.0
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: Row(
                children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: termController,
                    decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: "Time In Years",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))
                    ),
                  )
                ),

             Container(width: _minimumPadding * 5,),
             Expanded(
               child: DropdownButton(
                  items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                        );
                  }).toList(),

                  value: _currentItemSelected,

                  onChanged: (String? newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                  },

              )
             ),

                ],
              )
            ),

             Padding(
              padding: EdgeInsets.only(bottom: _minimumPadding,top: _minimumPadding),
              child: Row(children: [
              Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text('Calculate',textScaleFactor: 1.5,),

                        onPressed: () {

                              setState( () {
                                if(_formKey.currentState!.validate()) {

                                  this.displayResult =  _calculateTotalReturns();

                                }
                          });
                        },
                      )
                  ),
               Expanded(
                   child: RaisedButton(
                     color: Theme.of(context).primaryColorDark,
                     textColor: Theme.of(context).primaryColorLight,
                     child: Text('Reset',textScaleFactor: 1.5,),
                     onPressed: () {
                            setState( () {
                                _reset();
                            });
                     },
                   )
               ),
              ],
             )
            ),
              Padding(
                padding: EdgeInsets.all(_minimumPadding * 2),
                child: Text(this.displayResult,style: textStyle,),
              )
            ],
          )
          ),

        ),
      );

    }
      Widget getImageAsset() {
      AssetImage assetImage = AssetImage('images/money.png');
      Image image = Image(image: assetImage,width: 125.0,height: 125.0);

      return Container(child: image,margin: EdgeInsets.all(_minimumPadding * 10.0),);
      }

  void _onDropDownItemSelected(String? newValueSelected) {
    setState( () {

      this._currentItemSelected = newValueSelected!;

    });
  }
  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal +  (principal + roi + term) / 100;

    String result = 'After  $term years, your investment will be worth  $totalAmountPayable $_currentItemSelected';
    //  \u{20B9}    Rupee symbol
    return result;
  }
  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }

}


