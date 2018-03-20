clear all;
clc;
close all;
I = imread('image1.jpg') ;
subplot(1,2,1);imshow(I);title('original(720*480)image');
expansion(I);
function E=expansion(I)
[M, N, chn] = size(I) ;
FM = M ; FN = N +N/2;

OM = M ; ON = N;
O_im = I ;
N_rem = N - (FN - N) ;
[Y, X] = meshgrid(1:N, 1:M) ;
removed = zeros(M, N) ;

% traverse until we get desired width
while N > N_rem
    disp(N) ;
    cost =cost_gradient(I) ;
    dp = zeros(M, N) ;
    from = zeros(M, N) ;
    dp(1, :) = cost(1, :) ;
    from(1, :) = 1 : N ;
    
    for i = 2 : M
        for j = 1 : N
            dp(i, j) = dp(i - 1, j) ;
            from(i, j) = j ;
            if j > 1 && dp(i - 1, j - 1) < dp(i, j)
                dp(i, j) = dp(i - 1, j - 1) ;
                from(i, j) = j - 1 ;
            end
            if j < N && dp(i - 1, j + 1) < dp(i, j)
                dp(i, j) = dp(i - 1, j + 1) ;
                from(i, j) = j + 1 ;
            end
            dp(i, j) = dp(i, j) + cost(i, j) ;
        end
    end
    
    [~, idx] = min(dp(M, :)) ;
    for i = M : -1 : 1
        removed(i, Y(i, idx)) = 1 ;
        I(i, idx : N - 1, :) = I(i, idx + 1 : N, :) ;
        Y(i, idx : N - 1) = Y(i, idx + 1 : N) ;
        idx = from(i, idx) ;
    end
    I = I(:, 1 : N - 1, :) ;
    Y = Y(:, 1 : N - 1) ;
    N = N - 1 ;
    
end

I = double(O_im) ;
new_im = zeros(FM, FN, chn) ;

for i = 1 : OM
    k = 1 ;
    
    for j = 1 : ON
        new_im(i, k, :) = I(i, j, :) ;
        k = k + 1 ;
        if removed(i, j) == 1
            
            if (j > 1) && (j < N)
                new_im(i, k, :) = (I(i, j - 1, :) + I(i, j, :) + I(i, j + 1, :)) / 3 ;
            else
                new_im(i, k, :) = I(i, j, :) ;
            end
            k = k + 1 ;
        end
    end
    
end
subplot(1,2,2);imshow(uint8(new_im));title('Expansion by pixel');
function G_im = cost_gradient(im)
    
    [row,col,n] = size(im);
    if(n == 3)
        im = rgb2gray(im);
    end
    im = double(im)/255;

    [grad_x,grad_y] = gradient(im);
    G_im = grad_x + grad_y;
    G_im = abs(G_im);
end
end