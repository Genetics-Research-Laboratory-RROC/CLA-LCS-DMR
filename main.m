% input data format: each sample must have X Chromosome. each chromosome
% has 2 column, the first column is Location and the second column is CpG
% value. the name of the chromosoms are equal to their number and their
% file extention is txt ( for example for chromosome 1 the file is '1.txt').
% All chromosomes of a sample must be in a folder. the name of this folder
% is equal to the sample's number. for example chromosome 2 of sample 1
% directory is 1/2.txt
clc;
clearvars;
close all;
%{
NumOfNormalSamples=6;
NumOfCancerSamples=32;
NumOfChromosoms=22;
NumOfTotalSample=NumOfCancerSamples+NumOfNormalSamples;
%}
NumOfNormalSamples=input('Please Enter The Number Of Normal Samples: ');
NumOfCancerSamples=input('Please Enter The Number Of Cancer Samples: ');
NumOfChromosoms=input('Please Enter The Number Of Chromosoms: ');
NumOfTotalSample=NumOfCancerSamples+NumOfNormalSamples;
Model(NumOfNormalSamples,NumOfCancerSamples,NumOfChromosoms,NumOfTotalSample);
%---------load data------------
for chromosome=1:NumOfChromosoms
    model = dlmread(strcat('models/model',num2str(chromosome),'.txt'));
    for sampleNumber=1:NumOfCancerSamples
        A = importdata(strcat('Cancer/',num2str(sampleNumber),'/',num2str(chromosome),'.txt'));
        CancerLocOld=A.data(:,1);
        CancerCpGOld=A.data(:,2);
        clear A
        [CancerCpG,CancerLoc,NewModel,lenght]=omitLocations(CancerCpGOld,CancerLocOld,model);
        LocModel=NewModel(:,1);
        RegionsNumberModel=NewModel(:,2);
        AvgCpGsModel=NewModel(:,3);
        %-------------Built Cells----------------
        MaxBoundry=size(RegionsNumberModel,1);
        Start=1;
        NumberOfRegion=RegionsNumberModel(end);
        k=1;
        %---------Model Cells----------------
        for i=1:NumberOfRegion
            [Cell,NextStart]=BuiltCell(AvgCpGsModel,LocModel,RegionsNumberModel,lenght(i,4),i,Start,MaxBoundry);
            [r,c]=size(Cell);
            for j=1:c
                ModelCell(1,k)=Cell(1,j);
                k=k+1;
            end
            Start=NextStart;
        end
        %---------Cancer Cells-----------------
        
        Start=1;
        [~,c]=size(ModelCell);
        for i=1:c
            EndOfRegion=ModelCell(i).Location(end);
            StartOfRegion=ModelCell(i).Location(1);
            [CancerCell(i),NextStart]=BuiltCancerCell(CancerCpG,CancerLoc,Start,EndOfRegion,StartOfRegion);
            Start=NextStart;
        end
        %-----------------LCS------------------
        
        [~,NumberOfCell]=size(ModelCell);
        for i=1:NumberOfCell
            if size(CancerCell(i).CpGs)~=0
                [ModelCell(i).Similarity(1,1), ~, ~] = LCS(ModelCell(i).CpGs,CancerCell(i).CpGs);
            else
                ModelCell(i).Core=-1;
            end
        end
        
        %----------------------Detect Core------------
        % cells with .2<similarity<.7 will be found.
        [~,NumberOfCell]=size(ModelCell);
        j=1;
        Index=[];
        for i=1:NumberOfCell
            if  .2<ModelCell(i).Similarity(1,1) && ModelCell(i).Similarity(1,1)<.7
                Index(j)=i;
                j=j+1;
            end
        end
        %------------Main----------------
        if ~isempty(Index)
            [~,NumberOfCore]=size(Index);
            [CoreMatix]=DividCore(NumberOfCore,ModelCell,Index);
            CancerCoreMatrix=CancerCell(Index(:));
            SizeOfCoreMatrix=j-1;
            NumberOfCore=round(SizeOfCoreMatrix/3);
            NumberOfNewCore=1;
            i=0;
            Maxiteration=100;
            if NumberOfCore>0
                while i<Maxiteration  && NumberOfNewCore~=0
                    CoreMatixOld=CoreMatix;
                    CoreMatix=RebuiltNormalCell(SizeOfCoreMatrix,CoreMatix);
                    NewCancerCoreMatrix=ReBuiltCancerlCell(NumberOfCore,CancerCoreMatrix,CoreMatix);
                    CoreMatix=Similarity_LCS(CoreMatix,NewCancerCoreMatrix,SizeOfCoreMatrix);
                    [CoreMatix,NumberOfNewCore]=DetectActiveCore(CoreMatix,SizeOfCoreMatrix);
                    CoreMatix=CLA(CoreMatix,SizeOfCoreMatrix,CoreMatixOld);
                    i=i+1;
                end
                
                [ModelCells]=PostProcessing(CoreMatix,SizeOfCoreMatrix,Index,ModelCell);
                [~,NumberOfCell]=size(ModelCells);
                [ModelCells]=DifReg(NumberOfCell,ModelCells);
            else
                ModelCells=struct('CpGs',0,'Location',0,'RegionsNumber',0,'Similarity',[],'DMRs',[],'State',[],'Core',[],'SelectLeftNeighborProb',[],'SelectLeftNeighbor',[],'Alpha',[],'SelectRightNeighborProb',[],'SelectRightNeighbor',[],'Beta',[]);
            end
        else
            ModelCells=ModelCell;
        end
        str=strcat('ModelCells/ModelCells',num2str(chromosome),'_',num2str(sampleNumber),'.mat');
        save(str,'ModelCells');
        clear AvgCpGsModel c CancerCell CancerCoreMatrix CancerCpG CancerCpGOld CancerLoc CancerLocOld Cell
        clear CoreMatix CoreMatixOld EndOfRegion i Index j k lenght LocModel MaxBoundry ModelCell ModelCells
        clear NewCancerCoreMatrix NewModel NextStart NumberOfCell NumberOfCore NumberOfNewCore NumberOfRegion r
        clear RegionsNumberModel SizeOfCoreMatrix Start StartOfRegion x
        %end
    end
end
Final(NumOfCancerSamples,NumOfChromosoms,NumOfNormalSamples);