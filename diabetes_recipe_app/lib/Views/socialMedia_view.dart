import 'package:flutter/material.dart';

class SocialMediaView extends StatefulWidget {
  final List<Map<String, dynamic>> recipes; // A list of recipes with image, title, likes, and comments

  SocialMediaView({required this.recipes});

  @override
  _SocialMediaViewState createState() => _SocialMediaViewState();
}

class _SocialMediaViewState extends State<SocialMediaView> {
  late List<Map<String, dynamic>> recipeCards;

  @override
  void initState() {
    super.initState();
    // Initialize recipe cards from the passed recipes
    recipeCards = widget.recipes;
  }

  void _toggleLike(int index) {
    setState(() {
      recipeCards[index]['liked'] = !(recipeCards[index]['liked'] ?? false);
      recipeCards[index]['likes'] += recipeCards[index]['liked'] ? 1 : -1;
    });
  }

  void _viewRecipeImageWithComments(BuildContext context, int index) {
    final recipe = recipeCards[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullRecipeView(
          recipe: recipe,
          onCommentAdded: () {
            setState(() {
              // Update the UI to reflect the increased comment count
              recipe['comments'] = recipe['comments'];
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: recipeCards.length,
        itemBuilder: (context, index) {
          final recipe = recipeCards[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Clickable Recipe Image
                GestureDetector(
                  onTap: () => _viewRecipeImageWithComments(context, index),
                  child: Image.asset(
                    recipe['imagePath'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe Title
                      Text(
                        recipe['title'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      // Like & Comment Counts
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  recipe['liked'] ?? false
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_alt_outlined,
                                  color: recipe['liked'] ?? false
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () => _toggleLike(index),
                              ),
                              Text("${recipe['likes']} likes"),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => _viewRecipeImageWithComments(context, index),
                            child: Row(
                              children: [
                                Icon(Icons.comment_outlined),
                                SizedBox(width: 4),
                                Text("${recipe['comments'].length} comments"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Full Recipe View with Comments
class FullRecipeView extends StatefulWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onCommentAdded;

  FullRecipeView({required this.recipe, required this.onCommentAdded});

  @override
  _FullRecipeViewState createState() => _FullRecipeViewState();
}

class _FullRecipeViewState extends State<FullRecipeView> {
  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    final newComment = _commentController.text.trim();
    if (newComment.isNotEmpty) {
      setState(() {
        widget.recipe['comments'].add(newComment);
      });
      _commentController.clear();
      widget.onCommentAdded(); // Notify the parent view to update
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
          // Full Recipe Image
          Image.asset(
            recipe['imagePath'],
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          // Comments Section
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
          // Add Comment Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
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
