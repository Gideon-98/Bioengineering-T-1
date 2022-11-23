load 'Mk_manubrio.txt';

fr = Mk_manubrio(:,1);
t = Mk_manubrio(:,2);
%marker 0 (spalla)
mk0x = Mk_manubrio(:,3);
mk0y = Mk_manubrio(:,4);
mk0z = Mk_manubrio(:,5);
%marker 1 (gomito)
mk1x = Mk_manubrio(:,6);
mk1y = Mk_manubrio(:,7);
mk1z = Mk_manubrio(:,8);
%marker 2 (manubrio)
mk2x = Mk_manubrio(:,9);
mk2y = Mk_manubrio(:,10);
mk2z = Mk_manubrio(:,11);

%% grafico movimento dei 3 marker lungo x e y nel tempo

figure (1)
subplot(3,1,2);
plot(t,mk0y,t,mk1y,t,mk2y,'linewidth',1);
title('Componente lungo y');
xlabel('Tempo[s]');
ylabel('Posizione Marker[mm]');
legend('Spalla','Gomito','Manubrio');
subplot(3,1,1);
plot(t,mk0x,t,mk1x,t,mk2x,'linewidth',1);
title('Componente lungo x');
xlabel('Tempo[s]');
ylabel('Posizione Marker[mm]');
legend('Spalla','Gomito','Manubrio');
%% stima dell'angolo di flesso-estensione al gomito nel tempo

ps= sqrt(((mk2x-mk0x).^2)+(mk2y-mk0y).^2); %distanza manubrio-spalla
pg= sqrt(((mk2x-mk1x).^2)+(mk2y-mk1y).^2); %distanza manubrio-gomito
gs= sqrt(((mk1x-mk0x).^2)+(mk1y-mk0y).^2); %distanza gomito-spalla

beta= acos(((-(ps).^2)+((pg.^2)+gs.^2))./(2*(pg.*gs)));%angolo supplementare all'angolo di flesso-estensione
betag= beta*180/pi;%angolo in gradi
alfa= 180- betag;%angolo di flesso-estensione (in gradi)
subplot(3,1,3);
plot(t,alfa);
title('Angolo di flesso-estensione');
xlabel('Tempo[s]');
ylabel('Ampiezza angolo[°]');
%% incominciamo a fare le derivate in x e y e alfa

dt = diff(t); %troviamo dt utile a fare le derivate

%deriviamo con la definizione di rapporto incrementale

dmk2y = diff(mk2y);%troviamo la derivata della posizione
v_mk2y = dmk2y./dt;%troviamo la velocità
dv_mk2y = diff(v_mk2y);%troviamo la derivata della velocità
a_mk2y = dv_mk2y./dt(2:end);%troviamo la accellerazione

%da notare che man mano che aumento perdo un punto per ogni derivata

%incomincio con in filtraggi
v_mk2y_f = movmean(v_mk2y,100);%filtraggio su v
a_mk2y_f = movmean(a_mk2y,100);%filtraggio su a 

%grafico il tutto
figure (2)
subplot(3,1,1);
plot(t,mk2y,'linewidth',1);
title('Posizione lungo y');
xlabel('Tempo[s]');
ylabel('Posizione[mm]');
subplot(3,1,2);
plot(t(2:end),v_mk2y,'linewidth',0.5);
hold on;
plot(t(2:end),v_mk2y_f,'linewidth',1.5);
title('Velocità lungo y');
xlabel('Tempo[s]');
ylabel('Velocità [mm/s]');
legend('Vel','Vel Filtrata');
subplot(3,1,3);
plot(t(3:end),a_mk2y,'linewidth',0.5);
hold on;
plot(t(3:end),a_mk2y_f,'linewidth',2);
title('Accellerazione lungo y');
xlabel('Tempo[s]');
ylabel('Accellerazione [mm/s^2]');
legend('Acc','Acc Filtrata');

%derivate su x
dmk2x = diff(mk2x);%troviamo la derivata della posizione
v_mk2x = dmk2x./dt;%troviamo la velocità
dv_mk2x = diff(v_mk2x);%troviamo la derivata della velocità
a_mk2x = dv_mk2x./dt(2:end);%troviamo la accellerazione
%incomincio con in filtraggi
v_mk2x_f = movmean(v_mk2x,100);%filtraggio su v
a_mk2x_f = movmean(a_mk2x,100);%filtraggio su a 

%grafico il tutto
figure (3)
subplot(3,1,1);
plot(t,mk2x,'linewidth',1);
title('Posizione lungo x');
xlabel('Tempo[s]');
ylabel('Posizione[mm]');
subplot(3,1,2);
plot(t(2:end),v_mk2x,'linewidth',0.5);
hold on;
plot(t(2:end),v_mk2x_f,'linewidth',1.5);
title('Velocità lungo x');
xlabel('Tempo[s]');
ylabel('Velocità [mm/s]');
legend('Vel','Vel Filtrata');
subplot(3,1,3);
plot(t(3:end),a_mk2x,'linewidth',0.5);
hold on;
plot(t(3:end),a_mk2x_f,'linewidth',2);
title('Accellerazione lungo x');
xlabel('Tempo[s]');
ylabel('Accellerazione [mm/s^2]');
legend('Acc','Acc Filtrata');

