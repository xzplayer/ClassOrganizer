import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'dart:math';
import 'TasksClassFunctions.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(

      //The Appbar is almost the same for all pages
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 128, 135, 171),//Same Color for all Pages
        title: const Text(
          'AppTitle',
          style: TextStyle(//Same Title Style for all pages
            fontSize:40,
            color: Color.fromARGB(255, 163, 13, 13),//Same Color for all Pages
            fontWeight: FontWeight.w200,
            fontFamily: 'School',

          ),
          
          ),
        centerTitle: true,

        actions: [
          SettingsButton()
        ],

    ),

    //Using Column as my main composition, and container to keep the gradient background
    body: Container(
      
        decoration: const BoxDecoration(//Same Gradient For All Pages
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 45, 91, 91),Color.fromARGB(255, 102, 204, 204)]

          ),

        ),
        
        child:Column(

          children: [

            const Align(
              alignment: Alignment.topCenter,
              child: Text(
              
                'Welcome Back',
              
                style: TextStyle(
                  fontSize:40,
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'School',
                ),
              ),
            ),

            const SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: TakePhotoButton(imagePath: 'Assets/CameraLens.png', text: "Take a Photo",)
              ),
            
            const SizedBox(height: 30),

            TaskList(),
          ],
        )
       
    ),
    );
  }
}


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


class TakePhotoButton extends StatefulWidget {
  final String imagePath;  // Path to your image
  final String text;       // Text surrounding the circumference

  TakePhotoButton({required this.imagePath, required this.text});

  @override
  State<TakePhotoButton> createState() => _TakePhotoButtonState();
}

class _TakePhotoButtonState extends State<TakePhotoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Action on button press
        print("PhotoTaken");
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular container with image
          Container(
            height: 120,  // Button height
            width: 120,   // Button width (same value for perfect circle)
            decoration: BoxDecoration(
              shape: BoxShape.circle,  // Make it circular
              image: DecorationImage(
                image: AssetImage(widget.imagePath),  // Use your image here
                fit: BoxFit.cover,  // Cover the container
              ),
            ),
          ),
          // Circular text surrounding the button
          Positioned(
            bottom: 60,  // Adjust text position if needed
              child: ArcText(
              radius: 60, // Radius of the text arc
              text: widget.text,
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              startAngle: -pi / 2, // Starts at the top (12 o'clock position)
              stretchAngle: pi, // Spans 180 degrees (half-circle)
              startAngleAlignment: StartAngleAlignment.start, // Aligns text starting from startAngle
            ),
          ),
        ],
      ),
    );
  }
}