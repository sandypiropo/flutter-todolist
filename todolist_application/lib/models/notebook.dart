class Notebook {
  final String title;
  List<String> notes;

Notebook({required this.title, List<String>? notes}) : notes = notes ?? [];
}