load 'Mk_manubrio.txt';

fr = Mk_manubrio(:,1);
t = Mk_manubrio(:,2);
%marker 0 (shoulder)
mk0x = Mk_manubrio(:,3);
mk0y = Mk_manubrio(:,4);
mk0z = Mk_manubrio(:,5);
%marker 1 (elbow)
mk1x = Mk_manubrio(:,6);
mk1y = Mk_manubrio(:,7);
mk1z = Mk_manubrio(:,8);
%marker 2 (barbell)
mk2x = Mk_manubrio(:,9);
mk2y = Mk_manubrio(:,10);
mk2z = Mk_manubrio(:,11);

%% Graph of the movement of the 3 markers on x and y by time

figure (1)
subplot(3,1,2);
plot(t,mk0y,t,mk1y,t,mk2y,'linewidth',1);
title('Componente lungo y');
xlabel('Time[s]');
ylabel('Marker Position[mm]');
legend('Shoulder','Elbow','Barbell');
subplot(3,1,1);
plot(t,mk0x,t,mk1x,t,mk2x,'linewidth',1);
title('Componente lungo x');
xlabel('Time[s]');
ylabel('Marker Position[mm]');
legend('Shoulder','Elbow','Barbell');
%% estimate the angle of flex-extension at the elbow by time

ps= sqrt(((mk2x-mk0x).^2)+(mk2y-mk0y).^2); %barbell-shoulder distance
pg= sqrt(((mk2x-mk1x).^2)+(mk2y-mk1y).^2); %barbell-elbow distance
gs= sqrt(((mk1x-mk0x).^2)+(mk1y-mk0y).^2); %elbow-shoulder distance

beta= acos(((-(ps).^2)+((pg.^2)+gs.^2))./(2*(pg.*gs)));%"supplementary" angle in addition to the flex-extension angle
betag= beta*180/pi;%radiant->degree
alfa= 180- betag;%flex-extension angle(degree)
subplot(3,1,3);
plot(t,alfa);
title('Flex-extension angle');
xlabel('Time[s]');
ylabel('Degree[�]');
%% Start with derivating

dt = diff(t); %dt

%we derivate with the definition of incremental ratio

dmk2y = diff(mk2y);%position derivate
v_mk2y = dmk2y./dt;%speed
dv_mk2y = diff(v_mk2y);%speed derivate
a_mk2y = dv_mk2y./dt(2:end);%accelleration

%filtering
v_mk2y_f = movmean(v_mk2y,100);%filter on v
a_mk2y_f = movmean(a_mk2y,100);%filter on a 

%graph
figure (2)
subplot(3,1,1);
plot(t,mk2y,'linewidth',1);
title('Position on y axis');
xlabel('Time[s]');
ylabel('Position[mm]');
subplot(3,1,2);
plot(t(2:end),v_mk2y,'linewidth',0.5);
hold on;
plot(t(2:end),v_mk2y_f,'linewidth',1.5);
title('Speed on y axis');
xlabel('Time[s]');
ylabel('Speed[mm/s]');
legend('Speed','Filtered Speed');
subplot(3,1,3);
plot(t(3:end),a_mk2y,'linewidth',0.5);
hold on;
plot(t(3:end),a_mk2y_f,'linewidth',2);
title('Accelleration on y axis');
xlabel('Time[s]');
ylabel('Accelleration [mm/s^2]');
legend('Accelleration','Filtered Accelleration');

%derivative on x
dmk2x = diff(mk2x);%position derivate
v_mk2x = dmk2x./dt;%;%speed
dv_mk2x = diff(v_mk2x);%speed derivate
a_mk2x = dv_mk2x./dt(2:end);%);%accelleration
%Filtering
v_mk2x_f = movmean(v_mk2x,100);%filer speed
a_mk2x_f = movmean(a_mk2x,100);%filter accelleration

%graph
figure (3)
subplot(3,1,1);
plot(t,mk2x,'linewidth',1);
title('Position on x axis');
xlabel('Time[s]');
ylabel('Position[mm]');
subplot(3,1,2);
plot(t(2:end),v_mk2x,'linewidth',0.5);
hold on;
plot(t(2:end),v_mk2x_f,'linewidth',1.5);
title('Speed on x axis');
xlabel('Time[s]');
ylabel('Speed [mm/s]');
legend('Speed','Filtered Speed');
subplot(3,1,3);
plot(t(3:end),a_mk2x,'linewidth',0.5);
hold on;
plot(t(3:end),a_mk2x_f,'linewidth',2);
title('Accelleration on x axis');
xlabel('Time[s]');
ylabel('Accelleration [mm/s^2]');
legend('Accelleration','Filtered Accelleration');

