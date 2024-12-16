import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/social/socialMedia_viewmodel.dart';

class SocialMediaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SocialMediaViewModel>(context);

    

    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media"),
      ),
      body: ListView.builder(
        itemCount: viewModel.recipeCards.length,
        itemBuilder: (context, index) {
          final recipe = viewModel.recipeCards[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => viewModel.commentRecipes(context, index),
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
                      Text(
                        recipe['title'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  recipe['liked']
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_alt_outlined,
                                ),
                                onPressed: () => viewModel.toggleLike(index),
                              ),
                              Text("${recipe['likes']}"),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => viewModel.commentRecipes(context, index),
                            child: Text("${recipe['comments'].length} comments"),
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
