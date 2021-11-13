import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:flutter/material.dart';

class CreateOrJoinSquad extends StatelessWidget {
  const CreateOrJoinSquad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedBtn(
            label: 'Create Squad',
            onPressed: () {
              Navigator.of(context).restorablePushNamed(Routes.createSquadPage);
            },
          ),
          ElevatedBtn(
            label: 'Join Squad',
            onPressed: () {
              Navigator.of(context).restorablePushNamed(Routes.joinSquadPage);
            },
          ),
        ],
      ),
    );
  }
}
