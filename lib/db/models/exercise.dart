class exercise{
  final String exerciseName;
  final String category;
  final String description;
  final String gifPath;

  const exercise({
    required this.exerciseName,
    required this.category,
    required this.description,
    required this.gifPath,
  });

  factory exercise.fromJson(dynamic json){
    return exercise(exerciseName: json['exerciseName'],
        category: json["category"],
        description: json["description"],
        gifPath: json["gif"]);
  }

}