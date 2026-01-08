import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final Color? backgroundColor;

  const SectionCard({
    super.key,
    required this.child,
    this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      width: double.infinity,
      child: Card(
        color: backgroundColor ?? Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
