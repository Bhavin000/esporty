import 'package:esporty/src/presentation/components/message.dart';
import 'package:esporty/src/presentation/widgets/tab_btn.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String squadId;
  const MessageScreen({
    Key? key,
    required this.squadId,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late int _idx;
  @override
  void initState() {
    super.initState();
    _idx = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          color: Colors.blue,
          child: Row(
            children: [
              TabBtn('uploaded', 0, _idx, () => setState(() => _idx = 0)),
              TabBtn('Joined', 1, _idx, () => setState(() => _idx = 1)),
              TabBtn('Invited', 2, _idx, () => setState(() => _idx = 2)),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: _idx == 0
                ? Message('uploaded', widget.squadId)
                : _idx == 1
                    ? Message('joined', widget.squadId)
                    : Message('invited', widget.squadId),
          ),
        ),
      ],
    );
  }
}
