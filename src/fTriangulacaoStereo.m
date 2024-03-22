%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [XL XR]= fTriangulacaoStereo(xL, xR, paramsCalStereo, habCalibBouguet)

numClusters= length(xL);
concatenaPrimeiraNuvem= 0;

% Efetua a avredura em todas as linhas lasers, clusters, detectados:
for (ctCluster=1:numClusters)
    if length(xL{ctCluster}) && length(xR{ctCluster}) 
        % Faz a triangulação laser usando tanto as funções nativas do Matlab quanto Bouguet:
        if ~(habCalibBouguet)
            worldPoints = triangulate(xL{ctCluster}',xR{ctCluster}',paramsCalStereo.full)';
            [l c]= size(xR{ctCluster});
            ct=0;
            for m=1:c 
                if (isnan(worldPoints(:,m)))
                  ct= ct+1;   
                else
                  XL{ctCluster}(1,(m-ct))= worldPoints(1,m);  
                  XL{ctCluster}(2,(m-ct))= worldPoints(2,m);  
                  XL{ctCluster}(3,(m-ct))= worldPoints(3,m);  
                  XR{ctCluster}(1,(m-ct))= 0;  
                  XR{ctCluster}(2,(m-ct))= 0;  
                  XR{ctCluster}(3,(m-ct))= 0;       
                end
            end   
        else
            % load(pathCalibFile,'T','om','fc_left','cc_left','kc_left','alpha_c_left','fc_right','cc_right','kc_right','alpha_c_right'); 
            % Chama a função stereo_triangulation para determinar a projeção dos pontos 3D referentes a imagem esquerda e direita, 
            [X_L, X_R] = fStereoTriangulation(xL{ctCluster}, xR{ctCluster}, paramsCalStereo.om, paramsCalStereo.T, paramsCalStereo.fc_left, ...
                paramsCalStereo.cc_left, paramsCalStereo.kc_left, paramsCalStereo.alpha_c_left, paramsCalStereo.fc_right, ...
                paramsCalStereo.cc_right, paramsCalStereo.kc_right, paramsCalStereo.alpha_c_right);
            
            [l c]= size(xR{ctCluster});
            ct=0;
            for (m=1:c) 
                if ~(isnan(X_L(:,m)) & isnan(X_R(:,m)))
                  ct= ct + 1;   
                  XL{ctCluster}(1,ct)= X_L(1,m);  
                  XL{ctCluster}(2,ct)= X_L(2,m);  
                  XL{ctCluster}(3,ct)= X_L(3,m); 
                  
                  XR{ctCluster}(1,ct)= X_R(1,m);  
                  XR{ctCluster}(2,ct)= X_R(2,m);  
                  XR{ctCluster}(3,ct)= X_R(3,m);       
                end
            end      
        end

        % Integra as coordenadas XYZ de cada linha laser numa única variável.
        if ~(concatenaPrimeiraNuvem)
            ptsAppendedL= XL{ctCluster};
            ptsAppendedR= XR{ctCluster};
            % Integra também o pontos formados no plano imagem.
            imgPtsAppendL= [xL{ctCluster}];
            concatenaPrimeiraNuvem= 1;
        else
            ptsAppendedL= [ptsAppendedL XL{ctCluster}];
            ptsAppendedR= [ptsAppendedR XR{ctCluster}];
            imgPtsAppendL=[imgPtsAppendL xL{ctCluster}];
        end
    end    
end  

end