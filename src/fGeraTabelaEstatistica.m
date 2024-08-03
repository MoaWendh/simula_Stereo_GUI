function fGeraTabelaEstatistica(pontos, estatistica, curvaAjustada, distanciaNominal, CalculaIncerteza_Y)
clc;

if CalculaIncerteza_Y
    colName= {'Dist. Nominal(m)', 'Dist. Sim(m)', 'DP X(mm)', 'DP Z(mm)', 'Residuo Min X(mm)', 'Residuo Min Z(mm)', 'Residuo Max X(mm)', 'Residuo Max Z(mm)'};
    distancia_L= estatistica.distancia_L; %*1000;
    distanciaNominal= distanciaNominal/1000;
    t= table(distanciaNominal, distancia_L', estatistica.dp_L.x', estatistica.dp_L.z', estatistica.min_L.x', estatistica.min_L.z', estatistica.max_L.x', estatistica.max_L.z');
    t.Properties.VariableNames= colName;
    
    fig3= uifigure;
    fig3.HandleVisibility= 'on';

    fig3.Position= [80 1070 1200 200];
    uit= uitable(fig3, 'Data', t);
    uit.InnerPosition= [10 10 1150 175];
    uit.FontSize= 14;
    uit.FontWeight= 'bold';

    % Formatação tabela:
    s= uistyle;
    s.HorizontalAlignment= 'center';
    s.FontColor= 'blue';
    addStyle(uit,s, 'column',[1 2 3 4 5 6]);
else
    colName= {'Dist. Nominal(m)', 'Dist. Sim(m)', 'DP X(mm)', 'DP Z(mm)', 'Residuo Min X(mm)', 'Residuo Min Z(mm)', 'Residuo Max X(mm)', 'Residuo Max Z(mm)'};
    distancia_L= estatistica.distancia_L; %*1000;
    distanciaNominal= distanciaNominal/1000;
    t= table(distanciaNominal, distancia_L', estatistica.dp_L.x', estatistica.dp_L.z', estatistica.min_L.x', estatistica.min_L.z', estatistica.max_L.x', estatistica.max_L.z');
    t.Properties.VariableNames= colName;
    
    fig3= uifigure;
    fig3.HandleVisibility= 'on';

    fig3.Position= [80 1070 1200 200];
    uit= uitable(fig3, 'Data', t);
    uit.InnerPosition= [10 10 1150 175];
    uit.FontSize= 14;
    uit.FontWeight= 'bold';

    % Formatação tabela:
    s= uistyle;
    s.HorizontalAlignment= 'center';
    s.FontColor= 'blue';
    addStyle(uit,s, 'column',[1 2 3 4 5 6]);        
end

end