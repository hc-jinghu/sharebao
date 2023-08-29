import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharebao/const.dart';
import 'package:sharebao/data/category_data.dart';
import 'package:sharebao/data/finance_data.dart';
import 'package:sharebao/data/joint_goal_data.dart';
import 'package:sharebao/data/user_data.dart';

// Add an income or expense item

class AddItemPage extends StatefulWidget {
  // Type of financeItem, income or expense
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  // controllers
  final newItemAmountController = TextEditingController();
  final newItemDescController = TextEditingController();
  final _splitScrollController = ScrollController();
  final _tempScrollController = ScrollController();

  List<TextEditingController> splitAmountControllers = [];
  void generateNewSplitControllers(int users) {
    splitAmountControllers.clear();
    for (var i = 0; i < users; i++) {
      splitAmountControllers.add(TextEditingController());
      splitAmountControllers[i].text = '0';
    }
  }

  List<TextEditingController> tempAmountControllers = [];
  void generateNewTempControllers(int users) {
    tempAmountControllers.clear();
    for (var i = 0; i < users; i++) {
      tempAmountControllers.add(TextEditingController());
      tempAmountControllers[i].text = '0';
    }
  }

  // Calculate split amount based on splitOptions
  /*
  if splitoption.percent, double.parse(amount*splitcontroller.text)
  if splitoption.exact, double.parse(splitcontroller.text)
   */

  // Types options
  String selectedType = types.first;
  bool isExpense() {
    if (selectedType == types.first) {
      return true;
    } else {
      return false;
    }
  }

  // Category dropdown
  String? selectedCategory = "";
  List<String> categoryList() {
    if (isExpense()) {
      getExpenseCategories(categories);
      selectedCategory = expenseCategories.first;
      return expenseCategories;
    } else {
      getIncomeCategories(categories);
      selectedCategory = incomeCategories.first;
      return incomeCategories;
    }
  }

  // Project/Budget goal dropdown
  String? selectedGoal = "";
  List<String> goalList = [];
  String goalType() {
    if (selectedType == types.first) {
      goalList = budgetList;
      selectedGoal = goalList.first;
      return "Budget";
    } else {
      goalList = projectList;
      selectedGoal = goalList.first;
      return "Project";
    }
  }

