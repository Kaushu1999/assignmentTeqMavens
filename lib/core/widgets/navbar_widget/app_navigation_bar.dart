import 'package:assignment/core/constants/app_assets.dart';
import 'package:assignment/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<_NavItemData> _items = [
    _NavItemData(
      icon: Icons.home_outlined,
      label: 'Dashboard',
      iconAsset: AppAssets.tabDashboard,
    ),
    _NavItemData(
      icon: Icons.flight_takeoff_outlined,
      label: 'Hotels Resort',
      iconAsset: AppAssets.tabHotelResort,
    ),
    _NavItemData(
      icon: Icons.calendar_today_outlined,
      label: 'Booking Hotel',
      iconAsset: AppAssets.tabBookingHotel,
    ),
    _NavItemData(
      icon: Icons.person_outline,
      label: 'Account',
      avatarAsset: AppAssets.userProfile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPadding = 10.0;
        const itemGap = 4.0;
        const collapsedWidth = _NavigationItem.collapsedSize;
        final availableWidth = constraints.maxWidth - (horizontalPadding * 2);
        final selectedWidth =
            availableWidth -
            (collapsedWidth * (_items.length - 1)) -
            (itemGap * (_items.length - 1));

        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            decoration: BoxDecoration(
              color: const Color(0xFF111213).withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_items.length, (index) {
                final selected = currentIndex == index;

                return Padding(
                  padding: EdgeInsets.only(
                    right: index == _items.length - 1 ? 0 : itemGap,
                  ),
                  child: _NavigationItem(
                    icon: _items[index].icon,
                    label: _items[index].label,
                    iconAsset: _items[index].iconAsset,
                    avatarAsset: _items[index].avatarAsset,
                    selected: selected,
                    selectedWidth: selectedWidth.clamp(108.0, 180.0),
                    onTap: () => onTap(index),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.label,
    this.iconAsset,
    this.avatarAsset,
  });

  final IconData icon;
  final String label;
  final String? iconAsset;
  final String? avatarAsset;
}

class _NavigationItem extends StatefulWidget {
  const _NavigationItem({
    required this.icon,
    required this.onTap,
    required this.selected,
    required this.selectedWidth,
    this.label,
    this.iconAsset,
    this.avatarAsset,
  });

  static const double collapsedSize = 48;

  final IconData icon;
  final String? label;
  final String? iconAsset;
  final String? avatarAsset;
  final bool selected;
  final double selectedWidth;
  final VoidCallback onTap;

  @override
  State<_NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<_NavigationItem>
    with SingleTickerProviderStateMixin {
  static const double _size = _NavigationItem.collapsedSize;
  static const double _horizontalPadding = 14;
  static const double _iconGap = 10;
  static const double _iconSize = 24;
  static const double _avatarSize = _size;
  static const double _selectedAvatarSize = 40;

  static final TextStyle _labelStyle = AppTextStyles.navBarTitleFont;
  late final AnimationController _controller;

  static final SpringDescription _spring = SpringDescription.withDampingRatio(
    mass: 1,
    stiffness: 300,
    ratio: 0.45,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playBounce() {
    final simulation = SpringSimulation(_spring, 1.0, 1.0, 6.0);
    _controller.animateWith(simulation);
  }

  double get _targetWidth => widget.selected ? widget.selectedWidth : _size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _playBounce();
          widget.onTap();
        },
        borderRadius: BorderRadius.circular(_size / 2),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(scale: _controller.value, child: child);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            height: _size,
            width: _targetWidth,
            padding: EdgeInsets.symmetric(
              horizontal: widget.selected ? _horizontalPadding : 0,
            ),
            decoration: BoxDecoration(
              color: widget.selected
                  ? const Color(0xFF179BFF)
                  : const Color(0xFF303233),
              borderRadius: BorderRadius.circular(_size / 2),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final hasAvatar = widget.avatarAsset != null;
                final visualSize = !hasAvatar
                    ? _iconSize
                    : widget.selected
                    ? _selectedAvatarSize
                    : _avatarSize;
                final showLabel =
                    widget.selected &&
                    widget.label != null &&
                    constraints.maxWidth > visualSize + _iconGap;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: showLabel
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    _NavItemIcon(
                      icon: widget.icon,
                      iconAsset: widget.iconAsset,
                      avatarAsset: widget.avatarAsset,
                      size: visualSize,
                    ),
                    if (showLabel) ...[
                      const SizedBox(width: _iconGap),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.label!,
                            maxLines: 1,
                            style: _labelStyle,
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemIcon extends StatelessWidget {
  const _NavItemIcon({
    required this.icon,
    required this.size,
    this.iconAsset,
    this.avatarAsset,
  });

  final IconData icon;
  final double size;
  final String? iconAsset;
  final String? avatarAsset;

  @override
  Widget build(BuildContext context) {
    final avatarAsset = this.avatarAsset;
    final iconAsset = this.iconAsset;

    if (avatarAsset != null) {
      return ClipOval(
        child: Image.asset(
          avatarAsset,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: size,
              height: size,
              color: Colors.white.withValues(alpha: 0.16),
              child: Icon(icon, color: Colors.white, size: 20),
            );
          },
        ),
      );
    }

    if (iconAsset == null) {
      return Icon(icon, size: size, color: Colors.white);
    }

    return Image.asset(
      iconAsset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(icon, size: size, color: Colors.white);
      },
    );
  }
}
