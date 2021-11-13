import 'package:esporty/src/presentation/widgets/bnr.dart';
import 'package:esporty/src/presentation/widgets/dlg.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:esporty/src/presentation/widgets/icon_btn.dart';
import 'package:esporty/src/presentation/widgets/tf.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GameList extends StatelessWidget {
  final List<String> gameList;
  final Map<String, String> gameData;
  final ValueChanged notifyParent;
  GameList({
    Key? key,
    required this.gameList,
    required this.gameData,
    required this.notifyParent,
  }) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> get getCurrentStateValues {
    _formKey.currentState!.save();
    return _formKey.currentState!.value;
  }

  onItemPressed(BuildContext context, String gameName) {
    showDialog(
      context: context,
      builder: (context) => Dlg(
        height: 210,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(gameName, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 12),
            FormBuilder(
              key: _formKey,
              child: const TF(label: 'Enter Game Id', isPassword: false),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedBtn(
                  label: 'Submit',
                  onPressed: () {
                    if (getCurrentStateValues.containsKey(null) ||
                        getCurrentStateValues.containsValue(null) ||
                        getCurrentStateValues['Enter Game Id'].isEmpty) {
                      bnr(context, 'Enter Game Id');
                    } else {
                      gameData[gameName] =
                          getCurrentStateValues['Enter Game Id'];
                      notifyParent(gameData);
                      Navigator.pop(context);
                    }
                  },
                ),
                ElevatedBtn(
                  label: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: gameList.length,
      itemBuilder: (context, index) => item(context, gameList[index]),
    );
  }

  Widget item(context, gameName) {
    return Card(
      child: ListTile(
        title: Text(gameName),
        trailing: IconBtn(
          icon:
              gameData.containsKey(gameName) ? EvaIcons.doneAll : EvaIcons.plus,
          size: 24,
          onPressed: gameData.containsKey(gameName)
              ? null
              : () => onItemPressed(context, gameName),
        ),
      ),
    );
  }
}
