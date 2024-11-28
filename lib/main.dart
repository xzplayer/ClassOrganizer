import 'package:flutter/material.dart';
import 'quote.dart';
import 'quoteWidget.dart';


List <Quote> info = [

  Quote(text: "This ui is really cool",author: "Andy Oviedo"),
  Quote(text: "I am really cool",author: "Andy Oviedo"),
  Quote(text: "This app will be amazing",author: "Andy Oviedo"),
];


Widget createcards(Quote quote,Function delete){

  return FirstCard(quote:quote,delete:delete);
}


void main() => runApp(MaterialApp(
  home: TheAppItself()
));


class TheAppItself extends StatefulWidget {
  
  @override
  State<TheAppItself> createState() => TheHomeItself();
}

class TheHomeItself extends State<TheAppItself> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Ya boi'),
      centerTitle: true,
      backgroundColor: Colors.indigo[300],
    ),
    body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration( // Either color or decoration
            image: DecorationImage(
              image: NetworkImage('https://t3.ftcdn.net/jpg/01/34/81/06/360_F_134810683_ehP6EZeAiAQqABnuLh2AbjpJxrlX6jAb.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              Image.asset('Assets/BeautifulSky.jpg'),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Simple but better',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2), // Position of shadow
                        blurRadius: 3.0, // Blur radius
                        color: Color.fromARGB(255, 170, 255, 90).withOpacity(0.5),
                      ),
                    ],
                    color: Color.fromARGB(255, 0, 123, 4),
                    backgroundColor: Color.fromARGB(255, 194, 255, 196),
                    fontFamily: 'Skeleton',
                  ),
                ),
              ),
              Statelesstext(),
              StatelessIcon(),
              IncreaseWidget(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ButtonRow(), // A StatelessWidget to hold the buttons
        ),


        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: 
            //info.map((information)=>Text("${information.text} - ${information.author}")).toList(),
            info.map((information)=> createcards(
              
              information,
              (){
                setState(() {
                info.remove(information); 
              });
              }              
              )).toList(),
          
        ),
        const Padding (
          
          padding: EdgeInsets.fromLTRB(120.0, 80.0, 20.0, 20.0),
          child: Text("This is Padding"),
          
        )

      ],
    ),
    );
  }
}
class Statelesstext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Text('This is a Stateless Text'),
    );
  }
}

class StatelessIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.animation_rounded,
      color: Colors.orange,
      size: 25,
    );
  }
}

class ButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin:const EdgeInsets.only(left:1, right:1),
      color: const Color.fromARGB(255, 245, 130, 63).withOpacity(0.9), // Background color for the button row
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex:2,
            child:ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.auto_stories,
              ),
              label: const Text('Elevated'),
              style:ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 162, 204, 239),
              ),
            ),
          ),
          
          Expanded(
            flex:1,
            child: IconButton(
              onPressed:(){}, 
            icon: const Icon(Icons.backpack)),
          ),
          Expanded(
            flex:1,
            child: TextButton(
              onPressed: () {
                print('Hope it works');
              },
              child: const Text('Text'),
            ),
          ),
          Expanded(
            flex:2,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined'),
            ),
          ),
        ],
      ),
    );
  }
}

class IncreaseWidget extends StatefulWidget {
  const IncreaseWidget({super.key});

  @override
  State<IncreaseWidget> createState() => IncreaseButton();
}

class IncreaseButton extends State<IncreaseWidget> {

  int counter=0;
  @override

  Widget build(BuildContext context) {

    return Stack(

      children: [
        
        Text(
        'This is a Statefull action $counter',

        style: const TextStyle(

          fontSize: 15,
          letterSpacing: 1.5,
          color: Color.fromARGB(255, 0, 123, 4),
          fontFamily: 'Skeleton',
        ),
      ),

      FloatingActionButton(
      onPressed: (){setState(() {
        counter+=1;
      });},
      child: Text('click'),
      backgroundColor: Colors.deepPurple[100],
      )

      ]
    );
  }
}