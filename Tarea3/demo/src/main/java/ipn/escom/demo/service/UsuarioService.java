package ipn.escom.demo.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import ipn.escom.demo.entity.Usuario;

import ipn.escom.demo.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;  // Inyecta el codificador

    public void registrarUsuario(Usuario usuario) {
        // Codifica la contraseña antes de guardar
        usuario.setPassword(passwordEncoder.encode(usuario.getPassword()));
        // Guarda el usuario en la base de datos
        usuarioRepository.save(usuario);
    }
}
