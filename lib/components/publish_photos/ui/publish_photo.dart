import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/publish_photos/ui/add_location.dart';
import 'package:guarap/components/publish_photos/ui/take_photo.dart';

enum Category { sports, events, chill, food, study, other }

class PublishPhoto extends StatefulWidget {
  const PublishPhoto({super.key});

  @override
  State<PublishPhoto> createState() {
    return _PublishPhotoState();
  }
}

class _PublishPhotoState extends State<PublishPhoto> {
  Category _selectedCategory = Category.sports;

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "New Post",
            style: GoogleFonts.roboto(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 25, 25),
            child: Column(
              children: [
                const SizedBox(height: 15),

                // First row for image post and the input field
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TakePhoto(),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Write a caption...",
                          border: InputBorder.none,
                          // text styling
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Second row for the Category Tags
                Container(
                  // Give some padding to inner elements
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // Container border but only the top and bottom
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey),
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
                      Expanded(
                        child: DropdownButton(
                          isExpanded: true,
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //Third row for the location of the user
                AddLocation(),

                const SizedBox(height: 30),

                // Fifth row for the Publish button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      // red color button and text white
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 171, 0, 72),
                        foregroundColor: Colors.white,
                        // Expand button width
                        minimumSize: const Size(250, 30),
                      ),
                      child:
                          const Text("Share", style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
