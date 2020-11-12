Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8302B0FBE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 22:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKLVG0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 16:06:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56574 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVGZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 16:06:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACL006e007132;
        Thu, 12 Nov 2020 21:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 mime-version : cc : subject : from : to : references : in-reply-to :
 content-type; s=corp-2020-01-29;
 bh=CJSVKLbE8F1oV1KMPvVvqW6oosVicrDEQ9LmMW87MgE=;
 b=TMs4AFcQDty71K3E3Q2ls7l5Upg+JspAgzqEg2GItAE/Nf7vuYWce0RYTFSl7J8wzrHq
 g93fQIkFa57cE4HQKsbyNkNuNTMaEEertBRCNE3Tj8++GHXmsRymnLXnUYOinEtWPScW
 jNkUSRXuN1b2zXaSXhVpPhnYJxPpBPjv4usrPbXuLnngtiF7NzBZEbQMGbTcJVKNJ00i
 mG1J5W8NnJHcgaAvD5PdVALt82g8wMCOZhKu0pE6AUlKzqT3r+xnfkCGcQajrPWkLLwc
 gSm4tGXKINyBX2I5w2upo2tC5MyM7sZ+rHpPQq5QjO+arfqIRnmESxCv4y70fMgolg4e ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3b7v9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 21:06:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACL1EcT134482;
        Thu, 12 Nov 2020 21:04:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34rt56ph6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 21:04:20 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ACL4ASc013817;
        Thu, 12 Nov 2020 21:04:14 GMT
Received: from mbp2018.cdmnet.org (/84.69.16.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 13:04:10 -0800
Message-ID: <c9ae2eec-6db9-d4de-fb29-e4dcc6be2dac@oracle.com>
Date:   Thu, 12 Nov 2020 21:04:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:84.0)
 Gecko/20100101 Thunderbird/84.0a1
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: don't use interval-based rebinding over TCP
Content-Language: en-GB
From:   Calum Mackay <calum.mackay@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
References: <20201028201627.23625-1-calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <20201028201627.23625-1-calum.mackay@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SUdd9BMVNyphArlP5YbbX1iV3z9flDo6O"
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120123
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SUdd9BMVNyphArlP5YbbX1iV3z9flDo6O
Content-Type: multipart/mixed; boundary="ssv343dyU2kvrWTh71joEsIrIUvftDujy";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Message-ID: <c9ae2eec-6db9-d4de-fb29-e4dcc6be2dac@oracle.com>
Subject: Re: [PATCH] lockd: don't use interval-based rebinding over TCP
References: <20201028201627.23625-1-calum.mackay@oracle.com>
In-Reply-To: <20201028201627.23625-1-calum.mackay@oracle.com>

--ssv343dyU2kvrWTh71joEsIrIUvftDujy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

hi Anna, Trond,

was there any comment on this, please?

thanks,
calum.

On 28/10/2020 8:16 pm, Calum Mackay wrote:
> NLM uses an interval-based rebinding, i.e. it clears the transport's
> binding under certain conditions if more than 60 seconds have elapsed
> since the connection was last bound.
>=20
> This rebinding is not necessary for an autobind RPC client over a
> connection-oriented protocol like TCP.
>=20
> It can also cause problems: it is possible for nlm_bind_host() to clear=

> XPRT_BOUND whilst a connection worker is in the middle of trying to
> reconnect, after it had already been checked in xprt_connect().
>=20
> When the connection worker notices that XPRT_BOUND has been cleared
> under it, in xs_tcp_finish_connecting(), that results in:
>=20
> 	xs_tcp_setup_socket: connect returned unhandled error -107
>=20
> Worse, it's possible that the two can get into lockstep, resulting in
> the same behaviour repeated indefinitely, with the above error every
> 300 seconds, without ever recovering, and the connection never being
> established. This has been seen in practice, with a large number of NLM=

> client tasks, following a server restart.
>=20
> The existing callers of nlm_bind_host & nlm_rebind_host should not need=

