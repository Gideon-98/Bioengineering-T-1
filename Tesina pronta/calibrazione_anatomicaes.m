%CALIBRAZIONE ANATOMICA 
load calibrazione_anatomica.txt

%Vettori delle coordinate del marker0 sull'acromion
Mk0x=calibrazione_anatomica(:,3); 
Mk0y=calibrazione_anatomica(:,4);
Mk0z=calibrazione_anatomica(:,5);

%Vettori delle coordinate del marker1 sul grande trocantere
Mk1x=calibrazione_anatomica(:,6);
Mk1y=calibrazione_anatomica(:,7);
Mk1z=calibrazione_anatomica(:,8);

%Vettori delle coordinate del marker2 sull'epicondilo laterale
Mk2x=calibrazione_anatomica(:,9);
Mk2y=calibrazione_anatomica(:,10);
Mk2z=calibrazione_anatomica(:,11);

%Vettori delle coordinate del marker3 sul malleolo laterale
Mk3x=calibrazione_anatomica(:,12);
Mk3y=calibrazione_anatomica(:,13);
Mk3z=calibrazione_anatomica(:,14);

%Sono già stati prelevati i dati ottenuti dal test  e utilizzati per formare dodici
%vettori, ciascuno dei quali continene tutti i valori di una coordinata di
%uno dei marker (Mk0 per l'acromion, Mk1 per il grande trocantere, Mk2 per
%l'epicondilo laterale e Mk3 per il malleolo laterale)
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

%segmento L1= acromion - grande trocantere
L1x=(S0x-S1x)/1847; 
L1y=(S0y-S1y)/1847;
L1z=(S0z-S1z)/1847;
%L1=L1y perché trascuriamo le oscillazioni lungo l'asse x e y

%segmento L2= grande trocantere - epicondilo laterale
L2x=(S1x-S2x)/1847;
L2y=(S1y-S2y)/1847;
L2z=(S1z-S2z)/1847;
%L2=L2y perché trascuriamo le oscillazioni lungo l'asse x e y

%segmento L3=epicondilo laterale- malleolo laterale
L3x=(S2x-S3x)/1847;
L3y=(S2y-S3y)/1847;
L3z=(S2z-S3z)/1847;
%L3=L3y perché trascuriamo le oscillazioni lungo l'asse x e y

%Supponendo le distanze tra i marker (l1, L2 e L3) costanti, andiamo a
%trovare gli angoli articolari durante la calibrazione anatomica a riposo.
%Ciascun angolo è misurato rispetto al piano frontale.

Teta1=(180/pi)*atan2(L1x,L1y); %angolo al grande trocantere
Teta2=(180/pi)*atan2(L2x,L2y); %angolo all'epicondilo laterale
Teta3=(180/pi)*atan2(L3x,L3y); %angolo al malleolo laterare
















