function [picos_r, clasificacion] = f_Clasifier(ECG_Reg, frecuencia)
%F_CLASIFIER Summary of this function goes here
%   Detailed explanation goes here
    vector_tiempo=0:(1/frecuencia):((length(ECG_Reg)/frecuencia)-(1/frecuencia));
    
    %%-- Limpiando el ruido    
    %Cambiando el dominio de la frequencia usando 
    fresult=fft(ECG_Reg); 
    %Eliminando componentes con baja frecuencia
    fresult(1 : round(length(fresult)*5/frecuencia))=0;    
    fresult(end - round(length(fresult)*5/frecuencia) : end)=0;
    %Devolviendonos al dominio original
    corrected=real(ifft(fresult));
    
    %---Buscando los picos R
     desv_std_r=std(corrected);
    [ry, rx]=findpeaks(corrected,vector_tiempo,'MinPeakHeight',desv_std_r,'MinPeakDistance',0.6);
    
    %--Calculando los picos R-R
    tacograma=zeros(1,length(ry)-1);
    
    for i=2:length(ry)
        tacograma(i-1)=ry(i)-ry(i-1);
    end
    
    desv_es=std(tacograma);
    vec_des=ones(1,length(tacograma)).*desv_es;
    
    tiempo=rx(2:end);
    %--Buscando los picos que esten sobre la deviacion estandar de los picos R-R
    [ty,tx]= findpeaks(tacograma,rx(2:end),'MinPeakHeight',desv_es);
    
    
    %---Calculando las estadisticas para los R-R cada 5min
    
    estadisticas.MEANNN=[];
    estadisticas.SDNN=[];
    estadisticas.NN50=[];
    estadisticas.pNN50=[];
    
    %---Clasificando los puntos r
    clasificacion = strings(1,length(ry));
    for i=1:length(ry)
        if ismember(ry(i),ty);
            clasificacion(i)="A";
        else
            clasificacion(i)="N";
        end
    end
end



