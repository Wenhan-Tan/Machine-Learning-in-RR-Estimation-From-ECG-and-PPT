close all; clear all; clc;
%% Problem 8.1
[edit_cost, pred] = edit_distance('poem', 'poten');
x = [0 1 2 3 3 4];
y = [0 1 2 3 4 5];
plot(x, y);
grid on;
title('Edit Distance');
xlabel('poem');
ylabel('poten');

%% evalclusters
x1 = normrnd(0.00001, 1, [10, 1]);
x2 = normrnd(-0.00001, 1, [10, 1]);
eva = evalclusters([x1, x2], 'kmeans','gap','KList', [1:2]);

%% Functions
function [edit_cost,pred]=edit_distance(ref_str,test_str)
    I = length(ref_str);
    J = length(test_str);
    D = zeros(J,I);
    %Initialization
    D(1,1) = ~(ref_str(1) == test_str(1));
    pred(1,1) = 0;
    for j = 2:J
        D(j,1) = D(j-1,1)+1;
        pred(j,1) = (j-1) + sqrt(-1)*1;
    end
    for i = 2:I
        D(1,i) = D(1,i-1)+1;
        pred(1,i) = 1+ sqrt(-1)*(i-1);
    end
    %Main Loop
    for i = 2:I
        for j = 2:J
            if(ref_str(i) == test_str(j))
                d(j,i) = 0;
            else
                d(j,i) = 1;
            end
            c1 = D(j-1,i-1)+d(j,i); c2 = D(j,i-1)+1; c3 = D(j-1,i)+1;
            [D(j,i),ind] = min([c1 c2 c3]);
            if(ind == 1)
                pred(j,i) = (j-1)+sqrt(-1)*(i-1);
            elseif(ind == 2)
                pred(j,i) = j+sqrt(-1)*(i-1);
            else
                pred(j,i) = (j-1)+sqrt(-1)*i;
            end
        end
    end
    edit_cost = D(J,I);
end