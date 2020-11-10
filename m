Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8512ADC25
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgKJQ03 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 11:26:29 -0500
Received: from smtp-o-3.desy.de ([131.169.56.156]:43305 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJQ02 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 11:26:28 -0500
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 4E6646049F
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 17:26:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 4E6646049F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1605025582; bh=CthjvZH/GGdfW2WsMxRnJJ/gNbsbkGIYRs9Mi7KyIiE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BZpoM5mIuM/vJURGcBVRfd3p8sFRVS+dz1tLXMMfh79SjDy489XH5XwR7W/eBPq9m
         LTox7GIKyeNNUyWZO4DTZCtXCpEBqN0M+tNObkI3K2W1/vUyWJ/6HTdvk3PnknVdAS
         rE6hFnOtrrG27u/087DuTGMpSPT5wIbD+qWBQ3mE=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 492ABA0586;
        Tue, 10 Nov 2020 17:26:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 2368080067;
        Tue, 10 Nov 2020 17:26:22 +0100 (CET)
Date:   Tue, 10 Nov 2020 17:26:21 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1645111266.7511315.1605025581993.JavaMail.zimbra@desy.de>
In-Reply-To: <20201106225527.19148-4-trondmy@kernel.org>
References: <20201106225527.19148-1-trondmy@kernel.org> <20201106225527.19148-2-trondmy@kernel.org> <20201106225527.19148-3-trondmy@kernel.org> <20201106225527.19148-4-trondmy@kernel.org>
Subject: Re: [PATCH 3/3] NFSv4/pNFS: Store the transport type in struct
 nfs4_pnfs_ds_addr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Mac)/8.8.15_GA_3953)
Thread-Topic: NFSv4/pNFS: Store the transport type in struct nfs4_pnfs_ds_addr
Thread-Index: 96zob7ohlczkC45AjaTv2u5/9WqTBg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

this is what I get when trying to build your testing branch:


  CC [M]  fs/nfs/pnfs_nfs.o
fs/nfs/pnfs_nfs.c: In function =E2=80=98nfs4_decode_mp_ds_addr=E2=80=99:
fs/nfs/pnfs_nfs.c:1088:22: error: passing argument 1 of =E2=80=98kmemdup_nu=
l=E2=80=99 from incompatible pointer type [-Werror=3Dincompa
tible-pointer-types]
 1088 |  netid =3D kmemdup_nul(p, nlen, gfp_flags);
      |                      ^
      |                      |
      |                      __be32 * {aka unsigned int *}
In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./include/linux/uio.h:9,
                 from ./include/linux/socket.h:8,                          =
                                                           from ./include/u=
api/linux/in.h:24,
                 from ./include/linux/in.h:19,
                 from ./include/linux/nfs_fs.h:22,
                 from fs/nfs/pnfs_nfs.c:11:
./include/linux/string.h:180:38: note: expected =E2=80=98const char *=E2=80=
=99 but argument is of type =E2=80=98__be32 *=E2=80=99 {aka =E2=80=98unsign=
ed int
*=E2=80=99}
  180 | extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
      |                          ~~~~~~~~~~~~^
