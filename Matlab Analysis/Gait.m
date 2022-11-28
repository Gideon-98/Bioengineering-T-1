%Gait
load cammino.txt

%In the exectued test we consider only the time values when we have the coordinates of all the marker, 
%this because the human subject sometimes exit from the calibrated space

%Coordinates vectors of marker0 on acromion
Mk0x=cammino(713:1883,3);
Mk0y=cammino(713:1883,4);
Mk0z=cammino(713:1883,5);

%Coordinates vectors of marker1 on the great trochanter
Mk1x=cammino(713:1883,6);
Mk1y=cammino(713:1883,7);
Mk1z=cammino(713:1883,8);

%Coordinates vectors of marker2 on the lateral epicondyle
Mk2x=cammino(713:1883,9);
Mk2y=cammino(713:1883,10);
Mk2z=cammino(713:1883,11);

%Coordinates vectors of marker3 on the lateral malleolus
Mk3x=cammino(713:1883,12);
Mk3y=cammino(713:1883,13);
Mk3z=cammino(713:1883,14);

t=cammino(713:1883,2); %time vector during the measurements

%Consider constant the move on the x axis
L1y= Mk0y-Mk1y;%distance acromiom-trochanter y
L1z= Mk0z-Mk1z;%distance acromiom-trochanter Z
Teta1=(180/pi)*(atan2(-L1z,L1y));%acromiom-trochanter angle

L2y= Mk1y-Mk2y;%distance trochanter-epicondyle y
L2z= Mk1z-Mk2z;%distance trochanter-epicondyle z
Teta2=(180/pi)*(atan2(L2z,L2y));%trochanter-epicondyle angle

L3y= Mk2y-Mk3y;%distance epicondyle-malleoulus y
L3z= Mk2z-Mk3z;%distance epicondyle-malleoulus z
Teta3=(180/pi)*(atan2(-L3z,L3y));%epicondyle-malleoulus angle

figure(1)
subplot(3,1,1);
plot(t,Teta1);
title('Acromion-trocantere angle');
xlabel('Time[s]');
ylabel('Degree[�]');
subplot(3,1,2);
plot(t,Teta2);
title('Trochanter-epicondyle angle');
xlabel('Time[s]');
ylabel('Degree[�]');
subplot(3,1,3);
plot(t,Teta3);
title('Epicondyle-malleoulus angle');
xlabel('Time[s]');
ylabel('Degree[�]');



