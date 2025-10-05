// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

/*
 * @title Contrato KibuBank
 * @author Sergio Morvillo - Estudiante Talento Tech - Comision 2025
 * @notice Este contrato es el inicio de proyecto final del Ethereum Developer Pack 
 * @custom:security Es un contrato educativo y no debe ser usado en producción 
 */ 
contract KipuBank {
	/*////////////////////////
			Variables de Estado
	////////////////////////*/

    ///@notice variable inmutable para almacenar la dirección del cliente que desea realizar una transaccion
	address immutable public i_cliente;
    ///@notice mapping para almacenar el saldo de la cuenta del cliente
	mapping(address => uint256) public s_cliente;
    // declaro variable con el balance del banco
	uint256 private balance;

	/*////////////////////////
			Eventos
	////////////////////////*/
	///@notice evento emitido cuando el cliente deposita dinero en su cuenta
    event KibuBank_deposito(address indexed cliente, uint256 montoDeposito);
    ///@notice evento emitido cuando el cliente retira dinero de su cuenta
    event KibuBank_retiro(address indexed cliente, uint256 montoRetiro);
	
	/*///////////////////////
			Errors
	///////////////////////*/
	///@notice error emitido cuando falla una transacción
	error KibuBank_OperacionFallida(bytes erro);
	///@notice error emitido cuando alguien intenta una trasanccion y no es un cliente reconodido
	error KibuBank_ClienteNoReconocido(address cliente);
	///@notice error emitido cuando el cliente quiere retirar mas dinero del que tiene en su cuenta
    error InvalidValue();

	/*////////////////////////
			Funciones
	////////////////////////*/
	///@notice 
	constructor(address _cliente){
		i_cliente = _cliente;
	}

	///@notice función depositar dinero en la cuenta del cliente
	receive() external payable{
        s_cliente[msg.sender] += msg.value;
		balance+=balance;  // incremneta el balance general del banco
		emit KibuBank_deposito(msg.sender, msg.value);
    }
    
	///@notice función depositar dinero en la cuenta del cliente
    fallback() external payable{
        s_cliente[msg.sender] += msg.value;
		balance+=balance;  // incremneta el balance general del banco
		emit KibuBank_deposito(msg.sender, msg.value);
    }
	
	///@notice función depositar dinero en la cuenta del cliente
    function deposito() external payable {
        s_cliente[msg.sender] += msg.value;
		balance += balance;  // incremneta el balance general del banco
		emit KibuBank_deposito(msg.sender, msg.value);
    }

	///@notice función retirar dinero en la cuenta del cliente
    function retiro(uint256 _monto) external {
		// Se obtiene el saldo actual del cliente
	    uint256 s_saldo = s_cliente[msg.sender];

    	// Intentar transferir el monto solicitado al cliente
        if (s_saldo>= _monto) {
			// Emitir el evento indicando que se está realizando un retiro	
  			emit KibuBank_retiro(msg.sender, s_saldo);

			(bool exito, bytes memory erro) = msg.sender.call{value: s_saldo}("");
	    	// Si la transferencia falla, revertir la transacción con el error
			if(exito) {
            	s_cliente[msg.sender] = s_cliente[msg.sender] - s_saldo; // decrementa el saldo del cliente
				balance-=balance;  // decrementa el balance general del banco
			} else {
				revert	KibuBank_OperacionFallida(erro);
        	}
    	} 
	}
}