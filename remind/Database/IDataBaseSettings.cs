namespace remind.database{
    public interface IDatabaseSetting{
        string ConnectionString { get; set; }
        string DatabaseName { get; set; }
        string CollectionName { get; set; }
    }
}
