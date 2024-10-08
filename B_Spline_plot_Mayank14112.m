%--------------------------------------------------------------------------
%                         Plotting B-Spline Curve
%--------------------------------------------------------------------------

clc
clear all
format bank

%--------------------------------------------------------------------------
%                    (1) Taking input for B-Spline curve
%--------------------------------------------------------------------------

n=input('Enter the numbers of points : ');
% X=input('Enter n x coordinates ');
% Y=input('Enter n y coordinates ');
A=ginput(n);                                 % pick n control points graphically using mouse
k=input('Enter the order of curve : ');


for i=1:n
    X(i)=A(i,1);
    Y(i)=A(i,2);
    plot(X,Y,'--*');                          % Ploting control polygon
end
hold on
%--------------------------------------------------------------------------
%                   (2) Code for open uniform knot vector genration
%--------------------------------------------------------------------------

z=1;
for i= 1 : k
    O(i)=0;
end
for i= k+1 : n+1
    O(i)= z;
    z=z+1;
end
z=z-1;
for i= n+2 : k+n
    O(i)=z;
end

%--------------------------------------------------------------------------
%O=input('Knot vector for given n and k :' );   %Taking Knot vector as input
%--------------------------------------------------------------------------

O        

%--------------------------------------------------------------------------
%                    (3) Genrating B-Spline curve
%--------------------------------------------------------------------------

c=0;                                    % To count # of iterations of u
l=k;
for m=k : n                             % Increament in paramatric segment
    
for u = ((O(l))):.01:(O(l+1))           % Increament in each segment
   c=c+1;
for r=2:k
for i= l-k+r:l
    a=(u-O(i))/(O(i+k-r+1)-O(i));
X(r,i)= (1-a)*X(r-1,i-1)+(a)*X(r-1,i);  % Finding point on the curve using Cox-deBoor algorithm
Y(r,i)= (1-a)*Y(r-1,i-1)+(a)*Y(r-1,i);
end
end
ux(c,1)=X(k,l);                         %Storing new set of points on the curve in vectors
uy(c,1)=Y(k,l);
end
l=l+1;
end
axis('equal')

plot(ux,uy);                             % Ploting the B-spline curve

hold on

%--------------------------------------------------------------------------
%                          (4) Knot insertion
%--------------------------------------------------------------------------

l=input('Enter the position l where knot need to insert between l and l+1 : ');

t=input('Enter the knot value : ');

%--------------------------------------------------------------------------

% Producing new knot vector

for i=1 : l
    
    O1(i) = O(i);
end

O1(l+1)=t;

for i=l+2: n+k+1
    
    O1(i)=O(i-1);
    
end

%O1                                  % New Knot vector

%--------------------------------------------------------------------------

%Finding new point for same curve and new knot vector

QX(1,n+1)=(0);

QY(1,n+1)=(0);
for i=l-k+2:l
    a=(t-O(i))/(O(i+k-1)-O(i));     % Knot vector here should be original one
    QX(i)=(1-a)*X(1,i-1)+a*X(1,i);
    QY(i)=(1-a)*Y(1,i-1)+a*Y(1,i);

end

% Replacing new points with old points

for i=1:l-k+1
    QX(i)=X(1,i);
    QY(i)=Y(1,i);
end

for i= l+1:n+1
    QX(i)=X(1,i-1);
    QY(i)=Y(1,i-1);
end
% QX        % New points
% QY        % 


% Copying QX,QY on X and Y respectively

for i=1:n+1
    X(1,i)=QX(1,i);
    Y(1,i)=QY(1,i);
end
X=X(1,:);
Y=Y(1,:);
X1(n+1)=0;
Y1(n+1)=0;
X1=X;
Y1=Y;
X1                               % copying for future use for knot removal 
Y1                               % copying for future use for knot removal 

% Copying O1 to O
for i=1:n+k+1
    O(i)=O1(i);
end

%ploting new points

plot(X,Y,'green--*');
hold on

%--------------------------------------------------------------------------

% Ploting curve after knot insertion


c=0;                                     % To count no. of ittrations of u
l=k;
for m=k : n                              % Increament in paramatric segment
    
for u = ((O(l))):.01:(O(l+1))            % increament in each segment
   c=c+1;
for r=2:k
for i= l-k+r:l
    a=(u-O(i))/(O(i+k-r+1)-O(i));
X(r,i)= (1-a)*X(r-1,i-1)+(a)*X(r-1,i);   % Finding point on the curve using Cox-deBoor algorithm
Y(r,i)= (1-a)*Y(r-1,i-1)+(a)*Y(r-1,i);
end
end
ux(c,1)=X(k,l);                          % Storing point on the curve in vectors
uy(c,1)=Y(k,l);
end
l=l+1;
end
axis('equal')
plot(ux,uy,'red--');

%--------------------------------------------------------------------------
%                        (5) Knot removal
%--------------------------------------------------------------------------

s=input('enter the position from which knot to be remove, such that u(s) not equal to u(s+1):');
u=O(s);                               
m=4;                                  
AX(1,n)=0;
AY(1,n)=0;
i=s-k+1;
j=s-m;

%copying old points on new array set for X

for N=1:i-1
    AX(N)=X1(N);
end

for N=j+1:n
    AX(N)=X1(N+1);
end

%copying old points on new array set for Y

for N=1:i-1
    AY(N)=Y1(N);
end

for N=j+1:n
    AY(N)=Y1(N+1);
end

% Finding new points after knot removal

while(j-i>0)
    a=(u-O(i))/(O(i+k)-O(i));
    b=(u-O(j))/(O(j+k)-O(j));
    
    AX(i)=(X1(i)-(1-a)*AX(i-1))/a;
    AX(j)=(X1(j)-(b)*AX(j-1))/(1-b);
    AY(i)=(Y1(i)-(1-a)*AY(i-1))/a;
    AY(j)=(Y1(j)-(b)*AY(j-1))/(1-b);
    
    i=i+1;
    j=j-1;
end
plot(AX,AY,'Black--*');

AX

AY
 

%--------------------------------------------------------------------------

% ploting new curve after knot removal

O(:,s)=[];                                % Deletion of knot from knot vector
O
c=0;                                      % To count no. of ittrations of u
l=k;
for m=k : n                               % Increament in paramatric segment
    
for u = ((O(l))):.01:(O(l+1))             % Increament in each segment
   c=c+1;
for r=2:k
for i= l-k+r:l
    a=(u-O(i))/(O(i+k-r+1)-O(i));
AX(r,i)= (1-a)*AX(r-1,i-1)+(a)*AX(r-1,i);  % Finding point on the curve using Cox-deBoor algorithm
AY(r,i)= (1-a)*AY(r-1,i-1)+(a)*AY(r-1,i);
end
end
ux(c,1)=AX(k,l);                           % Storing point on the curve in vectors
uy(c,1)=AY(k,l);
end
l=l+1;
end
axis('equal')
plot(ux,uy,'black--');                     % Ploting curve with new points and knot vector


