import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SustainableStrategySection extends StatefulWidget {
  const SustainableStrategySection({super.key, this.height});

  final double? height;

  @override
  State<SustainableStrategySection> createState() => _SustainableStrategySectionState();
}

class _SustainableStrategySectionState extends State<SustainableStrategySection> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hasAnimated = false;

  static const _milestones = [
    _Milestone(year: '2023', title: 'Xây dựng nền tảng'),
    _Milestone(year: '2024', title: 'Tăng cường hiệu quả'),
    _Milestone(year: '2025', title: 'Chuẩn Quốc tế'),
  ];

  static final _esgItems = [
    const _EsgNode(icon: Icons.attach_money, angle: -math.pi / 4, distanceFactor: 0.7),
    const _EsgNode(icon: Icons.water_drop, angle: -math.pi / 1.8, distanceFactor: 0.8),
    const _EsgNode(icon: Icons.book, angle: -math.pi * 0.05, distanceFactor: 0.75),
    const _EsgNode(icon: Icons.recycling, angle: math.pi / 6, distanceFactor: 0.78),
    const _EsgNode(icon: Icons.people_alt, angle: math.pi / 1.6, distanceFactor: 0.74),
    const _EsgNode(icon: Icons.lightbulb, angle: math.pi * 0.85, distanceFactor: 0.8),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.3 && !_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
      _hasAnimated = true;
    } else if (info.visibleFraction > 0.3 && _controller.isCompleted && !_controller.isAnimating && !_hasAnimated) {
      _controller.forward(from: 0);
    }

    if (info.visibleFraction < 0.05 && _controller.isCompleted && !_controller.isAnimating) {
      _controller.reset();
      _hasAnimated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;
    final isLandscape = size.width >= size.height;
    final sectionHeight = widget.height ?? (isLandscape ? size.height : size.height / 2);

    return VisibilityDetector(
      key: const ValueKey('sustainable_strategy_section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: SizedBox(
        height: sectionHeight,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1542051841857-5f90071e7989?auto=format&fit=crop&w=2000&q=80',
                fit: BoxFit.cover,
                placeholder: (_, __) => const ColoredBox(color: Colors.black),
                errorWidget: (_, __, ___) => const ColoredBox(color: Colors.black),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.shade900.withOpacity(0.85),
                      Colors.indigo.shade900.withOpacity(0.55),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final showSideBySide = availableWidth > 720;
                final sidePadding = showSideBySide ? 96.0 : 24.0;
                final orbitExtent = showSideBySide ? null : math.min(availableWidth * 0.9, 360.0);

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chiến lược phát triển bền vững',
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: showSideBySide ? 40 : 24),
                      Expanded(
                    child: showSideBySide
                            ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: _MilestoneColumn(
                                        controller: _controller,
                                        milestones: _milestones,
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    Expanded(
                                      child: _EsgOrbit(
                                        controller: _controller,
                                        nodes: _esgItems,
                                        isWide: isWide,
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _MilestoneColumn(
                                      controller: _controller,
                                      milestones: _milestones,
                                      compact: true,
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: orbitExtent ?? 320,
                                      child: _EsgOrbit(
                                        controller: _controller,
                                        nodes: _esgItems,
                                        isWide: isWide,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MilestoneColumn extends StatelessWidget {
  const _MilestoneColumn({
    required this.controller,
    required this.milestones,
    this.compact = false,
  });

  final AnimationController controller;
  final List<_Milestone> milestones;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: compact ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
      children: List.generate(milestones.length, (index) {
        final start = (index * 0.18).clamp(0.0, 1.0);
        final end = (start + 0.35).clamp(0.0, 1.0);
        final animation = CurvedAnimation(
          parent: controller,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        );
        final milestone = milestones[index];

        final bottomPadding = compact && index != milestones.length - 1 ? 24.0 : 0.0;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: _AnimatedMilestone(
            animation: animation,
            milestone: milestone,
            isFirst: index == 0,
            theme: theme,
          ),
        );
      }),
    );
  }
}

class _AnimatedMilestone extends StatelessWidget {
  const _AnimatedMilestone({
    required this.animation,
    required this.milestone,
    required this.isFirst,
    required this.theme,
  });

  final Animation<double> animation;
  final _Milestone milestone;
  final bool isFirst;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.12, 0.12),
          end: Offset.zero,
        ).animate(animation),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  width: isFirst ? 22 : 18,
                  height: isFirst ? 22 : 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(isFirst ? 0.35 : 0.22),
                    border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 48,
                  width: 1,
                  color: Colors.white.withOpacity(0.25),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone.year,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  milestone.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EsgOrbit extends StatelessWidget {
  const _EsgOrbit({
    required this.controller,
    required this.nodes,
    required this.isWide,
  });

  final AnimationController controller;
  final List<_EsgNode> nodes;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final orbitSize = isWide ? 360.0 : 300.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveSize = math.min(constraints.maxWidth, orbitSize);
        final baseRadius = effectiveSize * 0.45;

        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: effectiveSize,
            width: effectiveSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: effectiveSize * 0.52,
                  height: effectiveSize * 0.52,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: effectiveSize * 0.38,
                  height: effectiveSize * 0.38,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'ESG',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                ...List.generate(nodes.length, (index) {
                  final node = nodes[index];
                  final start = 0.25 + index * 0.1;
                  final end = start + 0.25;
                  final animation = CurvedAnimation(
                    parent: controller,
                    curve: Interval(start.clamp(0.0, 1.0), end.clamp(0.0, 1.0), curve: Curves.easeOutBack),
                  );

                  return AnimatedBuilder(
                    animation: animation,
                    child: _OrbitingIcon(icon: node.icon),
                    builder: (context, child) {
                      final progress = animation.value.clamp(0.0, 1.0);
                      final radius = baseRadius * node.distanceFactor * progress;
                      final dx = radius * math.cos(node.angle);
                      final dy = radius * math.sin(node.angle);
                      return Positioned(
                        left: effectiveSize / 2 + dx - 28,
                        top: effectiveSize / 2 + dy - 28,
                        child: Opacity(
                          opacity: progress,
                          child: Transform.scale(
                            scale: 0.6 + 0.4 * progress,
                            child: child,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrbitingIcon extends StatelessWidget {
  const _OrbitingIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.8),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.45),
            blurRadius: 12,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

class _Milestone {
  const _Milestone({required this.year, required this.title});

  final String year;
  final String title;
}

class _EsgNode {
  const _EsgNode({
    required this.icon,
    required this.angle,
    required this.distanceFactor,
  });

  final IconData icon;
  final double angle;
  final double distanceFactor;
}
