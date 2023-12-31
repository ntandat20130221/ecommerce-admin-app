enum From { local, network }

class ImagePath {
  ImagePath({required this.path, required this.from});
  String path;
  From from;
}
