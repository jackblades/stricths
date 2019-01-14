


module Class.Functor where

class Functor f where
    map :: (a -> b) -> f a -> f b
    (<$) :: a -> f b -> f a
    
    {-# MINIMAL map #-}