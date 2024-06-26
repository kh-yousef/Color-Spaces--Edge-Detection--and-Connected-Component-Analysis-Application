function [H,S,I] = rgbtohsi(rgb)

 I=double(rgb)/255;
 R=I(:,:,1);
 G=I(:,:,2);
 B=I(:,:,3);
 h_eq = (0.5 * ((R - G) + (R - B))) ./ (sqrt((R - G).^2 + (R - B).*(G - B)));
 theta = acos(h_eq);
    
 H = theta;

%If B>G then H= 360-Theta
H(B>G)=360 -H(B>G);

%Saturation
S=1- (3./(sum(I,3)+0.000001)).*min(I,[],3);

%Intensity
I=(R+G+B)./3;

end