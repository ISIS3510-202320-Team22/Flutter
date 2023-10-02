import 'package:flutter/material.dart';
import 'package:guarap/components/header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        // TODO: implement listener
      },
      builder: (context, state) {
        return Header(
          Scaffold(
            bottomNavigationBar: NavigationBar(destinations: [
              NavigationDestination(
                  icon: IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.settings),
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
                      homeBloc.add(HomeCameraButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.camera_enhance),
                  ),
                  label: ""),
              NavigationDestination(
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                  ),
                  label: ""),
            ]),
          ),
        );
      },
    );
  }
}
