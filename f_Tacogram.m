function [ tacograma, tiempo] = f_Tacogram( ECG_Reg, frecuencia )
    vector_tiempo=0:(1/frecuencia):((length(ECG_Reg)/frecuencia)-(1/frecuencia));
    %-- Limpiando el ruido    
     x_r=diff(ECG_Reg).^2;
     
    fresult=fft(ECG_Reg);     
    fresult(1 : round(length(fresult)*5/frecuencia))=0;
    fresult(end - round(length(fresult)*5/frecuencia) : end)=0;
    corrected=real(ifft(fresult));
    
     desv_std_r=std(x_r);
    [ry, rx]=findpeaks(x_r,vector_tiempo(2:end),'MinPeakHeight',desv_std_r);
    [pk,lk] = findpeaks(ECG_Reg,vector_tiempo,'MinPeakDistance',0.5,'MinPeakHeight',0.5);
    
    figure
    subplot(2, 1, 1);
    plot(vector_tiempo,ECG_Reg,lk,pk,'o')
    title('Picos R')    
    subplot(2, 1, 2);
    plot(vector_tiempo(1:end),corrected)
  %  plot(vector_tiempo(1:end),corrected,rx,ry,'o',rx,ones(1,length(ry)).*desv_std_r)    
    
    
    tacograma=zeros(1,length(pk)-1);
    
    for i=2:length(pk)
        tacograma(i-1)=pk(i)-pk(i-1);
    end
    
    desv_es=std(tacograma);
    vec_des=ones(1,length(tacograma)).*desv_es;
    
    tiempo=lk(2:end);
    
    [ty,tx]= findpeaks(tacograma,lk(2:end),'MinPeakHeight',desv_es);
    
    figure
    plot(lk(2:end),tacograma,lk(2:end),vec_des,tx,ty,'o')
    title('Tacograma')
    ylabel('R - R interval (sec)')
    xlabel('Time (sec)')
    legend('Taco','standar desv', 'arritmias')
    disp(length(ty))
    
    
%     figure
%     plot(vector_tiempo,ECG_Reg,lk,pk,'o');

end

