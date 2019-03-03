%{

Script: main.m
Version of the MATLAB implemented: 2017a.

Author: Nadia Matos
email: nadiamatos.18@gmail.com

This script call the Hopfield.m script.

%}

clc; clear ('all'); close all;

img = Imagem();
inputs = [];

for i = 1 : 3
  inputs(:, :, i) = img.read(['padrao' num2str(i) '.bmp']);
end

rna = Hopfield(inputs, size(inputs, 3), size(inputs, 1)*size(inputs, 2), img);

rna.operation()
