enum DashboardStatus {
  initial,
  exit,
}

final class DashboardState {
  final DashboardStatus status;

  const DashboardState({
    this.status = DashboardStatus.initial,
  });

  DashboardState copyWith({
    DashboardStatus? status,
  }) {
    return DashboardState(
      status: status ?? this.status,
    );
  }
}