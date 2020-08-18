enum UserType { company, jobSeeker
}
extension ParseToString on UserType{
  String toShortString(){
    return this.toString().split('.').last;
  }
}
