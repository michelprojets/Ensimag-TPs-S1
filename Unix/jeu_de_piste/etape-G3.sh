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
[ -z "$DISPLAY" ] && die_rotpipe "Ibhf a'nirm cnf npgvié y'nssvpuntr tencuvdhr nirp FFU.

Eérffnlrm ra hgvyvfnag y'bcgvba -K qr FFU cbhe npgvire yr 'K11 sbejneqvat'."

echo "Prggr égncr grezvar yn cnegvr cevapvcnyr qh wrh qr cvfgr.

Yrf égncrf dhv fhvirag fbag qrf égncrf ra cyhf, n cevbev cyhf
qvssvpvyrf. Fv ibhf ibhf neergrm yà rg dhr ibhf nirm yh yr thvqr
ra ragvre, ibhf qrievrm nibve nccevf y'rffragvry.

Cbhe pbasvezre dhr ibhf êgrf neeviéf whfdh'vpv, abhf ibhf qrznaqbaf
q'nwbhgre ha pbzzragnver fhe yn cntr qr qvfphffvba qr yn cntr « Wrh qr
cvfgr » qh Jvxv, cbhe crezrgger à y'édhvcr rafrvtanagr q'nibve har
vqér qh abzoer q'éghqvnagf dhv fbag neeviéf nh obhg, rg fhegbhg cbhe
fnibve fv çn ibhf n cyh !

Yn sraêger qnaf yndhryyr f'nssvpur pr zrffntr rfg ra snvg yr cebtenzzr
'yrff' dhv gbhear qnaf ha grezvany. Ibhf cbhirm dhvggre ra ncchlnag fhe
'd'.

Fv ibhf fbhunvgrm snver yn qrhkvèzr cnegvr qh wrh qr cvfgr,
eraqrm-ibhf fhe yn cntr
uggc://rafvjvxv.rafvznt.se/vaqrk.cuc/GC_Havk_-_Wrh_qr_cvfgr
rg yvfrm y'éabapé qr y'égncr U1.

Fvaba, ibhf cbheerm ovra fûe l erirave cyhf gneq, cne rkrzcyr craqnag
yr pbhef q'Havk ninapé fv ibhf êgrf ra 1N Rafvznt.
"| unrotpipe > /tmp/tmp-G3.$$

wget "http://www-verimag.imag.fr/~moy/monitoring-jdp/record.php?login=$LOGNAME&step=G3" -O /dev/null 2>/dev/null &

LC_ALL=en_US.UTF-8 LESS= xterm -e less /tmp/tmp-G3.$$ || \
LC_ALL=en_US.UTF-8 LESS= gnome-terminal -e less /tmp/tmp-G3.$$
rm -f /tmp/tmp-G3.$$
