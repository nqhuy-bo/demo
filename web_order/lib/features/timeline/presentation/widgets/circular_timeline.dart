import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../data/models/timeline_node.dart';
import '../bloc/timeline_bloc.dart';

class CircularTimeline extends StatefulWidget {
  const CircularTimeline({
    super.key,
    required this.nodes,
    this.headerTitle = 'Hành trình & các mốc son',
    this.headerSubtitle,
    this.introHighlight = '35',
    this.introDescription = 'Năm Hành trình & các Mốc son',
  });

  final List<TimelineNode> nodes;
  final String headerTitle;
  final String? headerSubtitle;
  final String introHighlight;
  final String introDescription;

  @override
  State<CircularTimeline> createState() => _CircularTimelineState();
}

class _CircularTimelineState extends State<CircularTimeline> with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  double _currentRotation = 0.0;
  double _dragDistance = 0.0;
  final ValueNotifier<double> _parallaxNotifier = ValueNotifier<double>(0.0);
  late final AnimationController _timelineRevealController;
  late final Animation<double> _timelineOpacity;
  late final Animation<double> _timelineScale;
  late final AnimationController _introController;
  late final Animation<double> _introOpacity;
  bool _showIntro = true;
  Timer? _autoAdvanceTimer;
  bool _hasVisibilityReset = false;

  TimelineBloc get _bloc => context.read<TimelineBloc>();

  @override
  void initState() {
    super.initState();
    _currentRotation = _computeTargetRotation(0, widget.nodes.length);
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _rotationAnimation = AlwaysStoppedAnimation<double>(_computeTargetRotation(0, widget.nodes.length));
    _timelineRevealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 620),
    );
    final revealCurve = CurvedAnimation(
      parent: _timelineRevealController,
      curve: Curves.easeOutCubic,
    );
    _timelineOpacity = revealCurve;
    _timelineScale = Tween<double>(begin: 0.9, end: 1.0).animate(revealCurve);
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _introOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeInOutCubic,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showIntro = false;
          });
          _scheduleAutoAdvance();
        }
      });

    _timelineRevealController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scheduleAutoAdvance();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _timelineRevealController.dispose();
    _introController.dispose();
    _autoAdvanceTimer?.cancel();
    _parallaxNotifier.dispose();
    super.dispose();
  }

  double _computeTargetRotation(int index, int total) {
    if (total == 0) return 0;
    return -2 * math.pi * index / total;
  }

  void _animateRotation(int targetIndex) {
    final target = _computeTargetRotation(targetIndex, widget.nodes.length);
    _rotationAnimation = Tween<double>(
      begin: _currentRotation,
      end: target,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeOutCubic,
    ))
      ..addListener(() {
        setState(() {});
      });
    _rotationController
      ..reset()
      ..forward();
    _currentRotation = target;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details, Size size) {
    if (_showIntro) return;
    _cancelAutoAdvance();
    _dragDistance += details.primaryDelta ?? 0;
    final normalized = (_dragDistance / size.width).clamp(-1.0, 1.0);
    _parallaxNotifier.value = normalized * 0.6;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_showIntro) return;
    const threshold = 60.0;
    if (_dragDistance.abs() > threshold) {
      if (_dragDistance < 0) {
        _bloc.add(const TimelineEvent.next());
      } else {
        _bloc.add(const TimelineEvent.previous());
      }
    }
    _dragDistance = 0;
    _parallaxNotifier.value = 0;
    _scheduleAutoAdvance();
  }

  void _startExperience() {
    if (!_showIntro || _introController.isAnimating) return;
    _cancelAutoAdvance();
    _timelineRevealController.forward();
    _introController.forward();
  }

  void _scheduleAutoAdvance() {
    if (_showIntro) return;
    _cancelAutoAdvance();
    _autoAdvanceTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || _showIntro) return;
      _bloc.add(const TimelineEvent.next());
    });
  }

  void _resetExperience() {
    _cancelAutoAdvance();
    if (_introController.isAnimating) {
      _introController.stop();
    }
    if (_timelineRevealController.isAnimating) {
      _timelineRevealController.stop();
    }
    _introController.reset();
    _timelineRevealController.reset();
    _rotationController.stop();
    _parallaxNotifier.value = 0;
    _bloc.add(const TimelineEvent.select(0));
    setState(() {
      _showIntro = true;
      _currentRotation = _computeTargetRotation(0, widget.nodes.length);
      _rotationAnimation = AlwaysStoppedAnimation<double>(_currentRotation);
    });
  }

  void _handleVisibility(VisibilityInfo info) {
    if (info.visibleFraction < 0.2 && !_hasVisibilityReset) {
      _resetExperience();
      _hasVisibilityReset = true;
    } else if (info.visibleFraction >= 0.2 && _hasVisibilityReset) {
      _hasVisibilityReset = false;
    }
  }

  void _cancelAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    final timelineState = context.watch<TimelineBloc>().state;
    final nodes = timelineState.nodes;
    final currentNode = nodes[timelineState.currentIndex];

    return BlocListener<TimelineBloc, TimelineState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (_, state) {
        _animateRotation(state.currentIndex);
        _parallaxNotifier.value = 0;
        _scheduleAutoAdvance();
      },
      child: VisibilityDetector(
        key: const ValueKey('circular_timeline_section'),
        onVisibilityChanged: _handleVisibility,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final diameter = constraints.biggest.shortestSide * (isDesktop ? 0.9 : 0.98);
            final radius = diameter * 0.4;
            final isCompact = constraints.biggest.height < 720 || constraints.biggest.width < 520;
            final innerRadius = radius * (isCompact ? 0.48 : 0.58);
            final orbitRadius = innerRadius + (radius - innerRadius) * 0.52;
            final nodeOffsetX = radius * 0.24;
            final nodeOffsetY = radius * 0.3;
            final circleSize = Size.square(diameter);
            final edgeTop = constraints.biggest.height * (isCompact ? 0.6 : 0.53);
            final edgeHorizontal = isDesktop ? 56.0 : 20.0;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(details, circleSize),
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: _ParallaxBackground(
                      nodes: nodes,
                      parallax: _parallaxNotifier,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.75),
                            Colors.black.withOpacity(0.35),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: _showIntro,
                    child: FadeTransition(
                      opacity: _timelineOpacity,
                      child: ScaleTransition(
                        scale: _timelineScale,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: constraints.biggest.height * 0.08,
                              left: 0,
                              right: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.headerTitle,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.2,
                                        ),
                                  ),
                                  if (widget.headerSubtitle?.isNotEmpty ?? false)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        widget.headerSubtitle!,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: edgeHorizontal,
                              top: edgeTop,
                              child: _EdgeYearLabel(
                                year: nodes.first.year.toString(),
                                isLeft: true,
                              ),
                            ),
                            Positioned(
                              right: edgeHorizontal,
                              top: edgeTop,
                              child: _EdgeYearLabel(
                                year: nodes.last.year.toString(),
                                isLeft: false,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: isDesktop ? 48 : 16,
                                ),
                                child: _TimelineArrowButton(
                                  icon: Icons.chevron_left,
                                  onPressed: () {
                                    _cancelAutoAdvance();
                                    _bloc.add(const TimelineEvent.previous());
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: isDesktop ? 48 : 16,
                                ),
                                child: _TimelineArrowButton(
                                  icon: Icons.chevron_right,
                                  onPressed: () {
                                    _cancelAutoAdvance();
                                    _bloc.add(const TimelineEvent.next());
                                  },
                                ),
                              ),
                            ),
                            Center(
                              child: _TimelineCore(
                                circleSize: circleSize,
                                radius: radius,
                                innerRadius: innerRadius,
                                orbitRadius: orbitRadius,
                                isCompact: isCompact,
                                parallax: _parallaxNotifier,
                                rotationController: _rotationController,
                                rotationAnimation: _rotationAnimation,
                                onNodeTap: (index) {
                                  _cancelAutoAdvance();
                                  _bloc.add(TimelineEvent.select(index));
                                },
                                node: currentNode,
                                nodes: nodes,
                                nodeOffsetX: nodeOffsetX,
                                nodeOffsetY: nodeOffsetY,
                              ),
                            ),
                            if (isCompact)
                              Positioned(
                                bottom: constraints.biggest.height * 0.06,
                                left: 24,
                                right: 24,
                                child: _CompactDetails(node: currentNode),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_showIntro || _introController.isAnimating)
                    AnimatedBuilder(
                      animation: _introController,
                      builder: (context, child) {
                        return IgnorePointer(
                          ignoring: !_showIntro && _introController.status == AnimationStatus.completed,
                          child: Opacity(
                            opacity: _introOpacity.value,
                            child: child,
                          ),
                        );
                      },
                      child: _IntroOverlay(
                        highlight: widget.introHighlight,
                        description: widget.introDescription,
                        onStart: _startExperience,
                        firstYear: nodes.first.year.toString(),
                        lastYear: nodes.last.year.toString(),
                        edgeTop: edgeTop,
                        horizontalPadding: edgeHorizontal,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TimelineCirclePainter extends CustomPainter {
  _TimelineCirclePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.015
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RadialNodes extends StatelessWidget {
  const _RadialNodes({
    required this.nodes,
    required this.rotation,
    required this.orbitRadius,
    required this.outerRadius,
    required this.offsetX,
    required this.offsetY,
    required this.onNodeTap,
  });

  final List<TimelineNode> nodes;
  final double rotation;
  final double orbitRadius;
  final double outerRadius;
  final double offsetX;
  final double offsetY;
  final ValueChanged<int> onNodeTap;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TimelineBloc>().state;
    final nodeCount = nodes.length;
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (var i = 0; i < nodeCount; i++)
          _buildNode(
            context,
            index: i,
            isActive: i == state.currentIndex,
            theme: theme,
            count: nodeCount,
          ),
      ],
    );
  }

  Widget _buildNode(
    BuildContext context, {
    required int index,
    required bool isActive,
    required ThemeData theme,
    required int count,
  }) {
    final angle = (2 * math.pi * index / count) - math.pi / 2 + rotation;
    final x = orbitRadius * math.cos(angle);
    final y = orbitRadius * math.sin(angle);
    final baseStyle = theme.textTheme.labelLarge ?? theme.textTheme.bodyMedium!;

    final size = isActive ? 52.0 : 36.0;
    return Positioned(
      left: outerRadius + x - size / 2 + offsetX,
      top: outerRadius + y - size / 2 + offsetY,
      child: GestureDetector(
        onTap: () => onNodeTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: isActive
                ? const RadialGradient(
                    colors: [
                      Color(0xFF2F7CEC),
                      Color(0xFF0A4AD3),
                    ],
                    stops: [0.4, 1],
                  )
                : null,
            color: isActive ? null : theme.colorScheme.surfaceVariant.withOpacity(0.45),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(isActive ? 0.7 : 0.3),
              width: isActive ? 3.5 : 1.8,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.5),
                      blurRadius: 22,
                      spreadRadius: 3,
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: baseStyle.copyWith(
              color: Colors.white,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              fontSize: isActive ? 16 : 11,
              letterSpacing: isActive ? 0.8 : 0.2,
              height: 1.0,
            ),
            child: Text(
              nodes[index].year.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineCore extends StatelessWidget {
  const _TimelineCore({
    required this.circleSize,
    required this.radius,
    required this.innerRadius,
    required this.orbitRadius,
    required this.isCompact,
    required this.parallax,
    required this.rotationController,
    required this.rotationAnimation,
    required this.onNodeTap,
    required this.nodes,
    required this.node,
    required this.nodeOffsetX,
    required this.nodeOffsetY,
  });

  final Size circleSize;
  final double radius;
  final double innerRadius;
  final double orbitRadius;
  final bool isCompact;
  final ValueNotifier<double> parallax;
  final AnimationController rotationController;
  final Animation<double> rotationAnimation;
  final ValueChanged<int> onNodeTap;
  final List<TimelineNode> nodes;
  final TimelineNode node;
  final double nodeOffsetX;
  final double nodeOffsetY;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: circleSize.width,
      height: circleSize.height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: radius * 2.6,
            height: radius * 2.3,
            child: _HaloDecoration(radius: radius),
          ),
          SizedBox(
            width: radius * 2,
            height: radius * 2,
            child: CustomPaint(
              painter: _TimelineCirclePainter(
                color: Colors.white.withOpacity(0.18),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: rotationController,
            builder: (context, child) {
              final rotation = rotationAnimation.value;
              return _RadialNodes(
                nodes: nodes,
                rotation: rotation,
                orbitRadius: orbitRadius,
                outerRadius: radius,
                offsetX: nodeOffsetX,
                offsetY: nodeOffsetY,
                onNodeTap: onNodeTap,
              );
            },
          ),
          _CenterContent(
            parallax: parallax,
            diameter: innerRadius * 2,
            isCompact: isCompact,
            node: node,
          ),
        ],
      ),
    );
  }
}

class _CenterContent extends StatelessWidget {
  const _CenterContent({
    required this.parallax,
    required this.diameter,
    required this.isCompact,
    required this.node,
  });

  final ValueNotifier<double> parallax;
  final double diameter;
  final bool isCompact;
  final TimelineNode node;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final circle = ValueListenableBuilder<double>(
      valueListenable: parallax,
      builder: (context, offset, _) {
        return Transform.translate(
          offset: Offset(offset * 20, 0),
          child: SizedBox(
            width: diameter,
            height: diameter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [
                    Color(0xCC0D1726),
                    Color(0xE6000000),
                  ],
                  stops: [0.3, 1],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.22),
                  width: 1.6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: diameter * 0.15,
                  vertical: diameter * 0.18,
                ),
                child: isCompact
                    ? Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 320),
                          child: Text(
                            node.year.toString(),
                            key: ValueKey(node.year),
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            child: Text(
                              node.year.toString(),
                              key: ValueKey(node.year),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: Text(
                              node.title,
                              key: ValueKey(node.title),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: Text(
                              node.description,
                              key: ValueKey(node.description),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withOpacity(0.75),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );

    if (!isCompact) {
      return Positioned.fill(child: Center(child: circle));
    }

    return Positioned.fill(child: Center(child: circle));
  }
}

class _CompactDetails extends StatelessWidget {
  const _CompactDetails({required this.node});

  final TimelineNode node;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: Container(
        key: ValueKey(node.year),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              node.year.toString(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              node.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              node.description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParallaxBackground extends StatelessWidget {
  const _ParallaxBackground({
    required this.nodes,
    required this.parallax,
  });

  final List<TimelineNode> nodes;
  final ValueNotifier<double> parallax;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineBloc, TimelineState>(
      buildWhen: (previous, current) => previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        final node = state.nodes[state.currentIndex];
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 650),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          layoutBuilder: (child, previousChildren) => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ...previousChildren,
              if (child != null) child,
            ],
          ),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: ValueListenableBuilder<double>(
            key: ValueKey(node.image),
            valueListenable: parallax,
            builder: (context, offset, _) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Transform.translate(
                    offset: Offset(offset * 40, 0),
                    child: _BackgroundImage(imageUrl: node.image),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _IntroOverlay extends StatelessWidget {
  const _IntroOverlay({
    required this.highlight,
    required this.description,
    required this.onStart,
    required this.firstYear,
    required this.lastYear,
    required this.edgeTop,
    required this.horizontalPadding,
  });

  final String highlight;
  final String description;
  final VoidCallback onStart;
  final String firstYear;
  final String lastYear;
  final double edgeTop;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox.expand(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onStart,
          splashColor: Colors.white10,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.35),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      highlight,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Chạm để bắt đầu hành trình',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: edgeTop, left: horizontalPadding),
                  child: _EdgeYearLabel(year: firstYear, isLeft: true),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: edgeTop, right: horizontalPadding),
                  child: _EdgeYearLabel(year: lastYear, isLeft: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineArrowButton extends StatelessWidget {
  const _TimelineArrowButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.18),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Icon(icon, size: 28),
    );
  }
}

class _HaloDecoration extends StatelessWidget {
  const _HaloDecoration({required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HaloPainter(color: Colors.white.withOpacity(0.12)),
      size: Size.square(radius * 2.2),
    );
  }
}

class _HaloPainter extends CustomPainter {
  _HaloPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = RadialGradient(
      colors: [
        color,
        Colors.transparent,
      ],
    );
    final paint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: size.center(Offset.zero),
        width: size.width,
        height: size.height * 1.05,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EdgeYearLabel extends StatelessWidget {
  const _EdgeYearLabel({
    required this.year,
    required this.isLeft,
  });

  final String year;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final line = Container(
      width: 56,
      height: 1,
      color: Colors.white.withOpacity(0.6),
    );
    final text = Text(
      year,
      style: theme.textTheme.titleMedium?.copyWith(
        color: Colors.white.withOpacity(0.85),
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: isLeft
          ? [
              text,
              const SizedBox(width: 12),
              line,
            ]
          : [
              line,
              const SizedBox(width: 12),
              text,
            ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final isNetwork = imageUrl.startsWith('http');
    final widget = isNetwork
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const ColoredBox(
              color: Colors.black,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => const ColoredBox(
              color: Colors.black,
              child: Center(child: Icon(Icons.broken_image, color: Colors.white)),
            ),
          )
        : Image.asset(imageUrl, fit: BoxFit.cover);

    return Stack(
      fit: StackFit.expand,
      children: [
        widget,
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.3),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
