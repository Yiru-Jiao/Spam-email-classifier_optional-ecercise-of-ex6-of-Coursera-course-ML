% This file shoud be run after VocabList.m and SplitSets.m
% Vocabulary list has words whose frequencies are over n times
n=50; % in line with the n in the VocabList.m
%---------------------------------------------------
%------------------add function path----------------
addpath('SpamFunctions')
%-----------------load Train Set--------------------
eval(['load(''myTrainSet_gq' num2str(n) '.mat'')']);

%---------X, y will be in the environment-----------
C=0.1; % regularizing parameter
model=svmTrain(X,y,C,@linearKernel); % The function svmTrain and svmPredict
                                     % are obtained from the coursework of
                                     % the coursera course 'mechine learning'
                                     % of Andrew Ng.
                                     % According to his advice, they are not
                                     % suitable for more large scale training.

%---------------training accuracy--------------------
p=svmPredict(model,X);
fprintf('Training Accuracy: %f\n',mean(double(p==y))*100);

%-----------------load Test Set----------------------
eval(['load(''myTestSet_gq' num2str(n) '.mat'')']);

%------Xtest, ytest will be in the environment-------
p = svmPredict(model, Xtest);
fprintf('Test Accuracy: %f\n', mean(double(p==ytest))*100);
%---Sort the weights and obtain the vocabulary list---
[weight, idx] = sort(model.w, 'descend');
eval(['load(''myVocabList_gq' num2str(n) '.mat'')']);
for i = 1:10
    if i == 1
        fprintf('Top predictors of spam: \n');
    end
    fprintf('%-15s (%f) \n', myVocabList{idx(i)}, weight(i));
end