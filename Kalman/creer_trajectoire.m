function vecteur_x = creer_trajectoire(F,Q,x_init,T)

    racineQ = sqrtm(Q);

    vecteur_x(:,1) = x_init;
    
    for k = 2:T
       
        vecteur_x(:,k) = racineQ*randn(4,1)+(F*vecteur_x(:,k-1));
        
    end

end

