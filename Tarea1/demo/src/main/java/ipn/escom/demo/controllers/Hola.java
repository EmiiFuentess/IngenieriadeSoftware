package ipn.escom.demo.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hola")  // Define la ruta base
public class Hola {

    @GetMapping
    public String index() {
        return "¡Hola Spring!";
    }
}
