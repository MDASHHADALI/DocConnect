import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/helpers/network_manager.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';

import 'data/repositories/authentication/authentication_repository.dart';

Future<void> emailAndPasswordSignOut() async {
  try {
    TFullScreenLoader.openLoadingDialog(
        'Logging you out...', TImages.docerAnimation);
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    final userCredentials = await AuthenticationRepository.instance.logout();
    TFullScreenLoader.stopLoading();
    AuthenticationRepository.instance.screenRedirect();
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
  }
}
