program main;
uses bit, popop, fili, cross, math, dos;

var
    config : configuration;
    init_volume, max_iters, max_valueless_iters, pres_high, pres_low : longint;
    mutation_size, cross_size : longint;
    quality_eps, enough_func_value : real;
    selection_method, cross_method, mutation_method : string;
    test_mode, screen_flag : boolean;
    prev_best : real;
    cur_gen : generation;
    firstt, secondd, a, i, j, c : longint;
    cond_stop: integer;
    out_f, read_f : text;
    flag : boolean;
    s : string;
    temp : arr_pop;
    Hour1 , Minute1 , Second1 , Sec1001 :word;
    Hour2 , Minute2 , Second2 , Sec1002 :word;
    Miliseconds :integer;
    
begin
    
    Miliseconds := 0;
    config := Read_config('task_2.config');
    init_volume := config.init_volume;
    max_iters := config.max_iters;
    max_valueless_iters := config.max_valueless_iters;
    quality_eps := config.quality_eps;
    enough_func_value := config.enough_func_value;
    pres_high := config.pres_high;
    pres_low := config.pres_low;
    cross_size := config.cross_size;
    mutation_size := config.mutation_size;
    selection_method := config.selection_method;
    cross_method := config.cross_method;
    mutation_method := config.mutation_method;
    test_mode := config.test_mode;
    screen_flag := config.screen_flag;
    Generate(cur_gen, init_volume);
    prev_best := 0;
    cond_stop := 0;
    randseed := 40;
    flag := true;
    if test_mode = true then
    begin
        assign(out_f, 'output.txt');
        rewrite(out_f);
    end;
    while flag do
    begin
        GetTime(Hour1 , Minute1 , Second1 , Sec1001);
        Sort(cur_gen);
        GetTime(Hour2 , Minute2 , Second2 , Sec1002); 
      Miliseconds := Miliseconds + (Sec1002 + Second2*100 + Minute2*6000 + Hour2*360000 -
                      Sec1001 - Second1*100 - Minute1*6000 - Hour1*360000 + 1);
        if abs(cur_gen.population[0].fit - prev_best) < 0.01 
         then cur_gen.valueless_iter := cur_gen.valueless_iter + 1
         else cur_gen.valueless_iter := 0;
        writeln(cur_gen.population[0].fit, prev_best, quality_eps, cur_gen.valueless_iter );
        prev_best := cur_gen.population[0].fit;
        if test_mode = true then
            Print_pop_f(cur_gen, out_f);
             
        if test_mode = false then
        begin
            writeln('Generation number: ', cur_gen.num);
            writeln('Val: ', cur_gen.population[0].val : 7 : 7, ' fit: ', cur_gen.population[0].fit : 7 : 7);
            writeln;
        end;
        if Stop_flag(cur_gen, cond_stop, max_valueless_iters, max_iters,
                    enough_func_value) then
        begin
            if test_mode = true then
            begin
                writeln(out_f);
                writeln(out_f, '                                     ');
                if cond_stop = 1 
                then writeln(out_f, 'Too much valueless iterations')
                else if cond_stop = 2 
                then writeln(out_f, 'Too much iterations at all')
                else if cond_stop = 3 
                then writeln(out_f, 'Enough function value has been reached');
                writeln(out_f, 'Generation number: ', cur_gen.num);
                writeln(out_f, 'Final result: ', cur_gen.population[0].fit : 10 : 10, ' at point ', cur_gen.population[0].val : 10 : 10);
                writeln(out_f, '                                     ');
                writeln(out_f);
                writeln(out_f,'Work time (milliseconds):');
		        writeln(out_f, Miliseconds);
                close(out_f);
                flag := false;
            end
            else
            begin
                writeln;
                writeln('                                            ');
                if cond_stop = 1 
                then writeln('Too much valueless iterations')
                else if cond_stop = 2 
                then writeln('Too much iterations at all')
                else if cond_stop = 3 
                then writeln('Enough function value has been reached');
                writeln('Generation number: ', cur_gen.num);
                writeln('Final result: ', cur_gen.population[0].fit : 10 : 10, ' at point ', cur_gen.population[0].val : 10 : 10);
                writeln('                                            ');
                writeln('Work time (milliseconds):');
		        writeln(Miliseconds);
                writeln;
                flag := false;
            end;
            
        end;
        if flag = false 
        then continue;
        begin
        GetTime(Hour1 , Minute1 , Second1 , Sec1001);
        if selection_method = 'ROULETTE' 
        then Selection_roulette(cur_gen, pres_high, pres_low)
        else if selection_method = 'TRUNCATION' 
        then Selection_truncation(cur_gen, 0.75, pres_high, pres_low);
        if selection_method = 'ROULETTE' then
        begin
            Setlength(temp, cur_gen.sum_ratio);
            c := 0;
            for i := 0 to cur_gen.len - 1 do
                for j := 0 to trunc(cur_gen.population[i].ratio) - 1 do
                begin
                    temp[c] := cur_gen.population[i];
                    c := c + 1;
                end;
            for i := 1 to cross_size do
            begin
                if init_volume - cur_gen.len > mutation_size then
                begin
                    repeat
                     firstt := random(cur_gen.sum_ratio - 1);
                     secondd := random(cur_gen.sum_ratio - 1);
                     until(firstt <> secondd);
                     if cur_gen.sum_ratio + 2 <= high(cur_gen.population) then
                     if cross_method = 'DOUBLE' then begin
                        D_p_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                    if cross_method = 'SINGLE' then begin
                        S_p_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                    if cross_method = 'UNIVERSAL' then begin
                        Universal_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                    if cross_method = 'UNIFORM' then begin
                        Uniform_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                    cur_gen.len := cur_gen.len + 2;
                    Setlength(cur_gen.population, cur_gen.len);
                    cur_gen.population[cur_gen.len - 2] := cur_gen.population[cur_gen.sum_ratio + 1];
                    cur_gen.population[cur_gen.len - 1] := cur_gen.population[cur_gen.sum_ratio + 2];
                end;
                
            end;
            Setlength(temp, 0);
        end
        else if selection_method = 'TRUNCATION' then
        begin
            for i := 1 to cross_size do
            begin
                if init_volume - cur_gen.len > mutation_size then
                begin
                    repeat
                     firstt := random(cur_gen.sum_ratio - 1);
                     secondd := random(cur_gen.sum_ratio - 1);
                     until(firstt <> secondd);
                     if cur_gen.sum_ratio + 2 <= high(cur_gen.population) then
                     if cross_method = 'DOUBLE' then begin
                        D_p_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                     if cross_method = 'SINGLE' then begin
                        S_p_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                    if cross_method = 'UNIVERSAL' then begin
                        Universal_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                    if cross_method = 'UNIFORM' then begin
                        Uniform_cross(cur_gen.population[firstt].gene, cur_gen.population[secondd].gene,
                                  cur_gen.population[cur_gen.sum_ratio + 1].gene, 
                                 cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 1], cur_gen.population[cur_gen.sum_ratio + 1].gene);
                        Init(cur_gen.population[cur_gen.sum_ratio + 2], cur_gen.population[cur_gen.sum_ratio + 2].gene);
                        end;
                    cur_gen.len := cur_gen.len + 2;
                    Setlength(cur_gen.population, cur_gen.len);
                    cur_gen.population[cur_gen.len - 2] := cur_gen.population[cur_gen.sum_ratio + 1];
                    cur_gen.population[cur_gen.len - 1] := cur_gen.population[cur_gen.sum_ratio + 2];
                end;
            end;
        end;
        for i := 1 to mutation_size do
        begin
           if init_volume - cur_gen.len > 0 then
            begin
                a := random(cur_gen.sum_ratio);
                if  (a <= high(cur_gen.population)) then
                 if mutation_method = 'RANDOM' then begin
                    Random_mutation(cur_gen.population[a].gene, cur_gen.population[cur_gen.sum_ratio].gene);
                    Init(cur_gen.population[a],cur_gen.population[a].gene);
                    end;
               if mutation_method = 'SWAP' then begin
                    Swap_mutation(cur_gen.population[a].gene, cur_gen.population[cur_gen.sum_ratio].gene);
                    Init(cur_gen.population[a],cur_gen.population[a].gene);
                    end;
                if mutation_method = 'REVERSE' then begin
                    Reverse_mutation(cur_gen.population[a].gene, cur_gen.population[cur_gen.sum_ratio].gene);
                    Init(cur_gen.population[a],cur_gen.population[a].gene);
                    end;
                cur_gen.len := cur_gen.len + 1;
                Setlength(cur_gen.population, cur_gen.len);
                cur_gen.population[cur_gen.len - 1] := cur_gen.population[cur_gen.sum_ratio];
            end;
        end;
        cur_gen.num := cur_gen.num + 1;
        GetTime(Hour2 , Minute2 , Second2 , Sec1002); 
        Miliseconds := Miliseconds + (Sec1002 + Second2*100 + Minute2*6000 + Hour2*360000 -
                      Sec1001 - Second1*100 - Minute1*6000 - Hour1*360000) ;
        if test_mode = false then writeln('----------------------------------------------')
                                 else writeln(out_f, '----------------------------------------------');
      end;                            
    end;
    if test_mode and screen_flag then
    begin
        assign(read_f, 'output.txt');
        reset(read_f);
        while not eof(read_f) do
        begin
            readln(read_f, s);
            writeln(s);
        end;
        close(read_f);
    end;

    Setlength(cur_gen.population, 0);
end.
