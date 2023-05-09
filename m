Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2376FC890
	for <lists+linux-nfs@lfdr.de>; Tue,  9 May 2023 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjEIOLO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 May 2023 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjEIOLO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 May 2023 10:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E1030D6
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 07:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E272462DDD
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 14:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F954C4339B;
        Tue,  9 May 2023 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683641471;
        bh=RvciPa5zSE7QDNvPVThl9zKYOO/w27wOGxtLmFdHtFE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l5Shenlj5QT6+bctympcqhKDZz40BmoQ/Ueof2frLHqtMGZJZKgcLWSM7xR4UCJ1r
         xJb5PXKb8+gBIkrM/xIb7qsrQMAMNXR9DO1nUpKASUJt2bwd/gyH4Q51HwqaadGGkX
         T3p3bEwFVy7HUQ8ec4EhB/QGiXK0asnQevvubfrEn4mZR6RPIjE85hozJXt5L665KK
         bJERdMkk/6Tr8aMW6Rmeliu7no2UUAUkevWXfaTEyY9xiewd9ogtyZcjFryEY6pWZx
         NejCxzjWXBiOZfbExLJB4Q/xJQ6kcR1ZXAB441ViAg8tq+xD/sVgoi5C/GPFdLXcxv
         uRLLqRnbguF/Q==
Message-ID: <3e44255b4c826405be0f69206d0590dc8799644e.camel@kernel.org>
Subject: Re: [PATCH 2/2] SUNRPC: always free ctxt when freeing deferred
 request
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 09 May 2023 07:11:10 -0700
In-Reply-To: <168358936786.26026.624483381722608538@noble.neil.brown.name>
References: <168358930939.26026.4067210924697967164@noble.neil.brown.name>
         <168358936786.26026.624483381722608538@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.module_f38+16663+080ec715) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-05-09 at 09:42 +1000, NeilBrown wrote:
> Since the ->xprt_ctxt pointer was added to svc_deferred_req, it has not
> been sufficient to use kfree() to free a deferred request.  We may need
> to free the ctxt as well.
>=20
> As freeing the ctxt is all that ->xpo_release_rqst() does, we repurpose
> it to explicit do that even when the ctxt is not stored in an rqst.
> So we now have ->xpo_release_ctxt() which is given an xprt and a ctxt,
> which may have been taken either from an rqst or from a dreq.  The
> caller is now responsible for clearing that pointer after the call to
> ->xpo_release_ctxt.
>=20
> We also clear dr->xprt_ctxt when the ctxt is moved into a new rqst when
> revisiting a deferred request.  This ensures there is only one pointer
> to the ctxt, so the risk of double freeing in future is reduced.  The
> new code in svc_xprt_release which releases both the ctxt and any
> rq_deferred depends on this.
>=20

Thank you. Leaving stray pointers around like that is just asking for
trouble.

> Fixes: 773f91b2cf3f ("SUNRPC: Fix NFSD's request deferral on RDMA transpo=
rts")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc_rdma.h          |  2 +-
>  include/linux/sunrpc/svc_xprt.h          |  2 +-
>  net/sunrpc/svc_xprt.c                    | 21 ++++++++++++-----
>  net/sunrpc/svcsock.c                     | 30 +++++++++++++-----------
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 11 ++++-----
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
>  6 files changed, 39 insertions(+), 29 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_r=
dma.h
> index 24aa159d29a7..fbc4bd423b35 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -176,7 +176,7 @@ extern struct svc_rdma_recv_ctxt *
>  extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
>  				   struct svc_rdma_recv_ctxt *ctxt);
>  extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
> -extern void svc_rdma_release_rqst(struct svc_rqst *rqstp);
> +extern void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *ctxt);
>  extern int svc_rdma_recvfrom(struct svc_rqst *);
> =20
>  /* svc_rdma_rw.c */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> index 867479204840..6f4473ee68e1 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -23,7 +23,7 @@ struct svc_xprt_ops {
>  	int		(*xpo_sendto)(struct svc_rqst *);
>  	int		(*xpo_result_payload)(struct svc_rqst *, unsigned int,
>  					      unsigned int);
> -	void		(*xpo_release_rqst)(struct svc_rqst *);
> +	void		(*xpo_release_ctxt)(struct svc_xprt *, void *);
>  	void		(*xpo_detach)(struct svc_xprt *);
>  	void		(*xpo_free)(struct svc_xprt *);
>  	void		(*xpo_kill_temp_xprt)(struct svc_xprt *);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 5fd94f6bdc75..1e3bba433561 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -532,13 +532,21 @@ void svc_reserve(struct svc_rqst *rqstp, int space)
>  }
>  EXPORT_SYMBOL_GPL(svc_reserve);
> =20
> +static void free_deferred(struct svc_xprt *xprt, struct svc_deferred_req=
 *dr)
