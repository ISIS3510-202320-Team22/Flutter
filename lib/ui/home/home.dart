import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home({super.key});


  @override
  State<Home> createState(){
    return _Home();
  }
}


class _Home extends State<Home>{

  @override
  Widget build(context){
    return Scaffold(
      
      bottomNavigationBar: NavigationBar(destinations: const [
        NavigationDestination(icon:  Icon(Icons.camera,color: Colors.black), label: ""),
        NavigationDestination(icon:  Icon(Icons.post_add,color: Colors.black), label: "",),
        NavigationDestination(icon:  Icon(Icons.camera_alt,color: Colors.black), label: ""),
        NavigationDestination(icon:  Icon(Icons.people,color: Colors.black), label: ""),
      ],
      height: 50),
    );
  }
}