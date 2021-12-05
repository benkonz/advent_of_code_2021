module source.day4;

import std.array;
import std.stdio;
import std.conv;
import std.algorithm;

struct Input
{
    int[] numbers;
    int[][][] boards;
}

struct BoardState
{
    ulong[][ulong][] borad_maps;
    bool[][][] seen_list;
}

Input parse_input(string[] lines)
{
    auto joined = lines.join("\n");
    string[] split = joined.split("\n\n");

    auto numbers = split[0]
        .split(",")
        .map!(line => to!int(line, 10))
        .array();

    auto boards = split[1 .. split.length]
        .map!(board =>
                board
                .split("\n")
                .map!(line =>
                    line.split()
                    .map!(num => to!int(num, 10))
                    .array()
                )
                .array()
        )
        .array();

    Input input = {numbers: numbers, boards: boards};
    return input;
}

BoardState init_board_state(int[][][] boards)
{
    ulong[][ulong][] borad_maps;
    bool[][][] seen_list;

    // init board_maps and seen_list
    foreach (i, board; boards)
    {
        bool[][] seen;
        ulong[][ulong] board_map;
        foreach (j, row; board)
        {
            bool[] seen_col;
            foreach (k, cell; row)
            {
                board_map[cell] = [j, k];
                seen_col ~= false;
            }
            seen ~= seen_col;
        }
        borad_maps ~= board_map;
        seen_list ~= seen;
    }

    BoardState board_state = {borad_maps: borad_maps,
    seen_list: seen_list};
    return board_state;
}

bool check_for_win(bool[][] seen, int[][] board)
{
    // check horizontals and verticals
    for (int i = 0; i < seen.length; i++)
    {
        auto horiz_win = true;
        auto vert_win = true;

        for (int j = 0; j < seen.length; j++)
        {
            if (seen[i][j] == false)
            {
                horiz_win = false;
            }
            if (seen[j][i] == false)
            {
                vert_win = false;
            }
        }
        if (horiz_win || vert_win)
        {
            return true;
        }

    }
    return false;
}

int find_sum_unseen(bool[][] seen, int[][] board)
{
    auto unseen_sum = 0;
    for (int i = 0; i < seen.length; i++)
    {
        for (int j = 0; j < seen.length; j++)
        {
            if (seen[i][j] == false)
            {
                unseen_sum += board[i][j];
            }
        }
    }
    return unseen_sum;
}

int a(Input input)
{
    auto numbers = input.numbers;
    auto boards = input.boards;

    auto board_state = init_board_state(boards);
    ulong[][ulong][] borad_maps = board_state.borad_maps;
    bool[][][] seen_list = board_state.seen_list;
    // run each number until a win has happened
    foreach (number; numbers)
    {
        // for each board, update seen[board_index][board_maps[board_index][number]] = true
        foreach (i, board; boards)
        {
            auto board_map = borad_maps[i];
            auto seen = seen_list[i];

            if (number in board_map)
            {
                auto num_coord = board_map[number];
                auto num_i = num_coord[0];
                auto num_j = num_coord[1];

                seen[num_i][num_j] = true;
            }

            if (check_for_win(seen, board))
            {
                // find sum of all unmarked numbers
                auto sum_unseen = find_sum_unseen(seen, board);
                return number * sum_unseen;
            }
        }
    }

    return 0;
}

bool is_last_win(bool[][][] seen_list, int[][][] boards) {
    auto win_count = 0;
    foreach (i, board; boards) {
        auto seen = seen_list[i];
        if (check_for_win(seen, board)) {
            win_count++;
        }
    }

    return win_count == boards.length;
}

int b(Input input)
{
    auto numbers = input.numbers;
    auto boards = input.boards;

    auto board_state = init_board_state(boards);
    ulong[][ulong][] borad_maps = board_state.borad_maps;
    bool[][][] seen_list = board_state.seen_list;
    // run each number until a win has happened
    foreach (number; numbers)
    {
        // for each board, update seen[board_index][board_maps[board_index][number]] = true
        foreach (i, board; boards)
        {
            auto board_map = borad_maps[i];
            auto seen = seen_list[i];

            if (number in board_map)
            {
                auto num_coord = board_map[number];
                auto num_i = num_coord[0];
                auto num_j = num_coord[1];

                seen[num_i][num_j] = true;
            }

            if (is_last_win(seen_list, boards))
            {
                // find sum of all unmarked numbers
                auto sum_unseen = find_sum_unseen(seen, board);
                return number * sum_unseen;
            }
        }
    }

    return 0;
}
