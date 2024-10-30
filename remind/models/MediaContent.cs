using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace remind.models
{
    public class MediaContent
    {
        [BsonId]
        public ObjectId Id { get; set; }
        
        [BsonRequired]
        public string? UserId { get; set; }  // Reference to the User
        
        public string? Text { get; set; }
        
        public string? ImageUrl { get; set; } // URL of the uploaded image
        
        public string? Link { get; set; } // Optional link
        
        public string? Category { get; set; }
         // Category for organization
        public string? RemindBy { get; set; }
        
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow; // Timestamp for creation
    }
}
