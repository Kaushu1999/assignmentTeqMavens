import 'package:assignment/core/constants/app_assets.dart';
import 'package:assignment/core/constants/app_text_styles.dart';
import 'package:assignment/core/constants/static_constant_data.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  SideMenuItem _selectedItem = SideMenuItem.payment;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Drawer(
      width: screenWidth * 0.73,
      elevation: 0,
      backgroundColor: Colors.transparent,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(34),
          bottomRight: Radius.circular(34),
        ),
      ),

      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(34),
          bottomRight: Radius.circular(34),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF09283D),
                Color(0xFF07161D),
                Color(0xFF050B0E),
                Color(0xFF061E30),
              ],
              stops: [0.0, 0.28, 0.65, 1.0],
            ),
          ),

          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 22, 14, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(AppAssets.profile),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alice Premium',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.heading1.copyWith(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 3),

                            Text(
                              'Toronto, Canada',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _sectionTitle('Account Settings'),

                        _menuItem(item: SideMenuItem.notification, badge: '12'),

                        _menuItem(item: SideMenuItem.payment, showArrow: true),

                        _menuItem(
                          item: SideMenuItem.translate,
                          showArrow: true,
                        ),

                        _menuItem(item: SideMenuItem.privacy, showArrow: true),

                        const SizedBox(height: 18),

                        _sectionTitle('Host Settings'),

                        _menuItem(item: SideMenuItem.listing, showArrow: true),

                        _menuItem(item: SideMenuItem.host, showArrow: true),

                        const SizedBox(height: 18),

                        _sectionTitle('App Settings'),

                        _menuItem(item: SideMenuItem.darkMode),

                        _menuItem(item: SideMenuItem.update, showArrow: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 7),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required SideMenuItem item,
    bool showArrow = false,
    String? badge,
  }) {
    final bool selected = _selectedItem == item;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _selectedItem = item;
        });
      },
      child: Container(
        width: double.infinity,
        height: 60,

        decoration: BoxDecoration(
          color: selected ? const Color(0xFF159CF4) : Colors.transparent,

          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? Colors.white : const Color(0xFF1C2529),
                ),

                child: Icon(
                  item.icon,
                  size: 20,
                  color: selected
                      ? const Color(0xFF159CF4)
                      : const Color(0xFF9BA2A5),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                item.title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.68),
                ),
              ),
            ),

            if (badge != null)
              Container(
                width: 30,
                height: 23,
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA51F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            if (showArrow)
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: selected ? Colors.white : const Color(0xFFD4D4D4),
                  size: 21,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
