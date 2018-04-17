function I = MSLDE(f, L)
%{
This function is the main function of Multiscale Logarithm Difference
Edgemaps(MSLDE), decomposing an image into L difference edgemaps. 
Please note that MSLDE is protected by patent. Any commercial or industrial
purposes of using MSLDE are limited. But it is encouraged for usage of
study and research.

For any usage of this function, the following papers should be cited as reference, where
parameter settings and details are given in the first paper:

[1] Zhao-Rong Lai, Dao-Qing Dai, Chuan-Xian Ren, and Ke-Kun Huang. ¡°Multiscale logarithm difference edgemaps 
for face recognition against varying lighting conditions¡±, 
IEEE Transactions on Image Processing, vol. 24, no. 6, pp. 1735¨C1747, June 2015.
[2] Zhao-Rong Lai, Dao-Qing Dai, Chuan-Xian Ren, and Ke-Kun Huang.  ¡°Multi-layer surface albedo for face recognition
 with reference images in bad lighting conditions,¡± 
IEEE Transactions on Image Processing, vol. 23, no. 11, pp. 4709¨C4723, Nov. 2014.


Inputs:
f                  -the 2D image to be processed
L                  -the number of edgemaps, also the longest distance from
                    the current pixel

Outputs:
I                  -a 1*L cell array with the corresponding decomposed difference edgemaps

%}



F=log(f); % take the logarithm to produce a LOG image

[a,b]=size(F);



F_extend = padarray(F,[L,L],'symmetric','both');  % extends the border of F to implement difference
I = cell(1, L);
for l=1:L
    I{1,l}=zeros(a,b);
end

% create edgemaps
for i=L+1:a+L
    for j=L+1:b+L
        for l=1:L
            F_extend_cur=padarray(F_extend(i-l+1:i+l-1,j-l+1:j+l-1),[1,1],0,'both'); % a neighborhood around the current pixel
            ones_cur=padarray(ones(2*l-1, 2*l-1)*F_extend(i,j),[1,1],0,'both');
            I{1,l}(i-L, j-L) = sum(sum(     (F_extend(i,j)-F_extend(i-l:i+l,j-l:j+l)+F_extend_cur-ones_cur)        )); % implement difference
        end

    end
end



end
