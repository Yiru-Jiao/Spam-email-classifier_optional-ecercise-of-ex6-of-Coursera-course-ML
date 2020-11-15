% This file should be run first
% Build the vocabulary list
% select all words that occur over n times
n=50;
%------------------------------------------------------
%--------add function path----------------
addpath('SpamFunctions')
%--------read emails and extract a vocabulary----------
File1=dir(fullfile('SpamData','spam'));
File1=File1(3:end);
FileNames1={File1.name}';
File2=dir(fullfile('SpamData','non-spam'));
File2=File2(3:end);
FileNames2={File2.name}';
vocabulary={};
addpath(fullfile('SpamData','spam'));
for i=1:size(FileNames1,1)
    email_contents=readFile(FileNames1{i});
    vocabulary=[vocabulary;extractEmail(email_contents)];
    disp(i)
end
addpath(fullfile('SpamData','non-spam'))
for i=1:size(FileNames2,1)
    email_contents=readFile(FileNames2{i});
    vocabulary=[vocabulary;extractEmail(email_contents)];
    disp(i)
end
%-----------save the original vocabulary-------------------
save('vocabulary','vocabulary')
%----sort and filter words that occur less than n times----
myVocabList=tabulate(vocabulary);
myVocabList=sortrows(myVocabList,-2);
myVocabList=myVocabList(cell2mat(myVocabList(:,2))>=n,1);
eval(['save(''myVocabList_gq' num2str(n) ''',''myVocabList'')'])