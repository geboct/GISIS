class DBLink {
  String showDBLink(String phpFileName) {
    return 'https://jewelsparksolutions.com/gisis/$phpFileName.php';
  }
}

class ServerLink {
  String showDBLink() {
    return 'https://jewelsparksolutions.com/gisis/';
  }
}

class GetImagesLink {
  String showDBLink({required String imagePath}) {
    return 'https://jewelsparksolutions.com/gisis/${imagePath}';
  }
}
