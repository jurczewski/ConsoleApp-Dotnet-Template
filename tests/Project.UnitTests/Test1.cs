﻿using FluentAssertions;
using Xunit;

namespace Project.UnitTests;

public sealed class Test1
{
    [Fact]
    public void SimpleTest() => true.Should().BeTrue();
}
