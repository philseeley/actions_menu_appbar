import 'package:flutter/material.dart';

class ActionsMenuAppBar extends AppBar {

  ActionsMenuAppBar({
    super.key,
    super.title,
    super.leading,
    required BuildContext context,
    required List<IconButton> actions,
    double actionsPercent = 0.75
  }): super(actions: _actions(context, actions, actionsPercent));

  static List<Widget> _actions(BuildContext context, List<IconButton> actions, double actionsPercent){

    int numIcons = (MediaQuery.of(context).size.width*actionsPercent/48).floor();

    if(actions.length <= numIcons) {
      return actions;
    }

    List<Widget> dynamicActions = [];

    int i;
    for(i=0; i<numIcons-1; ++i) {
      dynamicActions.add(actions[i]);
    }

    List<PopupMenuItem<VoidCallback>> menuActions = [];

    for (; i < actions.length; ++i) {
      Icon icon = actions[i].icon as Icon;

      menuActions.add(PopupMenuItem<VoidCallback>(
        value: actions[i].onPressed,
        child: ListTile(
          leading: Icon(icon.icon),
          title: Text(icon.semanticLabel ?? ''),
        ),
      ));
    }

    dynamicActions.add(
      PopupMenuButton<VoidCallback>(tooltip: '',
        itemBuilder: (BuildContext context) {
          return menuActions;
        },
        onSelected: (VoidCallback? value) {
          if (value != null) {
            value();
          }
        })
    );

    return dynamicActions;
  }
}