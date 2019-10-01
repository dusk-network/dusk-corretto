/// This derive function has had the sage code manipulated so that it 
/// has a specific isogeny, namely where the Montgomery paramters provide
/// and A+2 which is square in Fp. The reasoning is to make it easy to 
/// work with each encoding. Additionally, the prime which forms as a result, 
/// is easier to encode in bits as the remainder fits on a u64 without the 
/// need to Montgomery reduced form. 

/// Below is the derivation function for the curve. 

sage: x = 2^252 + 27742317777372353535851937790883648493
....: Fq = GF(x)
....: 
....: # We wish to find a Montgomery curve with B = 1 and A the smallest such
....: # that (A - 2) / 4 is a small integer.
....: def get_A(n):
....:    return (n * 4) + 2
....: 
....: # A = 2 is invalid (singular curve), so we start at i = 1 (A = 6)
....: i = 1
....: 
....: while True:
....:     A = Fq(get_A(i))
....:     i = i + 1
....: 
....:     # We also want that A^2 - 4 is nonsquare.
....:     if ((A^2) - 4).is_square() && legendre_symbol(A+2,x),is_one():
....:         continue
....: 
....:     ec = EllipticCurve(Fq, [0, A, 0, 1, 0])
....:     o = ec.order()
....: 
....:     if (o % 8 == 0):
....:         o = o // 8
....:         if is_prime(o):
....:             twist = ec.quadratic_twist()
....:             otwist = twist.order()
....:             if (otwist % 4 == 0):
....:                 otwist = otwist // 4
....:                 if is_prime(otwist):
....:                     print "A = %s" % A
....:                     exit(0)
