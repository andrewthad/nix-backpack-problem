# Problem Using Backpack with Nix

The original problem that motivated this repository has been solved. The
solution is that `cabal configure` does not always work correctly in a
`nix-shell` and that `runhaskell Setup.hs configure` must be used instead.
However, a new problem has arisen, one more heinous than its predecessor.

## New Problem Description

Run the following commands, which results in the error shown afterwards:

```
bash> git clone https://github.com/andrewthad/nix-backpack-problem
bash> nix-build --pure release.nix
... elided for brevity ...
Preprocessing executable 'example' for nix-backpack-problem-1.0.0..
Building executable 'example' for nix-backpack-problem-1.0.0..
[1 of 1] Compiling Main             ( Main.hs, dist/build/example/example-tmp/Main.o )
/nix/store/ah79awgrjc75c68nn6gp32v4a9qli7mn-primitive-containers-0.1.0.0/lib/ghc-8.4.1/primitive-containers-0.1.0.0/Data/Map/Unboxed/Lifted.hi
Declaration for primitive-containers-0.1.0.0-Dh702QUZ6mrBrQ6cfYPU3V:Data.Map.Unboxed.Lifted.$fIsListMap2{v r8x}:
  Bad interface file: /nix/store/ah79awgrjc75c68nn6gp32v4a9qli7mn-primitive-containers-0.1.0.0/lib/ghc-8.4.1/primitive-containers-0.1.0.0/Map.hi
      Something is amiss; requested module  primitive-containers-0.1.0.0-JNYz44HuDdtIDtASnNcM9F-map-indef+2bbwYj3qpR1AhwaWbfmWe2:Map differs from name found in the interface file primitive-containers-0.1.0.0-JNYz44HuDdtIDtASnNcM9F-map-indef+K2XRbKjbYZpLEn7VFxOfUn:Map (if these names look the same, try again with -dppr-debug)

<no location info>: error:
    Cannot continue after interface file error
builder for '/nix/store/0bkrbljm2kyph09waf7lw9ksmqfkrckf-nix-backpack-problem-1.0.0.drv' failed with exit code 1
error: build of '/nix/store/0bkrbljm2kyph09waf7lw9ksmqfkrckf-nix-backpack-problem-1.0.0.drv' failed
```

Make sure you do not have a `dist` or `dist-newstyle` directory in here since
that confuses `nix-build` and can make it claim that it has successfully built
the project. I am able to successfully build this project, and projects like it,
with `cabal new-build` when I am not using `nix`. I suspect that the problem is
that the different instantiations of the same indefinite module are somehow
clobbering one another.

The compiler can be selected with an argument like `--argstr compiler ghc844`.

## Original (Solved) Problem Description

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


