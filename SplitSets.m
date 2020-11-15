% This file shoud be run after VocabList.m
% 1) extract word features according to vocabList
% 2) split data set and split train/test sets
% Vocabulary list has words whose frequencies are over n times
n=50; % in line with the n in the VocabList.m
%--------------------------------------------------------
%--------add function path----------------
addpath('SpamFunctions')
%-----------load the vocabulary list---------------------
eval(['load(''myVocabList_gq' num2str(n) '.mat'')']);
%-----------read emails and extract features-------------
File1=dir(fullfile('SpamData','spam'));
File1=File1(3:end);
FileNames1={File1.name}';
File2=dir(fullfile('SpamData','non-spam'));
File2=File2(3:end);
FileNames2={File2.name}';

X1=zeros(size(FileNames1,1),length(myVocabList)); % part 1 of X are spam
X2=zeros(size(FileNames1,1),length(myVocabList)); % part 2 of X are non-spam
y0=[ones(size(FileNames1,1),1);zeros(size(FileNames2,1),1)];
addpath(fullfile('SpamData','spam'));
for i=1:size(FileNames1,1)
    file_contents=readFile(FileNames1{i});
    word_indices=myProcessEmail(myVocabList,file_contents);
    features=zeros(1,length(myVocabList));
    features(word_indices)=1;
    X1(i,:)=features;
    disp(i)
end
addpath(fullfile('SpamData','non-spam'));
for i=1:size(FileNames2,1)
    file_contents=readFile(FileNames2{i});
    word_indices=myProcessEmail(myVocabList,file_contents);
    features=zeros(1,length(myVocabList));
    features(word_indices)=1;
    X2(i,:)=features;
    disp(i)
end
X0=[X1;X2];
%----------------save original X and y--------------------
%--to make it easier to spilt sets in other proportions---
eval(['save(''X0y0_gq' num2str(n) ''',''X0'',''y0'')']);

%------Split training set (70%) and test set (30%)--------
train_indices=randperm(length(y0),round(0.7*length(y0)));
X=X0(train_indices,:);
y=y0(train_indices,:);
eval(['save(''myTrainSet_gq' num2str(n) ''',''X'',''y'')']);
Xtest=X0;
Xtest(train_indices,:)=[];
ytest=y0;
ytest(train_indices,:)=[];
eval(['save(''myTestSet_gq' num2str(n) ''',''Xtest'',''ytest'')']);