unit pop;

interface

uses  bit;

procedure S_p_cross(ent1,ent2: longword; var child1, child2: longword); stdcall; external name 'SINGLE'; {$L pop.obj}
procedure D_p_cross(ent1,ent2: longword; var child1, child2: longword); stdcall; external name 'DOUBLE'; {$L pop.obj}
procedure Universal_cross(ent1,ent2: longword; var child1, child2: longword); stdcall; external name 'UNIVERSAL'; {$L pop.obj}
procedure Uniform_cross(ent1,ent2: longword; var child1, child2: longword); stdcall; external name 'UNIFORM'; {$L pop.obj}
procedure Random_mutation(ent : longword; var ent1 : longword); stdcall; external name 'RANDOM'; {$L pop.obj}
procedure Swap_mutation(ent : longword; var ent1 : longword); stdcall; external name 'SWAPP'; {$L pop.obj}
procedure Reverse_mutation(ent : longword; var ent1 : longword); stdcall; external name 'REVERSE'; {$L pop.obj}
procedure Sort(var cur_gen : generation); stdcall; external name 'SORTT'; {$L pop.obj}
implementation
end.
