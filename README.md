# 📝 ConsoleApp-Dotnet-Template

[![Build and test [CI]](https://github.com/jurczewski/DotnetEmptyTemplate/actions/workflows/build.yaml/badge.svg)](https://github.com/jurczewski/DotnetEmptyTemplate/actions/workflows/build.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Linkedin](https://img.shields.io/badge/Linkedin-0882bd?logo=linkedin)](https://www.linkedin.com/in/jurczewski/)

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/jurczewski)

Production-ready .NET 10 console app starter - skip the boilerplate, start with a solid foundation.

## 🔧 How to setup?

1. Create a new repository using this template
2. Replace `ProjectName` with your project name
    - On Windows run [rename-all.ps1](./rename-all.ps1) - renames everything in one shot

## ⚗️ Features

- **Serilog** - structured console logging with ANSI color theme, ready to go
- **Figgle** - ASCII banner on startup (Doom font)
- **appsettings.json** - typed `Settings` class bound via `IOptions` pattern
- **CI** - GitHub Actions & Azure Pipelines, daily NuGet vulnerability scan, Dependabot
- **xUnit v3 + AwesomeAssertions + AutoFixture + Moq** - full test stack wired up
- **Central Package Management** - all NuGet versions in `Directory.Packages.props`
