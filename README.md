# 📝 ConsoleApp-Dotnet-Template

[![Build and test [CI]](https://github.com/jurczewski/DotnetEmptyTemplate/actions/workflows/build.yaml/badge.svg)](https://github.com/jurczewski/DotnetEmptyTemplate/actions/workflows/build.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Linkedin](https://img.shields.io/badge/Linkedin-0882bd?logo=linkedin)](https://www.linkedin.com/in/jurczewski/)

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/jurczewski)

Production-ready .NET 10 console app starter - skip the boilerplate, start with a solid foundation.

## 🔧 How to setup?

1. Create a new repository using this template
2. Replace `ProjectName` with your project name - renames everything in one shot
    - On Windows run [rename-all.ps1](./scripts/rename-all.ps1)
    - On Linux/macOS run [rename-all.sh](./scripts/rename-all.sh)

## ⚗️ Features

- **Serilog** - structured console logging with ANSI color theme, ready to go
- **Figgle** - ASCII banner on startup (Doom font)
- **appsettings.json** - typed `Settings` class bound via `IOptions` pattern
- **CI** - GitHub Actions & Azure Pipelines, daily NuGet vulnerability scan, Dependabot
- **xUnit v3 + AwesomeAssertions + AutoFixture + Moq** - full test stack wired up
- **Central Package Management** - all NuGet versions in `Directory.Packages.props`

## 🗂️ Structure

```bash
├── src/ProjectName/
│   ├── Infrastructure/
│   │   ├── Logger.cs          # Serilog setup
│   │   └── Settings.cs        # typed config class
│   ├── appsettings.json
│   └── Program.cs
├── tests/ProjectName.UnitTests/
│   └── Test1.cs
├── .github/workflows/         # GitHub Actions
│   ├── build.yaml
│   └── nuget-vulnerability-scan.yml
├── .azuredevops/              # Azure DevOps Pipelines
│   ├── azure-pipelines.yml
│   ├── nuget-vulnerability-scan.yml
│   └── renovate.yml
├── scripts/
│   ├── rename-all.ps1         # Windows rename helper
│   └── rename-all.sh          # Linux/macOS rename helper
└── Directory.Packages.props   # central NuGet versions
```
