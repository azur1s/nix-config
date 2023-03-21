vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use "nyoom-engineering/oxocarbon.nvim"
end)
