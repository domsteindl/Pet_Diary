enum PetType {
  cat('Katze', "lib/src/assets/illustrations/cat.svg"),
  dog('Hunde', "lib/src/assets/illustrations/shiba.png"),
  bird('Vogel', '');

  final String label;
  final String imagePath;
  const PetType(this.label, this.imagePath);
}
