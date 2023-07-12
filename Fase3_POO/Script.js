
//const myCarouselElement = document.querySelector('#myCarousel')

//const carousel = new bootstrap.Carousel(myCarouselElement, {
//    interval: 2000,
//    touch: false
//})

function redirectToProduct(id) {
    // Redireccionar a otra página pasando el ID como parámetro en la URL
    window.location.href = "frmProductos.aspx?id=" + id;
}


function adjustTextAreaHeight(textarea) {
    textarea.style.height = "auto";  // Restablecer la altura para obtener el tamaño del contenido actual
    textarea.style.height = textarea.scrollHeight + "px";  // Establecer la altura según el tamaño del contenido
}


$(function () {
    $('#datetimepicker').datetimepicker({
        format: 'YYYY-MM-DD', // Formato de fecha deseado
        useCurrent: false // No usar la fecha y hora actual como valor inicial
    });
});

// Función para ajustar la altura del textarea
function ajustarAlturaTextarea() {
    var textarea = document.getElementById('txtInfo');
    textarea.style.height = "auto";
    textarea.style.height = textarea.scrollHeight + "px";
}

// Llama a la función de ajuste de altura al cargar la página y cada vez que el contenido del textarea cambie
window.onload = ajustarAlturaTextarea;
document.getElementById('txtInfo').addEventListener('input', ajustarAlturaTextarea);

function redirectToSearch() {
    let buscar = document.getElementById("txtBuscar").value; // Obtener el valor del TextBox
    let url = "frmBusqueda.aspx?buscar=" + buscar; // Construir la URL de destino con el valor del TextBox
    window.location.href = url; // Redireccionar a la página de destino
}