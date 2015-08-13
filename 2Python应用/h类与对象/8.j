#简化数据结构的初始化
#可以在一个基类中写一个公用的__init__()函数，让其它类继承它。

==============================================================

import math

class Structure1:
	#Class variable that specifies expected fields
	_fields = []

	def __init__(self, *args):
		if len(args) != len(self._fields):
			raise TypeError('Expected {} arguments'.format(len(self._fields)))
	#Set the arguments
	for name,value in zip(self._fields,args):
		setattr(self,name,value)


#继承自这个基类

#Example class definitions
class Stock(Structure1):
	_fields = ['name','shares','price']

class Point(Structure1):
	_fields = ['x','y']

class Circle(Structure1):
	_fields = ['radius']

	def area(self):
		return math.pi * self.radius ** 2

========================================================================

支持关键字参数

class Structure2:
	_fields = []

	def __init__(self,*args,**kwargs):
		if len(args) > len(self._fields):
			raise TypeError('Expected {} arguments'.format(len(self._fields)))

		#Set all of the positional arguments
		for name,value in zip(self._fields,args):
			setattr(self,name,value)

		#Set the remaining keyword arguments
		for name in self._fields[len[args):]:
			setattr(self,name,kwargs.pop(name))

		#Check for any remaining unknown arguments
		if kwargs:
			raise TypeError('Invalid argument(s): {}'.format(','.join(kwargs)))

#Example use
if __name__ == '__main__':
	class Stock(Structure2):
		_fields = ['name','shares','price']

	s1 = Stock('ACME',50,91.1)
	s2 = Stock('ACME',50,price=91.1)
	s3 = Stock('ACME',shares=50,price=91.1)

=========================================================

#将不在_fields中的名称加入到属性中去

class Structure3:
    # Class variable that specifies expected fields
    _fields = []

    def __init__(self, *args, **kwargs):
        if len(args) != len(self._fields):
            raise TypeError('Expected {} arguments'.format(len(self._fields)))

        # Set the arguments
        for name, value in zip(self._fields, args):
            setattr(self, name, value)

        # Set the additional arguments (if any)
        extra_args = kwargs.keys() - self._fields
        for name in extra_args:
            setattr(self, name, kwargs.pop(name))

        if kwargs:
            raise TypeError('Duplicate values for {}'.format(','.join(kwargs)))

# Example use
if __name__ == '__main__':
    class Stock(Structure3):
        _fields = ['name', 'shares', 'price']

    s1 = Stock('ACME', 50, 91.1)
    s2 = Stock('ACME', 50, 91.1, date='8/2/2012')

