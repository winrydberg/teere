import 'package:flutter/material.dart';


class ApplicationStatus extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: EdgeInsets.only(left: 2.0, right: 2.0),
      child: InkWell(
        onTap: () {
          //  Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context)=> )
          //     );
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            decoration: BoxDecoration(
               
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/new.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                )),
            child: Center(
                child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  
                  child:  Container(
                      width: 70.0,
                      height: 70.0,
                      child: Icon(Icons.help_outline,color: Colors.green,),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "CHECK STATUS",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
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
