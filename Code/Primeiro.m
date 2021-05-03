clc
close all

Y=load('BancoDeDados.mat')
x=Y.x;
limiar=250; %limiar de amplitude QRS
tempo=length(x)/77;%tempo total do sinal, numero de amostras sobre taxa de amostragem 


figure,plot(x)   %plota o sinal
ylabel('Amplitude do Sinal(mV)')
xlabel('Amostras')
title('Sinal ECG')
Xw=fftshift(fft(x));%transformada do sinal
figure, plot(linspace(-pi,pi,length(Xw)),abs(Xw))
ylabel('Valor Absoluto')
xlabel('Frequência(w)')
title('Transformada de Fourier do Sinal')
 
 %filtragem
[B,A] = butter(10,0.3/pi); %fltro ordem 10 freq de corte 0,3
[H,W] = freqz(B,A,length(x));
figure,plot(W,abs(H))
x_filt = filter(B,A,x);  %filtragem do sinal
figure,plot(real(x_filt))

ylabel('Amplitude do Sinal(mV)')
xlabel('Amostras')
title('Sinal ECG filtrado')

batimentos=0;
i=1;
while i<length(x_filt)  %conta a quantidade de batimentos
     if x_filt(i)<limiar
        batimentos=batimentos+1;
        i=i+25;
     else 
         i=i+1;
     end     
end


if batimentos/tempo<1 %braquicardia
    1
elseif batimentos>tempo*5/3 %taquicardia
    0
else %normal
    2
end



