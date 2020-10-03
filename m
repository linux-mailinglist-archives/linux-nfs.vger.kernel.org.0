Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BDA282585
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Oct 2020 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJCRVa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Oct 2020 13:21:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJCRV3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Oct 2020 13:21:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 093HKQJM034059;
        Sat, 3 Oct 2020 17:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : subject : from :
 to : references : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2020-01-29;
 bh=52oGMVQYLRfzC+liU67U+3b6KM7clCsnSugnWIL030Y=;
 b=oOlty/Am7Y/7ngnkX8H2FWyKzq+/DKm3EMw41cqZNyO+huMYeWURM4tmJxqscuhWmbZ9
 Kp8Ln8gLXBgOgy2hsphy9d643tbClFePCRFXW+R2ZXf5cityW4HxyF44h1KzTxh4xsiI
 BSzqJpk8fG4NefUbiD/Ctp45Lo6mhDEDZBfpExBM4TJ7MS+ltYfAaXMCCtI0SIVZV8It
 USxRutlleNI1xO5Cjlnj1JXAJBeH6rJEFhlaMbztm1K/bzFVl2UCTca/RptKu9GztYau
 PPA1QxW8yeKak206jzwyML4CclXYh/jwbamaFHm4ZDfYz5QiZ0AjmApJFdugByi87HrV DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33xetah96e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 03 Oct 2020 17:21:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 093HJwXk164079;
        Sat, 3 Oct 2020 17:21:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33xedst2ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Oct 2020 17:21:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 093HLFND032228;
        Sat, 3 Oct 2020 17:21:18 GMT
Received: from mbp2018.cdmnet.org (/82.27.120.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 03 Oct 2020 10:21:15 -0700
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: don't use timed rebind with TCP
From:   Calum Mackay <calum.mackay@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
References: <20201002225750.16452-1-calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
Message-ID: <9f36a510-3721-f454-a2ef-95e5b9beb360@oracle.com>
Date:   Sat, 3 Oct 2020 18:21:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:83.0)
 Gecko/20100101 Thunderbird/83.0a1
MIME-Version: 1.0
In-Reply-To: <20201002225750.16452-1-calum.mackay@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X8EFmoxTcIT3IH0cwgt9KqxONQBhERc22"
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9763 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010030146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9763 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010030146
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X8EFmoxTcIT3IH0cwgt9KqxONQBhERc22
Content-Type: multipart/mixed; boundary="MoIp4FMMkzlpfc5Bp5jNkW9GPFYFhD4IU";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Message-ID: <9f36a510-3721-f454-a2ef-95e5b9beb360@oracle.com>
Subject: Re: [PATCH] lockd: don't use timed rebind with TCP
References: <20201002225750.16452-1-calum.mackay@oracle.com>
In-Reply-To: <20201002225750.16452-1-calum.mackay@oracle.com>

--MoIp4FMMkzlpfc5Bp5jNkW9GPFYFhD4IU
Content-Type: multipart/mixed;
 boundary="------------B31639474C99E49834304CB4"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------B31639474C99E49834304CB4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Please hold off for now on this one; I think I need to adjust the=20
reclaimer a little.

thanks,
calum.

On 02/10/2020 11:57 pm, Calum Mackay wrote:
> It is possible for nlm_bind_host() to clear XPRT_BOUND whilst a connect=
ion
> worker is in the middle of trying to reconnect. When the latter notices=

> that XPRT_BOUND been cleared under it, in xs_tcp_finish_connecting(),
> that results in:
>=20
> 	xs_tcp_setup_socket: connect returned unhandled error -107
>=20
> Worse, it's possible that the two can get into lockstep, resulting in
> the same behaviour repeated indefinitely, with the above error every
> 300 seconds, without ever recovering, and the connection never being
> established. This is most likely to occur when there's a large number
> of NLM client tasks following a server reboot.
>=20
> Since the timed rebind would seem not to be needed for TCP in any case,=

> whilst the existing connection remains, restrict the timed rebinding to=

