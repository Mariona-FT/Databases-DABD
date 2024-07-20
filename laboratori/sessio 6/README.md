## Instruccions utilitzades en la sessió 6:


### PART 1:
instal·lar django al sistema: 
``
mariona@mariona-laptop:~$ python3 -m pip install Django``

Assegurar que s'ha instalat amb la comanda: 
``
mariona@mariona-laptop:~$ python3 -m django --version
5.0.4``

Crear una carpeta per aquesta sessió, i a dins d'aquesa crear el projecte de dabd:
``
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6$ django-admin startproject dabd``

Dins d'aquesta **ARRENCAR EL SERVIDOR**: 
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py runserver 8080
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).

You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.
April 27, 2024 - 10:41:01
Django version 5.0.4, using settings 'dabd.settings'
Starting development server at http://127.0.0.1:8080/
Quit the server with CONTROL-C.
```
Ara podrem entrar al server amb aquesta adreça: http://127.0.0.1:8080/

Crear una APLICACIÓ dins del projecte per gestionar productes anomenada: _producte_
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py startapp producte
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ ls
dabd  db.sqlite3  manage.py  producte
```

Crear una BASE DE DADES: 
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py migrate
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py createsuperuser
Username (leave blank to use 'mariona'): 
Email address: mariona@gmail.com
Password: **** 
Password (again): ****
This password is too short. It must contain at least 8 characters.
This password is too common.
This password is entirely numeric.
Bypass password validation and create user anyway? [y/N]: y
Superuser created successfully.
```

Ara es pot anar a: http://127.0.0.1:8080/admin

On hi haurà un login del superuser: user:mariona contra:****


### PART 2:
Crear els models: en el fitxer ``/dabd/producte/models.py``

Copiar l'esquema basic dels models: 
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ cat models.py 
from django.db import models

class ProductTemplate(models.Model):
    name = models.CharField(max_length=200)
    list_price = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    cost_price = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    salable = models.BooleanField()
    ...

    def __str__(self):
        return self.name


class ProductVariant(models.Model):
    template = models.ForeignKey(ProductTemplate, on_delete=models.CASCADE)
    code = models.CharField(max_length=200)
    ...

    def __str__(self):
        return '[' + self.code + '] ' + self.template.name
```

incloure l'aplicació producte dins del projecte de dabd, aixi que posar en els /dabd/dabd/setting.py
la línia: 
```
...
INSTALLED_APPS = [
    'producte.apps.ProducteConfig',
    ...
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
...
```

Guardar els canvis en el nostre model fent una migració:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py makemigrations producte
Migrations for 'producte':
  producte/migrations/0001_initial.py
    - Create model ProductTemplate
    - Create model ProductVariant
```
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py sqlmigrate producte 0001
BEGIN;
--
-- Create model ProductTemplate
--
CREATE TABLE "producte_producttemplate" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(200) NOT NULL, "list_price" decimal NOT NULL, "cost_price" decimal NOT NULL, "salable" bool NOT NULL);
--
-- Create model ProductVariant
--
CREATE TABLE "producte_productvariant" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "code" varchar(200) NOT NULL, "template_id" bigint NOT NULL REFERENCES "producte_producttemplate" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "producte_productvariant_template_id_98e2e5bf" ON "producte_productvariant" ("template_id");
COMMIT;
```
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, producte, sessions
Running migrations:
  Applying producte.0001_initial... OK
```

Indicar els models creats també son gestionables per la part administrativa del projecte:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ nano admin.py 
from django.contrib import admin

from .models import ProductTemplate, ProductVariant

admin.site.register(ProductTemplate)
admin.site.register(ProductVariant)
```

Ara si s'entra en servidor /admin, es pot veure que es pot administrar les plantilles del producte: **Product template**
i les variants del producte: **Produtc Variant**
(També ha de sortir :**Groups i Users**)


### EXERCICIS:

