var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello Docker, Terraform and Azure Cloud World, even http!");

app.Run();
