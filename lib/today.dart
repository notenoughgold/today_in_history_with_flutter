class Today {
  String date;
  String url;
  Data data;

  Today({this.date, this.url, this.data});

  Today.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    url = json['url'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['url'] = this.url;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Events> events;
  List<Births> births;
  List<Deaths> deaths;

  Data({this.events, this.births, this.deaths});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Events'] != null) {
      events = new List<Events>();
      json['Events'].forEach((v) {
        events.add(new Events.fromJson(v));
      });
    }
    if (json['Births'] != null) {
      births = new List<Births>();
      json['Births'].forEach((v) {
        births.add(new Births.fromJson(v));
      });
    }
    if (json['Deaths'] != null) {
      deaths = new List<Deaths>();
      json['Deaths'].forEach((v) {
        deaths.add(new Deaths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['Events'] = this.events.map((v) => v.toJson()).toList();
    }
    if (this.births != null) {
      data['Births'] = this.births.map((v) => v.toJson()).toList();
    }
    if (this.deaths != null) {
      data['Deaths'] = this.deaths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String year;
  String text;
  String html;
  List<Links> links;

  Events({this.year, this.text, this.html, this.links});

  Events.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    text = json['text'];
    html = json['html'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['text'] = this.text;
    data['html'] = this.html;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String title;
  String link;

  Links({this.title, this.link});

  Links.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    return data;
  }
}

class Births {
  String year;
  String text;
  String html;
  List<Links> links;

  Births({this.year, this.text, this.html, this.links});

  Births.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    text = json['text'];
    html = json['html'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['text'] = this.text;
    data['html'] = this.html;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deaths {
  String year;
  String text;
  String html;
  List<Links> links;

  Deaths({this.year, this.text, this.html, this.links});

  Deaths.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    text = json['text'];
    html = json['html'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['text'] = this.text;
    data['html'] = this.html;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
