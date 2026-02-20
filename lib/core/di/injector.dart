import 'package:get_it/get_it.dart';
import 'package:huungry/core/di/injector.config.dart';
import 'package:injectable/injectable.dart';

// ignore: unused_import

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
