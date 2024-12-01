import 'package:flutter/material.dart';


Color redcolor(){

  return  const Color.fromARGB(255, 163, 13, 13);
}

Color backgroundColor(){

  return const Color.fromARGB(255, 128, 135, 171);
}

BoxDecoration backgroundgradient(){

  return const BoxDecoration(//Same Gradient For All Pages
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 45, 91, 91),Color.fromARGB(255, 102, 204, 204)]
            
          )
          
          );

}


AppBar normalAppBar(String pagetitle){

    return AppBar(
       
        backgroundColor: backgroundColor(),
        title: Text(
          pagetitle,
          style: TextStyle(
            fontSize:40,
            color: redcolor(),
            fontWeight: FontWeight.w200,
            fontFamily: 'School',
            
          ),
          
          ),
        centerTitle: true,

      actions: [
      SettingsButton(), // Add the SettingsButton here
      ],
  
    );
}


//Shortcut to go to settings
class SettingsButton extends StatefulWidget { 

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
     
      onPressed: (){
        Navigator.pushNamed(context, '/Settings');//Should send me directly to the Settings page, check routes on main
      }, icon: const Icon(Icons.settings)//Simple Settings Icon
      );
  }
}