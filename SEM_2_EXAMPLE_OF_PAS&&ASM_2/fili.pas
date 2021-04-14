unit fili;
interface

uses bit, popop, cross;

type

    configuration = record  //parametres
                    init_volume, max_iters, max_valueless_iters, pres_high,
                    pres_low, mutation_size, cross_size : longint;
                    quality_eps, enough_func_value : real;
                    selection_method, cross_method, mutation_method : string;
                    test_mode, screen_flag : boolean;
                    end;

procedure Print_pop_f(cur_gen : generation; var out_f : text);
procedure Clear_spaces(var s : string);
function Read_config(file_name : string) : configuration;

implementation

procedure Print_pop_f(cur_gen : generation; var out_f : text);
var
    i : longint;
begin
    writeln(out_f, 'Number of generation: ', cur_gen.num);
    for i := 0 to cur_gen.len - 1 do
    begin
        write(out_f, 'Gene: ');
        Print_bit_f(cur_gen.population[i].gene, out_f);
        writeln(out_f, ' val: ', cur_gen.population[i].val : 7 : 7, ' fit: ',
                cur_gen.population[i].fit : 7 : 7, ' num: ', i);
    end;
    writeln(out_f);
end;

procedure Clear_spaces(var s : string);
var
    str : string;
    i, j : longint;
begin
    j := 0;
    str := '';
    for i := 1 to length(s) do
        if (ord(s[i]) <> 32) and (ord(s[i]) <> 10) then
        begin
            str := str + s[i];
            j := j + 1;
        end;
    if j = 0 then
    begin
        Setlength(s, 1);
        s[0] := '#';
    end
    else
        s := str;
    Setlength(str, 0);
end;

function Read_config(file_name : string) : configuration;
var
    config_f : TextFile;
    input_s, var_name, expected_value : string;
    eq_pos, err : longint;

begin
    assign(config_f, file_name);
    reset(config_f);
    Read_config.init_volume := 30;    // default
    Read_config.max_iters := 500;
    Read_config.max_valueless_iters := 100;
    Read_config.quality_eps := 0.00001;
    Read_config.enough_func_value := 0.2;
    Read_config.pres_high := 3;
    Read_config.pres_low := 3;
    Read_config.cross_size := 5;
    Read_config.mutation_size := 10;
    Read_config.selection_method := 'truncation';
    Read_config.cross_method := 'uniform';
    Read_config.mutation_method := 'swap';
    Read_config.test_mode := false;
    Read_config.screen_flag := true;

    while not eof(config_f) do
    begin
        readln(config_f, input_s);
        if input_s = '' then
            continue;
        Clear_spaces(input_s);   //Clearing spaces
        if input_s[1] = '#' then
            continue;
        eq_pos := pos('=', input_s);
        if eq_pos = 0 then
        begin
            writeln('No "=" symbol in line(', input_s, ')');
            close(config_f);
            halt;
        end;
        expected_value := copy(input_s, eq_pos + 1, high(input_s));
        if expected_value = '' then
        begin
            write('No expected_value in line(', input_s, ')');
            close(config_f);
            halt;
        end;
        Clear_spaces(expected_value);
        var_name := copy(input_s, 0, eq_pos - 1);
        if var_name = '' then
        begin
            writeln('No var_name in line(', input_s, ')');
            close(config_f);
            halt;
        end;
        Clear_spaces(var_name);
        if var_name = 'init_volume' then
        begin
            val(expected_value, Read_config.init_volume, err);
            if err <> 0 then
            begin
                writeln('Wrong type of init_volume parameter');
                close(config_f);
                halt;
            end;
            if Read_config.init_volume <= 0 then
            begin
                writeln('Wrong value of init_volume parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'pres_high' then
        begin
            val(expected_value, Read_config.pres_high, err);
            if err <> 0 then
            begin
                writeln('Wrong type of pres_high parameter');
                close(config_f);
                halt;
            end;
            if Read_config.pres_high > Read_config.init_volume then
            begin
                writeln('Wrong value of pres_high parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'pres_low' then
        begin
            val(expected_value, Read_config.pres_low, err);
            if err <> 0 then
            begin
                writeln('Wrong type of pres_low parameter');
                close(config_f);
                halt;
            end;
            if Read_config.pres_low > Read_config.init_volume then
            begin
                writeln('Wrong value of pres_low parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'cross_size' then
        begin
            val(expected_value, Read_config.cross_size, err);
            if err <> 0 then
            begin
                writeln('Wrong type of cross_size parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'mutation_size' then
        begin
            val(expected_value, Read_config.mutation_size, err);
            if err <> 0 then
            begin
                writeln('Wrong type of mutation_size parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'max_valueless_iters' then
        begin
            val(expected_value, Read_config.max_valueless_iters, err);
            if err <> 0 then
            begin
                writeln('Wrong type of max_valueless_iters parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'max_iters' then
        begin
            val(expected_value, Read_config.max_iters, err);
            if err <> 0 then
            begin
                writeln('Wrong type of max_iters parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'enough_func_value' then
        begin
            val(expected_value, Read_config.enough_func_value, err);
            if err <> 0 then
            begin
                writeln('Wrong type of enough_func_value parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'test_mode' then
        begin
            if (upcase(expected_value) = 'Y') or
                (upcase(expected_value) = 'YES') then
                Read_config.test_mode := true
            else if (upcase(expected_value) = 'N') or
                    (upcase(expected_value) = 'NO') then
                Read_config.test_mode := false
            else
            begin
                writeln('Wrong value of test_mode parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'screen_flag' then
        begin
            if (upcase(expected_value) = 'Y') or
                (upcase(expected_value) = 'YES') then
                Read_config.screen_flag := true
            else if (upcase(expected_value) = 'N') or
                    (upcase(expected_value) = 'NO') then
                Read_config.screen_flag := false
            else
            begin
                writeln('Wrong value of test_mode parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'selection_method' then
        begin
            if (upcase(expected_value) = 'TRUNCATION') or
                (upcase(expected_value) = 'ROULETTE') then
                Read_config.selection_method := upcase(expected_value)
            else
            begin
                writeln('Wrong value of selection_method parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'cross_method' then
        begin
            if (upcase(expected_value) = 'SINGLE') or
                (upcase(expected_value) = 'DOUBLE') or
                (upcase(expected_value) = 'UNIVERSAL') or
                (upcase(expected_value) = 'UNIFORM') then
                Read_config.cross_method := upcase(expected_value)
            else
            begin
                writeln('Wrong value of cross_method parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'mutation_method' then
        begin
            if (upcase(expected_value) = 'RANDOM') or
                (upcase(expected_value) = 'SWAP') or
                (upcase(expected_value) = 'REVERSE') then
                Read_config.mutation_method := upcase(expected_value)
            else
            begin
                writeln('Wrong value of mutation_method parameter');
                close(config_f);
                halt;
            end;
        end
        else if var_name = 'quality_eps' then
        begin
            val(expected_value, Read_config.quality_eps, err);
            if err <> 0 then
            begin
                writeln('Wrong type of quality_eps parameter');
                close(config_f);
                halt;
            end;
            if Read_config.quality_eps <= 0 then
            begin
                writeln('Wrong value of quality_eps parameter');
                close(config_f);
                halt;
            end;
        end;
    end;
    close(config_f);
end;

end.
