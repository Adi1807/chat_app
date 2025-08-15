import 'package:flutter/material.dart';

// Avatar widget that loads network image and falls back to initials if network fails or url empty
class AvatarWithFallback extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final double radius;
  const AvatarWithFallback({
    super.key,
    required this.avatarUrl,
    required this.name,
    this.radius = 16,
  });

  String _initials(String name) {
    final parts = name.split(' ');
    if (parts.isEmpty) return '';
    final first = parts[0].isNotEmpty ? parts[0][0] : '';
    final second = parts.length > 1 && parts[1].isNotEmpty ? parts[1][0] : '';
    return (first + second).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    if (avatarUrl.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey.shade300,
        child: Text(
          _initials(name),
          style: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: Image.network(
          avatarUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // fallback to initials
            return Container(
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: Text(
                _initials(name),
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
