% DeGroot_1974_examples
% Written by Michael Hatcher
% Based on DeGroot (1974), Reaching a Consensus, JASA

clc; clear; close all

% Calibration
N = 20;  %No. of simulated periods

%Example 1 
%T = [0.5 0.5; 0.25 0.75];  p = [0; 1]; 
%Example 2
%T = [0.5 0.5 0; 0.25 0.75 0; 1/3 1/3 1/3]; p = [0; 1; 0.5];
%Example 3
%T = [0.5 0.5 0 0; 0.5 0.5 0 0; 0 0 0.5 0.5; 0 0 0.5 0.5];
%p = [0 1; 0.5; 0.2];
%Example 4
%T = [1 0; 0 1]; p = [0; 1];

%Example 5
n = 8; %Size of network (Ex. 5)
T0 = rand(n); p = rand(n,1); 
for i=1:n 
    for j=1:n 
  T(i,j) = T0(i,j)/sum(T0(i,1:n));
    end
end

pnew = p; I = eye(length(p));
vec1 = ones(1,length(p));
vec0 = zeros(length(p),1);

% Stationary prob. vector (weights in final consensus) 
w = transpose([ T'-I; vec1 ] \ [ vec0; 1 ]);   
p_end = w*pnew;    %Terminal belief vector

for t=1:N

    pnew = T*pnew;
    
    for i=1:length(p)
        pe(i,t) = pnew(i);  %Dynamics
    end

end

disp('Terminal belief vector is')
pnew
Check = p_end - pnew;
if sum(Check)/length(Check) < 1e-10
    disp('Stationary prob vector is') 
    w
end

pe = [p pe];   %Inc. initial belief in plot

figure(1)
for i=1:length(pnew)
plot(pe(i,1:N+1)), hold on
end
title('Individual beliefs'), xlabel('Time')
