enum ContentPosition {
  Center,
  Top,
  Bottom,
}

extension ContentPositionParseToString on ContentPosition {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
