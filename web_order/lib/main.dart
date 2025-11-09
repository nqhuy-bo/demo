import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'core/di/injector.dart';
import 'features/timeline/data/models/timeline_node.dart';
import 'features/timeline/data/repositories/timeline_repository.dart';
import 'features/timeline/presentation/bloc/timeline_bloc.dart';
import 'features/timeline/presentation/widgets/circular_timeline.dart';
import 'features/timeline/presentation/widgets/environmental_carousel_section.dart';
import 'features/timeline/presentation/widgets/sustainable_strategy_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const TimelineApp());
}

class TimelineApp extends StatelessWidget {
  const TimelineApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TimelineRepository repository = locator<TimelineRepository>();
    final nodes = repository.fetchTimelineNodes();

    return BlocProvider<TimelineBloc>(
      create: (_) => locator<TimelineBloc>(param1: nodes),
      child: MaterialApp(
        title: 'Circular Timeline Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = MediaQuery.of(context).size;
                final sectionHeight = size.height.isFinite ? math.max(size.height, 720.0) : 720.0;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: sectionHeight,
                        width: double.infinity,
                        child: CircularTimeline(
                          nodes: nodes,
                          headerTitle: '35 Năm Hành trình & các Mốc son',
                          headerSubtitle: 'Các cột mốc nổi bật',
                          introHighlight: '35',
                          introDescription: 'Năm Hành trình & các Mốc son',
                        ),
                      ),
                      const SizedBox(height: 72),
                      SustainableStrategySection(height: sectionHeight),
                      const SizedBox(height: 72),
                      EnvironmentalCarouselSection(height: sectionHeight),
                      const SizedBox(height: 96),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
