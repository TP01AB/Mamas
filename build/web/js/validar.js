/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//Validacion cambio en perfil.
function validarPerfil() {
    const form = document.getElementById("perfil");
    const email = document.getElementById("emailRegistro");
    const nombre = document.getElementById("nombre");
    const apellidos = document.getElementById("apellidos");
    const dni = document.getElementById("dni");
    const telefono = document.getElementById("telefono");
    const nacimiento = document.getElementById("nacimiento");
    const emailError = document.getElementById("emailRegistroError");
    const nombreError = document.getElementById("nombreError");
    const apellidosError = document.getElementById("apellidosError");
    const dniError = document.getElementById("dniError");
    const telefonoError = document.getElementById("telefonoError");
    const nacimientoError = document.getElementById("nacimientoError");
    //-----------------------------FORMULARIO SUBMIT
    var correcto;
    form.addEventListener('submit', function (event) {
        if (!nombre.validity.valid) {
            error(nombre);
            event.preventDefault();
        }
        if (!apellidos.validity.valid) {
            error(apellidos);
            event.preventDefault();
        }
        if (!email.validity.valid) {
            error(email);
            event.preventDefault();
        }
        if (!dni.validity.valid) {
            error(dni);
            event.preventDefault();
        }
        if (!tfno.validity.valid) {
            error(tfno);
            event.preventDefault();
        }
    });
    nombre.addEventListener('blur', function (event) {
        if (nombre.validity.valid) {
            nombreError.className = 'valid-feedback';
            nombre.classList.add('is-valid');
            nombre.classList.remove('is-invalid');
            nombreError.textContent = '';
        } else {
            error(nombre);
        }
    });
    apellidos.addEventListener('blur', function (event) {
        if (apellidos.validity.valid) {
            apellidosError.className = 'valid-feedback';
            apellidos.classList.add('is-valid');
            apellidos.classList.remove('is-invalid');
            apellidosError.textContent = '';
        } else {
            error(apellidos);
        }
    });
    email.addEventListener('blur', function (event) {
        if (email.validity.valid) {
            emailError.className = 'valid-feedback';
            email.classList.add('is-valid');
            email.classList.remove('is-invalid');
            emailError.textContent = '';
        } else {
            error(email);
        }
    });
    dni.addEventListener('blur', function (event) {
        if (dni.validity.valid) {
            dniError.className = 'valid-feedback';
            dni.classList.add('is-valid');
            dni.classList.remove('is-invalid');
            dniError.textContent = '';
        } else {
            error(dni);
        }
    });
    telefono.addEventListener('blur', function (event) {
        if (telefono.validity.valid) {
            telefonoError.className = 'valid-feedback';
            telefono.classList.add('is-valid');
            telefono.classList.remove('is-invalid');
            telefonoError.textContent = '';
        } else {
            error(telefono);
        }
    });
    function error(campo) {
        if (campo == nombre) {
//Campo vacío
            if (nombre.validity.valueMissing) {
                nombreError.textContent = 'Debe introducir su nombre.';
            } else if (nombre.validity.tooShort) {
                nombreError.textContent = 'Debe tener al menos ' + nombre.minLength + ' caracteres; ha introducido ' + nombre.value.length;
            } else if (nombre.validity.tooLong) {
                nombreError.textContent = 'Debe tener como máximo ' + nombre.maxLength + ' caracteres; ha introducido ' + nombre.value.length;
            }
// Establece el estilo apropiado
            nombre.classList.remove('is-valid');
            nombre.classList.add('is-invalid');
            nombreError.className = 'invalid-feedback';
        }
        if (campo == apellidos) {
//Campo vacío
            if (apellidos.validity.valueMissing) {
                apellidosError.textContent = 'Debe introducir sus apellidos.';
            } else if (apellidos.validity.tooShort) {
                apellidosError.textContent = 'Debe tener al menos ' + apellidos.minLength + ' caracteres; ha introducido ' + apellidos.value.length;
            } else if (apellidos.validity.tooLong) {
                apellidosError.textContent = 'Debe tener como máximo ' + apellidos.maxLength + ' caracteres; ha introducido ' + apellidos.value.length;
            }
// Establece el estilo apropiado
            apellidos.classList.remove('is-valid');
            apellidos.classList.add('is-invalid');
            apellidosError.className = 'invalid-feedback';
        }
        if (campo == email) {
//Campo vacío
            if (email.validity.valueMissing) {
                emailError.textContent = 'Debe introducir su dirección de correo electrónico.';
                //No cumple los requisitos del campo email
            } else if (email.validity.typeMismatch) {
                emailError.textContent = 'El valor introducido debe ser una dirección de correo electrónico ';
                //Datos demasiado cortos
            }
// Establece el estilo apropiado
            email.classList.remove('is-valid');
            email.classList.add('is-invalid');
            emailError.className = 'invalid-feedback';
        }
        if (campo == dni) {
//Campo vacío
            if (dni.validity.valueMissing) {
                dniError.textContent = 'Debe introducir su dni.';
                //No cumple con el pattern
            } else if (dni.validity.patternMismatch) {
                dniError.textContent = 'El valor introducido debe seguir este patron 00000000X';
            }
// Establece el estilo apropiado
            dni.classList.remove('is-valid');
            dni.classList.add('is-invalid');
            dniError.className = 'invalid-feedback';
        }
        if (campo == telefono) {
            if (telefono.validity.valueMissing) {
                telefonoError.textContent = 'Debe introducir su teléfono.';
            } else if (telefono.validity.patternMismatch) {
                telefonoError.textContent = 'El valor introducido debe ser un numero de telefono de 9 digitos.';
            }
// Establece el estilo apropiado
            telefono.classList.remove('is-valid');
            telefono.classList.add('is-invalid');
            telefonoError.className = 'invalid-feedback';
        }
    }

}
//Validacion del formulario de registro.
function validarRegistro() {
//---------------------------VARIABLES
    const form = document.getElementById("registerForm");
    const email = document.getElementById("emailRegistro");
    const nombre = document.getElementById("nombre");
    const apellidos = document.getElementById("apellidos");
    const dni = document.getElementById("dni");
    const tfno = document.getElementById("telefono");
    const pass = document.getElementById("passwordRegistro");
    const nacimiento = document.getElementById("nacimiento");
    const emailError = document.getElementById("emailRegistroError");
    const nombreError = document.getElementById("nombreError");
    const apellidosError = document.getElementById("apellidosError");
    const dniError = document.getElementById("dniError");
    const tfnoError = document.getElementById("telefonoError");
    const passError = document.getElementById("passwordRegistroError");
    const nacimientoError = document.getElementById("nacimientoError");
    //-----------------------------FORMULARIO SUBMIT
    var correcto;
    form.addEventListener('submit', function (event) {
        if (!nombre.validity.valid) {
            error(nombre);
            event.preventDefault();
        }
        if (!apellidos.validity.valid) {
            error(apellidos);
            event.preventDefault();
        }
        if (!email.validity.valid) {
            error(email);
            event.preventDefault();
        }
        if (!dni.validity.valid) {
            error(dni);
            event.preventDefault();
        }
        if (!tfno.validity.valid) {
            error(tfno);
            event.preventDefault();
        }
        if (!pass.validity.valid) {
            error(pass);
            event.preventDefault();
        }
    });
    nombre.addEventListener('blur', function (event) {
        if (nombre.validity.valid) {
            nombreError.className = 'valid-feedback';
            nombre.classList.add('is-valid');
            nombre.classList.remove('is-invalid');
            nombreError.textContent = '';
        } else {
            error(nombre);
        }
    });
    apellidos.addEventListener('blur', function (event) {
        if (apellidos.validity.valid) {
            apellidosError.className = 'valid-feedback';
            apellidos.classList.add('is-valid');
            apellidos.classList.remove('is-invalid');
            apellidosError.textContent = '';
        } else {
            error(apellidos);
        }
    });
    email.addEventListener('blur', function (event) {
        if (email.validity.valid) {
            emailError.className = 'valid-feedback';
            email.classList.add('is-valid');
            email.classList.remove('is-invalid');
            emailError.textContent = '';
        } else {
            error(email);
        }
    });
    dni.addEventListener('blur', function (event) {
        if (dni.validity.valid) {
            dniError.className = 'valid-feedback';
            dni.classList.add('is-valid');
            dni.classList.remove('is-invalid');
            dniError.textContent = '';
        } else {
            error(dni);
        }
    });
    pass.addEventListener('blur', function (event) {
        if (pass.validity.valid) {
            passError.className = 'valid-feedback';
            pass.classList.add('is-valid');
            pass.classList.remove('is-invalid');
            passError.textContent = '';
        } else {
            error(pass);
        }
    });
    telefono.addEventListener('blur', function (event) {
        if (telefono.validity.valid) {
            telefonoError.className = 'valid-feedback';
            telefono.classList.add('is-valid');
            telefono.classList.remove('is-invalid');
            telefonoError.textContent = '';
        } else {
            error(telefono);
        }
    });
    function error(campo) {
        if (campo == nombre) {
//Campo vacío
            if (nombre.validity.valueMissing) {
                nombreError.textContent = 'Debe introducir su nombre.';
            } else if (nombre.validity.tooShort) {
                nombreError.textContent = 'Debe tener al menos ' + nombre.minLength + ' caracteres; ha introducido ' + nombre.value.length;
            } else if (nombre.validity.tooLong) {
                nombreError.textContent = 'Debe tener como máximo ' + nombre.maxLength + ' caracteres; ha introducido ' + nombre.value.length;
            }
// Establece el estilo apropiado
            nombre.classList.remove('is-valid');
            nombre.classList.add('is-invalid');
            nombreError.className = 'invalid-feedback';
        }
        if (campo == apellidos) {
//Campo vacío
            if (apellidos.validity.valueMissing) {
                apellidosError.textContent = 'Debe introducir sus apellidos.';
            } else if (apellidos.validity.tooShort) {
                apellidosError.textContent = 'Debe tener al menos ' + apellidos.minLength + ' caracteres; ha introducido ' + apellidos.value.length;
            } else if (apellidos.validity.tooLong) {
                apellidosError.textContent = 'Debe tener como máximo ' + apellidos.maxLength + ' caracteres; ha introducido ' + apellidos.value.length;
            }
// Establece el estilo apropiado
            apellidos.classList.remove('is-valid');
            apellidos.classList.add('is-invalid');
            apellidosError.className = 'invalid-feedback';
        }
        if (campo == email) {
//Campo vacío
            if (email.validity.valueMissing) {
                emailError.textContent = 'Debe introducir su dirección de correo electrónico.';
                //No cumple los requisitos del campo email
            } else if (email.validity.typeMismatch) {
                emailError.textContent = 'El valor introducido debe ser una dirección de correo electrónico ';
                //Datos demasiado cortos
            }
// Establece el estilo apropiado
            email.classList.remove('is-valid');
            email.classList.add('is-invalid');
            emailError.className = 'invalid-feedback';
        }
        if (campo == dni) {
//Campo vacío
            if (dni.validity.valueMissing) {
                dniError.textContent = 'Debe introducir su dni.';
                //No cumple con el pattern
            } else if (dni.validity.patternMismatch) {
                dniError.textContent = 'El valor introducido debe seguir este patron 00000000X';
            }
// Establece el estilo apropiado
            dni.classList.remove('is-valid');
            dni.classList.add('is-invalid');
            dniError.className = 'invalid-feedback';
        }
        if (campo == telefono) {
            if (telefono.validity.valueMissing) {
                telefonoError.textContent = 'Debe introducir su teléfono.';
            } else if (telefono.validity.patternMismatch) {
                telefonoError.textContent = 'El valor introducido debe ser un numero de telefono de 9 digitos.';
            }
// Establece el estilo apropiado
            telefono.classList.remove('is-valid');
            telefono.classList.add('is-invalid');
            telefonoError.className = 'invalid-feedback';
        }
        if (campo == pass) {
//Campo vacío
            if (pass.validity.valueMissing) {
                passError.textContent = 'Debe introducir una contraseña.';
                //Dato demasiado cortos
            } else if (pass.validity.tooShort) {
                passError.textContent = 'Debe tener al menos ' + pass.minLength + ' caracteres; ha introducido ' + pass.value.length;
                //Dato demasiado largo
            } else if (pass.validity.tooLong) {
                passError.textContent = 'Debe tener como máximo ' + pass.maxLength + ' caracteres; ha introducido ' + pass.value.length;
            }
// Establece el estilo apropiado
            pass.classList.remove('is-valid');
            pass.classList.add('is-invalid');
            passError.className = 'invalid-feedback';
        }
    }

}