  Widget _renderSplitPrompt(Widget splitAmountWidget, Widget goalDropdown) {
    switch (selectedSplit) {
      case (SplitOptions.percent || SplitOptions.exact):
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            splitAmountWidget,
          ],
        );
      case SplitOptions.none:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            goalDropdown,
          ],
        );
      default:
        return const SizedBox(height: 10);
    }
  }

  // Split pay
  Widget _splitPayWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: 310,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 229, 219, 240),
      ),
      child: userIds.isNotEmpty
          ? MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Scrollbar(
                controller: _splitScrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  primary: false,
                  controller: _splitScrollController,
                  itemCount: userIds.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getUserName(userIds[index]),
                            style: defaultStyle,
                          ),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                              style: const TextStyle(fontSize: 13),
                              decoration: const InputDecoration(hintText: '0'),
                              controller: splitAmountControllers[index],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          : const Center(child: Text("don't split with yourself :p")),
    );
  }

  // Temp pay
  bool isTempPay = false;
  Widget _tempPayWidget(bool isTempPay) {
    return isTempPay
        ? Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: 310,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 229, 219, 240),
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Scrollbar(
                controller: _tempScrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  primary: false,
                  controller: _tempScrollController,
                  itemCount: userIds.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getUserName(userIds[index]),
                            style: defaultStyle,
                          ),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                              style: const TextStyle(fontSize: 13),
                              decoration: const InputDecoration(hintText: '0'),
                              controller: tempAmountControllers[index],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        : const SizedBox(height: 10);
  }

  // Date picker
  DateTime date = DateTime.now();
  void _showDateDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  // Action button: save
  Future add() async {
    addItem(
      userIds,
      date.month,
      date.day,
      date.year,
      newItemDescController.text,
      double.parse(newItemAmountController.text),
      selectedSplit.toString(),
      selectedType,
      selectedCategory,
      selectedGoal,
      'CAD',
    );
    newItemDescController.clear();
    newItemAmountController.clear();
    // update user split
    for (var i = 0; i < userIds.length; i++) {
      updateSplitPayment(
          userIds[i], currId, double.parse(splitAmountControllers[i].text));
    }
    splitAmountControllers.clear;
    // update user temp

    generateNewId(currId);

    // TODO: navigate to list page
  }

  @override
  void dispose() {
    newItemDescController.dispose();
    newItemAmountController.dispose();
    for (var controller in splitAmountControllers) {
      controller.dispose();
    }
    for (var controller in tempAmountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    generateNewSplitControllers(userIds.length);
    generateNewTempControllers(userIds.length);
    selectedType = types.first;
    selectedSplit = SplitOptions.equal;
    getBudgetNames();
    getProjectNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('New Record'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 160,
                  width: 300,
                  child: Column(
                    children: [
                      // currency + amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // TODO: change currency to drop down menu
                          const Text(
                            'CAD',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: newItemAmountController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'amount',
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              ],
                            ),
                          ),
                          // photo widget
                          Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[500],
                                borderRadius: BorderRadius.circular(12)),
                            child: MaterialButton(
                              onPressed: () {},
                              child: const SizedBox.square(
                                dimension: 80,
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                          )
                        ],
                      ),
                      // TextField(desc) + date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextField(
                              maxLength: 30,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'desciption',
                              ),
                              controller: newItemDescController,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            child: CupertinoButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              onPressed: () => _showDateDialog(
                                CupertinoDatePicker(
                                  initialDateTime: date,
                                  mode: CupertinoDatePickerMode.date,
                                  use24hFormat: true,
                                  showDayOfWeek: true,
                                  maximumYear: date.year,
                                  onDateTimeChanged: (DateTime newDate) {
                                    setState(() => date = newDate);
                                  },
                                ),
                              ),
                              child: Text(
                                '${date.year}/${date.month}/${date.day}',
                                style: const TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // type + category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 55,
                  width: 170,
                  child: SegmentedButton<String>(
                    segments: <ButtonSegment<String>>[
                      ButtonSegment(
                          value: types.first, label: const Text('Expense')),
                      ButtonSegment(
                          value: types.last, label: const Text('Income ')),
                    ],
                    selected: <String>{selectedType},
                    onSelectionChanged: (Set<String> newSelection) {
                      setState(() {
                        selectedType = newSelection.first;
                      });
                    },
                    showSelectedIcon: false,
                    style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity:
                            VisualDensity(horizontal: -3, vertical: 2.5)),
                  ),
                ),
                DropdownMenu<String>(
                  dropdownMenuEntries: categoryList()
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                  label: const Text(
                    "Category",
                    style: TextStyle(fontSize: 13.5),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  width: 140,
                  initialSelection: selectedCategory,
                  onSelected: (String? value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            // split buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Split',
                  style: defaultStyle,
                ),
                SizedBox(
                  height: 30,
                  width: 230,
                  child: SegmentedButton<SplitOptions>(
                    segments: <ButtonSegment<SplitOptions>>[
                      ButtonSegment<SplitOptions>(
                          value: SplitOptions.equal,
                          label: const Text('='),
                          enabled: isExpense()),
                      ButtonSegment<SplitOptions>(
                          value: SplitOptions.percent,
                          label: const Text('%'),
                          enabled: isExpense()),
                      ButtonSegment<SplitOptions>(
                          value: SplitOptions.exact,
                          label: const Text('\$'),
                          enabled: isExpense()),
                      const ButtonSegment<SplitOptions>(
                          value: SplitOptions.none,
                          label: Text(
                            'Joint',
                            style: TextStyle(fontSize: 13.5),
                          )),
                    ],
                    selected: <SplitOptions>{selectedSplit},
                    onSelectionChanged: (Set<SplitOptions> newSelection) {
                      setState(() {
                        selectedSplit = newSelection.first;
                      });
                    },
                    showSelectedIcon: false,
                    style: const ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                          VisualDensity(horizontal: -3, vertical: -3),
                    ),
                  ),
                ),
              ],
            ),
            // split prompt -> render if SplitOption.percent or SplitOption.exact
            // project/budget -> render if SplitOption.none
            _renderSplitPrompt(
              _splitPayWidget(),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 310,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 229, 219, 240),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      goalType(),
                      style: defaultStyle,
                    ),
                    DropdownMenu<String>(
                      label: Text(
                        goalType(),
                        style: defaultStyle,
                      ),
                      dropdownMenuEntries: goalList
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                      inputDecorationTheme: const InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      width: 140,
                      initialSelection: selectedGoal,
                      onSelected: (String? value) {
                        setState(() {
                          selectedGoal = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            // Temp pay option
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Temp. pay',
                  style: defaultStyle,
                ),
                Transform.scale(
                  scale: 0.9,
                  child: Switch.adaptive(
                    activeColor: Colors.purple[300],
                    value: isTempPay,
                    onChanged: (value) {
                      setState(
                        () {
                          isTempPay = value;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // Temp pay widget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tempPayWidget(isTempPay),
              ],
            ),
            // Save button
            // TODO: store result to splitPayment & tempPayment on save
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.purple,
                  onPressed: add,
                  height: 30,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
