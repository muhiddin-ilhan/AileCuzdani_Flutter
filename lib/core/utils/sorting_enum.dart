enum SortState {
  priceAsc("priceASC"),
  priceDesc("priceDESC"),
  dateAsc("dateASC"),
  dateDesc("dateDESC");

  final String value;
  const SortState(this.value);
}
