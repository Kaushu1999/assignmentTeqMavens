import 'package:assignment/core/constants/app_assets.dart';
import 'package:assignment/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

enum SideMenuItem {
  notification(title: 'Notification', icon: Icons.notifications_none_rounded),
  payment(title: 'Payment', icon: Icons.notifications_none_rounded),
  translate(title: 'Translate', icon: Icons.notifications_none_rounded),
  privacy(title: 'Privacy', icon: Icons.notifications_none_rounded),
  listing(title: 'Listing', icon: Icons.notifications_none_rounded),
  host(title: 'Host', icon: Icons.notifications_none_rounded),
  darkMode(title: 'Dark Mode', icon: Icons.notifications_none_rounded),
  update(title: 'Update', icon: Icons.notifications_none_rounded);

  const SideMenuItem({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Property> properties = [
  Property(
    imageUrl: AppAssets.resortAsset2,
    title: 'Toronto, Canada',
    distance: '150KM',
    available: 'OCT 24-25',
    price: '\$50.00',
  ),
  Property(
    imageUrl: AppAssets.resortAsset1,
    title: 'Vancouver, Canada',
    distance: '120KM',
    available: 'OCT 25-26',
    price: '\$70.00',
  ),
];