//Validacion formulario login

function validacionLogin() {
    //Obtenemos formulario.
    const form = document.getElementById("loginForm");
    //Obtencion del campo email y su campo de error.
    const email = document.getElementById("emailLogin");
    const emailError = document.getElementById("emailLoginError");
    // Obtencion del campo password y su campo error.
    const password = document.getElementById("passwordLogin");
    const passwordError = document.getElementById("passwordLoginError");

    //Control de validacion en evento submit para el envio de formulario.
    form.addEventListener('submit', function (event) {
        if (!email.validity.valid) {
            error(email);
            event.preventDefault();
        }
        if (!password.validity.valid) {
            error(password);
            event.preventDefault();
        }
    });

    //Control de validacion en evento blur para cuando cambiamos el focus del input nos valide el campo.
    email.addEventListener('blur', function (event) {
        if (email.validity.valid) {
            emailError.className = 'valid-feedback';
            email.classList.remove('is-invalid');
            email.classList.add('is-valid');
            emailError.textContent = '';
        } else {
            error(email);
        }
    });
    password.addEventListener('blur', function (event) {
        if (password.validity.valid) {
            passwordError.className = 'valid-feedback';
            password.classList.remove('is-invalid');
            password.classList.add('is-valid');
            passwordError.textContent = '';
        } else {
            error(password);
        }
    });
    // fucnion para gestion de error por parametro del campo que genera el error en formulario
    function error(campo) {
        if (campo == email) {
            //Campo vacío
            if (email.validity.valueMissing) {
                emailError.textContent = 'Debe introducir su dirección de correo electrónico.';
                //No cumple los requisitos del campo email
            } else if (email.validity.typeMismatch) {
                emailError.textContent = 'El valor introducido debe ser una dirección de correo electrónico ';
                //Datos demasiado cortos
            }
            // Establece el estilo apropiado
            email.classList.remove('is-valid');
            email.classList.add('is-invalid');
            emailError.className = 'invalid-feedback';
        }
        if (campo == password) {
            //Campo vacío
            if (password.validity.valueMissing) {
                passwordError.textContent = 'Debe introducir una contraseña.';
                //Dato demasiado cortos
            } else if (password.validity.tooShort) {
                passwordError.textContent = 'Debe tener al menos ' + password.minLength + ' caracteres; ha introducido ' + password.value.length;
                //Dato demasiado largo
            }
            // Establece el estilo apropiado
            password.classList.remove('is-valid');
            password.classList.add('is-invalid');
            passwordError.className = 'invalid-feedback';
        }
    }
}


