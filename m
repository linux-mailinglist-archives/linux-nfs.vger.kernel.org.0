Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C06A59F0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Feb 2023 14:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjB1NXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Feb 2023 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1NXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Feb 2023 08:23:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A8012BCB
        for <linux-nfs@vger.kernel.org>; Tue, 28 Feb 2023 05:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DF861072
        for <linux-nfs@vger.kernel.org>; Tue, 28 Feb 2023 13:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EF8C433D2;
        Tue, 28 Feb 2023 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677590631;
        bh=Rze/MJ/sLXbSJjmJ6fPf3M+bYNZ6Lc5Zc+o/xvBSgds=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=N3mSrPuz5wRbSblE7qvK5YxUlno9dksYh7CguKLRZzt0G5NbP06uFIcmQKsOsmPFf
         288HxOn2d4sMJTNjqSY9e5zCIgCpIbUHY4SLgenAhDVKGvgs/THAnbsVd5+tLJVh4C
         eN1vjspkTT96EqM/rdmYp+1Ysy83zJ144x8cxo5BWl47eElwMis/w/ZBXts57Yp35K
         4Fd0pK1L11SUYlYRijAFlZ/53JtSPR7rkzqheEEEmgbk8+uh8OtKNSPiVC/Qh0ec6G
         xSL+1LulC9ZskojMhcvwyQ9WKZVv5zZoZOG9o4xeKpqHGoQEJO70KApv4/YK/ZswUE
         Mr3rPgPF8X2+Q==
Message-ID: <45e2e7f05a13abab777b3b0868744cdbfc623f2d.camel@kernel.org>
Subject: Re: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
From:   Jeff Layton <jlayton@kernel.org>
To:     Andrew Klaassen <andrew.klaassen@boatrocker.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Tue, 28 Feb 2023 08:23:49 -0500
In-Reply-To: <YQBPR01MB10724998CA29C5AFF7E6B391E86AF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
         <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
         <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
         <YQBPR01MB107243906854065876378D57B86D69@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724969B61BA7156DB71A82686DA9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB1072471CD751CDDEE7C0AD5BB86DA9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724998CA29C5AFF7E6B391E86AF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-02-27 at 14:48 +0000, Andrew Klaassen wrote:
> > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > Sent: Monday, February 6, 2023 12:19 PM
> >=20
> > > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > > Sent: Monday, February 6, 2023 10:28 AM
> > >=20
> >=20
> > > [snipping for readability; hope that's okay]
> > >=20
> > > =A0- I'm allocating memory.  I assume that means I should free it
> > > somewhere.
> > > But where?  In xprt_destroy(), which appears to do cleanup?  Or in
> > > xprt_destroy_cb(), which is called from xprt_destroy() and which
> > > frees
> > > xprt-
> > > > servername?  Or somewhere else completely?
> > > =A0- If I free the allocated memory, will that cause any problems in
> > > the
> > > cases where no timeout is passed in via the args and the static
> > > const
> > > struct xs_tcp_default_timeout is assigned to xprt->timeout?
> > > =A0- If freeing the static const struct default will cause a
> > > problem,
> > > what should I do instead?  Allocate and memcpy even when assigning
> > > the
> > > default?  And would that mean doing the same thing for all the
> > > other
> > > transports that are setting timeouts (local, udp, tcp, and
> > > bc_tcp)?
> >=20
> > [snipping more]
>=20
> Here's the patch in what I hope is its final form.  I'm planning to
> test it on a couple of hundred nodes over the next month or two.
>=20
> Since I'm completely new to this, what would be the chances of
> actually getting this patch in the kernel?
>=20
> Thanks.
>=20
> Andrew
>=20

Excellent work! I'll be interested to hear how the testing goes!


This patch still needs a bit of work. I'd consider this a proof-of-
concept. You are at least demonstrating the problem with this patch (and
a possible solution).

Conceptually, it's not 100% clear to me that we want the exact same
timeout on the RPC call and the xprt. We might, but working with
interlocking timeouts can bring in emergent behavioral changes and I
haven't thought through these.


> From caa3308a3bcf39eb95d9b59e63bd96361e98305e Mon Sep 17 00:00:00 2001
> From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> Date: Fri, 10 Feb 2023 10:37:57 -0500
> Subject: [PATCH] Sun RPC: Use passed-in timeouts if available instead
> of
> =A0always using defaults.
>=20

This needs a real patch description. Describe the problem you were
having, and how this patch changes things to address it. Make sure you
add a Signed-off-by line too.

When you resend, send it to the the nfs client maintainers (Trond and
Anna) using git-format-patch and git-send-email, and cc linux-nfs list.
I think your MUA might have mangled the patch a bit. Please look over
Documentation/process/submitting-patches.rst in the kernel source tree
too.=20


> ---
> =A0include/linux/sunrpc/xprt.h |  3 +++
> =A0net/sunrpc/clnt.c           |  1 +
> =A0net/sunrpc/xprt.c           | 21 +++++++++++++++++++++
> =A0net/sunrpc/xprtsock.c       | 22 +++++++++++++++++++---
> =A04 files changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index b9f59aabee53..ca7be090cf83 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -333,6 +333,7 @@ struct xprt_create {
> =A0	struct svc_xprt		*bc_xprt;	/* NFSv4.1
> backchannel */
> =A0	struct rpc_xprt_switch	*bc_xps;
> =A0	unsigned int		flags;
> +	const struct rpc_timeout *timeout;	/* timeout parms */
> =A0};
> =A0
> =A0struct xprt_class {
> @@ -373,6 +374,8 @@
> void			xprt_release_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *tas=
k);
> =A0void			xprt_release(struct rpc_task *task);
> =A0struct rpc_xprt *	xprt_get(struct rpc_xprt *xprt);
> =A0void			xprt_put(struct rpc_xprt *xprt);
> +struct rpc_timeout	*xprt_alloc_timeout(const struct rpc_timeout
> *timeo,
> +				const struct rpc_timeout
> *default_timeo);
> =A0struct rpc_xprt *	xprt_alloc(struct net *net, size_t size,
> =A0				unsigned int num_prealloc,
> =A0				unsigned int max_req);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0b0b9f1eed46..1350c1f489f7 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -532,6 +532,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args
> *args)
> =A0		.addrlen =3D args->addrsize,
> =A0		.servername =3D args->servername,
> =A0		.bc_xprt =3D args->bc_xprt,
> +		.timeout =3D args->timeout,
> =A0	};
> =A0	char servername[48];
> =A0	struct rpc_clnt *clnt;
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index ab453ede54f0..0bb800c90976 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1801,6 +1801,26 @@ static void xprt_free_id(struct rpc_xprt *xprt)
> =A0	ida_free(&rpc_xprt_ids, xprt->id);
> =A0}
> =A0
> +struct rpc_timeout *xprt_alloc_timeout(const struct rpc_timeout
> *timeo,
> +				       const struct rpc_timeout
> *default_timeo)
> +{
> +	struct rpc_timeout *timeout;
> +
> +	timeout =3D kzalloc(sizeof(*timeout), GFP_KERNEL);
> +	if (!timeout)
> +		return ERR_PTR(-ENOMEM);
> +	if (timeo)
> +		memcpy(timeout, timeo, sizeof(struct rpc_timeout));
> +	else
> +		memcpy(timeout, default_timeo, sizeof(struct
> rpc_timeout));

I don't think you need an allocation here. struct rpc_timeout is quite
small and it only contains a bunch of integers. I think it'd be better
to just embed this in struct rpc_xprt instead.

> +	return timeout;
> +}
> +
> +static void xprt_free_timeout(struct rpc_xprt *xprt)
> +{
> +	kfree(xprt->timeout);
> +}
> +
> =A0struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
> =A0		unsigned int num_prealloc,
> =A0		unsigned int max_alloc)
> @@ -1837,6 +1857,7 @@ EXPORT_SYMBOL_GPL(xprt_alloc);
> =A0
> =A0void xprt_free(struct rpc_xprt *xprt)
> =A0{
> +	xprt_free_timeout(xprt);
> =A0	put_net_track(xprt->xprt_net, &xprt->ns_tracker);
> =A0	xprt_free_all_slots(xprt);
> =A0	xprt_free_id(xprt);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index aaa5b2741b79..13703f8e0ef1 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2924,7 +2924,12 @@ static struct rpc_xprt *xs_setup_udp(struct
> xprt_create *args)
> =A0
> =A0	xprt->ops =3D &xs_udp_ops;
> =A0
> -	xprt->timeout =3D &xs_udp_default_timeout;
> +	xprt->timeout =3D xprt_alloc_timeout(args->timeout,
> &xs_udp_default_timeout);
> +	if (IS_ERR(xprt->timeout))
> +	{

Kernel coding style has the brackets on the same line as the "if"
statement. You should run your next iteration through checkpatch.pl.


> +		ret =3D ERR_CAST(xprt->timeout);
> +		goto out_err;
> +	}
> =A0
> =A0	INIT_WORK(&transport->recv_worker,
> xs_udp_data_receive_workfn);
> =A0	INIT_WORK(&transport->error_worker, xs_error_handle);
> @@ -3003,7 +3008,13 @@ static struct rpc_xprt *xs_setup_tcp(struct
> xprt_create *args)
> =A0	xprt->idle_timeout =3D XS_IDLE_DISC_TO;
> =A0
> =A0	xprt->ops =3D &xs_tcp_ops;
> -	xprt->timeout =3D &xs_tcp_default_timeout;
> +
> +	xprt->timeout =3D xprt_alloc_timeout(args->timeout,
> &xs_tcp_default_timeout);
> +	if (IS_ERR(xprt->timeout))
> +	{
> +		ret =3D ERR_CAST(xprt->timeout);
> +		goto out_err;
> +	}
> =A0
> =A0	xprt->max_reconnect_timeout =3D xprt->timeout->to_maxval;
> =A0	xprt->connect_timeout =3D xprt->timeout->to_initval *
> @@ -3071,7 +3082,12 @@ static struct rpc_xprt *xs_setup_bc_tcp(struct
> xprt_create *args)
> =A0	xprt->prot =3D IPPROTO_TCP;
> =A0	xprt->xprt_class =3D &xs_bc_tcp_transport;
> =A0	xprt->max_payload =3D RPC_MAX_FRAGMENT_SIZE;
> -	xprt->timeout =3D &xs_tcp_default_timeout;
> +	xprt->timeout =3D xprt_alloc_timeout(args->timeout,
> &xs_tcp_default_timeout);
> +	if (IS_ERR(xprt->timeout))
> +	{
> +		ret =3D ERR_CAST(xprt->timeout);
> +		goto out_err;
> +	}
> =A0
> =A0	/* backchannel */
> =A0	xprt_set_bound(xprt);
> --=20
> 2.39.1
>=20

--=20
Jeff Layton <jlayton@kernel.org>
