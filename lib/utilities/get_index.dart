int getIndex(
    {required int index, required bool isDescending, required int length}) {
  if (isDescending) {
    return length - index - 1;
  }
  return index;
}
