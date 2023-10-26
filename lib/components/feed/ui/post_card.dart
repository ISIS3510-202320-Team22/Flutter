import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.snap}) : super(key: key);
  final snap;
  @override
  Widget build(context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1695064823570-3a72b0a7daf6?auto=format&fit=crop&q=80&w=1370&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ]
                                    .map(
                                      (e) => InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ));
                  },
                ),
              ]),
            ),
            //Image Section
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: 380,
              child: Image.network(
                snap["image"],
                fit: BoxFit.cover,
              ),
            ),
            //Up & Down buttons section
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Text(
                    "Universidad de los Andes",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.thumb_up,
                        size: 35,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.thumb_down,
                          size: 35,
                        )),
                  ]),
                )
              ],
            ),

            //Description Section & Comments

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              children: [
                            const TextSpan(
                                text: "username",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '  ${snap["description"]}'),
                          ])))
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: const Text(
                  "View all 200 comments",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: const Text(
                "2020/23/22",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
