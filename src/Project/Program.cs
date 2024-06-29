using System.Reflection;
using Project.Infrastructure;
using Figgle;
using Microsoft.Extensions.Configuration;

namespace Project;

internal abstract class Program
{
    private static IConfigurationRoot? Configuration { get; set; }

    private static void Main(string[] args)
    {
        DisplayBanner();
        Logger.Initialize();
        BuildConfiguration();

        var settings = GetSettings();
    }

    private static void BuildConfiguration() =>
        Configuration = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddJsonFile("appsettings.development.json", optional: true, reloadOnChange: true)
            .Build();

    private static Settings GetSettings() =>
        Configuration!.GetSection(nameof(Settings)).Get<Settings>() ?? new Settings();

    private static void DisplayBanner()
    {
        var name = Assembly.GetCallingAssembly().GetName().Name;
        Console.WriteLine(FiggleFonts.Doom.Render(name!));
    }
}
