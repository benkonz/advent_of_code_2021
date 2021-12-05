module source.day5;

import std.array;
import std.stdio;
import std.conv;
import std.algorithm;
import std.format;

struct Point
{
    int x;
    int y;
}

string point_to_string(Point p)
{
    return format("x: %d, y: %d", p.x, p.y);
}

struct Line
{
    Point a;
    Point b;
}

string line_to_string(Line l)
{
    return format("a => %s, b => %s", point_to_string(l.a), point_to_string(l.b));
}

Line parse_line(string line_str)
{
    auto points = line_str
        .split(" -> ")
        .map!(point_str => point_str.split(",")
                .map!(n => to!int(n, 10))
                .array()
        )
        .array();

    Point point_a = {x: points[0][0],
    y: points[0][1]};

    Point point_b = {x: points[1][0],
    y: points[1][1]};

    Line l = {a: point_a, b: point_b};
    return l;
}

Line[] parse_input(string[] lines)
{
    return lines
        .map!(line => parse_line(line))
        .array();
}

bool is_vertical(Line line)
{
    return line.a.x == line.b.x;
}

bool is_horizontal(Line line)
{
    return line.a.y == line.b.y;
}

bool point_on_line(Line l, Point p)
{
    auto min_x = min(l.a.x, l.b.x);
    auto max_x = max(l.a.x, l.b.x);
    auto min_y = min(l.a.y, l.b.y);
    auto max_y = max(l.a.y, l.b.y);

    return p.x >= min_x && p.x <= max_x && p.y >= min_y && p.y <= max_y;
}

int a(Line[] lines)
{
    auto filtered_lines = lines
        .filter!(line => is_horizontal(line) || is_vertical(line))
        .array();
    auto max_x = 0;
    auto max_y = 0;
    foreach (line; filtered_lines)
    {
        max_x = max(max_x, line.a.x, line.b.x);
        max_y = max(max_y, line.a.y, line.b.y);
    }
    int[][] board = new int[][](max_x + 1, max_y + 1);

    auto answer = 0;
    for (int i = 0; i < board.length; i++)
    {
        for (int j = 0; j < board[0].length; j++)
        {
            foreach (line; filtered_lines)
            {
                Point p = {x: j, y: i};
                if (point_on_line(line, p))
                {
                    board[i][j]++;
                }
            }

            if (board[i][j] >= 2)
            {
                answer++;
            }
        }
    }
    return answer;
}
