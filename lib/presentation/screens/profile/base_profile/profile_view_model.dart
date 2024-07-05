import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/address.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/models/user.dart';
import 'package:make_appointment_app/presentation/helper/iterable_extensions.dart';
import 'package:make_appointment_app/repository/profile_repository.dart';

class ProfileViewModel extends BaseViewModel {
  final _profileRepository = locator.get<ProfileRepository>();
  User? user;
  List<Address> allAddresses = [];
  Address? get defaultAddress =>
      allAddresses.firstWhereOrNull((e) => e.defaultFlg == 1);

  ProfileViewModel() {
    getProfileData();
  }

  Future<void> getProfileData() async {
    handleMultiTask(
      requests: [
        getUser(),
        getAllAddresses(),
      ],
      onSuccess: (_) {
        notifyListeners();
      },
    );
  }

  Future<DataResult<User>> getUser() async {
    return handleTaskWithResultReturn(
      showLoading: false,
      showErrorDialog: false,
      onRequest: () => _profileRepository.getUser(),
      onSuccess: (value) {
        user = value;
      },
    );
  }

  Future<DataResult<List<Address>>> getAllAddresses() async {
    return handleTaskWithResultReturn(
      showLoading: false,
      showErrorDialog: false,
      onRequest: () => _profileRepository.getAllAddresses(),
      onSuccess: (value) {
        allAddresses = value;
      },
    );
  }
}
