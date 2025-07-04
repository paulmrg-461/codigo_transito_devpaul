import 'package:codigo_transito_devpaul/presentation/screens/basic_prompt/basic_prompt_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:codigo_transito_devpaul/presentation/screens/home/home_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/basic-prompt',
      builder: (context, state) => const BasicPromptScreen(),
    ),
  ],
);
