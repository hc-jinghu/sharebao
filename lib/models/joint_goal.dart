// Properties of a joint goal
// Joint Goal is participated by all users in the group

class JointGoal {
  final String name;
  final String? purpose;
  double amount;
  double progress;
  bool archived;

  JointGoal({
    required this.name,
    required this.purpose,
    required this.amount,
    this.progress = 0,
    this.archived = false,
  });

  toJson() {
    return {
      name: {
        "purpose": purpose,
        "amount": amount,
        "progress": progress,
        "archived": archived,
      }
    };
  }
}
