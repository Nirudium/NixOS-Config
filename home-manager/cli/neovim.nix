{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.oxocarbon.enable = true;
    plugins = {
      lightline.enable = true;
      chadtree.enable = true;
      treesitter.enable = true;
      nvim_lsp.enable = true; 
      

      #cmp
      nvim-cmp.enable = true;
      cmp-treesitter.enable = true;
      cmp-vim-lsp.enable = true; 
      cmp-buffer.enable = true;
      cmp-path.enable = true;
    };

    options = {
      number = true; 
      shiftwidth = 2;
    };
    keymaps = [
      {key = "j"; action = "<cmd>CHADopen<cr>";}
    ];
  };
}
