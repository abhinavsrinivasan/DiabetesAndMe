import 'package:flutter/material.dart';

class SocialMediaViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _recipes;

  SocialMediaViewModel({required List<Map<String, dynamic>> recipes})
      : _recipes = List.from(recipes);

  List<Map<String, dynamic>> get recipeCards => _recipes;

  void toggleLike(int index) {
    final recipe = _recipes[index];
    if (recipe['liked']) {
      recipe['liked'] = false;
      recipe['likes'] -= 1;
    } else {
      recipe['liked'] = true;
      recipe['likes'] += 1;
    }
    notifyListeners();
  }

  void commentRecipes(BuildContext context, int index) {
    final recipe = _recipes[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullRecipeView(
          recipe: recipe,
          onCommentAdded: () {
            notifyListeners();
          },
        ),
      ),
    );
  }
}

class FullRecipeView extends StatefulWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onCommentAdded;

  FullRecipeView({required this.recipe, required this.onCommentAdded});

  @override
  _FullRecipeViewState createState() => _FullRecipeViewState();
}

class _FullRecipeViewState extends State<FullRecipeView> {
  final TextEditingController _controller = TextEditingController();

  void _addComment() {
    final newComment = _controller.text.trim();
    if (newComment.isNotEmpty) {
      setState(() {
        widget.recipe['comments'].add(newComment);
      });
      _controller.clear();
      widget.onCommentAdded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
      ),
      body: Column(
        children: [
          Image.asset(
            recipe['imagePath'],
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: recipe['comments'].length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(recipe['comments'][index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
