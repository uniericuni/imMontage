function out = imMontage(imRef, folder, dup, wc, wh)

    if ~exist('dup','var')
        dup = 4;
    end
    if ~exist('wc','var')
        wc = 0.5;
    end
    if ~exist('wh','var')
        wh = 0.5;
    end
    
    imRef = imresize(imRef,floor(sqrt(dup)));
    
    % read files
    fprintf('read images ...\n');
    [height,width,channel] = size(imRef);
    files = dir([folder,'*.png']);
    N = length(files);
    for i=1:N
        fname = files(i).name;
        imT{i} = imread([folder,fname]);
        fprintf(['image', num2str(i), '...\n']);
    end
    index = randperm(N*dup);
    for i=1:N*dup
        im{i} = imT{mod(index(i),N)+1};
    end
    N = N*dup;
    [h,w,c] = size(im{1});
    
    % rescale
    fprintf('rescale images ...\n');
    sH = height/h;
    sW = width/w;
    i = 1;
    while(floor(sH*i)*floor(sW*i) <= N)
        i = i+1;
    end
    i = i-1;
    sH = floor(sH*i);
    sW = floor(sW*i);
    h = floor(height/sH);
    w = floor(width/sW);
    height = h*sH;
    width = w*sW;
    for i=1:channel
        imNRef(:,:,i) = imresize(imRef(:,:,i),[height,width]);
    end
    for i=1:N
        img = im{i};
        fprintf(['image', num2str(i), '...\n']);
        for j=1:channel
            imgN(:,:,j) = imresize(img(:,:,j),[h,w]);
        end 
        im{i} = imgN;
    end
    
    % histogram mapping
    fprintf('histogram mapping ...\n');
    out = ones(height,width,channel);
    for i=1:sH
        for j=1:sW
            index = (i-1)*sW+j;
            fprintf(['block', num2str(index), '...\n']);
            refBlock = imNRef(h*(i-1)+1:h*i, w*(j-1)+1:w*j,:);
            block = imhistmatch(im{index}, refBlock);
            block = uint8(block.*wh) + uint8(im{index}.*(1-wh));
            out(h*(i-1)+1:h*i, w*(j-1)+1:w*j, :) = block;
        end
    end
    
    % merging
    fprintf('image merging ...\n');
    out = imhistmatch(uint8(out),imNRef);
    out = uint8(out.*wc) + uint8(imNRef.*(1-wc));
    bRef = medfilt2(rgb2gray(imNRef), [3,3]*dup);
    out(edge(bRef,'canny')==true) = imNRef(edge(bRef,'canny')==true);
    
end
