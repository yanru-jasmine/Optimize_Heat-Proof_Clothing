function TEM=one(length)
xspan=[0 length];
tspan=[0 1000];
ngrid=[1000 20];
if x>0 && x<=0.06
Lambda=0.82;
cp=1377;
rou=300;
else if;
x>0.06 && x<=0.66;
Lambda=3.7;
cp=2100;
rou=862;
else if;
x>0.66 && x<=1.02;
Lambda=0.45;
cp=1726;
rou=74.2
else if
x>1.02 && x<=1.52;
Lambda=0.28
cp=1005;
rou=1.18;

[T,x,t]=rechuandao(a,xspan,tspan,ngrid);

[x,t]=meshgrid(x,t);
figure(1)
mesh(x,t,T);
xlabel('x')
ylabel('t')
zlabel('T')
figure(2)
plot(t(:,20),T(:,20));
xlabel('t')
ylabel('T')
TEM=abs(T(1000,20)-45);

function [U,x,t]=rechuandao(a,xspan,tspan,ngrid)
n=ngrid(1);
m=ngrid(2);
h=range(xspan)/(m-1);
x=linspace(xspan(1),xspan(2),m);
k=range(tspan)/(n-1);
t=linspace(tspan(1),tspan(2),n);
r=a*k/h^2;
if r>0.5
error('为了保证算法的收敛，请增大步长h或减小步长k!')
end
s=1-2*r;
U=zeros(ngrid);
U(1,:)=37;
for j=2:n
for i=2:m-1
U(j,i)=s*U(j-1,i)+r*(U(j-1,i-1)+U(j-1,i+1));
end
U(j,1)=75;
U(j,m)=U(j,m-1);
end