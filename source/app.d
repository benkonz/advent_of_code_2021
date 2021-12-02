import std.stdio;
import std.string;
import std.conv;

void main(string[] args)
{
	auto day = to!int(args[1]);
	auto file = File(args[2], "r");

	string[] lines;
	while (!file.eof())
	{
		auto line = strip(file.readln());
		lines ~= line;
	}

	if (day == 1)
	{
		import source.day1;

		auto elements = parse_input(lines);

		auto increased_a = a(elements);
		increased_a.writeln;

		auto increased_b = b(elements);
		increased_b.writeln;
	}

	if (day == 2)
	{
		import source.day2;

		auto instructions = parse_input(lines);

		auto answer_a = a(instructions);
		answer_a.writeln;

		auto answer_b = b(instructions);
		answer_b.writeln;
	}
}
