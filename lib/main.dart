import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double _minimumPadding = 5.0;
  var _currentSelectedItem = '';

  @override
  void initState() {
    super.initState();
    _currentSelectedItem = _currencies[0];
  }

  TextEditingController principleControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding*2),
        child: ListView(
          children: <Widget>[

            getImageAsset(),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principleControlled,
                decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter Principal e.g. 12000',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiControlled,
                decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'In perecent',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termControlled,
                      decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'Time in years',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        )
                      ),
                    ),
                  ),

                  Container(width: _minimumPadding*5,),

                  Expanded(
                    child: DropdownButton(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),

                      value: _currentSelectedItem,
                      onChanged: (String newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child:Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text('Calculate', textScaleFactor: 1.5,),
                      onPressed: () {
                        setState(() {
                          this.displayResult = _calculateTotalReturns();
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Reset', textScaleFactor: 1.5,),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(_minimumPadding*2),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding*10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentSelectedItem = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principleControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);

    double totalAmountPayable = principal + (principal*roi*term)/100 ;
    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentSelectedItem';
    return result;
  }

  void _reset() {
    principleControlled.text = '';
    roiControlled.text = '';
    termControlled.text = '';
    displayResult = '';
    _currentSelectedItem = _currencies[0];
  }
}