function [] = main()
  rootDir = 'Images';  % root directory path
  reference_img = 'ref.jpg'; 
  fused_img = 'our.jpg';
 
  fileFolders = dir(fullfile(rootDir, '*'));
  fileNames = {fileFolders.name};
  fileNum = length(fileNames);
  for n = 3:1:fileNum
      % the image file path
      hdrImage_path = fullfile(rootDir, fileNames(n), reference_img);
      ldrImage_path = fullfile(rootDir, fileNames(n), fused_img);
      hdrImage_path = hdrImage_path{1};
      ldrImage_path = ldrImage_path{1};
      % reference image
      hdrImage = imread(hdrImage_path);
      % the image of being computed
      ldrImage = imread(ldrImage_path);
      
      if isempty(hdrImage) || isempty(ldrImage)
          disp('load image failed!');
      end
      
      [Q, S, N, s_maps, s_local] = TMQI(hdrImage, ldrImage);  % calculate fused metrics
      
      % print metric
      s1 = sprintf('第%d组图像%s的的评价指标: Q=%f,S=%f,N=%f', n-2, char(fileNames(n)),Q,S,N);
      disp(s1);
  end
end