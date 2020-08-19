enum UserType { company, jobSeeker }

enum UserGender { male, female }

extension ParseToString on UserType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
