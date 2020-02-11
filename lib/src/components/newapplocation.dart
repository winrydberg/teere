import 'package:dfmc/src/screens/application.dart';
import 'package:flutter/material.dart';

class NewApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      margin: EdgeInsets.only(left: 2.0, right: 2.0, top: 15),
      child: InkWell(
        onTap: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> ApplicationScreen() )
              );
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
             decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/new.jpg"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                )),
            child: Center(
                child: Row(
              children: <Widget>[
                // Expanded(
                //   flex: 1,
                  
                //   child:  Container(
                //       width: 30.0,
                //       height: 30.0,
                //       child: Icon(Icons.add_circle,color: Colors.red,),
                //       decoration: BoxDecoration(
                //         color: Color(0xFFFFFFFF),
                //         shape: BoxShape.circle,
                //       ),
                //     ),
                // ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "APPLY NOW",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                )
              ],
            )),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
