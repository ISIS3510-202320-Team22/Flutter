import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/feed/bloc/feed_bloc.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.snap}) : super(key: key);
  final snap;
  @override
  Widget build(context) {
    final FeedBloc feedBloc = FeedBloc();
    bool color = false;
    print(snap);
    print(snap.runtimeType);
    return BlocConsumer<FeedBloc, FeedState>(
      bloc: feedBloc,
      listenWhen: (previous, current) => current is FeedActionState,
      buildWhen: (previous, current) => current is! FeedActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case FeedUpVoteState:
            color = true;
            break;
        }
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
                      radius: 18,
                      backgroundImage: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1670588776057-cf5cd890fb98?auto=format&fit=crop&q=80&w=1374&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snap["user"] != null ? "${snap["user"]}" : " ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(snap["date"] != null
                                ? DateFormat('MMM dd y HH:mm')
                                    .format(snap["date"].toDate())
                                : " "),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Delete',
                                    ]
                                        .map(
                                          (e) => InkWell(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 16)),
                    Expanded(
                      child: Text(
                        snap["address"] != null ? "${snap["address"]}" : " ",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 125,
                    ),
                    Expanded(
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            //upvote
                            feedBloc.add(FeedUpvoteEvent());
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            size: 35,
                            //color: color ? Colors.green : Colors.blue
                          ),
                        ),
                        //upvotes
                        Text(snap["upvotes"].toString()),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.thumb_down,
                              size: 35,
                            )),
                        //downvotes
                        Text(snap["downvotes"].toString()),
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
                                TextSpan(
                                    text: snap["user"] != null
                                        ? "${snap["user"]}"
                                        : " ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: '  ${snap["description"]}')
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
                      //snap["date"].toString(),
                      "Comments",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                /*
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    snap["address"] != null ? "${snap["address"]}" : " ",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),*/
              ],
            ));
      },
    );
  }
}
