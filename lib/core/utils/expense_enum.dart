enum ExpenseState {
  expense(1, "Harcama"),
  income(-1, "Gelir");

  final int value;
  final String title;
  const ExpenseState(this.value, this.title);
}
