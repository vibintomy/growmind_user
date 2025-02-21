import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';

class MessagePage extends StatelessWidget {
  final String name;
  final String imageUrl;
  const MessagePage({super.key,required this.imageUrl,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textColor,
        automaticallyImplyLeading: true,
      
           title: 
          Row(
            children: [
             
              Container(
                decoration:const BoxDecoration(
                  shape: BoxShape.circle
                ),
                height: 50,
                width: 50,
                child: ClipOval(child: Image.network(imageUrl,fit: BoxFit.cover,))),
                kwidth,
                Expanded(child: Text(name,style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 20,),))
            
          
        ],
          )
       
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/logo/download.jpg',),fit:BoxFit.cover )
         ),
         child: Column(
          children: [],
         ),
      ),
    );
  }
}
