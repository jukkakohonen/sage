"""
Exterior algebras Gröbner bases
"""

from sage.data_structures.bitset cimport FrozenBitset
from sage.rings.integer cimport Integer
from sage.algebras.clifford_algebra_element cimport CliffordAlgebraElement
from sage.structure.parent cimport Parent
from sage.structure.element cimport MonoidElement

cdef long degree(FrozenBitset X)
cdef CliffordAlgebraElement build_monomial(Parent E, FrozenBitset supp)

# Grobner basis functions
cdef class GroebnerStrategy:
    cdef Parent E  # the exterior algebra
    cdef int side
    cdef MonoidElement ideal
    cdef bint homogeneous

    cdef inline bint build_S_poly(self, CliffordAlgebraElement f, CliffordAlgebraElement g)

    cdef inline FrozenBitset leading_supp(self, CliffordAlgebraElement f)
    cdef inline partial_S_poly_left(self, CliffordAlgebraElement f, CliffordAlgebraElement g)
    cdef inline partial_S_poly_right(self, CliffordAlgebraElement f, CliffordAlgebraElement g)
    cdef set preprocessing(self, list P, list G)
    cdef list reduction(self, list P, list G)

    # These are the methods that determine the ordering of the monomials.
    # These must be implemented in subclasses. Declare them as "inline" there.
    cdef Integer bitset_to_int(self, FrozenBitset X)
    cdef FrozenBitset int_to_bitset(self, Integer n)

cdef class GroebnerStrategyNegRevLex(GroebnerStrategy):
    pass

cdef class GroebnerStrategyDegRevLex(GroebnerStrategy):
    cdef Integer rank

cdef class GroebnerStrategyDegLex(GroebnerStrategy):
    cdef Integer rank

