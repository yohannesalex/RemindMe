using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using remind.models;
using remind.services;

namespace remind.controllers
{
    [Route("api/auth")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserService service;

        private readonly IConfiguration config;

        public UserController(UserService service, IConfiguration config)
        {
            this.service = service;
            this.config = config;
        }

        [HttpPost("signup")]
        public ActionResult<User> CreateUser(User user)
        {
            try{service.CreateUser(user);
            var authService = new AuthService(config);
            var token = authService.GenerateToken(user);
            return Ok(new { Token = token });}
            catch (Exception e){
                Console.WriteLine(e.Message);
                if (e.Message == "User already exists"){
                    return Conflict(new {message = "User already exists"});
                }
                return StatusCode(500,"Error occureed while creating the user");
            }
        }
        [HttpPost("login")]
        public ActionResult<string> Login([FromBody] UserLogin user)
        {
            var existingUser = service.GetUsers().FirstOrDefault(u => u.Email == user.Email && u.Password == user.Password);
            if (existingUser == null)
            {
                return NotFound();
            }

            var authService = new AuthService(config);
            var token = authService.GenerateToken(existingUser);
            return Ok(new { Token = token });
        }

    }
}