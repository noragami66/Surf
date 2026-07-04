import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/glass_surface.dart';
import 'package:glina/core/style/palette.dart';

/// Docked bottom tab bar — flush with the screen edge.
class GlassBottomNav extends StatelessWidget {
  const GlassBottomNav({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<GlassNavDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final glass = GlassThemeExtension.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return DecoratedBox(
      decoration: GlassSurface.bottomBarDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: glass.navHeight,
            child: Row(
              children: [
                for (var i = 0; i < destinations.length; i++)
                  Expanded(
                    child: _NavItem(
                      destination: destinations[i],
                      selected: selectedIndex == i,
                      onTap: () => onDestinationSelected(i),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: bottomInset),
        ],
      ),
    );
  }
}

class GlassNavDestination {
  const GlassNavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final GlassNavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final glass = GlassThemeExtension.of(context);
    final color = selected ? Palette.textPrimary : Palette.textMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? destination.selectedIcon : destination.icon,
              color: color,
              size: glass.navIconSize,
            ),
            const SizedBox(height: 4),
            Text(
              destination.label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: color,
                fontSize: glass.navFontSize,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: glass.activeDotSize,
              height: glass.activeDotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Palette.textPrimary : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
