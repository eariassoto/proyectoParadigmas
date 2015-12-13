% esta funcion escala las matrices en referencia al conjunto de datos de entrenamiento
%
% profe esta funcion no la hicimos nosotros solo que no sé qué hice el link de donde
% la saque
% - Emmanuel

function [trndata,valdata,tstdata]=scaleSVM(trndata,valdata,tstdata,Lower,Upper)
%--------------------------------------------------------------------------
% DESCRIPTION: Used to Scale data uniformly
%--------------------------------------------------------------------------
Data=trndata.X;
[MaxV, I]=max(Data);
[MinV, I]=min(Data);
[R,C]= size(Data);
scaled=(Data-ones(R,1)*MinV).*(ones(R,1)*((Upper-Lower)*ones(1,C)./(MaxV-MinV)))+Lower;
for i=1:size(Data,2)
    if(all(isnan(scaled(:,i))))
        scaled(:,i)=0;
    end
end
trndata.X=scaled;

%######## SCALE THE VAL DATA TO THE RANGE OF TRAINING DATA ##########
Data=valdata.X;
[R,C]= size(Data);
scaled=(Data-ones(R,1)*MinV).*(ones(R,1)*((Upper-Lower)*ones(1,C)./(MaxV-MinV)))+Lower;
for i=1:size(Data,2)
    if(all(isnan(scaled(:,i))))
        scaled(:,i)=0;
    end
end
valdata.X=scaled;

%###### SCALE THE TEST DATA TO THE RANGE OF TRAINING DATA ###########
Data=tstdata.X;
[R,C]= size(Data);
scaled=(Data-ones(R,1)*MinV).*(ones(R,1)*((Upper-Lower)*ones(1,C)./(MaxV-MinV)))+Lower;
for i=1:size(Data,2)
    if(all(isnan(scaled(:,i))))
        scaled(:,i)=0;
    end
end
tstdata.X=scaled;

end
