# Optimal Worksite Scheduling with MiniZinc

This MiniZinc model solves a worksite scheduling problem on a network of nodes by choosing when maintenance or construction works should take place in order to minimize the overall traffic impact.

## Overview

The application considers:

- a set of **nodes** in a network
- monthly **traffic volumes** associated with each node
- a fixed **worksite duration** of 3 months for each node
- a limit on the maximum number of simultaneous worksites

The goal is to determine the best months to schedule worksites so that the total traffic affected by the works is as low as possible.

## Problem Definition

Each node must undergo a worksite lasting **3 consecutive months**.

The optimization model decides in which months each worksite should be active, subject to these rules:

1. Every node must be scheduled for exactly **3 months**
2. Those 3 months must be **consecutive**
3. At most **3 worksites** can be active in the same month
4. The total traffic impacted by the scheduled worksites should be minimized

## Model Parameters

### Sets

- `NODES = 1..num_nodes`  
  The set of nodes in the network

- `MONTHS = 1..m`  
  The set of planning months

### Input Parameters

- `num_nodes = 6`  
  Number of nodes in the network

- `m = 12`  
  Number of months in the planning horizon

- `TRAF[i,j]`  
  Traffic volume for node `i` during month `j`

## Traffic Data

The traffic matrix used in the model is:

| Node | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec |
|------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| 1 | 700 | 733 | 653 | 753 | 827 | 613 | 207 | 293 | 653 | 820 | 787 | 940 |
| 2 | 747 | 827 | 727 | 1220 | 847 | 813 | 193 | 673 | 740 | 953 | 913 | 840 |
| 3 | 3473 | 4013 | 3300 | 3633 | 4153 | 3187 | 1560 | 2287 | 3640 | 4053 | 4520 | 3980 |
| 4 | 6593 | 6747 | 6227 | 5560 | 5667 | 2160 | 1620 | 6893 | 6600 | 5953 | 5560 | 5980 |
| 5 | 1600 | 1320 | 1513 | 1787 | 1987 | 1593 | 580 | 893 | 1320 | 1940 | 1340 | 1560 |
| 6 | 2300 | 2733 | 2193 | 2260 | 2353 | 2320 | 680 | 1320 | 1520 | 2140 | 1987 | 2007 |

## Decision Variables

```minizinc
array[NODES, MONTHS] of var 0..1: order;
