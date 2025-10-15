% Define the number of nodes and traffic volumes associated with each node
int: num_nodes = 6;      
int: m = 12;        % Number of nodes in the network
set of int: NODES = 1..num_nodes;
set of int: MONTHS = 1..m;

%Traffic volumes associated with each node
array[NODES, MONTHS] of int: TRAF = [|700, 733, 653, 753, 827, 613, 207, 293, 653, 820, 787, 940|
                                      747, 827, 727, 1220, 847, 813, 193, 673, 740, 953, 913, 840|
                                      3473, 4013, 3300, 3633, 4153, 3187, 1560, 2287, 3640, 4053, 4520, 3980|
                                      6593, 6747, 6227, 5560, 5667, 2160, 1620, 6893, 6600, 5953, 5560, 5980|
                                      1600, 1320, 1513, 1787, 1987, 1593, 580, 893, 1320, 1940, 1340, 1560|
                                      2300, 2733, 2193, 2260, 2353, 2320, 680, 1320, 1520, 2140, 1987, 2007|];
% Decision variables
array[NODES,MONTHS] of var 0..1: order; % Order of nodes

% Objective: minimize traffic volume variation
var int: traffic_variation = sum(i in NODES, j in MONTHS)(TRAF[i,j] * order[i,j]);

% Constraint that sets the worksites duration to 3(hypothesis of mean duration for worksite)
constraint forall(i in NODES)(sum(j in MONTHS)(order[i,j]) = 3);

%Constraint that sets maximum 3 worksites at the same time(depending on budget)
constraint forall(j in MONTHS)(sum(i in NODES)(order[i,j]) <= 3);

%Constraint that ensures the consecutiveness of the worksites
constraint forall(i in NODES)
          (exists(j in 1..(m-2))
          (order[i,j] = 1 /\ order[i,j+1] = 1 /\ order[i,j+2] = 1));
          
% Solve the optimization problem
solve minimize traffic_variation;
