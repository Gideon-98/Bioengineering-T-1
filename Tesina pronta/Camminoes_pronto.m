%CAMMINO
load cammino.txt

%Nel test eseguito si considerano solo i valori temporali in cui si hanno
%le coordinate di tutti i marker, dato che il soggetto in alcuni istanti
%esce dal volume di calibrazione 

%Vettori delle coordinate del marker0 sull'acromion
Mk0x=cammino(713:1883,3);
Mk0y=cammino(713:1883,4);
Mk0z=cammino(713:1883,5);

%Vettori delle coordinate del marker1 sul grande trocantere
Mk1x=cammino(713:1883,6);
Mk1y=cammino(713:1883,7);
Mk1z=cammino(713:1883,8);

%Vettori delle coordinate del marker2 sull'epicondilo laterale
Mk2x=cammino(713:1883,9);
Mk2y=cammino(713:1883,10);
Mk2z=cammino(713:1883,11);

%Vettori delle coordinate del marker3 sul malleolo laterale
Mk3x=cammino(713:1883,12);
Mk3y=cammino(713:1883,13);
Mk3z=cammino(713:1883,14);

t=cammino(713:1883,2); %vettore degli istanti di tempo in cui sono prese le misurazioni

%Consideriamo costante lo spostamento lungo l'asse x
L1y= Mk0y-Mk1y;%distanza acromiom-trocantere y
L1z= Mk0z-Mk1z;%distanza acromiom-trocantere Z
Teta1=(180/pi)*(atan2(-L1z,L1y));%angolo acromiom-trocantere

L2y= Mk1y-Mk2y;%distanza trocantere-epicondilo y
L2z= Mk1z-Mk2z;%distanza trocantere-epicondilo z
Teta2=(180/pi)*(atan2(L2z,L2y));%angolo trocantere-epicondilo

L3y= Mk2y-Mk3y;%distanza epicondilo-malleolo y
L3z= Mk2z-Mk3z;%distanza epicondilo-malleolo z
Teta3=(180/pi)*(atan2(-L3z,L3y));%angolo epicondilo-malleolo

figure(1)
subplot(3,1,1);
plot(t,Teta1);
title('Angolo acromion-trocantere');
xlabel('Tempo[s]');
ylabel('Ampiezza[°]');
subplot(3,1,2);
plot(t,Teta2);
title('Angolo trocantere-epicondilo');
xlabel('Tempo[s]');
ylabel('Ampiezza[°]');
subplot(3,1,3);
plot(t,Teta3);
title('Angolo epicondilo-malleolo');
xlabel('Tempo[s]');
ylabel('Ampiezza[°]');



