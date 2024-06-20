import 'package:flutter/material.dart';
import 'package:todolist_application/constants/colors.dart';
import 'package:todolist_application/models/notebook.dart'; 
import 'notes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Notebook> notebooks = [];
  List<Notebook> filteredNotebooks = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredNotebooks = notebooks;
    searchController.addListener(_filterNotebooks);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterNotebooks);
    searchController.dispose();
    super.dispose();
  }

  void _addNotebook(String title) {
    setState(() {
      notebooks.add(Notebook(title: title));
      _filterNotebooks();  // Atualizar a lista filtrada
    });
  }

  void _filterNotebooks() {
    setState(() {
      filteredNotebooks = notebooks.where((notebook) {
        return notebook.title
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: platinum,
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25,
                  ),
                  border: InputBorder.none,
                  hintText: 'Procurar',
                  hintStyle: TextStyle(color: black),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotebooks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredNotebooks[index].title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotesScreen(notebook: filteredNotebooks[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await _showAddNotebookDialog(context);
          if (title != null && title.isNotEmpty) {
            _addNotebook(title);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<String?> _showAddNotebookDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nova Lista'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Nome da lista'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, _controller.text),
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: platinum,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/black.png'),
            ),
          ),
          Text(
            'NOTAS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          Icon(
            Icons.menu,
            color: black,
            size: 40,
          ),
        ],
      ),
    );
  }
}
