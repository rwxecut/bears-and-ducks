Заметка: `setmetatable(x, y)` возвращает `x`.

# Наследование

Данная версия наследования обеспечивает наследование
всех полей таблицы. При этом поле таблицы __index
зарезервировано для указания таблицей на саму себя.
Это важно при установке себя как метатаблицы
при создании своих экземпляров.

Кроме того, возможно определить специальные методы
такие как __call для своих экземпляров,
но по умолчанию они не будут наследоваться далее.

Пусть
* `table` - Таблица
* `metatable` - Метатаблица таблицы table
* `key` - ключ

Вычисление `table.key / table[key]` состоит из двух этапов:
1. Проверка, присутствует ли key в table.
2. Если нет, поиск с помощью metatable.__index.

В случае, когда metatable.__index == nil,
будет возвращен nil.

В случае, когда metatable.__index это функция,
будет возвращен metatable.__index(table, key_name)

В случае, когда metatable.__index это some_other_table,
поиск будет __аналогично__ проводиться в some_other_table.

Таким образом, если metatable.__index = table, на ключах,
отсутствующих в table мы получим бесконечную рекурсию.

## Вспомогательная функия `Construct`
```lua
function Construct(self, t)
    local o = t or {}
    self.__index = self
    return setmetatable(o, self)
end
```
Все самое важное находится в данной функции. Она предназначена
для подстановки в конструкторы для того чтобы ничего не забыть.

На самом деле, поигравшись с этой функцией можно наладить и
наследование специальных методов, но нам это не нужно.

Строка `local o = t or {}` позволяет передать таблицу t,
которая перекроет своими полями поля прототипа.
Если же она не будет передана, то перекрытия полей не произойдет.
Естественно, потом можно определить эти поля явно.

Строка `self.__index = self` выглядит странной, потому что она
как будто будет каждый раз делать одно и то же.
Она действительно ничего не делает, когда у одного и того же
класса повторно вызывается конструктор.
Но суть в том, что любой объект является прототипом.
Когда мы только создаем новый объект A, в нем не будет определено поле
`__index`, поэтому если мы попробуем создать из этого нового
объекта A новый объект B, то когда A установится как метатаблица
для B, наследование не будет работать потому что в метатаблице B
не будет поля `__index`.

Строка `return setmetatable(o, self)` собственно устанавливает
текущий объект как метатаблицу для создаваемого и возвращает наш
новосозданный объект, с которым потом в конструкторе можно
производить любые манипуляции.
В терминах переменных данной функции, когда будет производиться
поиск `o.key / o[key]`, проверится сначала содержимое `o`,
а потом пойдет поиск в `self.__index` = `self`,
то есть в прототипе `o`.

__Важно__, что Animal не установлен как metatable для себя.
Иначе мы бы получили бесконечную рекурсию при поиске
отсутствующих полей.

Кстати, еще можно наследоваться от прототипов, написанных не вами.
Вот только они могут сломаться если что-то ожидают от __index,
или, например, если они установлены как метатаблицы для самих себя.

## Класс Animal.
```lua
local Animal = {
    sound = "..."
}

function Animal:new(t)
    return Construct(self, t)
end

function Animal:say()
    print("Animal \"" .. self:getName() .. "\" says \"" .. self.sound .. "\"")
end

function Animal:getName()
    return self.name or "unknown"
end
```

## Класс Dog

Наследуемся от Animal.
Переопределяем `sound` и `new` в Dog.

Для всех остальных полей Dog будет производиться
поиск с помощью metatable.__index = Animal.

У instances Dog же metatable.__index будет равен Dog,
то есть любые поля, отсутствующие в instance,
будут искаться в Dog, а если их там нет, то уже в Animal.
```lua
local Dog = Animal:new {sound = "woof"}

function Dog:new(t)
    local o = Construct(self, t)
    print("Custom constructor!")
    return o
end
```

## Класс Cat

Наследуемся от Animal.
Переопределяем только `sound`.
```lua
local Cat = Animal:new {sound = "meow"}
```

## Класс Fish
Наследуемся от Animal.
Переопределяем только `say`.
```lua
local Fish = Animal:new()

function Fish:say()
    print("Animal \"" .. (self.name or "unknown") .. "\" makes a bubble")
end
```

## Instances
```lua
local a = Animal:new()
a:say()
-- Animal "unknown" says "..."

local d = Dog:new()
d:say()
-- Animal "unknown" says "woof"

local c = Cat:new()
c:say()
-- Animal "unknown" says "meow"

local f = Fish:new()
f:say()
-- Animal "unknown" makes a bubble
```

## More instances
```lua
local a_n = Animal:new {name = "Amy"}
a_n:say()
-- Animal "Amy" says "..."

local d_n = Dog:new {name = "Dan"}
d_n:say()
-- Animal "Dan" says "woof"

local c_n = Cat:new {name = "Cinnamon"}
c_n:say()
-- Animal "Cinnamon" says "meow"

local f_n = Fish:new {name = "Franklin"}
f_n:say()
-- Animal "Franklin" makes a bubble
```

## Пример с `__call`
```lua
local Bear = Animal:new {name = "Boris", sound = "ROAR"}

function Bear:__call()
    print("Bear_instance:__call")
    self:say()
end

local b = Bear:new()

b()
-- Bear_instance:__call
-- Animal "Boris" says "ROAR"
```