close all; clear all; clc;
randn('seed', 0); rand('seed', 0);

bw=GetRandomEllipseImage(1);
imagesc(bw)

[r,c]=find(bw);

x = r - mean(r);
y = c - mean(c);

[U,S,V] = svd([x,y],'econ');
xyp = [x y]*V;

plot(xyp(:,1), xyp(:,2), '.');
hold on;

r1 = max(xyp(:, 1));
r2 = max(xyp(:, 2));

theta=linspace(0,2*pi,1000);
cXp = r1*sin(theta)';
cYp=  r2*cos(theta)';
plot(cXp, cYp, '-b');
hold on;

cXY = [cXp cYp]/V;
plot(cXY(:, 1), cXY(:, 2));
hold on
plot(x, y, '.');