module source.day2;

import std.conv;
import std.algorithm;
import std.array;
import std.stdio;

string[][] parse_input(string[] lines)
{
    return lines
        .map!(line => line.split(" "))
        .array();
}

int a(string[][] instructions)
{
    auto horiz = 0;
    auto depth = 0;
    foreach (string[] instruction; instructions)
    {
        auto direction = instruction[0];
        auto magnitude = to!int(instruction[1], 10);

        if (direction == "forward")
        {
            horiz += magnitude;
        }
        else if (direction == "down")
        {
            depth += magnitude;
        }
        else if (direction == "up")
        {
            depth -= magnitude;
        }
    }

    return horiz * depth;
}

int b(string[][] instructions)
{
    auto horiz = 0;
    auto depth = 0;
    auto aim = 0;
    foreach (string[] instruction; instructions)
    {
        auto direction = instruction[0];
        auto magnitude = to!int(instruction[1], 10);

        if (direction == "forward")
        {
            horiz += magnitude;
            depth += (aim * magnitude);
        }
        else if (direction == "down")
        {
            aim += magnitude;
        }
        else if (direction == "up")
        {
            aim -= magnitude;
        }
    }

    return horiz * depth;
}
