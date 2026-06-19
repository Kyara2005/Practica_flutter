## Informe corto para README

### Flujo funcional
1. `ProductosPage`: el usuario selecciona un producto.
2. `ResumenPage`: se muestra el producto y el total; se confirma el pago.
3. `PagoPage`: se ingresa el nombre del titular, número de tarjeta, expiración y CVV.
4. `ResultadoPage`: se simula la aprobación o rechazo del pago.
5. `HistorialPage`: se consultan los pagos guardados.

### Validaciones
Cada transacción guarda la siguiente información:
- Nombre del titular obligatorio.
- Número de tarjeta obligatorio.
- Número de tarjeta con mínimo 16 dígitos.
- Fecha de expiración obligatoria.
- CVV obligatorio con exactamente 3 dígitos.
- No se guarda la tarjeta completa ni el CVV.

### Datos guardados
- Producto comprado
- Titular de la tarjeta
- Total de la transacción
- Últimos 4 dígitos de la tarjeta
- Estado del pago: `APROBADO` o `RECHAZADO`
- Fecha de la transacción

### 📸 Capturas de pantalla

#### 🛍️ Productos
<img width="720" height="1650" src="https://github.com/user-attachments/assets/a3510211-6959-4011-bdc5-021a69df8632" />

#### 📄 Resumen
<img width="720" height="1650" alt="image" src="https://github.com/user-attachments/assets/f581ff9c-e54c-4e48-bfbd-80d685341ab3" />

#### 💳 Formulario de pago
<img width="720" height="1650" src="https://github.com/user-attachments/assets/1b32e451-d035-47ba-a7b0-8ae6fa48ab54" />

#### ✍️ Proceso de pago
<img width="720" height="1650" src="https://github.com/user-attachments/assets/344f05e1-c314-4715-aa66-a1dbddd54632" />

#### ⚖️ Resultado
<img width="720" height="1650" src="https://github.com/user-attachments/assets/69080a40-067a-459c-b9f1-ab32e6b62392" />

#### 📊 Historial
<img width="720" height="1650" src="https://github.com/user-attachments/assets/6e514f53-31a3-4984-940b-07c535d48ec8" />### 

#### Supabase
<img width="1588" height="255" alt="image" src="https://github.com/user-attachments/assets/1eeee880-4f10-477d-b986-88e047820793" />


