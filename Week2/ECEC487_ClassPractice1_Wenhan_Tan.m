clear all; close all; clc;

[x, y] = meshgrid(-5:0.1:5, -5:0.1:5);
z = mvnpdf([x(:), y(:)], [0, 0], [0.1, 0; 0, 0.1]);
% z = reshape(z, size(x));
% surf(x, y, z);
% value of pd of point z is 1.5915