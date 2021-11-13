import 'package:flutter/material.dart';

class TabBtn extends StatelessWidget {
  final String _label;
  final int _crntIdx;
  final int _idx;
  final Function() onPressed;
  const TabBtn(this._label, this._crntIdx, this._idx, this.onPressed,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              _label,
              style: TextStyle(
                color: _idx == _crntIdx
                    ? Theme.of(context).appBarTheme.titleTextStyle!.color
                    : Theme.of(context).appBarTheme.foregroundColor,
                fontWeight:
                    _idx == _crntIdx ? FontWeight.w700 : FontWeight.w500,
                fontSize: _idx == _crntIdx ? 18 : 16,
              ),
            ),
          ),
          splashColor: Colors.white54,
        ),
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }
}
