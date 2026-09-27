enum RideStatus {
  incoming,
  accepted,
  enRouteToPickup,
  arrived,
  inProgress,
  completed,
  cancelled;

  bool get isCurrent =>
      this == accepted ||
      this == enRouteToPickup ||
      this == arrived ||
      this == inProgress;

  bool get isPast => this == completed;

  bool get isCancelled => this == cancelled;

  bool get isIncoming => this == incoming;

  String get label => switch (this) {
        RideStatus.incoming => 'New Assignment',
        RideStatus.accepted => 'Accepted',
        RideStatus.enRouteToPickup => 'En Route',
        RideStatus.arrived => 'Arrived',
        RideStatus.inProgress => 'In Progress',
        RideStatus.completed => 'Completed',
        RideStatus.cancelled => 'Cancelled',
      };
}
