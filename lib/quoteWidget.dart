import 'package:flutter/material.dart';
import 'quote.dart';

class FirstCard extends StatelessWidget {
 
  final Quote quote;
  final Function delete;
  FirstCard({required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(10),
    
        child: Column(
    
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
    
            Text(
              quote.text,
              style: const TextStyle(
    
                fontSize: 10,
                fontFamily: 'Skeleton',
                color: Color.fromARGB(255, 2, 50, 90),
    
              ),
              
              ),
    
              const SizedBox(height: 4),
    
               Text(
              quote.author,
              style: const TextStyle(
    
                fontSize: 5,
                fontFamily: 'Skeleton',
                color: Color.fromARGB(255, 0, 0, 0),
    
              ),
              
              ),
    
            const SizedBox(height: 5.0,),
            
            TextButton.icon(
              onPressed: () => delete(),
              label: const Text('Delete Quote'),
              icon: const Icon(Icons.delete)
              
              ),
  
          ],
        ),
        ),
    
    );
  }
}