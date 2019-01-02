function vecteur_y = creer_observations(H,R,vecteur_x,T)

    racineR = sqrtm(R);
    vecteur_y=zeros(2,T);
    
    for k = 1:T
        
        vecteur_y(:,k) = racineR*randn(2,1) + (H*vecteur_x(:,k));
        
    end
    
end

