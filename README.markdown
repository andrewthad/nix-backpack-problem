# Problem Using Backpack with Nix

The repository is a minimal example that reproduces an error I encounter when
trying to use `nix` to build a haskell project that has a dependency that
internally uses backpack. Steps to reproduce:

```
bash> git clone https://github.com/andrewthad/nix-backpack-problem
bash> nix-shell --attr env release.nix
nix-shell> cabal configure
Resolving dependencies...
Warning: solver failed to find a solution:
Could not resolve dependencies:
[__0] trying: nix-backpack-problem-1.0.0 (user goal)
[__1] next goal: primitive-containers (dependency of nix-backpack-problem)
[__1] rejecting: primitive-containers-0.1.0.0/installed-Dh7... (conflict:
primitive-containers =>
z-primitive-containers-z-set-indef==0.1.0.0/installed-ind...,
primitive-containers =>
z-primitive-containers-z-set-indef==0.1.0.0/installed-ind...)
[__1] fail (backjumping, conflict set: nix-backpack-problem,
primitive-containers)
After searching the rest of the dependency tree exhaustively, these were the
goals I've had most trouble fulfilling: nix-backpack-problem,
primitive-containers
Trying configure anyway.
Configuring nix-backpack-problem-1.0.0...
```

Interestingly, if I just `nix-build release.nix` instead, everything works fine.

Here's some other relevant background information. The package `primitive-containers`
is not yet on hackage. It's on my github. It depends on a fork of `primitive` that
has features that will be added to the next hackage release of `primitive`. Additionally,
`primitive-containers` uses backpack internally. It builds fine on its own
with `cabal new-build`.


