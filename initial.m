%% Create necessary folders
clc
clear all
mkdir('Cancer');
mkdir('DMRs');
mkdir('ModelCells');
mkdir('models');
mkdir('Treatment');
NumOfTreatmentSamples=input('Please Enter The Number Of Normal Samples: ');
NumOfCancerSamples=input('Please Enter The Number Of Cancer Samples: ');
for i=1:NumOfCancerSamples
    str=strcat('Sample',num2str(i))
    mkdir('Cancer/',str);
end
for i=1:NumOfTreatmentSamples
    str=strcat('Sample',num2str(i))
    mkdir('Treatment/',str);
end