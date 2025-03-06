package ipn.escom.demo.service;

// Cambia estos imports para que apunten a las clases correctas en ipn.escom.demo
import ipn.escom.demo.entity.Usuario;  // Asegúrate de que la clase Usuario esté en este paquete
import ipn.escom.demo.repository.UsuarioRepository;  // Asegúrate de que UsuarioRepository esté en este paquete
import ipn.escom.demo.service.CustomUserDetails;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service("customUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public UserDetails loadUserByUsername(String nombre) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByNombre(nombre);
        if (usuario == null) {
            throw new UsernameNotFoundException("Usuario no encontrado: " + nombre);
        }
        return new CustomUserDetails(usuario);
    }
}
