#!/bin/bash


alphabet1="abcdefghijklm"
alphabet2="nopqrstuvwxyz"
ALPHABET1="ABCDEFGHIJKLM"
ALPHABET2="NOPQRSTUVWXYZ"

unrotpipe () {
    tr "${alphabet2}${alphabet1}${ALPHABET2}${ALPHABET1}" \
      "${alphabet1}${alphabet2}${ALPHABET1}${ALPHABET2}"
}
die_rotpipe () { echo "$@" | unrotpipe; exit 1; }
[ -z "$SSH_CLIENT" ] && die_rotpipe "Vy frzoyr dhr ibhf ar fblrm cnf pbaarpgrf à yn znpuvar ivn FFU.

Wr ershfr qr z'rképhgre qnaf prf pbaqvgvbaf, qéfbyé.
Zrepv qr ibhf pbaarpgre à prggr znpuvar ivn FFU, rg wr
ibhf qbaarenv yn fbyhgvba.

Fv prggr égncr fr gebhir fhe yn zêzr znpuvar dhr ibger znpuvar qr
geninvy unovghry, ibhf cbhirm hgvyvfre ha CP vaqvivqhry bh ibger
znpuvar crefbaaryyr cbhe eényvfre prggr égncr."

echo "Ovra.

Y'égncr fhvinagr rfg geèf fvzvynver, p'rfg nhffv ha rképhgnoyr à
ynapre fhe har znpuvar qvfgnagr. Y'rképhgnoyr fr gebhir fhe yr
freirhe cpfreirhe.rafvznt.se, à y'rzcynprzrag :

  ~wqchavk/wrh-qr-cvfgr/SdZ6VuUC/rgncr-T3.fu

Yn pbzznaqr ra dhrfgvba hgvyvfr ha nssvpuntr tencuvdhr, qbap ibhf
evfdhrm q'nibve orfbva qr y'bcgvba -K qr yn pbzznaqr ffu.
"| unrotpipe