{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE RankNTypes #-}

module Lang.Crucible.Go.Types where

import qualified Data.Parameterized.Context as Ctx

import           Language.Go.AST
import           Language.Go.Types

import           Lang.Crucible.CFG.Extension
import qualified Lang.Crucible.CFG.Generator as Gen
import           Lang.Crucible.Types

----------------------------------------------------------------------
-- | Go extension tag.

newtype Go = Go ()

type instance ExprExtension Go = EmptyExprExtension
type instance StmtExtension Go = EmptyStmtExtension

instance IsSyntaxExtension Go

type Verbosity = Int


type VariableAssignment s ctx = Ctx.Assignment (GoVarOpen s) ctx

-- | GoVarReg and GoVarOpen are respectively the closed (abstracting
-- from type parameters) and open representations of Crucible
-- registers that store the value of a variable with a given type.

newtype GoVarOpen s tp = GoVarOpen {unGoVarOpen :: Gen.Reg s (ReferenceType tp)}
data GoVarReg s where
  GoVarReg :: TypeRepr tp -> Gen.Reg s (ReferenceType tp) -> GoVarReg s

newtype LabelStack s = LabelStack [Gen.Label s]


-- | The 'TypeRepr' and the zero initializer value for a given type
data ReprAndValue = forall typ. ReprAndValue (TypeRepr typ) (forall ext s. Gen.Expr ext s typ)

data SomeRepr = forall typ. SomeRepr (TypeRepr typ)
