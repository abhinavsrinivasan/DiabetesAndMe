class UserModel {
  String? name;
  String? profilePicture;
  Map<String, String>? healthInformation; 
  List<String>? favoriteRecipes; 
  Map<String, String>? reminders; 


  UserModel({
    this.name,
    this.profilePicture,
    this.healthInformation,
    this.favoriteRecipes,
    this.reminders,
  });


  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePicture = json['profilePicture'];
    healthInformation = Map<String, String>.from(json['healthInformation'] ?? {});
    favoriteRecipes = List<String>.from(json['favoriteRecipes'] ?? []);
    reminders = Map<String, String>.from(json['reminders'] ?? {});
  } 
}
