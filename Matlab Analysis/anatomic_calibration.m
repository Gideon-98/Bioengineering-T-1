%CALIBRAZIONE ANATOMICA 
load calibrazione_anatomica.txt

%Coordinate vectors of marker0 on acromion
Mk0x=calibrazione_anatomica(:,3); 
Mk0y=calibrazione_anatomica(:,4);
Mk0z=calibrazione_anatomica(:,5);

%Coordinate vectors of del marker1 on greater trochanter
Mk1x=calibrazione_anatomica(:,6);
Mk1y=calibrazione_anatomica(:,7);
Mk1z=calibrazione_anatomica(:,8);

%Coordinate vectors of marker2 on lateral epicondyle
Mk2x=calibrazione_anatomica(:,9);
Mk2y=calibrazione_anatomica(:,10);
Mk2z=calibrazione_anatomica(:,11);

%Coordinate vectors of  marker3 on lateral malleolus
Mk3x=calibrazione_anatomica(:,12);
Mk3y=calibrazione_anatomica(:,13);
Mk3z=calibrazione_anatomica(:,14);

% Are already taken the datas got from the test and used to create 12 vectors, 
% each one of them has every values of one markers coordinate 
% - Mk0 for acromion
% - Mk1 for greater trochanter
% - Mk2 of lateral epicondyle
% - Mk3 of lateral malleolus

S0x=sum(Mk0x);
S0y=sum(Mk0y);
S0z=sum(Mk0z);

S1x=sum(Mk1x);
S1y=sum(Mk1y);
S1z=sum(Mk1z);

S2x=sum(Mk2x);
S2y=sum(Mk2y);
S2z=sum(Mk2z);

S3x=sum(Mk3x);
S3y=sum(Mk3y);
S3z=sum(Mk3z);

%L1 = acromion - greater trochanter
L1x=(S0x-S1x)/1847; 
L1y=(S0y-S1y)/1847;
L1z=(S0z-S1z)/1847;
%L1=L1y because we disregard the swings in the x and y axis

%L2 = greater trochanter - lateral epicondyle
L2x=(S1x-S2x)/1847;
L2y=(S1y-S2y)/1847;
L2z=(S1z-S2z)/1847;
%L2=L2y because we disregard the swings in the x and y axis

%L3 = lateral epicondyle - lateral malleolus
L3x=(S2x-S3x)/1847;
L3y=(S2y-S3y)/1847;
L3z=(S2z-S3z)/1847;
%L3=L3y because we disregard the swings in the x and y axis

% Assuming the distances between the markers (L1, L2 and L3) constant,
% we go on to find the joint angles during anatomical calibration at rest.
% Each angle is measured with respect to the frontal plane.

Teta1=(180/pi)*atan2(L1x,L1y); % angle at greater trochanter
Teta2=(180/pi)*atan2(L2x,L2y); % angle at lateral epicondyle
Teta3=(180/pi)*atan2(L3x,L3y); % angle at lateral malleolus