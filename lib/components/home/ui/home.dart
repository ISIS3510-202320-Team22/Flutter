import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarap/components/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guarap/components/profile/ui/profile.dart';
import 'package:guarap/components/settings/ui/settings.dart';
import 'package:guarap/components/publish_photos/ui/publish_photo.dart';
import 'package:guarap/components/feed/ui/feed.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    //BlocConsumer for listening to events
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      // Callback that determines whether the listener should be called when the state changes.
      listenWhen: (previous, current) => current is HomeActionState,
      // Callback that determines whether the builder should rebuild when the state changes
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) async {
        if (state is HomeNavigateToPublishPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PublishPhoto()));
          analytics.logEvent(
            name: 'screen_view',
            parameters: {
              'firebase_screen': "PublishPhoto",
              'firebase_screen_class': PublishPhoto,
            },
          );
        } else if (state is HomeNavigateToProfilePageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Profile()));
          analytics.logEvent(
            name: 'screen_view',
            parameters: {
              'firebase_screen': "Profile",
              'firebase_screen_class': Profile,
            },
          );
        } else if (state is HomeNavigateToSettingsPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Settings()));
          analytics.logEvent(
            name: 'screen_view',
            parameters: {
              'firebase_screen': "Settings",
              'firebase_screen_class': Settings,
            },
          );
        }
      },
      builder: (context, state) {
        String sortStrategy;
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          case HomeSortStrategyChangedState:
            sortStrategy = (state as HomeSortStrategyChangedState).sortStrategy;
            print("SORT STRATEGY: $sortStrategy");
            break;
          case HomeErrorState:
            return const Scaffold(
                body: Center(
              child: Text("Error"),
            ));
          default:
            sortStrategy = "Recent";
        }
        return Scaffold(
          body: Feed(),
          bottomNavigationBar: NavigationBar(destinations: [
            NavigationDestination(
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home),
                ),
                label: "Feed"),
            NavigationDestination(
                icon: IconButton(
                  onPressed: () {
                    homeBloc.add(HomePublishButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.add_box),
                ),
                label: "Publish"),
            NavigationDestination(
                icon: IconButton(
                  onPressed: () {
                    homeBloc.add(HomeSettingsButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.category),
                ),
                label: "Settings"),
            NavigationDestination(
                icon: IconButton(
                  onPressed: () {
                    homeBloc.add(HomeProfileButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.person),
                ),
                label: "Profile"),
          ]),
        );
      },
    );
  }
}
