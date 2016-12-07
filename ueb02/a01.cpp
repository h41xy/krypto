#include <iostream>
#include <sstream>
#include <gmp.h>

int main(int argc, char** argv){

	// TODO Only max unsigned long is possible
	unsigned long p_ul = 0;
	p_ul = std::strtoul(argv[1],nullptr,10);

        mpz_t base,n, p, res, exp, one;
        mpz_init (base);
        mpz_init (n);
        mpz_init (p);
        mpz_init (res);
        mpz_init (exp);
        mpz_init (one);

	// Set primenumber
	// TODO check if prime
        mpz_set_ui(p,p_ul);

        // initialise values
        mpz_set_ui(base,2);
        mpz_set_ui(one,1);

        std::stringstream ss;

	// TODO Specialcase for p = 2
	do{
		mpz_set_ui(exp,0);

		do{
			// exp +=1
			mpz_add_ui(exp,exp,1);

			// base^exp mod p = res
			mpz_powm(res,base,exp,p);

			ss << res << " ";

		}while(mpz_cmp(res,one) != 0);
		ss << "-- ord=" << exp << std::endl;

		std::cout << ss.str();
		// clear stringstream
		ss.str("");
		// base += 1
		mpz_add_ui(base,base,1);

		// do while base < p
	}while(mpz_cmp(base,p) < 0);


}
