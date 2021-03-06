% This example uses the Levenberg-Marquardt method to determine  
% the coefficients of an inertially and aerodynamically
% symmetric projectile from poor starting conditions. It 
% outputs the iteration results, values for the cost function 
% and the LM factor. 

% Optimal Estimation of Dynamic Systems (2nd ed.) by Crassidis and Junkins
% Example 1.11

% Written by John L. Crassidis 9/03

% Other Required Routines: none

% True Values
k1=0.2;k2=0.1;k3=0.05;k4=0.0001;k5=0.0001;
lam1=-0.1;lam2=-0.05;lam3=-0.025;
w1=0.25;w2=0.5;w3=1.0;
d1=0;d2=0;d3=0;

% Measurements
t=[0:1:25]';m=length(t);
theta=k1*exp(lam1*t).*cos(w1*t+d1)+k2*exp(lam2*t).*cos(w2*t+d2) ...
     +k3*exp(lam3*t).*cos(w3*t+d3)+k4;

psi=k1*exp(lam1*t).*sin(w1*t+d1)+k2*exp(lam2*t).*sin(w2*t+d2) ...
   +k3*exp(lam3*t).*sin(w3*t+d3)+k5;

thetam=theta+0.0002*randn(m,1);
psim=psi+0.0002*randn(m,1);
ym=[thetam;psim];

% Factor for Levenberg-Marquardt Algorithm
fac=1e6;facc(1)=fac;

% Initial Conditions
xc=[0.5;0.25;0.125;0;0;-0.85;-0.06;-0.03;0.26;0.55;0.95;0.01;0.01;0.01];
dx=ones(14,1);i=1;clear xe;xe(1,:)=xc';

%Levenberg-Marquardt Algorithm
while norm(dx)>1e-6,

i=i+1;if (i > 50), break, end

k1e=xc(1);k2e=xc(2);k3e=xc(3);k4e=xc(4);k5e=xc(5);
lam1e=xc(6);lam2e=xc(7);lam3e=xc(8);
w1e=xc(9);w2e=xc(10);w3e=xc(11);
d1e=xc(12);d2e=xc(13);d3e=xc(14);

thetae=k1e*exp(lam1e*t).*cos(w1e*t+d1e)+k2e*exp(lam2e*t).*cos(w2e*t+d2e) ...
      +k3e*exp(lam3e*t).*cos(w3e*t+d3e)+k4e;

psie=k1e*exp(lam1e*t).*sin(w1e*t+d1e)+k2e*exp(lam2e*t).*sin(w2e*t+d2e) ...
    +k3e*exp(lam3e*t).*sin(w3e*t+d3e)+k5e;

h=[exp(lam1e*t).*cos(w1e*t+d1e) ...
   exp(lam2e*t).*cos(w2e*t+d2e) ...
   exp(lam3e*t).*cos(w3e*t+d3e) ones(m,1) zeros(m,1) ...
   k1e*t.*exp(lam1e*t).*cos(w1e*t+d1e) ...
   k2e*t.*exp(lam2e*t).*cos(w2e*t+d2e) ...
   k3e*t.*exp(lam3e*t).*cos(w3e*t+d3e) ...
   -k1e*t.*exp(lam1e*t).*sin(w1e*t+d1e) ...
   -k2e*t.*exp(lam2e*t).*sin(w2e*t+d2e) ...
   -k3e*t.*exp(lam3e*t).*sin(w3e*t+d3e) ...
   -k1e*exp(lam1e*t).*sin(w1e*t+d1e) ...
   -k2e*exp(lam2e*t).*sin(w2e*t+d2e) ...
   -k3e*exp(lam3e*t).*sin(w3e*t+d3e)
   exp(lam1e*t).*sin(w1e*t+d1e) ...
   exp(lam2e*t).*sin(w2e*t+d2e) ...
   exp(lam3e*t).*sin(w3e*t+d3e) zeros(m,1)  ones(m,1) ...
   k1e*t.*exp(lam1e*t).*sin(w1e*t+d1e) ...
   k2e*t.*exp(lam2e*t).*sin(w2e*t+d2e) ...
   k3e*t.*exp(lam3e*t).*sin(w3e*t+d3e) ...
   k1e*t.*exp(lam1e*t).*cos(w1e*t+d1e) ...
   k2e*t.*exp(lam2e*t).*cos(w2e*t+d2e) ...
   k3e*t.*exp(lam3e*t).*cos(w3e*t+d3e) ...
   k1e*exp(lam1e*t).*cos(w1e*t+d1e) ...
   k2e*exp(lam2e*t).*cos(w2e*t+d2e) ...
   k3e*exp(lam3e*t).*cos(w3e*t+d3e)];

dy=ym-[thetae;psie];
jold=sum(dy'*dy);

dx=inv(h'*h + fac*diag(diag(h'*h)))*h'*(ym-[thetae;psie]);
xc=xc+dx;
xe(i,:)=xc';

k1e=xc(1);k2e=xc(2);k3e=xc(3);k4e=xc(4);k5e=xc(5);
lam1e=xc(6);lam2e=xc(7);lam3e=xc(8);
w1e=xc(9);w2e=xc(10);w3e=xc(11);
d1e=xc(12);d2e=xc(13);d3e=xc(14);

thetae=k1e*exp(lam1e*t).*cos(w1e*t+d1e)+k2e*exp(lam2e*t).*cos(w2e*t+d2e) ...
      +k3e*exp(lam3e*t).*cos(w3e*t+d3e)+k4e;

psie=k1e*exp(lam1e*t).*sin(w1e*t+d1e)+k2e*exp(lam2e*t).*sin(w2e*t+d2e) ...
    +k3e*exp(lam3e*t).*sin(w3e*t+d3e)+k5e;
dy=ym-[thetae;psie];
jnew=sum(dy'*dy);

% Update Factor
if jnew < jold 
 fac=fac/5; 
else 
 fac=fac*5; 
end

facc(i)=fac;

cost(i)=.25e8*dy'*dy*0.5;

end

% Show Results
iteration_results=xe
disp(' Press any key to continue')
disp(' ')
pause
cost_fun=cost
disp(' Press any key to continue')
disp(' ')
pause
factor=facc