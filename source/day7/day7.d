module source.day7;

import std.array;
import std.stdio;
import std.conv;
import std.algorithm;
import std.format;
import std.math;

int[] parse_input(string[] input)
{
    return input[0]
        .split(",")
        .map!(num => to!int(num, 10))
        .array();
}

int sumOfNumbers(int n, int a, int l)
{
    return n * (a + l) / 2;
}

int findFuelA(int target, int[] nums)
{
    auto answer = 0;
    foreach (num; nums)
    {
        auto distance = abs(num - target);
        answer += distance;
    }
    return answer;
}

int findFuelB(int target, int[] nums)
{
    auto answer = 0;
    foreach (num; nums)
    {
        auto distance = abs(num - target);
        answer += sumOfNumbers(distance, 1, distance);
    }
    return answer;
}

int a(int[] input)
{
    auto maxNum = input.maxElement;
    auto answer = int.max;
    for (int i = 0; i < maxNum; i++)
    {
        answer = min(answer, findFuelA(i, input));
    }
    return answer;
}

int b(int[] input)
{
    auto maxNum = input.maxElement;
    auto answer = int.max;
    for (int i = 0; i < maxNum; i++)
    {
        answer = min(answer, findFuelB(i, input));
    }
    return answer;
}