%derivate on alpha
dalfa = diff(alfa);%alpha derivative
v_alfa = dalfa./dt;%speed derivative
dv_alfa = diff(v_alfa);%speed
a_alfa = dv_alfa./dt(2:end);%accelleration
%filtering
v_alfa_f = movmean(v_alfa,100);%Filtering on speed
a_alfa_f = movmean(a_alfa,100);%Filtering on accelleration

%grafico il tutto
figure (4)
subplot(3,1,1);
plot(t,alfa,'linewidth',1);
title('Alpha degree');
xlabel('Time[s]');
ylabel('Position[�]');
subplot(3,1,2);
plot(t(2:end),v_alfa,'linewidth',0.5);
hold on;
plot(t(2:end),v_alfa_f,'linewidth',1.5);
title('Angle speed');
xlabel('Time[s]');
ylabel('Angle Speed[�/s]');
legend('Speed','Filtering Speed');
subplot(3,1,3);
plot(t(3:end),a_alfa,'linewidth',0.5);
hold on;
plot(t(3:end),a_alfa_f,'linewidth',2);
title('Angle Accelleration y');
xlabel('Time[s]');
ylabel('Angle Accelleration[�/s^2]');
legend('Accelleration','Filtered Accelleration');
%% Dynamics
% We find the elbow reactions
% Simplified hypothesis: Muscular Force in x direction neglected  and C= 4 thank to the antropometrics parameters 
% found  for exercise. We neglect the arm inertia and the mass of the hand, the mass of the human subject


c=40; %action line for the muscular force
a=sum(pg,'all')/length(pg); %average distance between center of mass and barbell-elbow 
b=0.57*a; %distance between center of mass of barbell-elbow 

g=9.81;

Mman=5; %Barbell mass
Mbraccio=1.144; %Arm mass

Fb=Mbraccio*g;%arm weight
Fp=Mman*g;%barbell weight
Jtot= (Mman*a^2+Mbraccio*b^2)/10^6; %10^6 

%Calculate forces and torque with not filtered accelleration
Fart_x = ((-Mman*a_mk2x))/10^3; %Joint force on x
Fart_y= ((Fb+Fp)*ones(6947,1)+Mman*a_mk2y)/10^3; %Joint force on y
Mart= Jtot*a_alfa/10^3; %not filtered torque


%Calculate forces and torque with filtered accelleration
Fart_x_f = ((-Mman*a_mk2x_f))/10^3; %Joint force on x
Fart_y_f= ((Fb+Fp)*ones(6947,1)+Mman*a_mk2y_f)/10^3; %Joint force on y
Mart_f= Jtot*a_alfa_f/10^3; %filtered torque

%grafichiamo

figure (5)
subplot(3,1,1);
plot(t(3:end),Fart_x);
hold on;
plot(t(3:end),Fart_x_f,'linewidth',2);
title('Joint force on  x');
xlabel('Time[s]');
ylabel('Joint force[N]');
legend('Joint force','Filtered Joint force');
subplot(3,1,2);
plot(t(3:end),Fart_y);
hold on;
plot(t(3:end),Fart_y_f,'linewidth',2);
title('Joint force on y');
xlabel('Time[s]');
ylabel('Joint force[N]');
legend('Joint force','Filtered Joint force');
subplot(3,1,3);
plot(t(3:end),Mart);
hold on;
plot(t(3:end),Mart_f,'linewidth',2);
title('Joint Torque');
xlabel('Tempo[s]');
ylabel('Joint Torque [N*m]');
legend('Joint Torque','Filtered Joint Torque');


%Differences in 2 cases between filtered and not filtered
%Peaks from accellerations has lot of noise

%% Calculate the variations of the AP component(Anterposterior)

load 'F_manubrio.txt';

%frame and time on the force
fr_1 = F_manubrio(:,1);
t_1 = F_manubrio(:,2);
%force coordinate
fx = F_manubrio(:,3);
fy = F_manubrio(:,4);
fz = F_manubrio(:,5);
% variations graphs of the 3 components of the force during the time
figure (6)
subplot(2,1,1);
plot(t_1,fx);
title('APx component');
xlabel('Time[s]');
ylabel('Fx [N]');
subplot(2,1,2);
plot(t_1,fy);
title('APy component');
xlabel('Time[s]');
ylabel('Fy [N]');
%% Calculate the displacement of the AP component(Anterposterior) of the COP
load 'COP_manubrio.txt';

%frame e tempo on the COP
fr_2 = COP_manubrio(:,1);
t_2 = COP_manubrio(:,2);
%force coordinate
COPx = COP_manubrio(:,3);
COPy = COP_manubrio(:,4);
COPz = COP_manubrio(:,5);
% graphs for the variations of the components x and y of COP by time
figure (7)
subplot(2,1,1);
plot(t_2,COPx);
title('APx component of the COP');
xlabel('Time[s]');
ylabel('COPx [mm]');
subplot(2,1,2);
plot(t_2,COPx);
title('APy component of the COP');
xlabel('Time[s]');
ylabel('COPy[mm]');
