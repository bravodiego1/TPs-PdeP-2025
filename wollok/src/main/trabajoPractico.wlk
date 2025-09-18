// INSTRUMENTOS

// 1) La guitarra Fender Stratocaster, de color negra, ni hay que afinarla porque siempre suena bien.
// Su costo es de 15 chelines cuando es negra o 10 en caso contrario. La Fender es valiosa.

object guitarra{
    const nombre = "Fender Stratocaster"
    var color = "negro"

    method price(){
        if (color == "negro"){
            return 15
        } else{     
            return 10
        }
    }

    method estaAfinada() = true

    method esValiosa() = true
    
} 

// 2) La trompeta Jupiter al igual que todas las trompetas necesita afinarse en base a la temperatura ambiente.
// Si la temperatura está de 20 a 25 grados no hace falta afinarla, en caso contrario el músico que la toca deberá soplar
// la trompeta para ir calentando el metal hasta lograr la afinación deseada. 
// Sabemos si tiene puesta la sordina, que es un elemento que atenúa o cambia la calidad del sonido que se propaga por la trompeta. 
// Su costo es 30 chelines al que hay que agregarle 5 si tiene puesta la sordina. 
// La trompeta Jupiter no es considerada valiosa.

object trompeta {
    const nombre = "Jupiter"
    var temperaturaAmbiente = 0
    var tieneSordina = false
    
    method afinar (unaAfinacion) {
        if (!self.estaAfinada()) {
            self.soplar(unaAfinacion)
        }
    }
    
    method estaAfinada() = temperaturaAmbiente.between(20,25)
      
  
    method soplar(unaAfinacion) {
        temperaturaAmbiente += unaAfinacion
    }
    
    method costo() {
        if (tieneSordina) {
            return 35
        } else {
            return 30
        }
    }
    
    method esValiosa() = false
    
}

// 3) El piano Bechstein, que por el momento está ubicado en una habitación de 5x5, suena afinado mientras se mantenga en una habitación
// de más de 20 metros cuadrados. También sabemos la última fecha en que lo revisó un técnico afinador
// (el piano sale de fábrica revisado por primera vez). Su costo es 2 chelines por el ancho de la habitación en donde está.
// El piano Bechstein es valioso si está afinado.

object piano{
    const nombre = "Bechstein"
    var tamanioHabitacion = 25
    // var ultimaFechaDeRevision = 

    method estaAfinada() = tamanioHabitacion > 20
    
    method tamanioHabitacion(unTamanio) = unTamanio
    
    method costo() = 2 * tamanioHabitacion
    
    method esValiosa() = self.estaAfinada()
}

// 4) El violín Stagg, que comienza afinado pero cada vez que se hace un trémolo (implica mover el arco arriba y abajo muy rápido)
// comienza a perder algo de afinación: cuando se llega al décimo trémolo el violín queda desafinado. Sabemos el tipo de pintura
// con el que está laqueado. Su costo es 20 chelines al que le restamos los trémolos que tenga en el momento, pero nunca baja de 15.
// El violín es valioso si está pintado con laca acrílica.

object violin{
    const nombre="stagg"
    var property cantidadTremolos=0
    var afinado = true
    var property pinturaLaqueado = " "

    method estaAfinada(){
        if(cantidadTremolos>=10){
            afinado=false
        }
    }
    
    method costo(){
        return 15.max(20 - cantidadTremolos)
    }

    method esValiosa(){
        return pinturaLaqueado=="laca acrilica"
    }

    method tieneCostoPar() {
        return self.costo().even()
    }
}

// MUSICOS (un objeto por persona pq no hay q usar clases)

// 1) Johann es feliz si tiene un instrumento caro (que cueste más de 20 chelines). 
//Inicialmente Johann tiene una trompeta Jupiter.

object johann {
    var instrumento = trompeta
    
    method esFeliz() = instrumento.costo() > 20
    
}


// 2) Wolfgang es feliz si Johann es feliz.

object wolfgang {
    
    method esFeliz() = johann.esFeliz()


}

// 3) Antonio es feliz si su instrumento es valioso. Inicialmente tiene un piano Bechstein.
object antonio {
  var instrumento = piano

  method esFeliz() = instrumento.esValiosa()

  }
    

// 4) Giuseppe es feliz si su instrumento está afinado. Inicialmente tiene una guitarra Fender.

object giuseppe {
  var instrumento = guitarra

  method esFeliz() = instrumento.estaAfinada()

}

// 5) Maddalena es feliz si su instrumento tiene un costo par. Inicialmente tiene un violín Stagg.

object maddalena {
    var instrumento = violin

    method esFeliz() = instrumento.tieneCostoPar()
    
}


object asociacionMusical {
    var musicos = [johann,wolfgang,antonio,giuseppe,maddalena]
    
    method sonFelices() = musicos.filter({unMusico => unMusico.esFeliz()})
}

// TRABAJO TERMINADO (FALTAN TESTS (25)) 

