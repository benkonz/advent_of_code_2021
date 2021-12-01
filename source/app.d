import std.stdio;
import std.string;
import std.conv;

void main(string[] args)
{
	auto file = File(args[1], "r");

	int[] elements;
	while (!file.eof())
	{
		auto line = strip(file.readln());
		elements ~= to!int(line, 10);
	}

	// day 1
	{
		import source.day1;

		auto increased_a = a(elements);
		increased_a.writeln;

		auto increased_b = b(elements);
		increased_b.writeln;
	}
}
