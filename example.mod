param D > 0 integer;
param E > 0 integer;
param N > 0 integer;
param Pd > 0 integer;

set Nodes := 1..N;
set link_nos := 1..E;
set demand_nos := 1..D;
set route_nos := 1..Pd;

param link_src {link_nos} within Nodes;
param link_dest {link_nos} within Nodes;
param link_capacity {link_nos} >= 0 integer;

param demand_src {demand_nos} within Nodes;
param demand_dest {demand_nos} within Nodes;

set Routes{demand_nos,route_nos} within link_nos;
param h {demand_nos} >=0 integer;


param delta {e in link_nos, d in demand_nos, p in route_nos}
= if e in Routes[d,p] then 1 else 0;

var x {d in demand_nos, p in route_nos} >= 0 integer;
var z {e in link_nos} >= 0 integer default 0;

minimize total_cost:
sum{e in link_nos} (z[e]);

subj to all_demands {d in demand_nos}:
 sum{p in route_nos} x[d,p] = h[d];

subj to capacity_constraints {e in link_nos}:
    sum{d in demand_nos}(sum{p in route_nos} (delta[e,d,p]*x[d,p])) - link_capacity[e] - z[e] <= 0;