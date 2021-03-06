function [x_gauss_k,P_gauss_k,m_gauss_k,w_gauss_k] = gaussian_sum_filter(F,Q,H,R,y_k,P_gauss_prec,m_gauss_prec,w_gauss_prec)
    
    L = size(m_gauss_prec,2);

    Pk_k1 = zeros(size(P_gauss_prec));
    P_gauss_k = zeros(size(P_gauss_prec));
    mk_k1 = zeros(size(m_gauss_prec));
    m_gauss_k = zeros(size(m_gauss_prec));
    
    w_gauss_k = zeros(size(w_gauss_prec));
    wk_k1 = w_gauss_prec;

    for i = 1:L
       
        Pk_k1(:,:,i) = F*P_gauss_prec(:,:,i)*F'+Q;
        mk_k1(:,i) = F*m_gauss_prec(:,i);
        
    end
    
    for i = 1:L
    
        K(:,:,i) = Pk_k1(:,:,i) * H' * inv(H * Pk_k1(:,:,i) * H' + R);
        m_gauss_k(:,i) = mk_k1(:,i) + (K(:,:,i)*(y_k - (H*mk_k1(:,i))));
        P_gauss_k(:,:,i) = (eye(4)- (K(:,:,i)*H))*Pk_k1(:,:,i);
        w_gauss_k(i) = mvnpdf(y_k,H*mk_k1(:,i),H*Pk_k1(:,:,i)*H'+R);
        
    end
        
    [~,idx] = max(wk_k1);
    x_gauss_k = m_gauss_k(:,idx);

end

