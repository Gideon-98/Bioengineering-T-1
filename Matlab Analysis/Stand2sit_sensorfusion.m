%Stan2sit2stand +sensor fusion
%fstereo=250hz fimu=128hz

g = 9.805;

%% STEREOPHOTOGRAMMETRY
load stand2sit2standMK.txt
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
L1x= Mk0x-Mk1x;
L1y= Mk0y-Mk1y;
L1z= Mk0z-Mk1z;
Teta1=(180/pi)*(atan2(-L1x,L1y));

L2x= Mk1x-Mk2x;
L2y= Mk1y-Mk2y;
L2z= Mk1z-Mk2z;
Teta2=(180/pi)*(atan2(L2x,L2y));

L3x= Mk2x-Mk3x;
L3y= Mk2y-Mk3y;
L3z= Mk2z-Mk3z;
Teta3=(180/pi)*(atan2(-L3x,L3y));



figure(1)
subplot(3,1,1);
plot(t,Teta1);
title('Angle acromion-trochanter');
xlabel('Time[s]');
ylabel('Degree[�]');
subplot(3,1,2);
plot(t,Teta2);
title('Angle trochanter-epicondyle');
xlabel('Time[s]');
ylabel('Degree[�]');
subplot(3,1,3);
plot(t,Teta3);
title('Angle epicondyle-malleolus');
xlabel('Time[s]');
ylabel('Degree[�]');

figure(2) 
plot(t,Mk0y) 
title('Coordinate y acromion');
xlabel('Time[s]');
ylabel('Lenght[mm]');

%% IMU
load stand2sit2stand.mat

T_imu=1/128;
A= [0:8604];
t_imu=T_imu.*A';

A1x = h5d.s01108.raw.acc(:, 1);              
A1y = h5d.s01108.raw.acc(:, 2);
A1z = h5d.s01108.raw.acc(:, 3);

A2x= h5d.s01109.raw.acc(:, 1);
A2y = h5d.s01109.raw.acc(:, 2);
A2z = h5d.s01109.raw.acc(:, 3);


F=zeros(8605,1);
for K=1:1:8605
    F(K,1)=9.805;
end
f_g=F;


figure (3)
subplot(2,1,1);
plot(t_imu,A1y,t_imu,f_g)
title('Accelleration y IMU lombar');
xlabel('Time[s]');
ylabel('Accelleration[mm/s^2]');
legend('IMU','Gravity Force');
subplot(2,1,2);
plot(t_imu,A2y,t_imu,f_g)
title('Accelleration y IMU thigh');
xlabel('Time[s]');
ylabel('Accelleration[mm/s^2]');
legend('IMU','Gravity Force');

%% ALGORITMO PER TROVARE SIT DOWN E SIT OFF
% si suppone che nell'istante sitdown l'accelerazione della IMU a livello
% della coscia Ay2 converga verso a g(per proof mass) mentre nell'istante sit off
% l'accelerazione Ay1 misurata dalla imu sulla zona lombare sar� minima

%GOAL: create a matrix with every moments of time in a column and every values bigger than 9.81 on the other column 
%to divide them by moments of time for every the initial time matches with the sit down and the final one with the sit up

%% SITDOWN SIT UP ANALYSIS (DON'T DO THAT WITH STEREO)

%{
If we set a time period and create a matrix such that instants
with a value greater than 9.81 are worth 1 and values less than 9.81 are worth
zero for each time period I can mark as sit down instant the
first value 1 and as sit off instant the last value 1
%}
%create the matrix with the moments of times biggers than 9.81
Mat_ist=zeros(8605,1); 
sit_down=zeros(6,1);
sit_off=zeros(6,1);
Mind=zeros(6,2);

ind_in=15*128;   
ind_fin=20*128;
periodo=(ind_fin-ind_in);

%upload the values in Mind

for K=1:1:6
    Mind(K,1)=ind_in+(K-1)*periodo;
    Mind(K,2)=ind_fin+(K-1)*periodo;
end

%{
Mind(1,1)=15;Mind(1,2)=21;
Mind(2,1)=21;Mind(2,2)=25.5;
Mind(3,1)=25.5;Mind(3,2)=30;
Mind(4,1)=30;Mind(4,2)=34;
Mind(5,1)=34;Mind(5,2)=39;
Mind(6,1)=39;Mind(6,2)=43;

Mind=Mind*128
%}


for k=1:1:6
    in=Mind(k,1);
    fin=Mind(k,2);
     for K=in:1:(fin-1)
    if A2y(K,1)> g;
       Mat_ist(K,1)=1;
    else
        Mat_ist(K,1)=0;
    end    
  end   
    sit_down(k,1)
    down =find(Mat_ist(in:fin), 1, 'first');
     sit_down(k,1)= in+down;
    off =find(Mat_ist(in:fin), 1, 'last');
      sit_off(k,1)= in+off;

end    
s_off=sit_off
s_down=sit_down
    
t_s_off=s_off/128
t_s_down=s_down/128


%% third point
%g1(imu)= derivata di teta1
teta1_imu=(180/pi)*asin(-A1z/g);
teta1_imu=movmean(teta1_imu,50)
figure(4)
plot(t,Teta1,t_imu,teta1_imu)
title('Angle acromion-trochanter');
xlabel('Tempo[s]');
ylabel('Degree[�]');
legend('Teta','Teta Filtrato');


%% chance with longer method 
%syms teta1(t_imu) teta2(t_imu) acc1(t_imu) acc2(t_imu) acc0y(t_imu) acc0x(t_imu) g1(t_imu) g2(t_imu)
%{
%inizio a scrivere il sistema
% devo sapere derivate

%g1(imu)=- derivata di teta1
%g2(imu)= derivata di teta2

dt=diff(t_imu)
ode1 = diff(u) == 3*u + 4*v;
ode2 = diff(v) == -4*u + 3*v;
odes = [ode1; ode2]
%}