%derivate su alfa
dalfa = diff(alfa);%troviamo la derivata di alfa
v_alfa = dalfa./dt;%troviamo la velocità
dv_alfa = diff(v_alfa);%troviamo la derivata della velocità
a_alfa = dv_alfa./dt(2:end);%troviamo la accellerazione
%incomincio con in filtraggi
v_alfa_f = movmean(v_alfa,100);%filtraggio su v
a_alfa_f = movmean(a_alfa,100);%filtraggio su a

%grafico il tutto
figure (4)
subplot(3,1,1);
plot(t,alfa,'linewidth',1);
title('Ampiezza alfa');
xlabel('Tempo[s]');
ylabel('Posizione[°]');
subplot(3,1,2);
plot(t(2:end),v_alfa,'linewidth',0.5);
hold on;
plot(t(2:end),v_alfa_f,'linewidth',1.5);
title('Velocità angolare');
xlabel('Tempo[s]');
ylabel('Velocità angolare [°/s]');
legend('Vel','Vel Filtrata');
subplot(3,1,3);
plot(t(3:end),a_alfa,'linewidth',0.5);
hold on;
plot(t(3:end),a_alfa_f,'linewidth',2);
title('Accellerazione angolare y');
xlabel('Tempo[s]');
ylabel('Accellerazione angolare[°/s^2]');
legend('Acc','Acc Filtrata');
%% ora scrviamo le equazioni cardinal della dinamica
%troviamo le reazioni vincolari del gomito
% Ipotesi semplificative: Fmuscolare in direzione x trascurabile e C= 4 per
% parametri antropometrici trovati su dispensa (esercizio). inoltre si
% trascura inerzia del braccio
% massa della cavia pari a 57kg

c=40; %braccio di azione della forza muscolare
a=sum(pg,'all')/length(pg); %distanza media Centro di massa del manubrio-Gomito
b=0.57*a; %distanza Centro di Massa del braccio-Gomito

g=9.81;

Mman=5; %Massa manubrio
Mbraccio=1.144; %Massa braccio

Fb=Mbraccio*g;%peso del braccio
Fp=Mman*g;%peso del manubrio
Jtot= (Mman*a^2+Mbraccio*b^2)/10^6; %10^6 

%calcolo delle forze e momenti con accellerazioni non filtrate
Fart_x = ((-Mman*a_mk2x))/10^3; %forza articolare lungo x
Fart_y= ((Fb+Fp)*ones(6947,1)+Mman*a_mk2y)/10^3; %forza articolare lungo y
Mart= Jtot*a_alfa/10^3; %momento non filtrato


%calcolo delle forze e momenti con accellerazioni filtrate
Fart_x_f = ((-Mman*a_mk2x_f))/10^3; %forza articolare lungo x
Fart_y_f= ((Fb+Fp)*ones(6947,1)+Mman*a_mk2y_f)/10^3; %forza articolare lungo y
Mart_f= Jtot*a_alfa_f/10^3; %momento filtrato

%grafichiamo

figure (5)
subplot(3,1,1);
plot(t(3:end),Fart_x);
hold on;
plot(t(3:end),Fart_x_f,'linewidth',2);
title('Forza articolare lungo x');
xlabel('Tempo[s]');
ylabel('Forza articolare [N]');
legend('F.art','F.art Filtrata');
subplot(3,1,2);
plot(t(3:end),Fart_y);
hold on;
plot(t(3:end),Fart_y_f,'linewidth',2);
title('Forza articolare lungo y');
xlabel('Tempo[s]');
ylabel('Forza articolare [N]');
legend('F.art','F.art Filtrata');
subplot(3,1,3);
plot(t(3:end),Mart);
hold on;
plot(t(3:end),Mart_f,'linewidth',2);
title('Momento articolare');
xlabel('Tempo[s]');
ylabel('Momento articolare [N*m]');
legend('M.art','M.art Filtrato');


%da notare la differenza nei due casi, uno contiene picchi l'altro no
%i picchi dati dalle accellerazioni che contenevano molto rumore

%% Calcoliamo le variazioni della componente AP(anteroposteriore)

load 'F_manubrio.txt';

%frame e tempo sulla forza
fr_1 = F_manubrio(:,1);
t_1 = F_manubrio(:,2);
%coordinate della forza
fx = F_manubrio(:,3);
fy = F_manubrio(:,4);
fz = F_manubrio(:,5);
% grafici variazione delle tre componenti della forza nel tempo
figure (6)
subplot(2,1,1);
plot(t_1,fx);
title('Componente APx');
xlabel('Tempo[s]');
ylabel('Fx [N]');
subplot(2,1,2);
plot(t_1,fy);
title('Componente APy');
xlabel('Tempo[s]');
ylabel('Fy [N]');
%% calcoliamo lo spostamento AP(anteroposteriore) del COP
load 'COP_manubrio.txt';

%frame e tempo scanditi sulla COP
fr_2 = COP_manubrio(:,1);
t_2 = COP_manubrio(:,2);
%coordinate della forza
COPx = COP_manubrio(:,3);
COPy = COP_manubrio(:,4);
COPz = COP_manubrio(:,5);
% grafici variazione della componente x e y del COP nel tempo
figure (7)
subplot(2,1,1);
plot(t_2,COPx);
title('Componente APx del COP');
xlabel('Tempo[s]');
ylabel('COPx [mm]');
subplot(2,1,2);
plot(t_2,COPx);
title('Componente APy del COP');
xlabel('Tempo[s]');
ylabel('COPy[mm]');
