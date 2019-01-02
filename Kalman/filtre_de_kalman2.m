function [x_kalm_k,P_kalm_k] = filtre_de_kalman2(F,Q,H,R,y_k,x_kalm_prec,P_kalm_prec)

    if isnan(y_k(1))
       
        %y_k = [x_kalm_prec(1)+(Te*x_kalm_prec(2))
        %       x_kalm_prec(3)+(Te*
        %y_k = H*(F*x_kalm_prec);
        
        Pn_n1 = F*P_kalm_prec*F'+Q;
        
        K = Pn_n1 * H' * inv(H * Pn_n1 * H' + R);
        
        P_kalm_k = (eye(4)- (K*H))*Pn_n1;
        
        x_kalm_k = F*x_kalm_prec;
        
           
    else
        
        Pn_n1 = F*P_kalm_prec*F'+Q;

        K = Pn_n1 * H' * inv(H * Pn_n1 * H' + R);

        P_kalm_k = (eye(4)- (K*H))*Pn_n1;

        mn_n1 = F*x_kalm_prec;

        x_kalm_k = mn_n1  + (K*(y_k - (H*mn_n1)));

    end
    
end

