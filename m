Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0CB67B3AC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jan 2023 14:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjAYNqK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Jan 2023 08:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjAYNqK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Jan 2023 08:46:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA76E589BF
        for <linux-nfs@vger.kernel.org>; Wed, 25 Jan 2023 05:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C11661502
        for <linux-nfs@vger.kernel.org>; Wed, 25 Jan 2023 13:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA46C433D2;
        Wed, 25 Jan 2023 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674654341;
        bh=wHAj13sDu1szKvePG6g/DSEOcsMUwmL5g53Z7OSdxpc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ZOEQSqQAmbB2nSkh0WQma1Ea8YBz4olWeXInxrL6RmkHC7Zge9cXuJOP4D/jjBQQT
         wD9paP4wfFI+oc0Rnt6IRAn9xAyxQaf4Cc0TdiTs9XSE9buh5SYYeMYs0VrNPRDGSq
         LADcBRy4S3Gezh0I3okrnoh2MiJLzhwEKbT44foZgngHYzUlINQhwiMmPrKuHgf5E/
         hxZ1jnnRxX7BG/RoWTQp1yN81KOrpYGMNTYfgG0Vf/169ABAc9WpL/CLpgfZ+i4U9a
         psxvlib4Y91pPgboM/I3xQ+9xBAVU9/TDvStsQfKnRqbtTkYU5WN3QVm5KDDanhG9Z
         aW1kdWZGTcIOA==
Message-ID: <0d5940333170dfca716f8f3301141a1aefe18b15.camel@kernel.org>
Subject: Re: [PATCH v1 2/2] SUNRPC: Remove ->xpo_secure_port()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date:   Wed, 25 Jan 2023 08:45:40 -0500
In-Reply-To: <167459282253.15600.13316537036010057131.stgit@manet.1015granger.net>
References: <167459281558.15600.1555010122091924488.stgit@manet.1015granger.net>
         <167459282253.15600.13316537036010057131.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-01-24 at 15:40 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> There's no need for the cost of this extra virtual function call
> during every RPC transaction: the RQ_SECURE bit can be set properly
> in ->xpo_recvfrom() instead.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc_xprt.h          |    1 -
>  net/sunrpc/svc_xprt.c                    |    1 -
>  net/sunrpc/svcsock.c                     |    4 ++--
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    1 +
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 -------
>  5 files changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> index d42a75b3be10..775368802762 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -26,7 +26,6 @@ struct svc_xprt_ops {
>  	void		(*xpo_release_rqst)(struct svc_rqst *);
>  	void		(*xpo_detach)(struct svc_xprt *);
>  	void		(*xpo_free)(struct svc_xprt *);
> -	void		(*xpo_secure_port)(struct svc_rqst *rqstp);
>  	void		(*xpo_kill_temp_xprt)(struct svc_xprt *);
>  	void		(*xpo_start_tls)(struct svc_xprt *);
>  };
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index c2ce12538008..573a494f11d7 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -888,7 +888,6 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
> =20
>  	clear_bit(XPT_OLD, &xprt->xpt_flags);
> =20
> -	xprt->xpt_ops->xpo_secure_port(rqstp);
>  	rqstp->rq_chandle.defer =3D svc_defer;
>  	rqstp->rq_xid =3D svc_getu32(&rqstp->rq_arg.head[0]);
> =20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 815baf308236..81bdcb6f73bb 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -508,6 +508,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
>  	if (serv->sv_stats)
>  		serv->sv_stats->netudpcnt++;
> =20
> +	svc_sock_secure_port(rqstp);
>  	svc_xprt_received(rqstp->rq_xprt);
>  	return len;
> =20
> @@ -636,7 +637,6 @@ static const struct svc_xprt_ops svc_udp_ops =3D {
>  	.xpo_free =3D svc_sock_free,
>  	.xpo_has_wspace =3D svc_udp_has_wspace,
>  	.xpo_accept =3D svc_udp_accept,
> -	.xpo_secure_port =3D svc_sock_secure_port,
>  	.xpo_kill_temp_xprt =3D svc_udp_kill_temp_xprt,
>  };
> =20
> @@ -1028,6 +1028,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
>  	if (serv->sv_stats)
>  		serv->sv_stats->nettcpcnt++;
> =20
> +	svc_sock_secure_port(rqstp);
>  	svc_xprt_received(rqstp->rq_xprt);
>  	return rqstp->rq_arg.len;
> =20
> @@ -1209,7 +1210,6 @@ static const struct svc_xprt_ops svc_tcp_ops =3D {
>  	.xpo_free =3D svc_sock_free,
>  	.xpo_has_wspace =3D svc_tcp_has_wspace,
>  	.xpo_accept =3D svc_tcp_accept,
> -	.xpo_secure_port =3D svc_sock_secure_port,
>  	.xpo_kill_temp_xprt =3D svc_tcp_kill_temp_xprt,
>  };
> =20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdm=
a/svc_rdma_recvfrom.c
> index 5242ad121450..1c658fa43063 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -847,6 +847,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>  	rqstp->rq_xprt_ctxt =3D ctxt;
>  	rqstp->rq_prot =3D IPPROTO_MAX;
>  	svc_xprt_copy_addrs(rqstp, xprt);
> +	set_bit(RQ_SECURE, &rqstp->rq_flags);
>  	return rqstp->rq_arg.len;
> =20
>  out_err:
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrd=
ma/svc_rdma_transport.c
> index 94b20fb47135..416b298f74dd 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -73,7 +73,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt=
 *xprt);
>  static void svc_rdma_detach(struct svc_xprt *xprt);
>  static void svc_rdma_free(struct svc_xprt *xprt);
>  static int svc_rdma_has_wspace(struct svc_xprt *xprt);
> -static void svc_rdma_secure_port(struct svc_rqst *);
>  static void svc_rdma_kill_temp_xprt(struct svc_xprt *);
> =20
>  static const struct svc_xprt_ops svc_rdma_ops =3D {
> @@ -86,7 +85,6 @@ static const struct svc_xprt_ops svc_rdma_ops =3D {
>  	.xpo_free =3D svc_rdma_free,
>  	.xpo_has_wspace =3D svc_rdma_has_wspace,
>  	.xpo_accept =3D svc_rdma_accept,
> -	.xpo_secure_port =3D svc_rdma_secure_port,
>  	.xpo_kill_temp_xprt =3D svc_rdma_kill_temp_xprt,
>  };
> =20
> @@ -600,11 +598,6 @@ static int svc_rdma_has_wspace(struct svc_xprt *xprt=
)
>  	return 1;
>  }
> =20
> -static void svc_rdma_secure_port(struct svc_rqst *rqstp)
> -{
> -	set_bit(RQ_SECURE, &rqstp->rq_flags);
> -}
> -
>  static void svc_rdma_kill_temp_xprt(struct svc_xprt *xprt)
>  {
>  }
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
