{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_QuickCheck (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [2,15,0,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/QuickCheck-2.15.0.1-35ad2c8532ef27bdef478a3c79a2f30ae37a96ca25aed18863772e364a97b392/bin"
libdir     = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/QuickCheck-2.15.0.1-35ad2c8532ef27bdef478a3c79a2f30ae37a96ca25aed18863772e364a97b392/lib"
dynlibdir  = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/QuickCheck-2.15.0.1-35ad2c8532ef27bdef478a3c79a2f30ae37a96ca25aed18863772e364a97b392/lib"
datadir    = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/QuickCheck-2.15.0.1-35ad2c8532ef27bdef478a3c79a2f30ae37a96ca25aed18863772e364a97b392/share"
libexecdir = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/QuickCheck-2.15.0.1-35ad2c8532ef27bdef478a3c79a2f30ae37a96ca25aed18863772e364a97b392/libexec"
sysconfdir = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/QuickCheck-2.15.0.1-35ad2c8532ef27bdef478a3c79a2f30ae37a96ca25aed18863772e364a97b392/etc"

getBinDir     = catchIO (getEnv "QuickCheck_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "QuickCheck_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "QuickCheck_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "QuickCheck_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "QuickCheck_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "QuickCheck_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
