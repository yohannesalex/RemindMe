using Microsoft.AspNetCore.Http; // Make sure this is included
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using remind.models;
using remind.services;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc.ActionConstraints;
using System.ComponentModel.DataAnnotations;

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
        [HttpGet("GetContentById")]
        public ActionResult<MediaContent> GetMediaContentById(string id)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (userId == null)
            {
                return Unauthorized();
            }

            var mediaContent = mediaContentService.GetUserMediaContent(id);

            if (mediaContent == null)
            {
                return NotFound();
            }

            // Check if the media content belongs to the requesting user
            if (mediaContent.UserId != userId)
            {
                return Forbid();
            }

            return Ok(mediaContent);
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
        [HttpGet("GetContentByCategory/{catagory}")]
        public ActionResult<List<MediaContent>> GetUserMediaContentsBycatagory(string catagory)
        {
            Console.WriteLine(catagory);
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (userId == null)
            {
                return Unauthorized();
            }
            var contents = mediaContentService.GetUserMediaContentsByCategory(userId, catagory);
            return Ok(contents);
        }
        [HttpGet("GetContentByRemind/{remindBy}")]
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
        public async Task<ActionResult<MediaContent>> CreateMediaContent([FromForm] MediaContent mediaContent, IFormFile? file)
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
                mediaContent.ImageUrl = imageUrl; 
            }

            var createdContent = mediaContentService.CreateMediaContent(mediaContent);
            return CreatedAtAction(nameof(GetUserMediaContents), new { userId = userId }, createdContent);
        }
        [HttpPut("updateContent/{id}")]
        public async Task<ActionResult<MediaContent>> UpdateContent([FromForm] MediaContent mediaContent, IFormFile? file, string id)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value; // Get the user's ID from the JWT token

            if (userId == null)
            {
                return Unauthorized();
            }
            var orginal = mediaContentService.GetUserMediaContent(id);
            if (orginal == null)
            {
                return NotFound();
            }
            mediaContent.Id = id;
            mediaContent.CreatedAt = orginal.CreatedAt;




            mediaContent.UserId = userId;

            // Handle file upload
            if (file != null && file.Length > 0)
            {
                var imageUrl = await mediaContentService.UploadImageAsync(file);
                Console.WriteLine(imageUrl);
                mediaContent.ImageUrl = imageUrl; // Set the image URL in the media content
            }

            mediaContentService.UpdateMediaContent(mediaContent, id);
            return CreatedAtAction(nameof(GetMediaContentById), new { id = id }, mediaContent);
        }

        [HttpDelete("deleteContent")]
        public async Task<IActionResult> DeleteMediaContent(DeleteRequest request)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value; // Get the user's ID from the JWT token

            if (userId == null)
            {
                
                return Unauthorized();
            }

            var deleted = await mediaContentService.DeleteMediaContentAsync(request.Id, userId);
            if (deleted)
            {
                return NoContent(); // Return 204 No Content if deletion is successful
            }

            return NotFound(); // Return 404 if content with specified ID was not found
        }




    }

}
