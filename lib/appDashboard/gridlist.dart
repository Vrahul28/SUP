//  Dashboard 1

class Items {
  String title;
  String img;
  Items({required this.title, required this.img});
}

List<Items> admin = [item1, item2, item3];

List<Items> staff = [item2];

List<Items> visitor = [item2];

Items item1 = Items(
    title: "Company",
    img: "assets/images/company.png"
);

Items item2 = Items(
  title: "Staff",
  img: "assets/images/staff.png",
);

Items item3 = Items(
  title: "Blacklist",
  img: "assets/images/blacklist.png",
);

//  Dashboard 2

class Items2 {
  String title;
  String img;
  Items2({required this.title, required this.img});
}

List<Items2> admin_1= [it1, it2,it3,it5];
List<Items2> staff_1= [it2];
List<Items2> vistors_1= [it2];

Items2  it1 =  Items2(
    title: "Setup and Configure",
    img: "assets/images/settings.png"
);

Items2  it2 =  Items2(
    title: "Visitor Acess Management Service",
    img: "assets/images/id-card.png"
);

Items2  it3 = Items2(
    title: "Facility Booking",
    img: "assets/images/booking.png"
);

Items2  it4 = Items2(
    title: "Permit To Work",
    img: "assets/images/booking.png"
);

Items2  it5 = Items2(
    title: "Visitor Details Report",
    img: "assets/images/booking.png"
);

//  Vistor Acess

class Vistor {
  String title;
  String img;
  Vistor({required this.title, required this.img});
}

List<Vistor> adminVistor= [v1, v2, v3];
List<Vistor> onlyinvite= [v3];

Vistor  v1 = Vistor(
    title: "Email Template",
    img: "assets/images/home.png"
);

Vistor  v2 = Vistor(
    title: "Report",
    img: "assets/images/home.png"
);

Vistor  v3 = Vistor(
    title: "Invitation",
    img: "assets/images/home.png"
);