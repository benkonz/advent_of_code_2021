import std.stdio;
import std.string;
import std.conv;

string[] parse_lines_from_path(string path)
{
	auto file = File(path, "r");

	string[] lines;
	while (!file.eof())
	{
		auto line = strip(file.readln());
		lines ~= line;
	}

	return lines;
}

void main(string[] args)
{
	auto day = to!int(args[1]);
	auto lines = parse_lines_from_path(args[2]);

	if (day == 1)
	{
		import source.day1;

		auto elements = parse_input(lines);

		auto increased_a = a(elements);
		increased_a.writeln;

		auto increased_b = b(elements);
		increased_b.writeln;
	}
	else if (day == 2)
	{
		import source.day2;

		auto instructions = parse_input(lines);

		auto answer_a = a(instructions);
		answer_a.writeln;

		auto answer_b = b(instructions);
		answer_b.writeln;
	}
	else if (day == 3)
	{
		import source.day3;

		auto numbers = parse_input(lines);

		auto answer_a = a(numbers);
		answer_a.writeln;

		auto answer_b = b(numbers);
		answer_b.writeln;
	}
	else if (day == 4)
	{
		import source.day4;

		auto input = parse_input(lines);

		auto answer_a = a(input);
		answer_a.writeln;

		auto answer_b = b(input);
		answer_b.writeln;
	}
	else if (day == 5)
	{
		import source.day5;

		auto input = parse_input(lines);

		auto answer_a = a(input);
		answer_a.writeln;
	}
}
