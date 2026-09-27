/// A driver's availability toward taking on new jobs — set manually by the
/// driver, independent of whether a job is currently in progress.
enum DriverStatus {
  active('Active', 'You are currently working on FleetOps jobs and can take on new ones.'),
  onBreak('Taking a break', "You can't take on new jobs. FleetOps keeps tracking your location in the background."),
  unavailable(
    'Unavailable',
    "You can't take on or perform FleetOps jobs. When you're unavailable, GPS is turned off and doesn't use up the battery.",
  );

  const DriverStatus(this.label, this.description);

  final String label;
  final String description;
}
