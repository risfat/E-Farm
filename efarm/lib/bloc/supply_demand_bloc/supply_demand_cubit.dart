import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';
import '../../repositories/repository.dart';

part 'supply_demand_state.dart';

class SupplyDemandCubit extends Cubit<SupplyDemandState> {
  SupplyDemandCubit()
      : super(const SupplyDemandState.loading());

  final Repository userRepository = Repository();

  Future<void> init() async {
    try {
      final user = await userRepository.getUsers();
      emit(SupplyDemandState.success(user.users));
    } on Exception {
      emit(const SupplyDemandState.failure());
    }
  }


}
