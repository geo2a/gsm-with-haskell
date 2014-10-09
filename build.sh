#!/bin/bash
rm dist/build/gsm-with-haskell/gsm-with-haskell
cabal configure
cabal build