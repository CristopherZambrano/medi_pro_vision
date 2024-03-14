import 'package:flutter/material.dart';
import 'package:medi_pro_vision/Widgets/new_widget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile',
      home: ProfileScreem(),
    );
  }
}

class ProfileScreem extends StatefulWidget {
  const ProfileScreem({super.key});

  @override
  State<ProfileScreem> createState() => _ProfileScreemState();
}

class _ProfileScreemState extends State<ProfileScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: primaryTitle('Profile'),
      ),
    );
  }
}