> to force the rebind, for TCP, so restrict the interval-based rebinding
> to UDP only.
>=20
> For TCP, we will still rebind when needed, e.g. on timeout, and connect=
ion
> error (including closure), since connection-related errors on an existi=
ng
> connection, ECONNREFUSED when trying to connect, and rpc_check_timeout(=
),
> already unconditionally clear XPRT_BOUND.
>=20
> To avoid having to add the fix, and explanation, to both nlm_bind_host(=
)
> and nlm_rebind_host(), remove the duplicate code from the former, and
> have it call the latter.
>=20
> Drop the dprintk, which adds no value over a trace.
>=20
> Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
> ---
>   fs/lockd/host.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> index 0afb6d59bad0..771c289f6df7 100644
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
> @@ -494,13 +489,20 @@ nlm_bind_host(struct nlm_host *host)
>   	return clnt;
>   }
>  =20
> -/*
> - * Force a portmap lookup of the remote lockd port
> +/**
> + * nlm_rebind_host - If needed, force a portmap lookup of the peer's l=
ockd port
> + * @host: NLM host handle for peer
> + *
> + * This is not needed when using a connection-oriented protocol, such =
as TCP.
> + * The existing autobind mechanism is sufficient to force a rebind whe=
n
> + * required, e.g. on connection state transitions.
>    */
>   void
>   nlm_rebind_host(struct nlm_host *host)
>   {
> -	dprintk("lockd: rebind host %s\n", host->h_name);
> +	if (host->h_proto !=3D IPPROTO_UDP)
> +		return;
> +
>   	if (host->h_rpcclnt && time_after_eq(jiffies, host->h_nextrebind)) {=

>   		rpc_force_rebind(host->h_rpcclnt);
>   		host->h_nextrebind =3D jiffies + NLM_HOST_REBIND;
>=20

--=20
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation

--ssv343dyU2kvrWTh71joEsIrIUvftDujy--

--SUdd9BMVNyphArlP5YbbX1iV3z9flDo6O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAl+to0cFAwAAAAAACgkQhSPvAG3BU+KF
Gw/+PqU+ZAgxsnKOkGsD/SHCQmSmdS8GP/UQ/QR+0TMURe5r99k1/g3/EiZfUqOZ80+eqcM+hi3c
k/sc/8cRrHLIz+7K0qtPwi+YniTiElM+anOzQCDJ8Ydd6sYtRYDXXvG76FlCYDEq9t7N455tiPDn
3sg/GuyzAbrcvICwNaVmOb5V47RtP3Ug582AK0Fe7sDmvnQfaiHt5V7yt3snLOLFiRsNv3iORtxD
HlfWXjk08dkWpJI8mTXGANmf6Vrz4G6LDUz95J4YROkUHg8oD2lBjAcB//5ipVoWj1osAF5RHrC3
420uYKN8XxhW/XFv3ga22WzDNkyYpQhkE+e64wFIkU9yt81qY55qhIWCF8iptY5rUBj7FTQpyQDr
zFPZPnJRYDiJ1bKqdySKPwkVvNTBoG8RWhGxT8pXZXbWDNkGrwV7QrKtQ0u3b4/vPbdduDIlIUCO
MhlKQHhOaZ+F1kKqIP/k/e1KTcwddeAsotrt+Nt99kmFMkUqkqw5CPhA9TKL2lsTMjdZ7J48qVTP
jkF2IW3tt/UZl1GN/a6YdI+cZNLcDN/ki8gjVZP8SRpVEYEwz/S8g+kl2AULuo3LxFqHLPGmkuyw
6LQ6xwp87thddSAQLZVWnTLAvuO94pdZGZC8fKVrzWEfBMKcHU5Oyt1pmjuwDqqVv4B/NgFF7w36
wIQ=
=OWrw
-----END PGP SIGNATURE-----

--SUdd9BMVNyphArlP5YbbX1iV3z9flDo6O--
