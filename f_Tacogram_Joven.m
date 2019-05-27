function [pks,locs] = f_Tacogram_Joven( yDatos,xTiempo )

%VectorXy vectorY de los picosR

[pks,locs]=findpeaks(yDatos,'MinPeakWidth',15,'MaxPeakWidth',400,'MinPeakHeight',150);
plot(xTiempo(locs),pks,'or');
shg
hold on;plot(xTiempo,yDatos)
shg
col=size(pks);

%Vector diferencia de tiempo
colu=size(yDatos);
tiempoR=zeros(1,col(2)-1);
for i=1:col(2)
    pico=pks(1,i);
    indice=0;
    for j=1:colu(2)
        
        valor=yDatos(1,j);
        if valor == pico
            indice=j;
            break;
        end
    end
    tiempo = xTiempo(1,indice);
    tiempoR(1,i)=tiempo;
end

%plot(diferencia);



%disp(size(locs));
%disp(size(pks));



end