//---------------------------Validacion de cambio de contraseña
function validarCambio() {
    const form = document.getElementById("changeForm");
    const pass1 = document.getElementById("passwordChange");
    const pass2 = document.getElementById("password2Change");
    const pass1Error = document.getElementById("passwordChangeError1");
    const pass2Error = document.getElementById("password2ChangeError2");
//-----------------------------FORMULARIO SUBMIT
    var correcto;
    form.addEventListener('submit', function (event) {
        if (!pass1.validity.valid) {
            error(pass1);
            event.preventDefault();
        }
        if (!pass2.validity.valid) {
            error(pass2);
            event.preventDefault();
        }
    });

    pass1.addEventListener('blur', function (event) {
        if (pass1.validity.valid) {
            pass1Error.className = 'valid-feedback';
            pass1.classList.add('is-valid');
            pass1.classList.remove('is-invalid');
            pass1Error.textContent = '';
        } else {
            error(pass1);
        }
    });
    pass2.addEventListener('input', function (event) {
        comprobarContras(pass1, pass2);
    });
}
function comprobarContras(pass1, pass2) {

    var c1 = pass1.value;
    var c2 = pass2.value;
    if (c1 != c2) {
        pass2Error.textContent = 'Las contraseñas no coinciden.';
        pass2Error.className = 'invalid-feedback';
        pass2.classList.remove('is-valid');
        pass2.classList.add('is-invalid');
        correcto = false;
    } else {
        correcto = true;
        if (!pass2.value.length == 0) {
            pass2Error.textContent = '';
            pass2Error.className = 'valid-feedback';
            pass2.classList.add('is-valid');
            pass2.classList.remove('is-invalid');
        }
    }
}

