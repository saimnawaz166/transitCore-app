/// A driver's availability toward taking on new jobs — set manually by the
/// driver, independent of whether a job is currently in progress. Synced to
/// the backend's own DriverStatus enum via [wireValue]/[fromWire].
enum DriverStatus {
  active('Active', 'You are currently working on FleetOps jobs and can take on new ones.', 'active'),
  onBreak(
    'Taking a break',
    "You can't take on new jobs. FleetOps keeps tracking your location in the background.",
    'on-break',
  ),
  unavailable(
    'Unavailable',
    "You can't take on or perform FleetOps jobs. When you're unavailable, GPS is turned off and doesn't use up the battery.",
    'unavailable',
  );

  const DriverStatus(this.label, this.description, this.wireValue);

  final String label;
  final String description;
  final String wireValue;

  static DriverStatus fromWire(String value) => DriverStatus.values.firstWhere(
        (s) => s.wireValue == value,
        orElse: () => DriverStatus.unavailable,
      );
}
