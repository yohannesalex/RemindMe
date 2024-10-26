using Microsoft.AspNetCore.Http; // Make sure this is included
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using remind.models;
using remind.services;
using System.Security.Claims;

namespace remind.controllers
{
    [Route("api/media")]
    [ApiController]
    [Authorize] // Ensures that only authenticated users can access these endpoints
    public class MediaContentController : ControllerBase
    {
        private readonly MediaContentService mediaContentService;

        public MediaContentController(MediaContentService mediaContentService)
        {
            this.mediaContentService = mediaContentService;
        }

        [HttpGet("GetContents")]
        public ActionResult<List<MediaContent>> GetUserMediaContents()
        {  
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return Unauthorized();
            }
            var contents = mediaContentService.GetUserMediaContents(userId);
            return Ok(contents);
        }
        [HttpGet("GetContentByCategory")]
        public ActionResult<List<MediaContent>> GetUserMediaContentsBycatagory(string catagory)
        {   Console.WriteLine(catagory);
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return Unauthorized();
            }
            var contents = mediaContentService.GetUserMediaContentsByCategory(userId, catagory);
            return Ok(contents);
        }
        [HttpGet("GetContentByRemind")]
        public ActionResult<List<MediaContent>> GetUserMediaContentsByremind(string remindBy)
        {   
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return Unauthorized();
            }
            var contents = mediaContentService.GetUserMediaContentByRemind(userId, remindBy);
            return Ok(contents);
        }

        [HttpPost("addContents")]
        public async Task<ActionResult<MediaContent>> CreateMediaContent([FromForm] MediaContent mediaContent, IFormFile file)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value; // Get the user's ID from the JWT token

            if (userId == null)
            {
                return Unauthorized();
            }

            mediaContent.UserId = userId; // Assign the user ID to the media content

            // Handle file upload
            if (file != null && file.Length > 0)
            {
                var imageUrl = await mediaContentService.UploadImageAsync(file);
                Console.WriteLine(imageUrl);
                mediaContent.ImageUrl = imageUrl; // Set the image URL in the media content
            }

            var createdContent = mediaContentService.CreateMediaContent(mediaContent);
            return CreatedAtAction(nameof(GetUserMediaContents), new { userId = userId }, createdContent);
        }
    }
}
