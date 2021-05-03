clc
close all
x=load('BancoDeDadosPDSDef.mat');
M=x.Mat;
figure, plot(M(1,1:3600));
figure, plot(M(51,1:3600));
M = M(randperm(size(M,1)),:); %mistura as linhas

for i=1:100 %faz a FT  do sinal
Xw=fftshift(fft(M(i,1:3600)));%transformada do sinal
M(i,1:3600)=abs(Xw);
end

%perceptron 1 camada 90% treino 10% teste
net=perceptron;
net=train(net,M(1:90,1:3600)',M(1:90,3601)'); %treino

erro=0;
%teste
for k=91:100
   valor_real=M(k,3601)
   resultado = net(M(k,1:3600)')   
   erro=abs(valor_real-resultado)+erro;
end
taxa_erro=erro/10;