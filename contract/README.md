Este contrato intenta reproducir un banco de cryptos (ether),
donde se le va a permitir a los usuarios, depositar y retirar
sus criptos (ether).

Para almacenar los saldos de los clientes, se usa una variable mapping,
con la direccion del cliente como campo indice, para guardar su saldo.

Contempla funciones de ingreso de ether, donde si el cliente existe, 
incrementa su saldo, y si no existe lo agrega y guarda su primer deposito.
Al mismo tiempo, almacena en una variable interna, el balance total del banco.

Otra funcion de egreso, que le permitira al cliente retirar su dinero, siempre
que tenga el saldo necesario para ello. Si la operacion se puede concretar,
el cliente obtendar sus ether, y la variable del balance del banco, tambien
quedara actualizada.
