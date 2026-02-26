import 'package:flutter/material.dart';

class ScrollCoordinator {
  final ScrollController controller = ScrollController();

  bool get isAtTop {
    if (!controller.hasClients) return true;
    return controller.offset <= 0;
  }

  void dispose() {
    controller.dispose();
  }
}