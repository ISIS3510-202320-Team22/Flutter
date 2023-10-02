import 'package:flutter/material.dart';
import 'package:guarap/components/header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/profile/ui/profile.dart';
import 'package:guarap/components/publish_photos/ui/publish_photo.dart';

import '../../feed/ui/feed.dart';
import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(context) {
    //BlocConsumer for listening to events
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      // Callback that determines whether the listener should be called when the state changes.
      listenWhen: (previous, current) => current is HomeActionState,
      // Callback that determines whether the builder should rebuild when the state changes
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeNavigateToPublishPageActionState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PublishPhoto()));
        }
        else if (state is HomeNavigateToProfilePageActionState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Profile()));
        }

      },
      builder: (context, state) {
        return Header(
          Scaffold(
            bottomNavigationBar: NavigationBar(destinations: [
              NavigationDestination(
                  icon: IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.home),
                  ),
                  label: ""),
              NavigationDestination(
                  icon: IconButton(
                    onPressed: () {
                      homeBloc.add(HomePublishButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.add_box),
                  ),
                  label: ""),
              NavigationDestination(
                  icon: IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.category),
                  ),
                  label: ""),
              NavigationDestination(
                  icon: IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProfileButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.person),
                  ),
                  label: ""),
            ]),
          body: const Feed(),
          ),
        );
      },
    );
  }
}
