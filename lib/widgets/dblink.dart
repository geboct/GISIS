class DBLink {
  String showDBLink(String phpFileName) {
    return 'add server files path/$phpFileName.php';
  }
}

class ServerLink {
  String showDBLink() {
    return 'add server files path/';
  }
}

class GetImagesLink {
  String showDBLink({required String imagePath}) {
    return 'add server files path/${imagePath}';
  }
}
