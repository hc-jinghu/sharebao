import 'package:sharebao/const.dart';
import 'package:sharebao/models/joint_goal.dart';

// CRUD joint goal

final List<String> goalTypes = ["budget", "project"];

// add joint goal
Future addJointGoal(
  String type,
  String name,
  String purpose,
  double amount,
  double progress,
  bool archived,
) async {
  await db.collection('jointGoal').doc(type).set(JointGoal(
        name: name,
        purpose: purpose,
        amount: amount,
        progress: progress,
        archived: archived,
      ).toJson());
}

// get budget goals
Map<String, dynamic> budgetGoals = {};
Future getBudgetGoal() async {
  db.collection('jointGoal').doc(goalTypes.first).get().then(
    (snapshot) {
      budgetGoals = snapshot.data() as Map<String, dynamic>;
    },
  );
}

// get budget names
List<String> budgetList = [];
void getBudgetNames() {
  budgetList.clear();
  for (var budget in budgetGoals.keys) {
    budgetList.add(budget);
  }
}

// get project goals
Map<String, dynamic> projectGoals = {};
Future getProjectGoal() async {
  db.collection('jointGoal').doc(goalTypes.last).get().then(
    (snapshot) {
      projectGoals = snapshot.data() as Map<String, dynamic>;
    },
  );
}

// get project names
List<String> projectList = [];
void getProjectNames() {
  projectList.clear();
  for (var project in projectGoals.keys) {
    projectList.add(project);
  }
}

// update joint goal

// delete joint goal