import 'package:go_router/go_router.dart';
import 'package:tasks/presentation/detail/detail_page.dart';
import 'package:tasks/presentation/home/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DetailPage(id: id);
          },
        ),
      ],
    ),
  ],
);
