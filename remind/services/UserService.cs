using MongoDB.Driver;
using remind.models;

namespace remind.services
{
    public class UserService{
        private readonly IMongoCollection<User> users;
        public UserService(IConfiguration configuration){
            var client  = new MongoClient(configuration.GetConnectionString("HyphenDb"));
            var database = client.GetDatabase("HyphenDb");
            users = database.GetCollection<User>("Users");
        }
    public List<User> GetUsers() => users.Find(user => true).ToList();
    public User CreateUser(User user){
        var checker = users.Find(s => s.Email == user.Email).FirstOrDefault();
        
        if (checker != null){
            throw new Exception("User already exists"); 
        }else{
         users.InsertOne(user);
         return user;}
     }
    

    }
}

