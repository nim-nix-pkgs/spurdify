{
  description = ''Spurdification library and CLI'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-spurdify-0_0_2.flake = false;
  inputs.src-spurdify-0_0_2.ref   = "refs/tags/0.0.2";
  inputs.src-spurdify-0_0_2.owner = "paradox460";
  inputs.src-spurdify-0_0_2.repo  = "spurdify";
  inputs.src-spurdify-0_0_2.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-spurdify-0_0_2"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-spurdify-0_0_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}