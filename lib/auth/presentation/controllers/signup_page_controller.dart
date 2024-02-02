import 'package:gibspons/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'signup_page_controller.g.dart';

@riverpod
class SignupPageController extends _$SignupPageController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    final authRepository = ref.read(djangoAuthRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.register(
        email: email,
        password: password,
        name: name,
      ),
    );
  }
}
