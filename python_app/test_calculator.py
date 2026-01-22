import pytest
from calculator import Calculator

def test_addition():
    calc = Calculator()
    assert calc.add(2, 3) == 5
    assert calc.add(-1, 1) == 0

def test_subtraction():
    calc = Calculator()
    assert calc.subtract(5, 3) == 2

def test_multiplication():
    calc = Calculator()
    assert calc.multiply(3, 4) == 12

def test_division():
    calc = Calculator()
    assert calc.divide(10, 2) == 5

def test_division_by_zero():
    calc = Calculator()
    with pytest.raises(ValueError):
        calc.divide(5, 0)

# Parameterized test
@pytest.mark.parametrize("a,b,expected", [(1,2,3), (5,5,10), (-1,1,0)])
def test_add_multiple(a, b, expected):
    calc = Calculator()
    assert calc.add(a, b) == expected