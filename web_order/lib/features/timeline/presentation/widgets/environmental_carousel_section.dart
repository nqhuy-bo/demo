import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EnvironmentalCarouselSection extends StatefulWidget {
  const EnvironmentalCarouselSection({super.key, this.height});

  final double? height;

  @override
  State<EnvironmentalCarouselSection> createState() => _EnvironmentalCarouselSectionState();
}

class _EnvironmentalCarouselSectionState extends State<EnvironmentalCarouselSection> {
  final PageController _controller = PageController(viewportFraction: 0.4);
  int _currentIndex = 0;

  static const _items = [
    _CarouselItem(
      imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
      backgroundUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=2000&q=80',
      title: 'Tái tạo hạ tầng bền vững',
      description: 'Ứng dụng năng lượng tái tạo tại hệ thống cảng và kho vận.',
    ),
    _CarouselItem(
      imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ef?auto=format&fit=crop&w=1200&q=80',
      backgroundUrl: 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=2000&q=80',
      title: 'Chuỗi cung ứng xanh',
      description: 'Giảm phát thải CO₂ trong chuỗi vận tải và giao nhận hàng.',
    ),
    _CarouselItem(
      imageUrl: 'https://images.unsplash.com/photo-1433477155337-9aea4e790195?auto=format&fit=crop&w=1200&q=80',
      backgroundUrl: 'https://images.unsplash.com/photo-1495107334309-fcf20504a5ab?auto=format&fit=crop&w=2000&q=80',
      title: 'Phát triển cộng đồng',
      description: 'Các hoạt động ESG gắn liền với phát triển cộng đồng địa phương.',
    ),
  ];

  void _goTo(int index) {
    final target = index.clamp(0, _items.length - 1);
    _controller.animateToPage(
      target,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;
    final isLandscape = size.width >= size.height;
    final sectionHeight = widget.height ?? (isLandscape ? size.height : size.height / 2);

    return SizedBox(
      height: sectionHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: CachedNetworkImage(
                key: ValueKey(_items[_currentIndex].backgroundUrl),
                imageUrl: _items[_currentIndex].backgroundUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const ColoredBox(color: Colors.black),
                errorWidget: (_, __, ___) => const ColoredBox(color: Colors.black),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade900.withOpacity(0.83),
                    Colors.green.shade800.withOpacity(0.55),
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
              final showHorizontalLayout = availableWidth > 720;
              final padding = EdgeInsets.symmetric(
                horizontal: showHorizontalLayout ? 96 : 24,
                vertical: showHorizontalLayout ? 48 : 32,
              );

              final content = Column(
                crossAxisAlignment: showHorizontalLayout ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                children: [
                  Text(
                    'E',
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: Colors.lightGreenAccent,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ENVIRONMENTAL',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.lightGreenAccent,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Phát triển mô hình Cảng Xanh',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: showHorizontalLayout ? TextAlign.start : TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Góp phần xanh hoá chuỗi cung ứng thông qua các sáng kiến môi trường.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.85),
                    ),
                    textAlign: showHorizontalLayout ? TextAlign.start : TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: showHorizontalLayout ? 180 : 220,
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (index) => setState(() => _currentIndex = index),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            double value = 1;
                            if (_controller.position.haveDimensions) {
                              value = ((_controller.page ?? _controller.initialPage) - index).toDouble();
                              value = (1 - (value.abs() * 0.45)).clamp(0.75, 1.0);
                            }
                            return Center(
                              child: Transform.scale(
                                scale: value,
                                child: _CarouselCard(item: item, isActive: index == _currentIndex),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: showHorizontalLayout ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _CircleButton(
                            icon: Icons.arrow_back,
                            onPressed: () => _goTo(_currentIndex - 1),
                          ),
                          const SizedBox(width: 12),
                          _CircleButton(
                            icon: Icons.arrow_forward,
                            onPressed: () => _goTo(_currentIndex + 1),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: showHorizontalLayout ? 320 : 200,
                        child: _ProgressIndicator(
                          current: _currentIndex,
                          total: _items.length,
                        ),
                      ),
                    ],
                  ),
                ],
              );

              return Padding(
                padding: padding,
                child: showHorizontalLayout
                    ? content
                    : SingleChildScrollView(
                        child: content,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({required this.item, required this.isActive});

  final _CarouselItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isActive ? 0.9 : 0.6),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: isActive ? 24 : 12,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              height: 90,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => const ColoredBox(color: Colors.black12),
              errorWidget: (_, __, ___) => const ColoredBox(color: Colors.black12),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              item.title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.green.shade900,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.green.shade800.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.3),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(14),
      ),
      child: Icon(icon),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: (current + 1) / total),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 6,
                  width: constraints.maxWidth * value,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _CarouselItem {
  const _CarouselItem({
    required this.imageUrl,
    required this.backgroundUrl,
    required this.title,
    required this.description,
  });

  final String imageUrl;
  final String backgroundUrl;
  final String title;
  final String description;
}
