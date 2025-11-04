import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mymoodie/features/auth/presentation/pages/login_page.dart';
import 'package:mymoodie/features/auth/presentation/pages/register_page.dart';
import 'package:mymoodie/features/mood/presentation/bloc/mood_bloc.dart';
import 'package:mymoodie/features/mood/presentation/pages/mood_main_screen.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_text_styles.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di; // 👈 added

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init(); // 👈 initialize GetIt

  runApp(const MyMoodieApp());
}

class MyMoodieApp extends StatelessWidget {
  const MyMoodieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>(), // 👈 use from GetIt
        ),
        BlocProvider<MoodBloc>(
          create: (_) => di.sl<MoodBloc>(), // 👈 add this line
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyMoodie',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          textTheme: const TextTheme(
            headlineLarge: AppTextStyles.heading1,
            headlineMedium: AppTextStyles.heading2,
            bodyLarge: AppTextStyles.body,
            bodyMedium: AppTextStyles.small,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppColors.accent,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: AppTextStyles.button,
            ),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/mood-main': (_) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return MoodMainScreen(userId: user.uid);
            } else {
              return const LoginPage(); // Fallback if no user
            }
          },
        },
      ),
    );
  }
}
