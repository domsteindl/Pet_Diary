enum PetType {
  cat("Katze", "lib/src/assets/illustrations/cat.svg"),
  dog("Hund", "lib/src/assets/illustrations/shiba.png");

  final String label;
  final String imagePath;
  const PetType(this.label, this.imagePath);
}