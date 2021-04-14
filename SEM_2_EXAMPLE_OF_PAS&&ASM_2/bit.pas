unit bit;

interface
uses math;

type

    entity = record
            gene : longword;
            val, fit, ratio : real;
            null : boolean;
            end;

    arr_pop = array of entity; 

    generation = record       
                 population : arr_pop;
                 len, num, valueless_iter : longint;
                 sum_ratio : longint;  
                 end;

procedure Print_bit(num : longword);
procedure Print_bit_f(num : longword; var out_f : text);
function Get_bit(input : longword; n : byte) : byte;
procedure Set_bit(var input : longword; n : byte);
procedure Unset_bit(var input : longword; n : byte);
function F(x : real) : real;
procedure Selection_roulette(var cur_gen : generation; pres_high, pres_low : longint);
procedure Selection_truncation(var cur_gen : generation; T : real; pres_high, pres_low : longint);
function my_random (x : longword):longword;
procedure Init(var ent : entity; gene : longword);

implementation

procedure Print_bit(num : longword);
var
    mask : longword;
begin
    mask := 1 shl 31;
    while mask <> 0 do
    begin
        if (num and mask) = 0 
          then  write(0)
          else write(1);
        mask := mask shr 1;
    end;
end;

procedure Print_bit_f(num : longword; var out_f : text);
var
    mask : longword;
begin
    mask := 1 shl 31;
    while mask <> 0 do
    begin
        if (num and mask) = 0 
          then write(out_f, 0)
          else write(out_f, 1);
        mask := mask shr 1;
    end;
end;

function Get_bit(input : longword; n : byte) : byte;
var
    mask : longword;
begin
    mask := 1;
    mask := mask shl (31 - n);
    if input and mask > 0 
       then Get_bit := 1
       else Get_bit := 0;
end;

procedure Set_bit(var input : longword; n : byte);
var
    mask : longword;
begin
    mask := 1;
    mask := mask shl (31 - n);
    input := input or mask;
end;

procedure Unset_bit(var input : longword; n : byte);
var
    mask : longword;
begin
    mask := 1;
    mask := mask shl (31 - n);
    input := not ((not input) or mask);
end;

function F(x : real) : real;
begin
    F := x * (x - 1.1) * (x - 1.1) * (x - 1.1) * (x - 1.1) * (x - 1.1) * (x - 1.2) * (x - 1.2) * (x - 1.2) * (x - 1.2) * (x - 1.3) * (x - 1.3) * (x - 1.3) * cos(x + 100);
end;

procedure Selection_roulette(var cur_gen : generation; pres_high, pres_low : longint);
var
    count, i : longint;
    fit_sum, test_value : real;
    temp : arr_pop;
begin
    Setlength(temp, cur_gen.len);
    fit_sum := 0;
    count := 0;
    for i := 0 to pres_high - 1 do if i <= high(cur_gen.population) then
    begin
        temp[count] := cur_gen.population[i];
        inc(count);
    end;
    for i := cur_gen.len - pres_low to cur_gen.len - 1 do 
                  if (i <= high(cur_gen.population)) and (i >= low(cur_gen.population)) then
    begin
        temp[count] := cur_gen.population[i];
        count := count + 1;
    end;   
    for i := low(cur_gen.population) to high(cur_gen.population) do fit_sum := fit_sum + cur_gen.population[i].fit;
    for i := pres_high to cur_gen.len - pres_low do
                  if (i <= high(cur_gen.population)) and (i >= low(cur_gen.population)) then
    begin
        test_value := random;
        if test_value < (cur_gen.population[i].fit/fit_sum) then
        begin
            temp[count] := cur_gen.population[i];
            count := count + 1;
        end;
    end;
//  Setlength(temp, count);
  // Setlength(cur_gen.population, count);
 //  cur_gen.len := count;
 //   for i := 0 to count - 1 do
 //   cur_gen.population[i] := temp[i];
  //  Setlength(temp, 0);
    cur_gen.population := temp;
    cur_gen.sum_ratio := count - 1;
    setlength(temp, 0);
end;

procedure Selection_truncation(var cur_gen : generation; T : real; pres_high,
                                pres_low : longint);
var
    i, count : longint;
    temp : arr_pop;

begin
    Setlength(temp, cur_gen.len);
    count := 0;
    for i := 0 to pres_high - 1 do
    begin
        temp[count] := cur_gen.population[i];
        count := count + 1;
    end;
    for i := cur_gen.len - pres_low to cur_gen.len - 1 do
    begin
        temp[count] := cur_gen.population[i];
        count := count + 1;
    end;
    for i := 0 to round(T * (cur_gen.len - (pres_low + pres_high))) - 1 do
    begin
        temp[count] := cur_gen.population[i + pres_low];
        count := count + 1;
    end;
    Setlength(temp, count);
    Setlength(cur_gen.population, count);
    cur_gen.len := count;
    for i := 0 to count - 1 do
    cur_gen.population[i] := temp[i];
    Setlength(temp, 0);
end;

function my_random (x : longword):longword;
begin
    my_random := random(x);
end; 

procedure Init(var ent : entity; gene : longword);
begin
    ent.val := (gene * 4) / power(2, 32);
    ent.fit := F(ent.val);
    ent.ratio := 0;
    ent.null := false;
end;

end.
