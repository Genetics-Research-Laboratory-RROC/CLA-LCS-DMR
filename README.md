# CLA-LCS-DMR

## Description
A Hybrid Method based on Cellular Learning Automata and Longest Common Subsequence Algorithm to Detect Differential Methylation Regions in Bisulfite Sequencing Data

## How to Run
1) Run "initial.m".
2) Enter cancer samples in “cancer” folder. 
3) Enter normal samples in “normal” folder. 
4) Rename the samples in “cancer” and “normal” folders in a sequence order (1, 2, ... , n).
5) Each sample folder should consist of 1 to n “chromosome information file” which is termed by the name of each chromosome and is composed with two columns “CpG location” and “methylation ratio”. 
6) Run “Main.m”.
7) The output results are accessible in DMRs file.
* Note:  CLA-LCS   DMR   program   is   implemented   in   Ubuntu   enviroment.   If   it   is   run   inWindows enviroment, several directories  should be changed in “Main, Model and  Final”functions
