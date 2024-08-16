class DBLink {
  String showDBLink(String phpFileName) {
    return '$phpFileName.php';
  }
}

class ServerLink {
  String showDBLink() {
    return '';
  }
}

class GetImagesLink {
  String showDBLink({required String imagePath}) {
    return '${imagePath}';
  }
}
