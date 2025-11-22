using System.Globalization;
using Serilog;
using Serilog.Sinks.SystemConsole.Themes;

namespace ProjectName.Infrastructure;

public static class Logger
{
    public static void Initialize()
        => Log.Logger = new LoggerConfiguration()
            .WriteTo.Console(theme: AnsiConsoleTheme.Code, formatProvider: CultureInfo.InvariantCulture)
            .CreateLogger();
}
