class Mode {
  var selectionMode = false;

  bool get getMode {
    return selectionMode;
  }

  updateMode(bool mode){
    selectionMode = mode;
  }
}