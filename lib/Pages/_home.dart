import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'dart:math';
import '../Shortcuts/_tasksClassFunctions.dart';
import '../Shortcuts/_variableShortcuts.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(

      //The Appbar is almost the same for all pages
      appBar:normalAppBar("AppTitle"),

    //Using Column as my main composition, and container to keep the gradient background
    body: Container(
      
        decoration: backgroundgradient(),
        
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
            
            TaskList(listheight: 80,),//Shows The Tasks and their due dates

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child:ChevronTextContainer(text: "Tasks", route: '/Tasks'),

            ),
            
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child:ChevronTextContainer(text: "Files", route: '/Files'),

            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child:ChevronTextContainer(text: "Notes", route: '/Notes'),

            ),
           
            
          ],
        )
       
    ),
    );
  }
}



//Class to take a photo, have to modify the gesture Detector to save the photos later
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


//Its a Chevron like, or a "Pasalibros" like container button 
class ChevronTextContainer extends StatefulWidget {
  final String text;
  final String route;

  ChevronTextContainer({
    required this.text,
    required this.route,
  });

  @override
  State<ChevronTextContainer> createState() => _ChevronTextContainerState();
}

class _ChevronTextContainerState extends State<ChevronTextContainer> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 1.5; // Stretch the chevron when tapped
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // Reset the scale when touch is released
    });
  }
  @override
  Widget build(BuildContext context) {
     
    return GestureDetector( //A gesture detector to "Animate" when pressed
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        setState(() {
          _scale = 1.0; // Reset scale if touch is canceled
        });
      },
      child:ClipPath(
      clipper: ChevronClipper( scale: _scale), //Shape Class
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        color: const Color.fromARGB(52, 0, 0, 0),
        child: TextButton(
          onPressed: (){
            Navigator.pushNamed(context, widget.route); // To go to another pages
          }, 
          child: Text(
          widget.text,
          style: TextStyle(
            color: redcolor(),
            fontSize: 18,
            fontFamily: 'School'
          ),
        ), 
        )
        
       
        ),
      )
    );
  }
}


//Make a specific chape for a container
class ChevronClipper extends CustomClipper<Path> {

  final double scale;

  ChevronClipper({this.scale = 1.0});
  @override
  Path getClip(Size size) {
    Path path = Path();

     // Modify the width based on the scale
    double normalwidth=size.width - 30;
    double chevronWidth = (normalwidth) * scale;

    // Start with the main rectangular body
    path.lineTo(0, 0);
    path.lineTo(normalwidth, 0); // Create the main horizontal line with scaling
    path.lineTo(chevronWidth + 30, size.height / 2); // Chevron tip on the right
    path.lineTo(normalwidth, size.height); // Bottom right corner
    path.lineTo(0, size.height); // Bottom left corner
    path.close(); // Close the shape


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper is ChevronClipper && oldClipper.scale != scale;
  }
}