> +{
> +	if (dr)
> +		xprt->xpt_ops->xpo_release_ctxt(xprt, dr->xprt_ctxt);
> +	kfree(dr);

nit: might as well put the kfree inside the if block to avoid it in the
common case of dr =3D=3D NULL.

> +}
> +
>  static void svc_xprt_release(struct svc_rqst *rqstp)
>  {
>  	struct svc_xprt	*xprt =3D rqstp->rq_xprt;
> =20
> -	xprt->xpt_ops->xpo_release_rqst(rqstp);
> +	xprt->xpt_ops->xpo_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
> +	rqstp->rq_xprt_ctxt =3D NULL;
> =20
> -	kfree(rqstp->rq_deferred);
> +	free_deferred(xprt, rqstp->rq_deferred);
>  	rqstp->rq_deferred =3D NULL;
> =20
>  	svc_rqst_release_pages(rqstp);
> @@ -1054,7 +1062,7 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
>  	spin_unlock_bh(&serv->sv_lock);
> =20
>  	while ((dr =3D svc_deferred_dequeue(xprt)) !=3D NULL)
> -		kfree(dr);
> +		free_deferred(xprt, dr);
> =20
>  	call_xpt_users(xprt);
>  	svc_xprt_put(xprt);
> @@ -1176,8 +1184,8 @@ static void svc_revisit(struct cache_deferred_req *=
dreq, int too_many)
>  	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
>  		spin_unlock(&xprt->xpt_lock);
>  		trace_svc_defer_drop(dr);
> +		free_deferred(xprt, dr);
>  		svc_xprt_put(xprt);
> -		kfree(dr);
>  		return;
>  	}
>  	dr->xprt =3D NULL;
> @@ -1222,14 +1230,13 @@ static struct cache_deferred_req *svc_defer(struc=
t cache_req *req)
>  		dr->addrlen =3D rqstp->rq_addrlen;
>  		dr->daddr =3D rqstp->rq_daddr;
>  		dr->argslen =3D rqstp->rq_arg.len >> 2;
> -		dr->xprt_ctxt =3D rqstp->rq_xprt_ctxt;
> =20
>  		/* back up head to the start of the buffer and copy */
>  		skip =3D rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
>  		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
>  		       dr->argslen << 2);
>  	}
> -	WARN_ON_ONCE(rqstp->rq_xprt_ctxt !=3D dr->xprt_ctxt);
> +	dr->xprt_ctxt =3D rqstp->rq_xprt_ctxt;
>  	rqstp->rq_xprt_ctxt =3D NULL;
>  	trace_svc_defer(rqstp);
>  	svc_xprt_get(rqstp->rq_xprt);
> @@ -1263,6 +1270,8 @@ static noinline int svc_deferred_recv(struct svc_rq=
st *rqstp)
>  	rqstp->rq_daddr       =3D dr->daddr;
>  	rqstp->rq_respages    =3D rqstp->rq_pages;
>  	rqstp->rq_xprt_ctxt   =3D dr->xprt_ctxt;
> +
> +	dr->xprt_ctxt =3D NULL;
>  	svc_xprt_received(rqstp->rq_xprt);
>  	return dr->argslen << 2;
>  }
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index a51c9b989d58..aa4f31a770e3 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -121,27 +121,27 @@ static void svc_reclassify_socket(struct socket *so=
ck)
>  #endif
> =20
>  /**
> - * svc_tcp_release_rqst - Release transport-related resources
> - * @rqstp: request structure with resources to be released
> + * svc_tcp_release_ctxt - Release transport-related resources
> + * @xprt: the transport which owned the context
> + * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
>   *
>   */
> -static void svc_tcp_release_rqst(struct svc_rqst *rqstp)
> +static void svc_tcp_release_ctxt(struct svc_xprt *xprt, void *ctxt)
>  {
>  }
> =20
>  /**
> - * svc_udp_release_rqst - Release transport-related resources
> - * @rqstp: request structure with resources to be released
> + * svc_udp_release_ctxt - Release transport-related resources
> + * @xprt: the transport which owned the context
> + * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
>   *
>   */
> -static void svc_udp_release_rqst(struct svc_rqst *rqstp)
> +static void svc_udp_release_ctxt(struct svc_xprt *xprt, void *ctxt)
>  {
> -	struct sk_buff *skb =3D rqstp->rq_xprt_ctxt;
> +	struct sk_buff *skb =3D ctxt;
> =20
> -	if (skb) {
> -		rqstp->rq_xprt_ctxt =3D NULL;
> +	if (skb)
>  		consume_skb(skb);
> -	}
>  }
> =20
>  union svc_pktinfo_u {
> @@ -696,7 +696,8 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	unsigned int sent;
>  	int err;
> =20
> -	svc_udp_release_rqst(rqstp);
> +	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
> +	rqstp->rq_xprt_ctxt =3D NULL;
> =20
>  	svc_set_cmsg_data(rqstp, cmh);
> =20
> @@ -768,7 +769,7 @@ static const struct svc_xprt_ops svc_udp_ops =3D {
>  	.xpo_recvfrom =3D svc_udp_recvfrom,
>  	.xpo_sendto =3D svc_udp_sendto,
>  	.xpo_result_payload =3D svc_sock_result_payload,
> -	.xpo_release_rqst =3D svc_udp_release_rqst,
> +	.xpo_release_ctxt =3D svc_udp_release_ctxt,
>  	.xpo_detach =3D svc_sock_detach,
>  	.xpo_free =3D svc_sock_free,
>  	.xpo_has_wspace =3D svc_udp_has_wspace,
> @@ -1298,7 +1299,8 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
>  	unsigned int sent;
>  	int err;
> =20
> -	svc_tcp_release_rqst(rqstp);
> +	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
> +	rqstp->rq_xprt_ctxt =3D NULL;
> =20
>  	atomic_inc(&svsk->sk_sendqlen);
>  	mutex_lock(&xprt->xpt_mutex);
> @@ -1343,7 +1345,7 @@ static const struct svc_xprt_ops svc_tcp_ops =3D {
>  	.xpo_recvfrom =3D svc_tcp_recvfrom,
>  	.xpo_sendto =3D svc_tcp_sendto,
>  	.xpo_result_payload =3D svc_sock_result_payload,
> -	.xpo_release_rqst =3D svc_tcp_release_rqst,
> +	.xpo_release_ctxt =3D svc_tcp_release_ctxt,
>  	.xpo_detach =3D svc_tcp_sock_detach,
>  	.xpo_free =3D svc_sock_free,
>  	.xpo_has_wspace =3D svc_tcp_has_wspace,
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdm=
a/svc_rdma_recvfrom.c
> index 1c658fa43063..5c51e28b3111 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -239,21 +239,20 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rd=
ma,
>  }
> =20
>  /**
> - * svc_rdma_release_rqst - Release transport-specific per-rqst resources
> - * @rqstp: svc_rqst being released
> + * svc_rdma_release_ctxt - Release transport-specific per-rqst resources
> + * @xprt: the transport which owned the context
> + * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
>   *
>   * Ensure that the recv_ctxt is released whether or not a Reply
>   * was sent. For example, the client could close the connection,
>   * or svc_process could drop an RPC, before the Reply is sent.
>   */
> -void svc_rdma_release_rqst(struct svc_rqst *rqstp)
> +void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *vctxt)
>  {
> -	struct svc_rdma_recv_ctxt *ctxt =3D rqstp->rq_xprt_ctxt;
> -	struct svc_xprt *xprt =3D rqstp->rq_xprt;
> +	struct svc_rdma_recv_ctxt *ctxt =3D vctxt;
>  	struct svcxprt_rdma *rdma =3D
>  		container_of(xprt, struct svcxprt_rdma, sc_xprt);
> =20
> -	rqstp->rq_xprt_ctxt =3D NULL;
>  	if (ctxt)
>  		svc_rdma_recv_ctxt_put(rdma, ctxt);
>  }
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrd=
ma/svc_rdma_transport.c
> index 416b298f74dd..ca04f7a6a085 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -80,7 +80,7 @@ static const struct svc_xprt_ops svc_rdma_ops =3D {
>  	.xpo_recvfrom =3D svc_rdma_recvfrom,
>  	.xpo_sendto =3D svc_rdma_sendto,
>  	.xpo_result_payload =3D svc_rdma_result_payload,
> -	.xpo_release_rqst =3D svc_rdma_release_rqst,
> +	.xpo_release_ctxt =3D svc_rdma_release_ctxt,
>  	.xpo_detach =3D svc_rdma_detach,
>  	.xpo_free =3D svc_rdma_free,
>  	.xpo_has_wspace =3D svc_rdma_has_wspace,

Reviewed-by: Jeff Layton <jlayton@kernel.org>
