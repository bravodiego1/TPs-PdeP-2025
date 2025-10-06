// MUSICOS
import instrumentos.*
// 1) Johann es feliz si tiene un instrumento caro (que cueste más de 20 chelines). 
//Inicialmente Johann tiene una trompeta Jupiter.

object johann {
    var instrumento = trompeta

    method instrumento(unInstrumento){
        instrumento = unInstrumento
    }
    
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

  method instrumento (unInstrumento){
    instrumento = unInstrumento
  }

  method esFeliz() = instrumento.estaAfinada()

}

// 5) Maddalena es feliz si su instrumento tiene un costo par. Inicialmente tiene un violín Stagg.

object maddalena {
    var instrumento = violin
    method instrumento(unInstrumento){
        instrumento = unInstrumento
    }
    method esFeliz() = instrumento.tieneCostoPar()
    
}


object asociacionMusical {
    const musicos = #{johann,wolfgang,giuseppe,maddalena}

    method musicosFelices() = musicos.filter({unMusico => unMusico.esFeliz()})
}