

module Class.Applicative where

import Class.Functor

class Functor f => Applicative (f :: * -> *) where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b
    liftA2 :: (a -> b -> c) -> f a -> f b -> f c
    (*>) :: f a -> f b -> f b
    (<*) :: f a -> f b -> f a
    
    {-# MINIMAL pure, ((<*>) | liftA2) #-}