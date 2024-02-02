import 'package:gibspons/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'login_page_controller.g.dart';

@riverpod
class LoginPageController extends _$LoginPageController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final authRepository = ref.read(djangoAuthRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authRepository.login(
        email: email,
        password: password,
      ),
    );
  }
}
