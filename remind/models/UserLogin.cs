using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace remind.models
{
    public class UserLogin{
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public required string Id { get; set; } 

        [BsonElement("Email")]
        public required string Email { get; set; } 
        [BsonElement("Password")]
        public required string Password { get; set; }
        


    }
}
