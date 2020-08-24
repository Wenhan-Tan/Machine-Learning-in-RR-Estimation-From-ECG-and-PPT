clear all; close all; clc;

%% Computer Experiment 4.6
randn('seed', 0);

m = [-5 5 5 -5; 5 -5 5 -5];
s = 2;
sigma = [0.5 1;2 4];
N = 100;
[x1, y1] = data_generator(m, s, N);

randn('seed', 10);
[x2, y2] = data_generator(m, s, N);
[pe_tr1, pe_te1, svmModel] = SVM_Class(x1, y1, x2, y2);

%% Computer Experiment 4.6 Using Decision Tree Classifier
[pe_tr2, pe_te2] = DT_Class(x1, y1, x2, y2);

%% Computer Experiemnt 4.6 Using Pruned Decision Tree Classifier
[pe_tr3, pe_te3] = PDT_Class(x1, y1, x2, y2);

%% Functions
function [x,y]=data_generator(m,s,n)
    S = s*eye(2);
    [l,c] = size(m);
    x = []; % Creating the training set
    for i = 1:c
        x = [x mvnrnd(m(:,i)',S,n)'];
    end
    y=[ones(1,n) ones(1,n) -ones(1,n) -ones(1,n)];
end

function [pe_tr, pe_te, svmModel]=SVM_Class(x1, y1, x2, y2)
    svmModel = fitcsvm(x1', y1', 'KernelFunction', 'rbf');
    
    train_res = predict(svmModel, x1');
    pe_tr = sum(y1'~=train_res) / length(y1);
    
    test_res=predict(svmModel, x2');
    pe_te=sum(y2'~=test_res) / length(y2);
end

function [pe_tr, pe_te]=DT_Class(x1, y1, x2, y2)
    dtModel = fitctree(x1', y1');
    
    train_res = predict(dtModel, x1');
    pe_tr = sum(y1'~=train_res) / length(y1);
    
    test_res=predict(dtModel, x2');
    pe_te=sum(y2'~=test_res) / length(y2);
    view(dtModel, 'Mode', 'Graph')
end

function [pe_tr, pe_te]=PDT_Class(x1, y1, x2, y2)
    pdtModel = fitctree(x1', y1');
    
    train_res = predict(pdtModel, x1');
    pe_tr = sum(y1'~=train_res) / length(y1);
    
    test_res=predict(pdtModel, x2');
    pe_te=sum(y2'~=test_res) / length(y2);
    view(pdtModel, 'Mode', 'Graph', 'Prune', 1)
end