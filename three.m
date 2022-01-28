clc; 
clear all; 
close all; 
global BitLength 
global boundsbegin 
global boundsend 
bounds=[22.50 23.88]; 
precision=0.0001; 
boundsbegin=bounds(:,1); 
boundsend=bounds(:,2); 
BitLength=ceil(log2((boundsend-boudsbegin)'./precision)); 
popsize=50; 
Generationnmax=12; 
pcrossover=0.90; 
pmutation=0.09; 
population=round(rand(popsize,BitLength)); 
[Fitvalue,cumsump]=fitnessfun(population); 
Generation=1; 
while Generation<Generationnmax+1 
for j=1:2:popsize 
seln=selection(population,cumsump); 
scro=crossover(population,seln,pcrossover); 
scnew(j,:)=scro(1,:); 
scnew(j+1,:)=scro(2,:); 
smnew(j,:)=mutation(scnew(j,:),pmutation); 
smnew(j+1,:)=mutation(scnew(j+1,:),pmutation); 
end 
population=smnew; 
[Fitvalue,cumsump]=fitnessfun(population); 
[fmax,nmax]=max(Fitvalue); 
fmean=mean(Fitvalue); 
ymax(Generation)=fmax; 
ymean(Generation)=fmean; 
x=transform2to10(populaton(nmax,:)); 
xx=boundsbegin+x*(boundsend-boundsbegin)/(power((boundsend),BitLength)-1); 
xmax(Generation)=xx; 
Generation=Generation+1; 
end 
Generation=Generation-1; 
Bestpopulation=xx; 
Besttargetfunvalue=targetfun(xx); 
figure(1); 12; 
hand1=plot(1:Generation,ymean); 
set(hand1,'linestyle','-','linewidth',1.8,'marker','*','markersize',6) 
hold on; 
hand2=plot(1:Generation,ymean); 
set(hand2,'color','r','linestyle','-','linewidth',1.8,...'marker','h','markersize',6) 
xlabel('进化代数');ylabel('最大/平均适应度');xlim([1 Generationnmax]); 
legend('最大适应度','平均适应度');xlim([1 Generationnmax]); 
legend('最大适应度','平均适应度'); 
box off;hold off; 
function scro=crossover(population,seln,pc) 
BitLength=size(population,2); 
pcc=IfCroIfMut(pc); 
if pcc==1 
chb=round(rand*(BitLength-2))+1; 
scro(1,:)=[population(seln(1),1:chb) population(seln(2),chb+1:BitLength)]; 
scro(2,:)=[population(seln(2),1:chb) population(seln(1),chb+1:BitLength)]; 
else 
scro(1,:)=population(seln(1),:); 
scro(2,:)=population(seln(2),:); 
end 

function[Fitvalue,cumsump]=fitnessfun(population) 
global BitLength 
global boundsbegin 
global boundsend 
popsize=size(population,1); 
for i=1:popsize 
x=transform2to10(population(i,:)); 
xx=boundsbegin+x*(boundsend-boundbegin)/(power((boundsend),BitLength)-1); 
Fitvalue(i)=targetfun(xx); 
end 
Fitvalue=Fitvalue'+230; 
fsum=sum(Fitvalue); 
Pperpopulation=Fitvalue/fsum; 
cumsump(1)=Pperpopulation(1); 
for i=2:popsize 
cumsump(i)=cumsump(i-1)+Pperpopulation(i); 13; 
end 
cumsump=cumsump'; 

function snnew=mutation(snew,pmutation) 
BitLength=size(snew,2); 
snnew=snew; 
pmm=IfCroIfMut(pmutation); 
if pmm=1 
chb=round(rand*(BitLength-1))+1; 
snnew(chb)=abs(snew(chb)-1); 
end 

function pcc=IfCroIfMut(~) 
text(1:100)=0; 
1=round(100*mutORcro); 
text(1:1)=1; 
n=round(rand*99)+1; 
pcc=text(n); 

function seln=selection(~,cumsump) 
for i=1:2 
r=rand; 
prand=cumsump-r; 
j=1; 
while prand(j)<0 
j=j+1; 
end 
seln(i)=j; 
end 

function x=transform2to10(Population) 
BitLength=size(Population,2); 
x=Population(BitLength); 
for i=1:BitLength-1 
x=x+Population(BitLength-i)*power(2,i); 
end 
function y=targetfun(~) 
y=(0.6982-0.0892+0.7103)x;
