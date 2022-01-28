function dynamic_edge(image_name,t,out_name)
% 用热传导方程的解来做动态边界
heat_matrix=Heat_Equation(image_name,t);

bi_image=binari_value(heat_matrix);

imshow(bi_image,[]);
imwrite( bi_image,out_name);

function outcome=Heat_Equation( image_name,t )
image_I=imread(image_name);
 
[size_r,size_c]=size(image_I);
image_I=double(image_I);

N=t/0.1; 
for index=1:N
   image_ex=matrix_expand(image_I);
   diff_two_order=zeros(size_r,size_c);
    
    for row=2:size_r+1
        for col=2:size_c+1
            diff_two_order(row-1,col-1)=-4*image_ex(row,col)+image_ex(row-1,col)+image_ex(row+1,col)+image_ex(row,col-1)+image_ex(row,col+1);
        end
    end         
   image_I=image_I+0.1*diff_two_order;            
end 
outcome=image_I;

function matrix_ex=matrix_expand(matrix)
   [size_r,size_c]=size(matrix);
   matrix_ex=zeros(size_r+2,size_c+2);
   for row=1:size_r
       for col=1:size_c
           matrix_ex(row+1,col+1)=matrix(row,col);
       end
   end
  for row=1:size_r
      matrix_ex(row+1,1)=matrix(row,1);
      matrix_ex(row+1,size_c+2)=matrix(row,size_c);
  end
  for col=1:size_c
      matrix_ex(1,col+1)=matrix(1,col);
      matrix_ex(size_r+2,col+1)=matrix(size_r,col);
  end
  matrix_ex(1,1)=matrix(1,1);
  matrix_ex(1,size_c+2)=matrix(1,size_c);
  matrix_ex(size_r+2,1)=matrix(size_r,1);
  matrix_ex(size_r+2,size_c+2)=matrix(size_r,size_c);

function bi_matrix=binari_value( former_matrix )
[size_r,size_c]=size( former_matrix );
bi_matrix=zeros(size_r,size_c);
for index=1:size_r*size_c
        if former_matrix(index)>128
            bi_matrix(index)=1;
        end    
end