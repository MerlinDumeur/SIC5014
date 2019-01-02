function vecteur_y = creer_observations_radar(R,vecteur_x,T)

    racineR = sqrtm(R);
    vecteur_y=zeros(2,T);
    
    for k = 1:T
        
        vecteur_y(:,k) = racineR*randn(2,1) + h(vecteur_x(:,k));
        
    end
    
end

