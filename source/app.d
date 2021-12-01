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

	auto increased_a = a(elements);
	increased_a.writeln;

	
	auto increased_b = b(elements);
	increased_b.writeln;
}

int a(int[] elements)
{
	auto increased = 0;
	for (int i = 1; i < elements.length; i++)
	{
		auto prev = elements[i - 1];
		auto current = elements[i];

		if (current > prev)
		{
			increased++;
		}
	}

	return increased;
}

int b(int[] elements)
{
	auto i = 0;
	auto j = 3;
	auto window_sum = elements[0] + elements[1] + elements[2];
	auto increased = 0;

	while (j < elements.length)
	{
		auto prev_sum = window_sum;
		window_sum -= elements[i];
		window_sum += elements[j];
		auto curr_sum = window_sum;
		if (curr_sum > prev_sum)
		{
			increased++;
		}
		i++;
		j++;
	}

	return increased;
}
