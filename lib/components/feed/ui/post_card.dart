import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/feed/bloc/feed_bloc.dart';
import 'package:guarap/models/post_model.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostCard extends StatefulWidget {
  final PostModel post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() {
     return _PostCardState();
  }
}

class _PostCardState extends State<PostCard> {
  bool color = false;

  @override
  void initState() {
    feedBloc.add(PostCardInitialEvent(post: widget.post));
    super.initState();
  }

  final FeedBloc feedBloc = FeedBloc();

  @override
  Widget build(context) {
    
    bool upVoted = false;
    bool downVoted = false;
    int upvotes = widget.post.upvotes!;
    int downvotes = widget.post.downvotes!;

    return BlocConsumer<FeedBloc, FeedState>(
      bloc: feedBloc,
      listenWhen: (previous, current) => current is FeedActionState,
      buildWhen: (previous, current) => current is! FeedActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case PostCardInitial:
            state as PostCardInitial;
            upVoted = state.upVoted;
            downVoted = state.downVoted;
            break;
          case PostUpvoteState:
            upVoted = true;
            upvotes++;
            downVoted = false;
            break;
          case PostDownvoteState:
            upVoted = false;
            downVoted = true;
            downvotes++;
            break;
          case PostCancelUpvoteState:
            state as PostCancelUpvoteState;
            upVoted = false;
            upvotes--;
            downVoted = state.downVoted;
            if (state.downVoted) {
              downvotes++;
            }
            break;
          case PostCancelDownvoteState:
            state as PostCancelDownvoteState;
            upVoted = state.upVoted;
            if (state.upVoted) {
              upvotes++;
            }
            downVoted = false;
            downvotes--;
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
                      backgroundImage: CachedNetworkImageProvider(
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
                              widget.post.user != null ? "${widget.post.user}" : " ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              
                            ),
                            Text(widget.post.date != null
                                ? DateFormat('MMM dd y HH:mm')
                                    .format(widget.post.date!.toDate())
                                : " "),
                          ],
                        ),
                      ),
                    ),
                    /*
                    post.sponsored == true
                        /? const Icon(
                            Icons.verified,
                            color: Colors.blue,
                          )
                        : const SizedBox.shrink(),*/
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
                                      'Report',
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
                  child: CachedNetworkImage(
                    imageUrl: widget.post.image!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    placeholderFadeInDuration: const Duration(milliseconds: 0),
                    fadeOutDuration: const Duration(milliseconds: 0),
                    fadeInDuration: const Duration(milliseconds: 0),
                  ),
                ),
                //Up & Down buttons section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 16)),
                    Expanded(
                      child: Text(
                        widget.post.address != null ? "${widget.post.address}" : " ",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    Expanded(
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            // Upvote event
                            if (downVoted) {
                              feedBloc.add(PostCardCancelDownvoteEvent(post: widget.post, upVoted: true));
                            }
                            else if (upVoted) {
                              feedBloc.add(PostCardCancelUpvoteEvent(post: widget.post, downVoted: false));
                            }
                            else {
                              feedBloc.add(PostCardUpvoteEvent(post: widget.post));
                            }
                          },
                          icon: Icon(
                              upVoted ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                            size: 35,
                            //color: color ? Colors.green : Colors.blue
                          ),
                        ),
                        //upvotes
                        Text(upvotes.toString()),
                        IconButton(
                            onPressed: () {
                              // Downvote event
                              if (upVoted) {
                                feedBloc.add(PostCardCancelUpvoteEvent(post: widget.post, downVoted: true));
                              }
                              else if (downVoted) {
                                feedBloc.add(PostCardCancelDownvoteEvent(post: widget.post, upVoted: false));
                              }
                              else {
                                feedBloc.add(PostCardDownvoteEvent(post: widget.post));
                              }
                            },
                            icon: Icon(
                              downVoted ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                              size: 35,
                            )),
                        //downvotes
                        Text(downvotes.toString()),
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
                                    text: widget.post.user != null
                                        ? "${widget.post.user}"
                                        : " ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: '  ${widget.post.description}')
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
              ],
            ));
      },
    );
  }
}