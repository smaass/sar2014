SAR 2014
=======

<h3>Hacer que funcione en localhost</h3>

<p>Para poder desarrollar cómodamente en tu PC, viendo los cambios inmediátamente en localhost, seguir los siguientes pasos:</p>

<h4>1. Instalar XAMPP</h4>
<p>Descarga XAMPP de https://www.apachefriends.org/index.html. Luego instálalo e inícialo.</p>

<h4>2. Clonar el proyecto en la carpeta de XAMPP</h4>
<p>Clona el proyecto SAR2014 en la carpeta htdocs del directorio raíz de XAMPP. Luego podrás acceder al proyecto a través de http://localhost/sar2014. Sin embargo, si lo haces ahora verás que hay un error de base de datos, pues esta no existe.</p>

<h4>3. Configurar la base de datos</h4>
<p>Para que el proyecto funcione debes crear la base de datos. Para esto dirígete a http://localhost/phpmyadmin, y selecciona la pestaña "Databases". En esa pestaña crea una base de datos de nombre "5401_1401_g2", y luego selecciónala. Con la base de datos seleccionada, ve a la pestaña "Import" y selecciona el archivo "dump.sql" que se encuentra en la raíz del proyecto, luego haz click en "Ok". Ahora podrás acceder al SAR en http://localhost/sar2014, pero sin privilegios...</p>

<h4>4. Obtener acceso de administrador</h4>
<p>Todavía no sé cómo :(<p/>
