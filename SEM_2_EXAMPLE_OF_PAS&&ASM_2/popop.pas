unit popop;
interface

uses bit, cross;

procedure Generate(var cur_gen : generation; init_volume : longint);
procedure Print_pop(cur_gen : generation);
function Stop_flag(cur_gen : generation; var cond_stop : integer;
                    max_valueless_iters, max_iters : longint;
                    enough_func_value : real) : boolean;

implementation

procedure Generate(var cur_gen : generation; init_volume : longint);
var
    i : longint;

begin
    Setlength(cur_gen.population, init_volume);
    cur_gen.len := init_volume;
    cur_gen.num := 0;
    cur_gen.valueless_iter := 0;
    cur_gen.sum_ratio := 0;
    for i := 0 to init_volume - 1 do
    begin
        cur_gen.population[i].gene := random(high(longword));
        Init(cur_gen.population[i], cur_gen.population[i].gene);
    end;
end;

procedure Print_pop(cur_gen : generation);
var
    i : longint;
begin
    writeln('Number of generation: ', cur_gen.num);
    for i := 0 to cur_gen.len - 1 do
    begin
        write('Gene: ');
        Print_bit(cur_gen.population[i].gene);
        writeln(' val: ', cur_gen.population[i].val : 7 : 7, ' fit: ', cur_gen.population[i].fit : 7 : 7, ' num: ', i);
    end;
    writeln;
end;

//Stop criterion
function Stop_flag(cur_gen : generation; var cond_stop : integer;
                    max_valueless_iters, max_iters : longint;
                    enough_func_value : real) : boolean;
begin
    Stop_flag := false;
    if cur_gen.valueless_iter >= max_valueless_iters then
    begin
        cond_stop := 1;
        Stop_flag := true;
    end;
    if cur_gen.num >= max_iters then
    begin
        cond_stop := 2;
        Stop_flag := true;
    end;
    if cur_gen.population[0].fit >= enough_func_value then
    begin
        cond_stop := 3;
        Stop_flag := true;
    end;
end;

end.
