package pe.edu.utp.isi.dwi.proyecto_123_dwi.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        String requestedPath = httpRequest.getRequestURI();

        boolean clienteAutenticado = session != null && session.getAttribute("clienteSesion") != null;
        boolean colaboradorAutenticado = session != null && session.getAttribute("colaboradorSesion") != null;

        // ✅ Permitir acceso a registro_colaborador.xhtml sin sesión
        if (requestedPath.contains("registro_colaborador.xhtml")) {
            chain.doFilter(request, response);
            return;
        }

        // 🔒 Restringir si accede a zonas protegidas sin sesión
        if ((!clienteAutenticado && requestedPath.contains("/cliente/"))
                || (!colaboradorAutenticado && requestedPath.contains("/colaborador/"))) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.xhtml");
            return;
        }

        // ✔ Continuar si tiene sesión válida
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