> UDP only.
>=20
> For TCP, we will still rebind when needed, e.g. on timeout, connection
> error (including closure), and in the reclaimer.
>=20
> Whilst there, refactor some duplicate code.
>=20
> Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
> ---
>   fs/lockd/host.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> index 0afb6d59bad0..6e98c2ed6ffc 100644
> --- a/fs/lockd/host.c
> +++ b/fs/lockd/host.c
> @@ -439,12 +439,7 @@ nlm_bind_host(struct nlm_host *host)
>   	 * RPC rebind is required
>   	 */
>   	if ((clnt =3D host->h_rpcclnt) !=3D NULL) {
> -		if (time_after_eq(jiffies, host->h_nextrebind)) {
> -			rpc_force_rebind(clnt);
> -			host->h_nextrebind =3D jiffies + NLM_HOST_REBIND;
> -			dprintk("lockd: next rebind in %lu jiffies\n",
> -					host->h_nextrebind - jiffies);
> -		}
> +		nlm_rebind_host(host);
>   	} else {
>   		unsigned long increment =3D nlmsvc_timeout;
>   		struct rpc_timeout timeparms =3D {
> @@ -495,15 +490,18 @@ nlm_bind_host(struct nlm_host *host)
>   }
>  =20
>   /*
> - * Force a portmap lookup of the remote lockd port
> + * Force a portmap lookup of the remote lockd port, unless we're using=
 a
> + * TCP connection.
>    */
>   void
>   nlm_rebind_host(struct nlm_host *host)
>   {
> -	dprintk("lockd: rebind host %s\n", host->h_name);
> -	if (host->h_rpcclnt && time_after_eq(jiffies, host->h_nextrebind)) {
> +	if (unlikely(host->h_proto =3D=3D IPPROTO_UDP) && host->h_rpcclnt &&
> +			time_after_eq(jiffies, host->h_nextrebind)) {
>   		rpc_force_rebind(host->h_rpcclnt);
>   		host->h_nextrebind =3D jiffies + NLM_HOST_REBIND;
> +		dprintk("lockd: rebind host %s; next rebind in %lu jiffies\n",
> +			host->h_name, host->h_nextrebind - jiffies);
>   	}
>   }
>  =20
>=20

--=20
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation

--------------B31639474C99E49834304CB4
Content-Type: application/pgp-keys;
 name="OpenPGP_0x8523EF006DC153E2.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0x8523EF006DC153E2.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBF8EmckBEADY7zXjHab4thpE0tJt04MQJYJKBt72eXTweUlzrny8e55IrVpNI6ueSzD9b=
mTR
scSqXNgBHbxOxDpajZpELgLm5c6nXjrmc7H01jWvMbrXheWWYJqp3rAohb2TgKn3iU/X1Jasx=
FPg
hPyAvPgvJkRVzBuiKpcg3iPOUId7Q6GNinXZvOKvEWaP7G5abVZUQOT4DTTCPDWYENTDwEL8n=
onR
CIw/ip26WBoFsuUrW981X/Vch46otvSZay5ewiBL/ZO45JxIJdtMglLGoEC0AVrTb3TU/EHMC=
O5G
joWPt9xxMixG/Wtl/8Ciz0PHnJGT4a0LcNgXYWdecIS0GsBxCznGcLnINLYCdoY17DuUsFC3P=
7EB
piS0ew0hlHAJt/jjX2AjqI/GXptzUm/sc8td99of2ksYZ8O+vmgKAs/mbNuPyvd6skTh8R8xE=
ZZ9
zGhNmGxPP7Xd/Eud3ShF9oqx4lTj0eZYy5oWzmLFTN1D1uBjU+aitbp9TPyPVgqxm57p430CY=
9Ei
RocvfarWTOEEswgorumrPQzdtspxtqCZd3AfN3EMvKT/YtBO+OQHW9ljZNi3VjBgeH7DlXBQD=
LaJ
h6MzqX3htRIDumPhTA0kMaQQahcGicoe6GP/Eox2m7fulWq8AGDpwufNdV4WOSt86D4h8orUC=
z5s
ctIDnxg9PZjzUQARAQABzSZDYWx1bSBNYWNrYXkgPGNhbHVtLm1hY2theUBvcmFjbGUuY29tP=
sLB
jwQTAQgAORYhBNRgW60GIMfKPVXcPoUj7wBtwVPiBQJfBJnKBQkB4TOAAhsDBQsJCAcCBhUIC=
QoL
AgUWAgMBAAAKCRCFI+8AbcFT4j3fD/9KJ6mkpirMTHZ0JOzIjYaexASOhvQOT5EJLDeS9ww9J=
iCn
xV0LtCPbidoAOK8Ad9mkdlLZIvIbFKlP4LfPteJqRq7NKlbOAPPsVTk6oAcUa0jxPqABMCo1i=
6lZ
cXmYJdlHF3v94sP/aAoXt+dP+bNUsrmTDGFQ9EBATTWEwUSv4BZ9JpGvYlfltVwa3nnMgkvEM=
oPM
eenHTu5Edb82ZJk6mub2OseZ7F+VJBi2Z8/DOW1WGxdyy5ufZbHKOnvyp+V8ntDmo3V9rccVi=
qfg
7zGVG3MKv3xhtAuCirENg6Kefw19njKWsQzIdiSvMkSAQuTJuAIPprixd1/epWryXpgNrgC3S=
Fw0
wWHy83F30faGxnSXmqhLh+Mu7UIeCmANAyx7zBRTe2MyxR8JWePmMkScSQYGkFQWjQG0xs6Ky=
39o
12l8ZHKQ8c846zkOpZjzK55FpS/BVgOiasZ8PT1/5MDcJpRo3rZCqKUBiO1Ly9CFu6MSyJD4y=
ba/
dOyjg1xDiFnWwu5E8aixxA64NF6FnjA5dIfLujTLjrTsOPSwH2TvyHB5rLGP0fgrLwM5fUW7x=
YVk
DFgFfC+MJzlg79YlQS3gWpuxUzZscitBKd4AOBZ+7Lb4HD1Ajv3pkhkFfOodJlV+9Kcp0xFNO=
HKm
D3wsJDb+tHdmFjFJWyGHziI9Xmwr8s7BTQRfBJnLARAAxwkBdfVeL7NMa2oHvZS9LOy2qQO3W=
VN/
JRmyNJ4HF/p33x9jwemZe8ZYXwJBT7lXErZTYijhwTP4Ss6RFs8vjPN4WAi7BkBU9dx10Hi+U=
rHc
zYrwi7NecBsD4q2rH4xs/QoN9LNJt4+vLzh9HqlASVa+o2p5Fs3TyNSBqb4B7m55+RD6K6F13=
bfX
M84msz8za2L9dxtjtwOyOYFeoODMBhdkMourO+e2eSxOtecJXpldx1LZurWrq7D79wmVFw/4w=
P+M
OAHKPfpWo/P18AfXEW9VD5WBzh9+n8kquA0C8lnAP9qRxtTsIAicLU2vIiXmiUNSvAJiDnBv+=
94a
mdDGu6aJ+f2lT2A5+QHNXb0QeaV2ob8wzCOOwZZG5hF99zbS0iVR+7LgnJsoJYcKVrySK5oYf=
AFM
Q8tUA102dZ6lHkVdRw77mIfbaXB637SAIxJGpwI1bDw3+xLqdqJW/Rs3BDSGrJRMPE1MnfvaA=
Pfh
qWSa9aFZ7wZPvO9sm9O5zO3R08COqCLgJxNOAVnJCw9aC5X1XzWyQvE3NA94Afl3KVAU1uxtg=
Tpn
wP5J05SllpSXeF4DpnH+sFX4+ZS4Cx+V96DgYY3ew6/SUGdMbEfJsqelCqz62vHguMA4cLIMb=
Onb
h9CkGsYeJEURixCywgft5frUtgUo5StuHFkt4Lou/D0AEQEAAcLBfAQYAQgAJhYhBNRgW60GI=
MfK
PVXcPoUj7wBtwVPiBQJfBJnNBQkB4TOAAhsMAAoJEIUj7wBtwVPi4Y4P/2stK5ZJFbi/30xuJ=
Yuu
pvc41NJi+P7gs7OqEQjDBpSsqFnVA6EMexk8Wj6nxsmVVXifG/Hi6/LbyPGPJzBcG45siAaUO=
G8/
kOviW42unAsN+v9SE1kXrlJ2PAj0+gpQ4J2ykjWy/n2SmZHs37Fzq7l3KpK1UwC1UDMEx9WgI=
RoQ
Adqa7lifmn6IaI6zObtP6QR4j24+cvzD+JWAkrBnsKOysosZXQVHHT/rioYM7EANxAMH3pC4m=
NK6
A+jMvWXIjY7NwhwOTabEwGP0LogOtyvJQc0bUlvxP8uz9bN43JDJd+X+jez4ktrGc3oADRafu=
BNK
mS0B6tXXrNj8IciSKZn8r4H42jHus5a7B+07ZoN50w5j9rvvATYo0nOruczhteMCagmEkH+SH=
OkW
miYwIcRHCPuVQoIkA80gvB+1miwZp9E6UjMe+BeQNxBrjGqOQMXLudf7A7DeXU/O2ycn5vtis=
GMD
f6Cu3dB91k4dfU6XI09AxTAjq3ww4N2Vh+Iif/qSiRlWqVwgufav47C69iwAgTrVmJQUJ+cSq=
8Xm
c0tNEUy/dWgseBy0yXmHQfrOycYVF48KBKJOYNxM46ypTmKpTknZ8XYOUMzx9SnKMEGHPOVrh=
Utz
NvkfnXhomE1WOtxIdgWvKPiDjxC2bWKGvRWiGwA+9q027QWpPxn0iOOU
=3DEpGa
-----END PGP PUBLIC KEY BLOCK-----

--------------B31639474C99E49834304CB4--

--MoIp4FMMkzlpfc5Bp5jNkW9GPFYFhD4IU--

--X8EFmoxTcIT3IH0cwgt9KqxONQBhERc22
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAl94swgFAwAAAAAACgkQhSPvAG3BU+LE
nRAAqjWW7CTQejG5mQpswU2LONJZXW/hYt/Iz9KV2UlBCxdFKlHpNP9/bz1xTJvsEJKMA01iSmZA
266xKVe7Z2jm/bp/h7URl6yaBHSq6JsY+3gM/okEr89OwSHEi5f5Ze3fcx6SGJye0ZphTgCISc94
Dj9iviDd+IYhBUlIpByN+uIDJLtVETjKEJ4/z8TXcHH71YG6Np0AYA2Ik+cH/sc2uBLX6N4eLcP2
s4UC0LpPyUgzr6Dja9SvqqjmDFR7dE6i9evU0TX3qGtH1SqBVLvJjjHGg/lShTRPcHedKQrF8eJv
fCqGU7ViepYqriYNMvx9JXUkobbyAIEllSOWFpVYuyPtht5OTB+2rkQ+UvYuO/9WoA/2ssKU3Ucv
ZnreB5wuPt0GnVsjM3qztSfuB9MY44RMDb8yFiexH/TSsvkq7DdmE+BxTjnc5qBTvyW7nLXo5wmD
HeQt27B4qW06L53DeXOY2ye1M1cOGFXc0UoKpBU0Pj2Cq66G/f0UJOadvRuUwNCvz7DetFXXsM/F
DEWdUNtIFr6jHX+LeUvVzXZAjXNW5SOEyx1C8Pnv0oCiN5JW/vB2GvXus49uZHiIKWNfynJNqCmI
qSYjW/hyqZk3x5qyr36FQYd0m185yKnpamv8S4Ac3rb2Lbn00nagEpDcT6Si/GyI/awheXFtbCBh
nEg=
=/tzS
-----END PGP SIGNATURE-----

--X8EFmoxTcIT3IH0cwgt9KqxONQBhERc22--
