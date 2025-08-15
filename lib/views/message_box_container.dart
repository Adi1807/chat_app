import 'package:flutter/material.dart';

// Hover container for background change on hover
class MessageBoxContainer extends StatefulWidget {
  final Widget child;
  const MessageBoxContainer({super.key, required this.child});

  @override
  State<MessageBoxContainer> createState() => _MessageBoxContainerState();
}

class _MessageBoxContainerState extends State<MessageBoxContainer> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        color: _hovering
            ? Colors.grey.withValues(alpha: 0.04)
            : Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