fs/nfs/pnfs_nfs.c:1108:20: error: passing argument 1 of =E2=80=98kmemdup_nu=
l=E2=80=99 from incompatible pointer type [-We



Regards,
   Tigran.

----- Original Message -----
> From: "trondmy" <trondmy@kernel.org>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, 6 November, 2020 23:55:27
> Subject: [PATCH 3/3] NFSv4/pNFS: Store the transport type in struct nfs4_=
pnfs_ds_addr

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> We want to enable RDMA and UDP as valid transport methods if a
> GETDEVICEINFO call specifies it. Do so by adding a parser for the
> netid that translates it to an appropriate argument for the RPC
> transport layer.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfs/pnfs.h     |  1 +
> fs/nfs/pnfs_nfs.c | 66 +++++++++++++++++++++++++++++++++++++----------
> 2 files changed, 53 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> index 2661c44c62db..20ee37b751e3 100644
> --- a/fs/nfs/pnfs.h
> +++ b/fs/nfs/pnfs.h
> @@ -51,6 +51,7 @@ struct nfs4_pnfs_ds_addr {
> =09size_t=09=09=09da_addrlen;
> =09struct list_head=09da_node;  /* nfs4_pnfs_dev_hlist dev_dslist */
> =09char=09=09=09*da_remotestr;=09/* human readable addr+port */
> +=09int=09=09=09da_transport;
> };
>=20
> struct nfs4_pnfs_ds {
> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> index 7027dac41cc7..d00750743100 100644
> --- a/fs/nfs/pnfs_nfs.c
> +++ b/fs/nfs/pnfs_nfs.c
> @@ -854,13 +854,15 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_serv=
er
> *mds_srv,
>=20
> =09=09if (!IS_ERR(clp)) {
> =09=09=09struct xprt_create xprt_args =3D {
> -=09=09=09=09.ident =3D XPRT_TRANSPORT_TCP,
> +=09=09=09=09.ident =3D da->da_transport,
> =09=09=09=09.net =3D clp->cl_net,
> =09=09=09=09.dstaddr =3D (struct sockaddr *)&da->da_addr,
> =09=09=09=09.addrlen =3D da->da_addrlen,
> =09=09=09=09.servername =3D clp->cl_hostname,
> =09=09=09};
>=20
> +=09=09=09if (da->da_transport !=3D clp->cl_proto)
> +=09=09=09=09continue;
> =09=09=09if (da->da_addr.ss_family !=3D clp->cl_addr.ss_family)
> =09=09=09=09continue;
> =09=09=09/* Add this address as an alias */
> @@ -870,7 +872,7 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server
> *mds_srv,
> =09=09}
> =09=09clp =3D get_v3_ds_connect(mds_srv,
> =09=09=09=09(struct sockaddr *)&da->da_addr,
> -=09=09=09=09da->da_addrlen, IPPROTO_TCP,
> +=09=09=09=09da->da_addrlen, da->da_transport,
> =09=09=09=09timeo, retrans);
> =09=09if (IS_ERR(clp))
> =09=09=09continue;
> @@ -908,7 +910,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server
> *mds_srv,
>=20
> =09=09if (!IS_ERR(clp) && clp->cl_mvops->session_trunk) {
> =09=09=09struct xprt_create xprt_args =3D {
> -=09=09=09=09.ident =3D XPRT_TRANSPORT_TCP,
> +=09=09=09=09.ident =3D da->da_transport,
> =09=09=09=09.net =3D clp->cl_net,
> =09=09=09=09.dstaddr =3D (struct sockaddr *)&da->da_addr,
> =09=09=09=09.addrlen =3D da->da_addrlen,
> @@ -923,6 +925,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server
> *mds_srv,
> =09=09=09=09.data =3D &xprtdata,
> =09=09=09};
>=20
> +=09=09=09if (da->da_transport !=3D clp->cl_proto)
> +=09=09=09=09continue;
> =09=09=09if (da->da_addr.ss_family !=3D clp->cl_addr.ss_family)
> =09=09=09=09continue;
> =09=09=09/**
> @@ -937,8 +941,9 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server
> *mds_srv,
> =09=09} else {
> =09=09=09clp =3D nfs4_set_ds_client(mds_srv,
> =09=09=09=09=09=09(struct sockaddr *)&da->da_addr,
> -=09=09=09=09=09=09da->da_addrlen, IPPROTO_TCP,
> -=09=09=09=09=09=09timeo, retrans, minor_version);
> +=09=09=09=09=09=09da->da_addrlen,
> +=09=09=09=09=09=09da->da_transport, timeo,
> +=09=09=09=09=09=09retrans, minor_version);
> =09=09=09if (IS_ERR(clp))
> =09=09=09=09continue;
>=20
> @@ -1017,6 +1022,41 @@ int nfs4_pnfs_ds_connect(struct nfs_server *mds_sr=
v,
> struct nfs4_pnfs_ds *ds,
> }
> EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_connect);
>=20
> +struct xprt_lookup_transport {
> +=09const char *name;
> +=09sa_family_t protofamily;
> +=09int type;
> +};
> +
> +static const struct xprt_lookup_transport xl_xprt[] =3D {
> +=09{ "tcp", AF_INET, XPRT_TRANSPORT_TCP },
> +=09{ "tcp6", AF_INET6, XPRT_TRANSPORT_TCP },
> +=09{ "rdma", AF_INET, XPRT_TRANSPORT_RDMA },
> +=09{ "rdma6", AF_INET6, XPRT_TRANSPORT_RDMA },
> +=09{ "udp", AF_INET, XPRT_TRANSPORT_UDP },
> +=09{ "udp6", AF_INET6, XPRT_TRANSPORT_UDP },
> +=09{ NULL, 0, -1 },
> +};
> +
> +static int
> +nfs4_decode_transport(const char *str, size_t len, sa_family_t protofami=
ly)
> +{
> +=09const struct xprt_lookup_transport *p;
> +
> +=09for (p =3D xl_xprt; p->name; p++) {
> +=09=09if (p->protofamily !=3D protofamily)
> +=09=09=09continue;
> +=09=09if (strlen(p->name) !=3D len)
> +=09=09=09continue;
> +=09=09if (memcmp(p->name, str, len) !=3D 0)
> +=09=09=09continue;
> +=09=09if (xprt_load_transport(p->name) !=3D 0)
> +=09=09=09continue;
> +=09=09return p->type;
> +=09}
> +=09return -1;
> +}
> +
> /*
>  * Currently only supports ipv4, ipv6 and one multi-path address.
>  */
> @@ -1029,8 +1069,8 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_=
stream
> *xdr, gfp_t gfp_flags)
> =09int nlen, rlen;
> =09int tmp[2];
> =09__be32 *p;
> -=09char *netid, *match_netid;
> -=09size_t len, match_netid_len;
> +=09char *netid;
> +=09size_t len;
> =09char *startsep =3D "";
> =09char *endsep =3D "";
>=20
> @@ -1114,15 +1154,11 @@ nfs4_decode_mp_ds_addr(struct net *net, struct
> xdr_stream *xdr, gfp_t gfp_flags)
> =09case AF_INET:
> =09=09((struct sockaddr_in *)&da->da_addr)->sin_port =3D port;
> =09=09da->da_addrlen =3D sizeof(struct sockaddr_in);
> -=09=09match_netid =3D "tcp";
> -=09=09match_netid_len =3D 3;
> =09=09break;
>=20
> =09case AF_INET6:
> =09=09((struct sockaddr_in6 *)&da->da_addr)->sin6_port =3D port;
> =09=09da->da_addrlen =3D sizeof(struct sockaddr_in6);
> -=09=09match_netid =3D "tcp6";
> -=09=09match_netid_len =3D 4;
> =09=09startsep =3D "[";
> =09=09endsep =3D "]";
> =09=09break;
> @@ -1133,9 +1169,11 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr=
_stream
> *xdr, gfp_t gfp_flags)
> =09=09goto out_free_da;
> =09}
>=20
> -=09if (nlen !=3D match_netid_len || strncmp(netid, match_netid, nlen)) {
> -=09=09dprintk("%s: ERROR: r_netid \"%s\" !=3D \"%s\"\n",
> -=09=09=09__func__, netid, match_netid);
> +=09da->da_transport =3D nfs4_decode_transport(netid, nlen,
> +=09=09=09=09=09=09 da->da_addr.ss_family);
> +=09if (da->da_transport =3D=3D -1) {
> +=09=09dprintk("%s: ERROR: unknown r_netid \"%*s\"\n",
> +=09=09=09__func__, nlen, netid);
> =09=09goto out_free_da;
> =09}
>=20
> --
> 2.28.0
