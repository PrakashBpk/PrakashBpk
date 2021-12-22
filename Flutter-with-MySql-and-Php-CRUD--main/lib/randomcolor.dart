import 'dart:math';

import 'dart:ui';

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(100), random.nextInt(75),
        random.nextInt(120), random.nextInt(256));
  }
}
