function pontos3D_aux= fIncrementaDistancia(pontos3D, DistanciaMaximaSim, IncrementoDistancia) 

pontos3D_aux= pontos3D;
distanciaInicial= pontos3D(3);    
numDistancias= ceil((DistanciaMaximaSim- distanciaInicial)/IncrementoDistancia) + 1;

for ctDist=2:numDistancias-1
    pontos3D_aux(ctDist,1)= pontos3D_aux(ctDist-1,1);   
    pontos3D_aux(ctDist,2)= pontos3D_aux(ctDist-1,2);
    pontos3D_aux(ctDist,3)= pontos3D_aux(ctDist-1,3) + IncrementoDistancia;            
end
end