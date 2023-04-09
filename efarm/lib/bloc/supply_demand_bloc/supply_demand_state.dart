part of 'supply_demand_cubit.dart';

enum Status { loading, success, failure }

class SupplyDemandState extends Equatable {
  const SupplyDemandState._({
    this.status = Status.loading,
    this.users =  const <UserModel>[],
  });

  const SupplyDemandState.loading() : this._();

  const SupplyDemandState.success(List<UserModel> users)
      : this._(status: Status.success, users: users);

  const SupplyDemandState.failure() : this._(status: Status.failure);

  final Status status;
  final List<UserModel> users;

  @override
  List<Object> get props => [status, users];
}
