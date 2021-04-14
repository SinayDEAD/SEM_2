unit cross;

interface

uses bit;

procedure Random_mutation(ent : longword; var ent1 : longword); 
procedure Swap_mutation(ent : longword; var ent1 : longword); 
procedure Reverse_mutation(ent : longword; var ent1 : longword);
procedure S_p_cross(ent1,ent2: longword; var child1, child2: longword); 
procedure D_p_cross(ent1,ent2: longword; var child1, child2: longword); 
procedure Universal_cross(ent1,ent2: longword; var child1, child2: longword); 
procedure Uniform_cross(ent1,ent2: longword; var child1, child2: longword);
procedure Sort(var cur_gen : generation); 

implementation

procedure Random_mutation(ent : longword; var ent1 : longword); 
var
    pos : byte;
begin
    ent1 := ent;
    pos := my_random(31);
    if Get_bit(ent, pos) = 1 
    then Unset_bit(ent1, pos)
    else Set_bit(ent1, pos);
end;

procedure Swap_mutation(ent : longword; var ent1 : longword); 
var
    pos1, pos2, bit1, bit2 : byte;
    flag : boolean;
begin
    flag := true;
    while flag do
    begin
        ent1 := ent;
        repeat
            pos1 := my_random(31);
            pos2 := my_random(31);
        until pos1 <> pos2;
        bit1 := Get_bit(ent, pos1);
        bit2 := Get_bit(ent, pos2);
        if bit1 <> bit2 then
        begin
            flag := false;
            if bit1 = 1 then
            begin
                Unset_bit(ent1, pos1);
                Set_bit(ent1, pos2);
            end else begin
                Set_bit(ent1, pos1);
                Unset_bit(ent1, pos2);
            end;
        end;
    end;
end;

procedure Reverse_mutation(ent : longword; var ent1 : longword); 
var
    bit1, bit2, i, pos : byte;
begin
    ent1 := ent;
    pos := my_random(31);
    for i := ((pos + 31) shr 1) + 1 to 31 do
    begin
        bit1 := Get_bit(ent, i);
        bit2 := Get_bit(ent, 31 - i +  + pos);
        if bit1 = 1 
        then Set_bit(ent1, 31 - i + pos)
        else Unset_bit(ent1, 31 - i + pos);
        if bit2 = 1 
        then Set_bit(ent1, i)
        else Unset_bit(ent1, i);
    end;
end;

procedure S_p_cross(ent1,ent2: longword; var child1, child2: longword); 
var
    trail, i, bit1, bit2 : byte;

begin
    trail := my_random(31);
    for i := 0 to trail - 1 do
    begin
        bit1 := Get_bit(ent1, 31 - i);
        bit2 := Get_bit(ent2, 31 - i);
        if bit1 = 1 
          then Set_bit(child2, 31 - i)
          else Unset_bit(child2, 31 - i);
        if bit2 = 1 
          then Set_bit(child1, 31 - i)
          else Unset_bit(child1, 31 - i);
    end;
end;

procedure D_p_cross(ent1,ent2: longword; var child1, child2: longword); 
var
    trail_start, trail_size, i, bit1, bit2 : byte;

begin
    trail_start := my_random(31);
    trail_size := my_random(31 - trail_start);
    for i := 0 to trail_size do
    begin
        bit1 := Get_bit(ent1, 31 - (i + trail_start));
        bit2 := Get_bit(ent2, 31 - (i + trail_start));
        if bit1 = 1 
          then Set_bit(child2, 31 - (i + trail_start))
          else Unset_bit(child2, 31 - (i + trail_start));
        if bit2 = 1 
          then  Set_bit(child1, 31 - (i + trail_start))
          else  Unset_bit(child1, 31 - (i + trail_start));
    end;
end;

procedure Universal_cross(ent1,ent2: longword; var child1, child2: longword); 
var
    i : longint;

begin
    for i := 0 to 31 do
    begin
        if my_random(2) = 1 then
        begin
            if Get_bit(ent1, 31 - i) = 1 
            then Set_bit(child1, 31 - i)
            else Unset_bit(child1, 31 - i);
        end else begin
            if Get_bit(ent2, 31 - i) = 1 
              then Set_bit(child2, 31 - i)
              else Unset_bit(child2, 31 - i);
        end;
    end;
    for i := 0 to 31 do
    begin
        if my_random(2) = 1 then
        begin
            if Get_bit(ent1, 31 - i) = 1 
             then Set_bit(child1, 31 - i)
            else Unset_bit(child1, 31 - i);
        end else begin
            if Get_bit(ent2, 31 - i) = 1 
              then Set_bit(child2, 31 - i)
              else Unset_bit(child2, 31 - i);
        end;
    end;
end;

procedure Uniform_cross(ent1,ent2: longword; var child1, child2: longword); 
var
    mask : longword;
    i : longint;

begin
    mask := my_random(high(longword));
    for i := 0 to 31 do
    begin
        if Get_bit(mask, i) = 0 then
          if Get_bit(ent1, i) = 1 
            then Set_bit(child1, i)
            else Unset_bit(child1, i)
        else
            if Get_bit(ent2, i) = 1 
            then Set_bit(child2, i)
            else Unset_bit(child2, i);
    end;
    for i := 0 to 31 do
    begin
        if Get_bit(mask, i) = 0 then
          if Get_bit(ent1, i) = 1 
           then Get_bit(child1, i)
           else Unset_bit(child1, i)
        else
          if Get_bit(ent2, i) = 1 
          then Set_bit(child2, i)
          else Unset_bit(child2, i);
    end;
end;

procedure Sort(var cur_gen : generation); 
var
  temp : entity;
  i, j, m : longint;
begin
    for i := 0 to cur_gen.len - 1 do
   begin
       m := i;
       for j := i + 1 to cur_gen.len - 1 do
           if cur_gen.population[j].fit > cur_gen.population[m].fit 
           then m := j;
                temp := cur_gen.population[m];
                cur_gen.population[m] := cur_gen.population[i];
                cur_gen.population[i] := temp;
    end;
end;

end.
