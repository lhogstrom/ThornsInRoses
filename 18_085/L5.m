%% Class 5: 
% Alex Townsend, 24th Feb 2015
%        ajt@mit.edu

%% Height and weight data in pounds and inches. 
data = LoadBMIData;   % Data is of children in Hong Kong. 
                      % Adult BMI data may differ!!! 
height = data(:,2); 
weight = data(:,3);

BMI = 703*weight./height.^2; 
[mx, idx1] = max(BMI); 
[mn, idx2] = min(BMI); 

plot(height, weight,'k.','markersize',3), hold on
plot(height(idx1),weight(idx1),'.r','markersize',20)
plot(height(idx2),weight(idx2),'.b','markersize',20)
xlabel('Height in inches'), axis([60 75 60 180])
ylabel('Weight in lb') 
set(gca,'fontsize',16)

%% BMI curves (Healthy range)
t = linspace(60,75);
plot(t, 16/703*t.^2,'r-','linewidth',2)
plot(t, 23/703*t.^2,'r-','linewidth',2)
shg
%% Height is a normal curve:
hold off
histogram(height, 'Normalization', 'pdf') 
xlabel('Height in inches')
set(gca,'fontsize',16)

%% Medical BMI = weight/(C*height^2)
A = height.^2; 
[Q, R] = qr( A, 0 ); 
y = Q'*weight; 
x = R \ y;

plot(height, weight,'k.','markersize',3), hold on
plot(height(idx1),weight(idx1),'.r','markersize',20)
plot(height(idx2),weight(idx2),'.b','markersize',20)
t = linspace(60,75);
plot(t, 16/703*t.^2,'r-','linewidth',2)
plot(t, 23/703*t.^2,'r-','linewidth',2)
xlabel('Height in inches') 
ylabel('Weight in lb') 
set(gca,'fontsize',16), axis([60 75 60 180])
t = linspace(min(height), max(height)); 
plot(t, x*t.^2,'b-','linewidth',3)
lsq_error = norm( weight - x.*height.^2, 2 ) 

%% What about: weight/( A + B*height + C*height^2 )
A = [ones(numel(height),1) height height.^2]; 
[Q, R] = qr( A, 0 ); 
y = Q'*weight; 
x = R \ y;

plot(height, weight,'k.','markersize',3), hold on
plot(height(idx1), weight(idx1),'.r','markersize',20)
plot(height(idx2), weight(idx2),'.b','markersize',20)
t = linspace(60,75);
plot(t, 16/703*t.^2,'r-','linewidth',2)
plot(t, 23/703*t.^2,'r-','linewidth',2)
xlabel('Height in inches') 
ylabel('Weight in lb') 
set(gca,'fontsize',16), axis([60 75 60 180])
t = linspace(min(height), max(height)); 
plot(t, x(1) + x(2)*t + x(3)*t.^2,'g-','linewidth',3)
lsq_error = norm( weight - A * x, 2 ) 

%% Or weight/( A + B*height + C*height^2+D*height^3 )
A = [ones(numel(height),1) height height.^2 height.^3]; 
[Q, R] = qr( A, 0 ); 
y = Q'*weight; 
x = R \ y;

plot(height, weight,'k.','markersize',3), hold on
plot(height(idx1), weight(idx1),'.r','markersize',20)
plot(height(idx2), weight(idx2),'.b','markersize',20)
t = linspace(60,75);
plot(t, 16/703*t.^2,'r-','linewidth',2)
plot(t, 23/703*t.^2,'r-','linewidth',2)
xlabel('Height in inches') 
ylabel('Weight in lb') 
set(gca,'fontsize',16), axis([60 75 60 180])
t = linspace(min(height), max(height)); 
plot(t, x(1) + x(2)*t + x(3)*t.^2 + x(4)*t.^3,'m-','linewidth',3)

lsq_error = norm( weight - A * x, 2 )  


%% BMI 
A = [height.^1.65]; 
[Q, R] = qr( A, 0 ); 
y = Q'*weight; 
x = R \ y;

plot(height, weight,'k.','markersize',3), hold on
plot(height(idx1), weight(idx1),'.r','markersize',20)
plot(height(idx2), weight(idx2),'.b','markersize',20)
t = linspace(60,75);
plot(t, 16/703*t.^2,'r-','linewidth',2)
plot(t, 23/703*t.^2,'r-','linewidth',2)
xlabel('Height in inches') 
ylabel('Weight in lb') 
set(gca,'fontsize',16), axis([60 75 60 180])
t = linspace(min(height), max(height)); 
plot(t, x(1)*t.^1.65,'m-','linewidth',3)

norm( weight - A * x, 2 ) 

%% Townsend's BMI formula for Hong Kong children :p 
%  BMI = weight/(A + Bheight^(1/2) + Cheight + Dheight^1.5 + Eheight^2)
% Make up your own formula: 

A = bsxfun(@power, height, 0:.5:2);
[Q, R] = qr( A, 0 ); 
y = Q'*weight; 
x = R \ y;

plot(height, weight,'k.','markersize',3), hold on
plot(height(idx1), weight(idx1),'.r','markersize',20)
plot(height(idx2), weight(idx2),'.b','markersize',20)
t = linspace(60,75);
plot(t, 16/703*t.^2,'r-','linewidth',2)
plot(t, 23/703*t.^2,'r-','linewidth',2)
xlabel('Height in inches') 
ylabel('Weight in lb') 
set(gca,'fontsize',16), axis([60 75 60 180])
t = linspace(min(height), max(height))'; 
plot(t, bsxfun(@power, t, 0:.5:2)*x ,'m-','linewidth',3)
lsq_error = norm( weight - A * x, 2 ) 

%% Rotation by theta: 
theta = pi/2; 
Q = [cos(theta) -sin(theta); sin(theta) cos(theta)]; 
x = randn(2,1); x = x./norm(x);  

plot( [0 x(1) + 1i*x(2)],'linewidth',2 ), hold on, 
y = Q*x; 
plot( [0 y(1) + 1i*y(2)],'linewidth',2 ), hold on, 
t = linspace(0,2*pi); plot( exp(1i*t),'k-','linewidth',2)
axis(1.1*[-1 1 -1 1]), axis equal
set(gca,'fontsize',16), hold off

%% QR for rectangular matrices 
A = rand(5,2); 
[Q,R] = qr(A); 

%% Incredible: It's Francis' algorithm (essentially 
% a top ten algorithm of the 1900s) 
A = randn( 100 ); A = (A + A')/2;
for k = 1:250
    [Q, R] = qr( A ); 
    A = R * Q; 
    spy(abs(A)>1e-3), 
    title('What is going on?','fontsize',20)
    drawnow, shg, pause(.01)
end

%% Take a look at diagonal and eigenvalues: 
for k = 1:1000 
    [Q, R] = qr( A ); 
    A = R * Q; 
end
[sort(diag(A)) sort(eig(A))]