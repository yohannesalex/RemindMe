namespace remind.models
{
   public class UserInfoModel
{
    public required string UserId { get; set; } 
    public string? Text { get; set; }
    public IFormFile? Image { get; set; } 
    public string? ImageUrl { get; set; } 
    public string? Link { get; set; } 
    public required string Category { get; set; }
}

}