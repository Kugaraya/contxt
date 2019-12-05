//start dependencies

import 'package:ConTXT/sim/sim_bloc_provider.dart';
import 'package:ConTXT/sim/sim_bloc.dart';
import 'package:ConTXT/ui/router.dart';
import 'package:flutter/material.dart';

//end dependencies

main() async {
  runApp(ConTXT());
} 

class ConTXT extends StatelessWidget {
  final bloc = SimCardsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.loadSimCards();

    return SimCardsBlocProvider(
      simCardBloc: bloc,
      child: MaterialApp(
        title: 'ConTXT',
        theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blue[300]
        ),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
