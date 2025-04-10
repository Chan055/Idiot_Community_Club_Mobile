class User {
  static int myCount = 0;
  static List<Member> reqMembers = [
    Member(
      name: "Alex",
      email: "kit.kat@gmail.com",
      image: "assets/images/RedPanda.jpeg",
    ),
    Member(
      name: "Jordan",
      email: "kit.kat@gmail.com",
      image: "assets/images/RedPanda.jpeg",
    ),
    Member(
      name: "Taylor",
      email: "kit.kat@gmail.com",
      image: "assets/images/RedPanda.jpeg",
    ),
    Member(
      name: "Morgan",
      email: "kit.kat@gmail.com",
      image: "assets/images/RedPanda.jpeg",
    ),
    Member(
      name: "Casey",
      email: "kit.kat@gmail.com",
      image: "assets/images/RedPanda.jpeg",
    ),
    Member(
      name: "Jamie",
      email: "kit.kat@gmail.com",
      image: "assets/images/RedPanda.jpeg",
    ),
    Member(
      name: "Riley",
      email: "kit.kat@gmail.com",
      image: "assets/images/RedPanda.jpeg",
    ),
  ];

  static List<Message> myMessages = [
    Message(
      message:
          "Hey everyone! Our chess club is hosting a tournament this Saturday. Get ready!Hey everyone! Our chess club is !Hey everyone! Our chess club is hosting a tournament this Saturday. Get !Hey everyone! Our chess club is hosting a tournament this Saturday. Get ready!",
      time: "09:00",
    ),
    Message(
      message:
          "Reminder: The registration for the upcoming chess event closes tomorrow. Don’t miss out!We are introducing a weekly chess puzzle challenge! Solve it and win prizes!",
      time: "09:15",
    ),
    Message(
      message:
          "We are introducing a weekly chess puzzle challenge! Solve it and win prizes!",
      time: "09:30",
    ),
    Message(
      message:
          "Our club meeting is scheduled for Friday at 5 PM. See you all there!",
      time: "10:00",
    ),
    Message(
      message:
          "Big news! We’re collaborating with another university for an inter-club chess match!",
      time: "10:30",
    ),
    Message(
      message:
          "Chess beginners are welcome! We have a special training session next week. Join us!",
      time: "11:00",
    ),
    Message(
      message:
          "Friendly reminder: The rapid chess tournament starts at 3 PM today. Be on time!",
      time: "11:30",
    ),
    Message(
      message: "Anyone up for a casual blitz match before the meeting?",
      time: "12:00",
    ),
    Message(
      message:
          "Congrats to our tournament winner! Amazing games, well played everyone!",
      time: "12:45",
    ),
    Message(
      message:
          "A new chess book recommendation list is out! Check our website for details.",
      time: "13:15",
    ),
    Message(
      message: "We’re planning a fun chess night next weekend. Who’s in?",
      time: "14:00",
    ),
    Message(
      message:
          "Our coach will be giving a strategy session on endgames this Thursday. Don’t miss it!",
      time: "15:00",
    ),
    Message(
      message: "Thanks for another great meeting today! See you all next week.",
      time: "16:30",
    ),
  ];
}

class Member {
  String name, email, image;
  Member({required this.name, required this.email, required this.image});
}

class Message {
  String message, time;
  Message({required this.message, required this.time});
}
