


module Data.Either where

import Class.Functor
import Class.Applicative
import Class.Monad

data Either a b = Left a | Right b

type Maybe a = Either () a

left :: a -> Either a b
left = Left

right :: b -> Either a b
right = Right

just :: a -> Maybe a
just = Right

nothing :: Maybe a
nothing = Left ()

instance Functor (Either a) where
    map f (Right x) = Right (f x)
    map f (Left x)  = Left x

instance Applicative (Either a) where
    pure a = Right a

    Right f <*> Right x = Right (f x)
    _       <*> Left  x = Left x
    Left x  <*> _       = Left x

instance Monad (Either a) where
    Right x >>= f = f x
    Left x  >>= _ = Left x


--
newtype EitherT m a b = EitherT { runEitherT :: m (Either a b) }

instance Functor m => Functor (EitherT m a) where
    map f (EitherT x) = EitherT (map (map f) x)

instance Monad m => Applicative (EitherT m a) where
    pure a = EitherT (pure (Right a))

    EitherT mf <*> EitherT mx 
        = EitherT (mf >>= \f -> 
                   mx >>= \x -> 
                   return (f <*> x))

instance Monad m => Monad (EitherT m a) where
    EitherT mx >>= f 
        = EitherT (mx >>= \case
            Left  x -> Left x
            Right a -> f a)
    









