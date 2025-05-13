package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.http.HttpFilter;

/**
 * Servlet Filter implementation class EncodingFilter
 */
@WebFilter(
		urlPatterns = { "/*" }, 	// 모든 경로 매핑
		initParams = { 
				@WebInitParam(name = "Encoding", value = "UTF-8", description = "인코딩 설정값")
		})
public class EncodingFilter extends HttpFilter implements Filter {

	private FilterConfig filterConfig = null;
	private String encoding;
	
	
	
	/**
	 * 생성자
	 */
    public EncodingFilter() {
        super();
    }

    /**
     * 
     */
    public void init(FilterConfig filterConfig) throws ServletException {
    	this.filterConfig = filterConfig;
    	this.encoding = filterConfig.getInitParameter("encoding"); // UTF-8
    	System.out.println(filterConfig.getInitParameter("encoding"));
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("인코딩 필터 : " + encoding);
		request.setCharacterEncoding(encoding);
		request.setContentType();
		response.setCharacterEncoding(encoding);
		response.setContentType("text/plain; charset=UTF-8");
		chain.doFilter(request, response);
	}


	public void destroy() {
		// TODO Auto-generated method stub
	}
}
