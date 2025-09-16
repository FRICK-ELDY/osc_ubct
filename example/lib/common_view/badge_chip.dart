//! summary: バッジチップ（UI onlyなどの表示）
//! path: example/lib/common_view/badge_chip.dart

import 'package:flutter/material.dart';

class BadgeChip extends StatelessWidget {
  final String text;
  const BadgeChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: cs.primaryContainer,
      ),
      child: Text(text, style: TextStyle(color: cs.onPrimaryContainer)),
    );
  }
}
