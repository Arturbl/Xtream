

class ChatUtils {

  static List<dynamic> sortMessagesByDate(List<dynamic> messages) {
    int lengthOfArray = messages.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      print(messages[i]['date'].toDate().compareTo(messages[i + 1]['date'].toDate()));
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        // if (messages[j]['date'].toDate() > messages[j + 1]['date'].toDate()) {
        //   int temp = messages[j];
        //   messages[j] = messages[j + 1];
        //   messages[j + 1] = temp;
        // }
      }
    }
    return messages;
  }

}