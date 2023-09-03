class TextInputModel {
  final String inputValue;
  final bool displayError;
  final bool isValid;

  const TextInputModel({
    this.inputValue = '',
    this.displayError = false,
    this.isValid = false,
  });
}
