import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';

/// A reusable wrapper that provides standard padding and SafeArea
class PageContainer extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;
  final EdgeInsetsGeometry padding;

  const PageContainer({
    super.key,
    required this.child,
    this.useSafeArea = true,
    this.padding = const EdgeInsets.all(AppSpacing.md),
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(padding: padding, child: child);
    if (useSafeArea) {
      content = SafeArea(child: content);
    }
    return content;
  }
}

/// A standard scrollable page layout that future screens will reuse
class ScrollablePageLayout extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const ScrollablePageLayout({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }
}
