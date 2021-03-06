function [ tacograma, tiempo] = f_Tacogram( ECG_Reg, frecuencia )
    vector_tiempo=0:(1/frecuencia):((length(ECG_Reg)/frecuencia)-(1/frecuencia));
    
    %%-- Limpiando el ruido    
    x_r=diff(ECG_Reg).^2;
    %Cambiando el dominio de la frequencia usando furier
    fresult=fft(ECG_Reg); 
    %Eliminando componentes con baja frecuencia
    fresult(1 : round(length(fresult)*5/frecuencia))=0;    
    fresult(end - round(length(fresult)*5/frecuencia) : end)=0;
    %Devolviendonos al dominio original
    corrected=real(ifft(fresult));
    
    %---Buscando los picos R
     desv_std_r=std(corrected);
    [ry, rx]=findpeaks(corrected,vector_tiempo,'MinPeakHeight',desv_std_r,'MinPeakDistance',0.6);
    %[pk,lk] = findpeaks(ECG_Reg,vector_tiempo,'MinPeakDistance',0.5,'MinPeakHeight',0.5);
    
    figure
    subplot(2, 1, 1);
    plot(vector_tiempo,ECG_Reg)
    xlabel('Time (sec)')
     
    subplot(2, 1, 2);
    plot(vector_tiempo(1:end),corrected,rx,ry,'o')
    xlabel('Time (sec)')
  %  plot(vector_tiempo(1:end),corrected,rx,ry,'o',rx,ones(1,length(ry)).*desv_std_r)    
    
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
    
    figure
    plot(rx(2:end),tacograma,rx(2:end),vec_des,tx,ty,'o')
    title('Tacograma')
    ylabel('R - R interval (sec)')
    xlabel('Time (sec)')
    legend('Tacograma','standar desv', 'arrhythmia')   
 end

