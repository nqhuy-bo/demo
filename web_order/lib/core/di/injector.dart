import 'package:get_it/get_it.dart';
import '../../features/timeline/data/models/timeline_node.dart';
import '../../features/timeline/data/repositories/timeline_repository.dart';
import '../../features/timeline/presentation/bloc/timeline_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  if (locator.isRegistered<TimelineRepository>()) return;

  locator.registerLazySingleton<TimelineRepository>(
    () => const TimelineRepository(),
  );

  locator.registerFactoryParam<TimelineBloc, List<TimelineNode>, void>(
    (nodes, _) => TimelineBloc(nodes: nodes),
  );
}
