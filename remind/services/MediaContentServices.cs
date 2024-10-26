using Microsoft.AspNetCore.Http; // Required for IFormFile
using Microsoft.Extensions.Configuration;
using MongoDB.Driver;
using remind.models;
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
        public List<MediaContent> GetUserMediaContentsByCategory(string userId, string catagory) =>
            mediaContents.Find(content => content.Category == catagory && content.UserId == userId).ToList();
        public List<MediaContent> GetUserMediaContentByRemind(string userId, string remindby) =>
            mediaContents.Find(content => content.RemindBy == remindby && content.UserId == userId).ToList();
        public MediaContent CreateMediaContent(MediaContent mediaContent)
        {
            mediaContents.InsertOne(mediaContent);
            return mediaContent;
        }

        public async Task<string> UploadImageAsync(IFormFile file)
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
    }
}
