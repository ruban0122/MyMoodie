import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// AUTH
import 'features/auth/data/data_sources/firebase_auth_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/domain/usecases/google_sign_in_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

// MOOD
import 'features/mood/data/data_sources/mood_remote_data_source.dart';
import 'features/mood/data/repositories/mood_repository_impl.dart';
import 'features/mood/domain/repositories/mood_repository.dart';
import 'features/mood/domain/usecases/add_mood.dart';
import 'features/mood/domain/usecases/get_moods.dart';
import 'features/mood/domain/usecases/delete_mood.dart';
import 'features/mood/presentation/bloc/mood_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 🔥 Firebase Core Services
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // ============================
  // AUTH FEATURE
  // ============================
  sl.registerLazySingleton(() => FirebaseAuthSource(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => GoogleSignInUseCase());

  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
        googleSignInUseCase: sl(),
      ));

  // ============================
  // MOOD FEATURE
  // ============================
  sl.registerLazySingleton<MoodRemoteDataSource>(
      () => MoodRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<MoodRepository>(() => MoodRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AddMood(sl()));
  sl.registerLazySingleton(() => GetMoods(sl()));
  sl.registerLazySingleton(() => DeleteMood(sl()));

  sl.registerFactory(() => MoodBloc(
        addMood: sl(),
        getMoods: sl(),
        deleteMood: sl(),
      ));
}
