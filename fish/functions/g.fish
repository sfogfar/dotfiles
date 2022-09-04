function g --wraps=git --description 'alias g git'
  if count $argv > /dev/null
    git $argv;
  else
    git status --short --branch
  end
end
