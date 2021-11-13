import 'package:esporty/src/presentation/components/contests.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:flutter/material.dart';

class ContestScreen extends StatelessWidget {
  final String squadId;
  const ContestScreen({
    Key? key,
    required this.squadId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Contests(
              squadId: squadId,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 28),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.createContestPage,
            arguments: squadId,
          );
        },
      ),
    );
  }
}
