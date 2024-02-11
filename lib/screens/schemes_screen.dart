import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class   SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});
  @override
  State<SchemesScreen> createState() {
    return _SchemesScreenState();
    }
}

class _SchemesScreenState extends State<SchemesScreen> {
  late List dat = [];
  Future<void> loadData() async {
    var data = await rootBundle.loadString("assets/Data.json");
    setState(() {
      dat = json.decode(data);
    });

  }

void ss(){
    loadData();
    print(dat['d'][0]['name']);
    // var re = [];
    // for(final i in dat){
    //   for(final j in i.split("\n")){
    //     for(final k in j.split()){
    //       if(k.toUpperCase() == occu.toUpperCase()){
    //       re.add(i);
    //       break;
    //     }
        
    //     }break;
    //   }
    //   }
    //   return dat['d'][0]['name'];
  }



  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What do you want to know about?'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {ss();},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  ),
                ),
              child: Text("Helo")
            ),
          ),]
      )
    );
    }
}

