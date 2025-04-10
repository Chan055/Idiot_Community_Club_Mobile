class RandomUser {
  String? gender, email, phone, cell, nat;
  Name? name;
  Location? location;
  Login? login;
  Dob? dob;
  Registered? registered;
  Id? id;
  Picture? picture;

  RandomUser(
      {this.gender,
        this.email,
        this.phone,
        this.cell,
        this.nat,
        this.name,
        this.location,
        this.login,
        this.dob,
        this.registered,
        this.id,
        this.picture});

  factory RandomUser.from(dynamic data) {
    return RandomUser(
      gender: data["gender"],
      email: data["email"],
      phone: data["phone"],
      cell: data["cell"],
      nat: data["nat"],
      name: data["name"] != null ? Name.from(data["name"]) : null,
      location: data["location"] != null ? Location.from(data["location"]) : null,
      login: data["login"] != null ? Login.from(data["login"]) : null,
      dob: data["dob"] != null ? Dob.from(data["dob"]) : null,
      registered: data["registered"] != null ? Registered.from(data["registered"]) : null,
      id: data["id"] != null ? Id.from(data["id"]) : null,
      picture: data["picture"] != null ? Picture.from(data["picture"]) : null,
    );
  }
}

class Name {
  String? title, first, last;

  Name({this.title, this.first, this.last});

  factory Name.from(dynamic data) {
    return Name(
      title: data["title"] ?? "Unknown",
      first: data["first"] ?? "Unknown",
      last: data["last"] ?? "Unknown",
    );
  }
}

class Location {
  Street? street;
  String? city, state, country, postcode;
  Coordinates? coordinates;
  Timezone? timezone;

  Location(
      {this.street,
        this.city,
        this.state,
        this.country,
        this.postcode,
        this.coordinates,
        this.timezone});

  factory Location.from(dynamic data) {
    return Location(
      street: data["street"] != null ? Street.from(data["street"]) : null,
      city: data["city"] ?? "Unknown",
      state: data["state"] ?? "Unknown",
      country: data["country"] ?? "Unknown",
      postcode: data["postcode"]?.toString(),
      coordinates: data["coordinates"] != null
          ? Coordinates.from(data["coordinates"])
          : null,
      timezone: data["timezone"] != null ? Timezone.from(data["timezone"]) : null,
    );
  }
}

class Street {
  int? number;
  String? name;

  Street({this.name, this.number});

  factory Street.from(dynamic data) {
    return Street(
      name: data["name"] ?? "Unknown",
      number: data["number"] ?? 0,
    );
  }
}

class Coordinates {
  String? latitude, longitude;

  Coordinates({this.latitude, this.longitude});

  factory Coordinates.from(dynamic data) {
    return Coordinates(
      latitude: data["latitude"] ?? "0.0",
      longitude: data["longitude"] ?? "0.0",
    );
  }
}

class Timezone {
  String? offset, description;

  Timezone({this.offset, this.description});

  factory Timezone.from(dynamic data) {
    return Timezone(
      offset: data["offset"] ?? "0:00",
      description: data["description"] ?? "Unknown",
    );
  }
}

class Login {
  String? uuid, username, password, salt, md5, sha1, sha256;

  Login(
      {this.uuid,
        this.username,
        this.password,
        this.salt,
        this.md5,
        this.sha1,
        this.sha256});

  factory Login.from(dynamic data) {
    return Login(
      uuid: data["uuid"] ?? "Unknown",
      username: data["username"] ?? "Unknown",
      password: data["password"] ?? "Unknown",
      salt: data["salt"] ?? "Unknown",
      md5: data["md5"] ?? "Unknown",
      sha1: data["sha1"] ?? "Unknown",
      sha256: data["sha256"] ?? "Unknown",
    );
  }
}

class Dob {
  String? date;
  int? age;

  Dob({this.age, this.date});

  factory Dob.from(dynamic data) {
    return Dob(
      age: data["age"] ?? 0,
      date: data["date"] ?? "Unknown",
    );
  }
}

class Registered {
  String? date;
  int? age;

  Registered({this.age, this.date});

  factory Registered.from(dynamic data) {
    return Registered(
      age: data["age"] ?? 0,
      date: data["date"] ?? "Unknown",
    );
  }
}

class Id {
  String? name, value;

  Id({this.name, this.value});

  factory Id.from(dynamic data) {
    return Id(
      name: data["name"] ?? "Unknown",
      value: data["value"] ?? "Unknown",
    );
  }
}

class Picture {
  String? large, medium, thumbnail;

  Picture({this.large, this.medium, this.thumbnail});

  factory Picture.from(dynamic data) {
    return Picture(
      large: data["large"] ?? "",
      medium: data["medium"] ?? "",
      thumbnail: data["thumbnail"] ?? "",
    );
  }
}