import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/header.dart';
import 'package:guarap/components/publish_photos/ui/take_photo.dart';

class PublishPhoto extends StatelessWidget {
  const PublishPhoto({super.key});

  @override
  Widget build(context) {
    return Header(
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 25, 25, 25),
        child: Column(
          children: [
            // First row for the title New Page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Post",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),

            const SizedBox(height: 20),

            // Second row for image post and the input field
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TakePhoto(),
                SizedBox(width: 20,),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Write a caption...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Third row for the Category Tags
            Container(
              // Give some padding to inner elements
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // Container border but only the top and bottom
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey),
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Category Tags",
                        border: InputBorder.none,
                        // text styling
                        hintStyle: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Fourth row for the Category Tags
            Container(
              // Give some padding to inner elements
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // Container border but only the top and bottom
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Location",
                        border: InputBorder.none,
                        // text styling
                        hintStyle: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Fifth row for the Publish button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton( 
                  onPressed: () {},                  
                   // red color button and text white
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const  Color.fromARGB(255, 171, 0, 72),
                    foregroundColor: Colors.white,
                    // Expand button width
                    minimumSize: const Size(250, 30),
                  ),                  
                  child: const Text("Share",
                  style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
