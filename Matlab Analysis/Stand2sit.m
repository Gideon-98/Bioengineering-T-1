%STAND TO SIT TO STAND 
load stand2sit2stand.txt

%Coordinates vectors of the marker0 on acromiom
Mk0x=stand2sit2standMK(:,3);
Mk0y=stand2sit2standMK(:,4);
Mk0z=stand2sit2standMK(:,5);

%Coordinates vectors of the marker1 on great trochanter
Mk1x=stand2sit2standMK(:,6);
Mk1y=stand2sit2standMK(:,7);
Mk1z=stand2sit2standMK(:,8);

%Coordinates vectors of the marker2 on lateral epicondyle
Mk2x=stand2sit2standMK(:,9);
Mk2y=stand2sit2standMK(:,10);
Mk2z=stand2sit2standMK(:,11);

%Coordinates vectors of the marker3 on lateral malleolus
Mk3x=stand2sit2standMK(:,12);
Mk3y=stand2sit2standMK(:,13);
Mk3z=stand2sit2standMK(:,14);

t=stand2sit2standMK(:,2); %time vector during the measurements

%Consider constant the move on the x axis

L1y= Mk0y-Mk1y;%distance acromiom-trochanter y
L1z= Mk0z-Mk1z;%distance acromiom-trochanter z
Teta1=(180/pi)*(atan2(-L1z,L1y));%Angle acromiom-trochanter

L2y= Mk1y-Mk2y;%distance trochanter-epicondyle y
L2z= Mk1z-Mk2z;%distance trochanter-epicondyle z
Teta2=(180/pi)*(atan2(L2z,L2y));%Angle trochanter-epicondyle

L3y= Mk2y-Mk3y;%distance epicondyle-malleolus y
L3z= Mk2z-Mk3z;%distance epicondyle-malleolus z
Teta3=(180/pi)*(atan2(-L3z,L3y));%Angle epicondyle-malleolus

figure(1)
subplot(3,1,1)
plot(t,Teta1)
title('Angle acromion-trochanter');
xlabel('Time[s]');
ylabel('Degree [�]');
subplot(3,1,2)
plot(t,Teta2)
title('Angle trochanter-epicondyle');
xlabel('Time[s]');
ylabel('Degree [�]');
subplot(3,1,3)
plot(t,Teta3)
title('Angle epicondyle-malleolus');
xlabel('Time[s]');
ylabel('Degree [�]');




