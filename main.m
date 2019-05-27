%% Primera parte: carga y visualización de datos.
clc, clear all, close all;
File_Name='ECG_recording.eeg';
[Y_Signal]=f_GetSignalsNico(File_Name,'ECG1+');
vector_tiempo=0:(1/256):((length(Y_Signal)/256)-(1/256));
figure('Name','Electrocardiograma')
plot(vector_tiempo,Y_Signal)
title('Electrocardiograma')


%% Parte 2
clc, clear all, close all;
% desvicion_estandar=std(Y_Signal);
% line_y=zeros(1,length(vector_tiempo));
% for i=1:length(vector_tiempo)
%     line_y(i)= desvicion_estandar;
% end
% 
% [pk,lk] = findpeaks(Y_Signal,vector_tiempo,'MinPeakDistance',0.3,'MinPeakHeight',desvicion_estandar);
% figure;
% plot(vector_tiempo, Y_Signal,lk,pk,'o',vector_tiempo,line_y );
load('./Data/Arr_Ann_Loc.mat');%
load('./Data/Arr_Ann_Str.mat');%Anotaciones de los picos
load('./Data/Arr_Data.mat');% ECG

picos_r=cell2mat(m_ann_loc(7));
anotaciones=m_ann_str{1,1};
cont_arr=0;
for k=1:length(anotaciones) 
    if anotaciones(k)=="A"
        cont_arr=cont_arr+1;
    end
end

f_Tacogram(m_Data(1,:),360);

%f_Tacogram(Y_Signal,256);
