import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/feed/bloc/feed_bloc.dart';
import 'package:guarap/models/post_model.dart';

class Report extends StatefulWidget {
  const Report({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  State<Report> createState() {
    return _Report();
  }
}

class _Report extends State<Report> {
  final _inputDescriptionController = TextEditingController();
  bool isLoading = false;
  final FeedBloc feedBloc = FeedBloc();

  @override
  void dispose() {
    _inputDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocConsumer<FeedBloc, FeedState>(
        bloc: feedBloc,
        listenWhen: (previous, current) => current is FeedActionState,
        buildWhen: (previous, current) => current is! FeedActionState,
        listener: (context, state) {
          switch (state.runtimeType) {
            case FeedErrorState:
              {
                state as FeedErrorState;
                // Show error message in snack bar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
                break;
              }
            case ReportPageSuccessState:
              {
                // Show success message in snack bar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Report submitted successfully!"),
                    backgroundColor: Colors.blue,
                  ),
                );
                Navigator.pop(context);
                break;
              }
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ReportPageLoadingState:
              {
                isLoading = true;
                break;
              }
            default:
              {
                isLoading = false;
              }
          }

          return Scaffold(
            appBar: AppBar(
                title: Text(
                  "Report",
                  style: GoogleFonts.roboto(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Why are you reporting this post?",
                          style: GoogleFonts.roboto(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _inputDescriptionController,
                          maxLength: 1000,
                          maxLines: 10,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFAB003E),
                                  padding: const EdgeInsets.all(20)),
                              onPressed: () {
                                feedBloc.add(ReportPostSubmitEvent(
                                    postId: widget.post.id!,
                                    postUserId: widget.post.user!,
                                    userReportingId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    description:
                                        _inputDescriptionController.text));
                              },
                              child: !isLoading
                                  ? Text(
                                      "Report",
                                      style: GoogleFonts.roboto(
                                          color: Colors.white, fontSize: 18),
                                    )
                                  : const CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