1. Canvia la configuració del fitxer ``dabd/settings.py`` per usar un altre SGBD com per exemple el PostgreSQL del servidor ubiwan.epsevg.upc.edu que escolta pel port 5432 (https://docs.djangoproject.com/en/3.1/ref/settings/#databases), 

Genera les taules a la nova base de dades ``(python manage.py migrate) ``i torna a crear un usuari administrador ``(python manage.py createsuperuser). ``

Per exemple, per PostgreSQL et caldrà instal·lar prèviament la llibreria de Python que permet connectar-se a una base de dades PostgreSQL ``(pip install psycopg2 o pip install psycopg2-binary).``

Verificar que hi ha instalat postgres:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ pip install psycopg2-binary

mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/dabd$ pip install mysql-connector-python
```


Canviar els settings del projecte:``dabd/dabd/settings.py``
```
...
DATABASES = {
    'default': {
       # 'ENGINE': 'django.db.backends.sqlite3',
       # 'NAME': BASE_DIR / 'db.sqlite3',
         'ENGINE': 'django.db.backends.postgresql',
        'NAME': '..',  # Nom de la teva base de dades
        'USER': '..',          # El teu usuari de PostgreSQL
        'PASSWORD': '...', # La contrasenya de PostgreSQL
        'HOST': 'ubiwan.epsevg.upc.edu', # Servidor de la base de dades
        'PORT': '5432',            # Port del servidor de PostgreSQL
        }
}
...
```
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, producte, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying producte.0001_initial... OK
  Applying sessions.0001_initial... OK

mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py createsuperuser
Username (leave blank to use 'mariona'): 
Email address: mariona@gmail.com
Password: ****
Password (again): ****
This password is too short. It must contain at least 8 characters.
This password is too common.
This password is entirely numeric.
Bypass password validation and create user anyway? [y/N]: y
Superuser created successfully.
```


2. Afegeix una nova entitat ProductCategory que siguin les categories (o famílies) de productes que permeti guardar el nom de la categoria, la categoria pare (per tal d'implementar una relació jeràrquica, una categoria pot contenir vàries subcategories i així successivament). 
I entre les plantilles de productes i categories hi ha una relació de molts a molts (many2many), doncs una plantilla de productes pot pertànyer a vàries categories i viceversa (afegiu aquesta relació només en un lloc, per exemple un camp ManyToManyField a ProductCategory que apunti a ProductTemplate; 
Django ja crea automàticament la taula intermèdia que implementa la relació de molts a molts). 
Els camps categoria pare i plantilles de producte haurien de poder ser buits o nulls; mireu a la documentació de Django com podeu usar les opcions blank i null, doncs per defecte els camps no poden ser buits.

Nova ENTITAT guardar en els models:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ cat models.py 
from django.db import models

# Create your models here.
class ProductCategory(models.Model):
    name = models.CharField(max_length=200)
    parent = models.ForeignKey(
        'self', on_delete=models.CASCADE,
        null=True, blank=True,
        related_name='subcategories'
    )
    product_templates = models.ManyToManyField(
        'ProductTemplate',
        blank=True,
        related_name='categories'
    )

    def __str__(self):
        return self.name


class ProductTemplate(models.Model):
    name = models.CharField(max_length=200)
    list_price = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    cost_price = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    salable = models.BooleanField()
    ...

    def __str__(self):
        return self.name


class ProductVariant(models.Model):
    template = models.ForeignKey(ProductTemplate, on_delete=models.CASCADE)
    code = models.CharField(max_length=200)
    ...

    def __str__(self):
        return '[' + self.code + '] ' + self.template.name
```

Guardar els canvis:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py makemigrations
Migrations for 'producte':
  producte/migrations/0002_productcategory.py
    - Create model ProductCategory
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, producte, sessions
Running migrations:
  Applying producte.0002_productcategory... OK
```

Fer que es pugui també gestionar per l'admin: 
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ cat admin.py 
from django.contrib import admin

# Register your models here.
from .models import ProductTemplate, ProductVariant, ProductCategory

admin.site.register(ProductTemplate)
admin.site.register(ProductVariant)
admin.site.register(ProductCategory)
```

### PART 3:
Arranca la shell de python amb accés a Django i executa una a una aquestes instruccions per veure que passa. Comprovaràs que pots fer SQL queries amb simples instruccions Python. 
Prèviament has d'haver afegit un parell de plantilles de producte des de la part d'administració de Django, afegeix per exemple "Bicicleta BMX" i "Bicicleta MTB".

Entrar en el servidor en admin i fer ADD de Product Template: http://127.0.0.1:8080/admin/producte/producttemplate/ 
```
Select product template to change
ADD PRODUCT TEMPLATE
Action: 
---------
 Go 0 of 2 selected

PRODUCT TEMPLATE
	Bicicleta MTB
	Bicicleta BMX
```

Entrar en el SHELL:
```
python manage.py shell

In [2]: from producte.models import ProductTemplate, ProductVariant, ProductCategory

>>> # Obtenim tots els registres/objectes
In [6]: ProductTemplate.objects.all()
Out[6]: <QuerySet [<ProductTemplate: Bicicleta BMX>, <ProductTemplate: Bicicleta MTB>]>

In [7]: templates = ProductTemplate.objects.all()
   ...: for t in templates:
   ...: Iprint(t.name, t.list_price, t.cost_price)
   
Bicicleta BMX 25.00 30.00
Bicicleta MTB 55.00 120.00

>>> # Obtenim uns quants registres/objectes
In [9]: templates = ProductTemplate.objects.filter(name='Bicicleta BMX')

In [10]: templates[0]
Out[10]: <ProductTemplate: Bicicleta BMX>

In [11]: templates[0].list_price
Out[11]: Decimal('25.00')

>>> # Obtenim un únic registre/objecte i el modifiquem (també es pot usar update())
In [12]: t = ProductTemplate.objects.get(name='Bicicleta BMX')

In [13]: t
Out[13]: <ProductTemplate: Bicicleta BMX>

In [14]: t.list_price
Out[14]: Decimal('25.00')

In [15]: t.list_price=75.00

In [16]: t.save()

In [17]: t.list_price
Out[17]: 75.0

>>> # Creem un registre/objecte nou (també es pot usar create() i desprès l'eliminem
In [18]: t = ProductTemplate(name='Monopatí', list_price=200, cost_price=120, salable=True)

In [19]: ProductTemplate.objects.all()
Out[19]: <QuerySet [<ProductTemplate: Bicicleta MTB>, <ProductTemplate: Bicicleta BMX>]>

In [20]: t.save()

In [21]: ProductTemplate.objects.all()
Out[21]: <QuerySet [<ProductTemplate: Bicicleta MTB>, <ProductTemplate: Bicicleta BMX>, <ProductTemplate: Monopatí>]>

In [22]: t=ProductTemplate.objects.get(name='Monopatí')

In [23]: t.delete()
Out[23]: (1, {'producte.ProductTemplate': 1})

In [24]: ProductTemplate.objects.all()
Out[24]: <QuerySet [<ProductTemplate: Bicicleta MTB>, <ProductTemplate: Bicicleta BMX>]>
```

### PART 4:
Ara crear una simple pàgina web en la part pública del nostre web,
En _producte/views.py_ posar les vistes que es volen implementar. 
Ara fer un llistat dels productes que es poden oferir
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ cat views.py 

from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
from .models import ProductTemplate, ProductVariant

def index(request):
    product_list = ProductVariant.objects.all()
    output = '<br>'.join([
    	'<a href="/producte/%s">[%s] %s</a>' % (p.id, p.code, p.template.name)
    	for p in product_list if p.template.salable])
    return HttpResponse(output)


def producte(request, producte_id):
    p = ProductVariant.objects.get(id=producte_id)
    output = 'Codi: %s<br>Nom: %s<br>Preu venda: %s' % (p.code, p.template.name, p.template.list_price)
    return HttpResponse(output)
```

Crear el fitxer *producte/urls.py* per enllaçar les dues vistes definides anteriorment
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ cat urls.py 
from django.urls import path
from . import views

urlpatterns = [
    # ex: /producte/
    path('', views.index, name='index'),
    # ex: /producte/5/
    path('<int:producte_id>/', views.producte, name='producte'),
]
```

Crear el modificar *dabd/urls.py* per enllaçar les rutes dels productes
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/dabd$ cat urls.py 
"""
URL configuration for dabd project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include,path

urlpatterns = [
    path('producte/', include('producte.urls')),
    path('admin/', admin.site.urls),
]
...
```

Executar el servidor: 
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py runserver 8080
 ```
Per veure el llistat dels productes a :`` http://127.0.0.1:8080/producte/``

Han de ser SALABLE + SER VARIANT --> TENIR UN CODI !!

Exemple llistat: http://127.0.0.1:8080/producte/
  - [12344] Patins
  - [1111] Monocicle
  - [Blava] Bicicleta BMX
  - [Vermella] Bicicleta BMX
  - [Verda] Bicicleta BMX

El llistat son enllaços que porta a una pàgina amb la seva informació: 
-  [Vermella] Bicicleta BMX
    - http://127.0.0.1:8080/producte/5/
    - Codi: Vermella
    - Nom: Bicicleta BMX
    - Preu venda: 75.00

### PART 5:
	
Crear dades ficticies

Per aconseguir numeros aleatoris i dades aleatories instalar llibreria: **faker**

``
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/dabd$ pip install faker``

A dins del projecte de django es poden tenir scripts pròpis, i executar-los amb el *manage.py*

Aquest lhem de posar en la carpeta: 
```
django/dabd/producte/management/commands/createdata.py

mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ cd producte/
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ mkdir -p management
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte$ cd management/
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte/management$ mkdir -p commands
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte/management$ cd commands/
Crear el fitxer:
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte/management/commands$
nano createdata.py 
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd/producte/management/commands$
cat createdata.py 
import random
import faker.providers
from faker import Faker
```
```
from django.core.management.base import BaseCommand
from producte.models import ProductTemplate, ProductVariant, ProductCategory

CATEGORIES = [
  'patinet',
  'bici',
  'moto',
  'cotxe',
  'camio',
  'autocar',
  'excavadora',
  'tractor',
  'caravana',
  'autocaravana'
  ]

NUM_PRODUCT_TEMPLATES = 100
NUM_PRODUCT_PRODUCTS = 200
NUM_PRODUCT_CATEGORIES = len(CATEGORIES)

class Provider(faker.providers.BaseProvider):
  def producte_categoria(self):
    return self.random_element(CATEGORIES)

class Command(BaseCommand):
  help = "Create example data"

  def handle(self, *args, **kwargs):
    fake = Faker()
    fake.add_provider(Provider)

    # Product templates creation
    for i in range(NUM_PRODUCT_TEMPLATES):
      name = ' '.join(fake.words(nb=2, part_of_speech='noun'))
      cost_price = random.randint(0, 99999)/100
      # list_price = [cost_price, cost_price*2]
      list_price = round(cost_price * (1+random.random()),2)
      salable = random.choice([False, True])
      print(name, cost_price, list_price, salable)
      ProductTemplate.objects.create(
        name=name,
        list_price=list_price,
        cost_price=cost_price,
        salable=salable)
    templates = ProductTemplate.objects.all()
    print(templates.count(), "product templates added.")

    # Product variantss creation
    for i in range(NUM_PRODUCT_PRODUCTS):
      code = fake.unique.bothify('PROD-??-###', letters='ABCDE')
      if i<NUM_PRODUCT_TEMPLATES:
        # Així ens assegurem que cada plantilla tingui almenys un producte
        template = templates[i]
      else:
        template = random.choice(templates)
      print(code, template)
      ProductVariant.objects.create(
        code = code,
        template = template
      )
    products = ProductVariant.objects.all()
    print(products.count(), "products added.")

    # Product categories creation
    for i in range(NUM_PRODUCT_CATEGORIES):
      name = fake.unique.producte_categoria()
      parent = None
      # Només la 2a meitat de categories tindran categoria pare
      if (i>NUM_PRODUCT_CATEGORIES/2):
        parent = random.choice(ProductCategory.objects.all())
      # Escollim entre 1 i 5 templates que tindrà cada categoria
      ptemplates = random.choices(templates, k=random.randint(1,5))
      print(name, parent, ptemplates)
      c = ProductCategory.objects.create(
        name = name,
        parent = parent,
      )
      # Afegim les plantilles associades a cada categoria (camp rel és una camp ManyToManyField)
      for t in ptemplates:
        c.product_templates.add(t)
      c.save()
    categories = ProductCategory.objects.all()
    print(categories.count(), "categories added.")
```

Executar el script en CARPETA ORIGINAL PROJECTE:
```
mariona@mariona-laptop:~/Documentos/altres-DABD/sessio6/dabd$ python3 manage.py createdata 
discipline animal 562.36 661.38 True
water bottom 601.08 1096.88 False
debt period 348.23 364.04 False
...
possession station 135.18 199.3 False
stranger bridge 394.84 510.42 True
imagination spirit 772.79 1285.7 True
birth love 969.92 1228.69 False
506 product templates added.
PROD-BE-893 Bicicleta MTB
PROD-AD-887 extent replacement
PROD-DA-047 Monocicle
PROD-EE-493 Patins
PROD-EA-919 bicicleta yy
PROD-DC-309 tricicle 200
...
PROD-DD-458 board card
PROD-BD-297 funeral towel
PROD-EE-376 structure bicycle
PROD-DB-581 seat shoe
PROD-EC-136 exit sex
1006 products added.
caravana None [<ProductTemplate: disaster football>, <ProductTemplate: store lecture>, <ProductTemplate: church cousin>]
camio None [<ProductTemplate: end diet>]
cotxe None [<ProductTemplate: tooth permission>, <ProductTemplate: member event>, <ProductTemplate: pride level>, <ProductTemplate: signal review>]
autocar None [<ProductTemplate: pie farm>, <ProductTemplate: garden site>, <ProductTemplate: surprise occasion>]
excavadora None [<ProductTemplate: computer independence>, <ProductTemplate: skin structure>, <ProductTemplate: garage counter>, <ProductTemplate: meaning ruin>, <ProductTemplate: education distribution>]
autocaravana None [<ProductTemplate: shame subject>, <ProductTemplate: medicine resource>, <ProductTemplate: weekend balance>]
moto cotxe [<ProductTemplate: board card>, <ProductTemplate: layer town>, <ProductTemplate: voice teacher>]
patinet caravana [<ProductTemplate: shelter relationship>, <ProductTemplate: calendar meal>, <ProductTemplate: scheme painting>]
bici camio [<ProductTemplate: stroke coffee>, <ProductTemplate: situation salt>, <ProductTemplate: board card>, <ProductTemplate: understanding efficiency>, <ProductTemplate: community news>]
tractor cotxe [<ProductTemplate: judge plane>, <ProductTemplate: mouse comment>, <ProductTemplate: emergency cookie>, <ProductTemplate: homework activity>]
11 categories added.
```
