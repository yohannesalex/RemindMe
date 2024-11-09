using Microsoft.AspNetCore.Http; // Required for IFormFile
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MongoDB.Bson;
using MongoDB.Driver;
using remind.models;
using System.ComponentModel;
using System.IO;

namespace remind.services
{
    public class MediaContentService
    {
        private readonly IMongoCollection<MediaContent> mediaContents;

        public MediaContentService(IConfiguration configuration)
        {
            var client = new MongoClient(configuration.GetConnectionString("HyphenDb"));
            var database = client.GetDatabase("HyphenDb");
            mediaContents = database.GetCollection<MediaContent>("MediaContents");
        }

        public List<MediaContent> GetUserMediaContents(string userId) =>
            mediaContents.Find(content => content.UserId == userId).ToList();
        public MediaContent GetUserMediaContent(string id) =>
            mediaContents.Find(content => content.Id == id).FirstOrDefault();
        public List<MediaContent> GetUserMediaContentsByCategory(string userId, string catagory) {
            if (catagory == "All"){
                return mediaContents.Find(content => content.UserId == userId).ToList();
            }else{
            return mediaContents.Find(content => content.Category == catagory && content.UserId == userId).ToList();}}
        public List<MediaContent> GetUserMediaContentByRemind(string userId, string remindby) =>
            mediaContents.Find(content => content.RemindBy == remindby && content.UserId == userId).ToList();
        public MediaContent CreateMediaContent(MediaContent mediaContent)
        {
            if (string.IsNullOrEmpty(mediaContent.Id))
            {
                mediaContent.Id = ObjectId.GenerateNewId().ToString();  // Generate new unique ID as a string
            }

            mediaContents.InsertOne(mediaContent);
            return mediaContent;
        }

        public void UpdateMediaContent(MediaContent mediaContent, string id) =>
            mediaContents.ReplaceOne(content => content.Id == id, mediaContent);
        public async Task<bool> DeleteMediaContentAsync(string id, string userId)
        {
            var filter = Builders<MediaContent>.Filter.Eq(m => m.Id, id) &
                         Builders<MediaContent>.Filter.Eq(m => m.UserId, userId);
            var result = await mediaContents.DeleteOneAsync(filter);
            return result.DeletedCount > 0;
        }
        public async Task<string?> UploadImageAsync(IFormFile file)
        {
            if (file == null || file.Length == 0)
                return null;

            var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
            var filePath = Path.Combine("wwwroot/images", fileName); // Store in wwwroot/images

            // Create the directory if it doesn't exist
            if (!Directory.Exists(Path.Combine("wwwroot/images")))
            {
                Directory.CreateDirectory(Path.Combine("wwwroot/images"));
            }

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            // Return the URL of the saved image
            return $"/images/{fileName}";
        }
        public bool DeleteImage(string imageUrl)
{
    // Construct the full path of the image in the wwwroot folder
    var filePath = Path.Combine("wwwroot", imageUrl.TrimStart('/'));

    if (File.Exists(filePath))
    {
        File.Delete(filePath);
        return true; // Indicate that the file was successfully deleted
    }
    
    return false; // Indicate that the file was not found
}

    }
}
