import 'package:flutter/material.dart';
import 'contsdrt.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform ;
import 'dart:convert';
import 'package:http/http.dart' ;



class BTC extends StatefulWidget {
  @override
  _BTCState createState() => _BTCState();
}

class _BTCState extends State<BTC> {
  String SelectedCurrency='USD' ;

  double rate;
  double Lrate;
  double Erate;

  void getprice()async{
    var url ='https://rest.coinapi.io/v1/exchangerate/BTC/$SelectedCurrency?apikey=F8A98B5B-29E0-4865-87CC-8AB9730C80AD';
    var Lurl ='https://rest.coinapi.io/v1/exchangerate/LTC/$SelectedCurrency?apikey=F8A98B5B-29E0-4865-87CC-8AB9730C80AD';
    var Eurl ='https://rest.coinapi.io/v1/exchangerate/ETH/$SelectedCurrency?apikey=F8A98B5B-29E0-4865-87CC-8AB9730C80AD';
    //Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    // Await the http get response, then decode the json-formatted response.
    Response response = await get(url);
    print(response.body);
    var max = await jsonDecode(response.body);
     rate = max['rate'];
    Response lresponse = await get(Lurl);
    print(lresponse.body);
    var lmax = await jsonDecode(lresponse.body);
    Lrate = lmax['rate'];
    Response eresponse = await get(Eurl);
    print(eresponse.body);
    var emax = await jsonDecode(eresponse.body);
    Erate = emax['rate'];
     setState(() {});
   // print(url);
  }


  DropdownButton<String>  builddrop(){
    List<DropdownMenuItem<String>> drt =[];
    for(String currency in curate){
      DropdownMenuItem <String> dropdownlist =  DropdownMenuItem(child:  Text(currency),value:currency,);
      drt.add(dropdownlist);
    }
   return  DropdownButton<String>(
        value: SelectedCurrency,
        items: drt,

        onChanged:(value){
          rate = null;
          setState(() {
            SelectedCurrency = value;
          });
          print(value);
          getprice();
        }
        );
  }
  CupertinoPicker buildcuper(){
  List <Widget> jay  =[];
    for(String cur in curate ){
      jay.add(Text(cur));
    }
  return CupertinoPicker(
    backgroundColor: Colors.blue,
    itemExtent: 50,
    onSelectedItemChanged: (value){
      print(value);
    },
    children:jay

  );
}
Widget dropdownpicker(){
    if (Platform.isIOS){
      return buildcuper();
    }else if(Platform.isAndroid){
      return builddrop();
    }
}
  @override
  void initState() {
    super.initState();
    this.builddrop();
    this.getprice();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: Text('my btc ticker',
              style: TextStyle(fontSize: 20, color: Colors.black45)
          ),
          backgroundColor: Colors.white,
          elevation: 10,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                width: 350,
                height: 50,
                child: Card(
                  child: Center(child:
                  Text('1 BTC is about ${rate != null?rate.toStringAsFixed(1):'?'} ${' '+SelectedCurrency}' )
                    ,
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                width: 350,
                height: 50,
                child: Card(
                  child: Center(child:
                  Text('1 LC is about ${Lrate != null?Lrate.toStringAsFixed(1):'?'} ${' '+SelectedCurrency}' )
                    ,
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                width: 350,
                height: 50,
                child: Card(
                  child: Center(child:
                  Text('1 ETH is about ${Erate != null?Erate.toStringAsFixed(1):'?'} ${' '+SelectedCurrency}' )
                    ,
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/10,
width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child:Center(
                child:dropdownpicker(),
              ),
            )
          ],
        ));
  }
}



