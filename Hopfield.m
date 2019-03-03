%{

Script: Perceptron.m
Version of the MATLAB implemented: 2017a.

Author: Nadia Matos
email: nadiamatos.18@gmail.com

This script is of Hopfield RNA, doing learning and operation process.

%}

classdef Hopfield < handle

  properties
    quantityOutputRna = 1; quantityInputRna = 0;
    inputRna = []; weigthRna = []; quantPatterns = 0;
    img = [];
  end

  methods

    function obj = Hopfield(database, quantPatterns, quantInputs, img)
      obj.inputRna = database;
      obj.quantityInputRna = quantInputs;
      obj.quantPatterns = quantPatterns;
      obj.img = img;

      obj.externalProduct();
    end

    function externalProduct(obj)
      z = []; aux = 0;
      for i = 1 : obj.quantPatterns
        for j = 1 : size(obj.inputRna, 1)
          z(i, end+1:end+size(obj.inputRna, 2)) = obj.inputRna(j, :, i);
        end
        aux = aux + z(i, :)*(z(i, :)');
      end
      obj.weigthRna = (1/obj.quantityInputRna)*aux*(-1*obj.quantPatterns/obj.quantityInputRna)*eye(obj.quantityInputRna)
    end

    function y = functionActivation(obj, u)
      % parameter of the activation function
      if (u >= 0) y = 1; else y = 0; end
    end

    function operation(obj)
      while true
        disp('Working ...');
        aux = input('\nDigite o nome da imagem padrao: ', 's');
        inputTest = obj.img.read(aux);
        outputTest = [];

        x = []; u = []; outCurrent = []; outLast = [];

        for i = 1 : size(inputTest, 1)
          x(1, end+1:end+size(obj.inputRna, 2)) = inputTest(i, :);
        end
        outCurrent(1, :) = x;

        while true
          outLast = outCurrent; % 1x256, W 256x256
          for i = 1 : 256
            u(1, i) = obj.weigthRna(i, :)*outLast';
            outCurrent(1, i) = obj.functionActivation(u(1, i));
          end
          if (outCurrent - outLast) break; end
        end

        k = 0;
        for i = 1 : size(inputTest, 1)
          outputTest(i, :) = outCurrent(1, k+1:k+size(obj.inputRna, 2));
          k = k + size(obj.inputRna, 2);
        end
        subplot(1, 2, 1); imshow(inputTest)
        subplot(1, 2, 2); imshow(outputTest)
        
      end
    end
  end

end
