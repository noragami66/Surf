import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';

/// Shared solid panel styling for cards and icon badges.
abstract final class GlassSurface {
  static BoxDecoration cardDecoration({required BorderRadius borderRadius}) {
    return BoxDecoration(
      color: Palette.cardFill,
      borderRadius: borderRadius,
      border: Border.all(color: Palette.cardBorder),
    );
  }

  static BoxDecoration badgeDecoration({required BorderRadius borderRadius}) {
    return BoxDecoration(
      color: Palette.cardFill,
      borderRadius: borderRadius,
      border: Border.all(color: Palette.cardBorder),
    );
  }

  static BoxDecoration bottomBarDecoration() {
    return const BoxDecoration(
      color: Palette.cardFill,
      border: Border(top: BorderSide(color: Palette.cardBorder)),
    );
  }
}
