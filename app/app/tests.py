from django.test import SimpleTestCase
from app import calc
class calcTest(SimpleTestCase):
    def test_add(self):
        res=calc.add(5,8)
        self.assertEqual(res,13)