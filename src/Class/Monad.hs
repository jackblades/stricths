
module Class.Monad where

import Class.Applicative

class Applicative m => Monad (m :: * -> *) where
    (>>=) :: m a -> (a -> m b) -> m b
    (>>) :: m a -> m b -> m b
    return :: a -> m a

    {-# MINIMAL (>>=) #-}

class Monad m => MonadRunnable m where
    runM :: m a -> a

    {-# MINIMAL runM #-}