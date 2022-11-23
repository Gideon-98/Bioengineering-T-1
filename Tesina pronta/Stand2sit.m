%STAND TO SIT TO STAND 
load stand2sit2stand.txt

%Vettori delle coordinate del marker0 sull'acromion
Mk0x=stand2sit2stand(:,3);
Mk0y=stand2sit2stand(:,4);
Mk0z=stand2sit2stand(:,5);

%Vettori delle coordinate del marker1 sul grande trocantere
Mk1x=stand2sit2stand(:,6);
Mk1y=stand2sit2stand(:,7);
Mk1z=stand2sit2stand(:,8);

%Vettori delle coordinate del marker2 sull'epicondilo laterale
Mk2x=stand2sit2stand(:,9);
Mk2y=stand2sit2stand(:,10);
Mk2z=stand2sit2stand(:,11);

%Vettori delle coordinate del marker3 sul malleolo laterale
Mk3x=stand2sit2stand(:,12);
Mk3y=stand2sit2stand(:,13);
Mk3z=stand2sit2stand(:,14);

t=stand2sit2stand(:,2); %vettore degli istanti di tempo in cui sono prese le misurazioni 

%Consideriamo costante lo spostamento lungo l'asse x

L1y= Mk0y-Mk1y;%distanza acromiom-trocantere y
L1z= Mk0z-Mk1z;%distanza acromiom-trocantere z
Teta1=(180/pi)*(atan2(-L1z,L1y));%angolo acromiom-trocantere

L2y= Mk1y-Mk2y;%distanza trocantere-epicondilo y
L2z= Mk1z-Mk2z;%distanza trocantere-epicondilo z
Teta2=(180/pi)*(atan2(L2z,L2y));%angolo trocantere-epicondilo

L3y= Mk2y-Mk3y;%distanza epicondilo-malleolo y
L3z= Mk2z-Mk3z;%distanza epicondilo-malleolo z
Teta3=(180/pi)*(atan2(-L3z,L3y));%angolo epicondilo-malleolo

figure(1)
subplot(3,1,1)
plot(t,Teta1)
title('Angolo acromion-trocantere');
xlabel('Tempo[s]');
ylabel('Ampiezza [°]');
subplot(3,1,2)
plot(t,Teta2)
title('Angolo trocantere-epicondilo');
xlabel('Tempo[s]');
ylabel('Ampiezza [°]');
subplot(3,1,3)
plot(t,Teta3)
title('Angolo epicondilo-malleolo');
xlabel('Tempo[s]');
ylabel('Ampiezza [°]');




