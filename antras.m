close all 
clear all 
clc  

% Pasirinkti DNT struktura: 
% vienas iejimas x
% pasleptajame sluoksnyje turi buti nuo 4 iki 8 neuronu
% vienas pasleptasis sluoksnis su 5 neuronais
% vienas isejimas y arba d

% 1. Duomenu paruosimas

x = 0.1:1/22:1;
%y = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;

figure(1)
%plot(x,y,'rx')
plot(x,d,'rx')

% 2. Pradiniu parametro reiksmiu generavimas

% 1 sluoksnio rysiu svoriai

w11_1 = randn(1); b1_1 = randn(1);
w21_1 = randn(1); b2_1 = randn(1);
w31_1 = randn(1); b3_1 = randn(1);
w41_1 = randn(1); b4_1 = randn(1);
w51_1 = randn(1); b5_1 = randn(1);

% 2 sluoksnio isejimo rysiu svoriai

w11_2 = randn(1); b1_2 = randn(1);
w12_2 = randn(1);
w13_2 = randn(1);
w14_2 = randn(1);
w15_2 = randn(1);

zingsnis = 0.3;


for index = 1:100000
    for n = 1:20
        % 3. Tinklo atsako apskaiciavimas
        % pirmojo sluoksnio neuronas
        v1_1 = x(n)*w11_1 + b1_1;
        v2_1 = x(n)*w21_1 + b2_1;
        v3_1 = x(n)*w31_1 + b3_1;
        v4_1 = x(n)*w41_1 + b4_1;
        v5_1 = x(n)*w51_1 + b5_1;

        % aktyvavimo funkcijos pritaikymas
        y1_1 = 1/(1+exp(-v1_1));
        y2_1 = 1/(1+exp(-v2_1));
        y3_1 = 1/(1+exp(-v3_1));
        y4_1 = 1/(1+exp(-v4_1));
        y5_1 = 1/(1+exp(-v5_1));

        % pasverta suma isejimo sluoksnyje
        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + b1_2;

        % aktyvavimo funkcijos pritaikymas
        y_apskaiciuota = v1_2;

        % 4. Klaidos apskaiciavimas
        %e = y(n) - y_apskaiciuota; 
        e = d(n) - y_apskaiciuota;

        % 5. Klaidos gradientu apskaiciavimas
        % klaidos gradiento apskaiciavimas isejimo neuronui
        delta_out = e;
        
        % klaidos gradiento apskaiciavimas pasleptojo sluoksnio neuronams
        delta_1_1 = y1_1*(1-y1_1)*(delta_out*w11_2);
        delta_2_1 = y2_1*(1-y2_1)*(delta_out*w12_2);
        delta_3_1 = y3_1*(1-y3_1)*(delta_out*w13_2);
        delta_4_1 = y4_1*(1-y4_1)*(delta_out*w14_2);
        delta_5_1 = y5_1*(1-y5_1)*(delta_out*w15_2);

        % 6. Koefiecientu reiksmiu atnaujinimas
        % svoriu atnaujinimas isejimo sluoksnyje 

        w11_2 = w11_2 + zingsnis*delta_out*y1_1;
        w12_2 = w12_2 + zingsnis*delta_out*y2_1;
        w13_2 = w13_2 + zingsnis*delta_out*y3_1;
        w14_2 = w14_2 + zingsnis*delta_out*y4_1;
        w15_2 = w15_2 + zingsnis*delta_out*y5_1;
        b1_2 = b1_2 + zingsnis*delta_out;

        % svoriu atnaujinimas pasleptajame sluoksnyje 

        w11_1 = w11_1 + zingsnis*delta_1_1*x(n);
        w21_1 = w21_1 + zingsnis*delta_2_1*x(n);
        w31_1 = w31_1 + zingsnis*delta_3_1*x(n);
        w41_1 = w41_1 + zingsnis*delta_4_1*x(n);
        w51_1 = w51_1 + zingsnis*delta_5_1*x(n);
        b1_1 = b1_1 + zingsnis*delta_1_1; 
        b2_1 = b2_1 + zingsnis*delta_2_1; 
        b3_1 = b3_1 + zingsnis*delta_3_1; 
        b4_1 = b4_1 + zingsnis*delta_4_1; 
        b5_1 = b5_1 + zingsnis*delta_5_1;

    end
end

for m = 1:20
    % tinklo atsako apskaiciavimas
    % pirmojo sluoksnio neuronas
    v1_1 = x(m)*w11_1 + b1_1; 
    v2_1 = x(m)*w21_1 + b2_1;
    v3_1 = x(m)*w31_1 + b3_1;
    v4_1 = x(m)*w41_1 + b4_1;
    v5_1 = x(m)*w51_1 + b5_1;

    % aktyvavimo funkcijos pritaikymas
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    y5_1 = 1/(1+exp(-v5_1));

    % pasverta suma isejimo sluoksnyje
    v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + b1_2;

    % aktyvavimo funkcijos pritaikymas
    y_apskaiciuota(m) = v1_2;

end

figure(2)
%plot(x,y,'rx',x,y_apskaiciuota,'bx')
plot(x,d,'rx',x,y_apskaiciuota,'bx')






       









