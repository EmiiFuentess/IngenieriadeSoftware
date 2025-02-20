package ipn.escom.demo.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    @GetMapping("hola")
    public String getMethodName() {
        return "hola"; // Nombre del archivo HTML en /templates/hola.html
    }
}
