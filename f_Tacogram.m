function [ tacograma, tiempo] = f_Tacogram( ECG_Reg, frecuencia )
    
    %-- Limpiando el ruido
    x_r=diff(ECG_Reg).^2;
    
    
    vector_tiempo=0:(1/frecuencia):((length(ECG_Reg)/frecuencia)-(1/frecuencia));
    [pk,lk] = findpeaks(ECG_Reg,vector_tiempo,'MinPeakDistance',0.5,'MinPeakHeight',0.5);
    
    figure
    plot(vector_tiempo,ECG_Reg,lk,pk,'o')
    title('Picos R')
    
    
    figure('Name', 'Ruido')    
    plot(vector_tiempo(2:end),x_r)
    
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
