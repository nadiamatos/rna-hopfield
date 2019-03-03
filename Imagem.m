%{

Script: main.m
Version of the MATLAB implemented: 2017a.

Author: Nadia Matos
email: nadiamatos.18@gmail.com

This script contains the class Imagem, for to capture data of images.

%}

classdef Imagem < handle

  properties
    dimensions = 10*ones(1, 2); name = [];
    image = []; maxGray = 255; minGray = 0;
    coordinates = []; obstacles = [];
  end

  methods
    function obj = Imagem()
      obj.image = obj.maxGray*ones(obj.dimensions(1), obj.dimensions(2));
    end

    function out = read(obj, name)
      obj.name = name; aux = imread(obj.name);
      obj.image = im2bw(aux, 0.5);
      obj.dimensions = size(obj.image);
      out = obj.image;
    end

    function write(obj, data)
      if (~isempty(data)) obj.image = data; end
      obj.image = uint8(mat2gray(obj.image));
      imwrite(obj.image, ['out' obj.name]);
    end

    function processing(obj)
      aux = find(obj.image == 0);
      if ~(isempty(aux))
        obj.image(aux) = -1*ones(size(aux, 1), 1);
      end
    end

  end

end
