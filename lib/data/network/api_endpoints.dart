class ApiEndpoints {
  static const baseUrl = 'https://dummyjson.com';
  static const loginEndPoint = "$baseUrl/auth/login";
  static const registerEndPoint = "$baseUrl/api/register";

  static var moviesToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYjE4ZjIwMjZmMTNmZjZiYzQ0NDZlZTllZDZiMDg5MyIsIm5iZiI6MTcyMjY4MDQxNi4yMDY1NzQsInN1YiI6IjViZDVkMzE1YzNhMzY4MjEwMDAzNDdmZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jBIAaBbHgWyph4gR790FBW-55QqMLy9kjM_i8gCVCx0';
  static var moviesListEndPoint = 'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1';
}
