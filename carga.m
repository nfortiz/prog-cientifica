clc, clear all
% Primera parte: carga y visualizacion

senal=f_GetSignalsNico('ECG_recording.eeg','Fp1');
col=size(senal);

yDatos=zeros(1,col(2));
for j=1:col(2)
    yDatos(1,j)=senal(1,j);
end
xTiempo=0:0.00390625:273.2812;


AxesH = axes('Xlim', [0, 274], 'XTick', 0:13:274, 'NextPlot', 'add');
plot(xTiempo,yDatos,'b');xlabel('Tiempo (seg)');

[rtax,rtay]=f_Tacogram_Joven(yDatos,xTiempo);

disp(rtax(10));
disp(rtay(10));

