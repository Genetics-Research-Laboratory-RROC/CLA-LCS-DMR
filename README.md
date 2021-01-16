# CLA-LCS-DMR
# MATLAB Version: 8.6
## Description
A Hybrid Method based on Cellular Learning Automata and Longest Common Subsequence Algorithm to Detect Differential Methylation Regions in Bisulfite Sequencing Data
## Each data must have 2 column. the first column is contained Locations and the second column is consist of CPG's.
## How to Run
1) Run "DMR_Finder.fig".
2) Enter number of the Control samples,number of the Treatment samples, and number of the Chromosomes then press 'Create Directory' button. 
3) Copy your data in the created directory.
	for example: copy first chromosome of the first Control's sample in the 'Control/Sample1/Chromosome1' folder
		     and first chromosome of the first treatment's sample in the 'treatment/Sample1/Chromosome1' folder
4) Press 'Find DMRs' button and wait until the 'Done! DMRs Are In DMRs Folders' shown. it may takes several minutes.
5) The output results are accessible in DMRs file.
* Note:  CLA-LCS   DMR   program   is   implemented   in   Ubuntu   enviroment.   If   it   is   run   inWindows enviroment, several directories  should be changed in “Main, Model and  Final”functions
