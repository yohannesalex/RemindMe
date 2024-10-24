namespace remind.database{
    public class DatabaseSettings : IDatabaseSetting{
        public required string ConnectionString { get; set; } 
        public required string DatabaseName { get; set; } 
        public required string CollectionName { get; set; } 
    }
}
