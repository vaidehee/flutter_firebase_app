//This is a data class containing user information
class UserData{
  String email;

  UserData( this.email);

  UserData.data(Map<String,dynamic> map){
    this.email=map['email'] ;
   }


}