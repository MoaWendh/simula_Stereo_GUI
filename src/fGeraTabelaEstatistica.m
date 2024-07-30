function fGeraTabelaEstatistica(pontos, estat, curvaAjustada, distanciaNominal)
clc;


colName= {'Dist. Nominal (m)', 'Dist. Sim (m)', 'DP direção X (mm)', 'DP direção Y (mm)', 'DP direção Z (mm)'};
distancia_L= estat.distancia_L; %*1000;
distanciaNominal= distanciaNominal/1000;
t1= table(distanciaNominal, distancia_L', estat.dp_L_X', estat.dp_L_Y', estat.dp_L_Z');
t1.Properties.VariableNames= colName;
tabela= t1;  

fig3= uifigure;
fig3.HandleVisibility= 'on';

fig3.Position= [80 1070 1200 200];
uit= uitable(fig3, 'Data', tabela);
uit.InnerPosition= [10 10 1150 175];
uit.FontSize= 14;
uit.FontWeight= 'bold';

% Formatação tabela:
s= uistyle;
s.HorizontalAlignment= 'center';
s.FontColor= 'blue';
addStyle(uit,s, 'column',[1 2 3 4 5 6]);

end