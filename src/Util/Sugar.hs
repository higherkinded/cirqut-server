module Util.Sugar
  ( if'
  ) where


if' :: Bool -> b -> b -> b
if' predicate x y = if predicate then x else y