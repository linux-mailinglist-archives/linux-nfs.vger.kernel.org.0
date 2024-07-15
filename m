Return-Path: <linux-nfs+bounces-4930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90B931801
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19521F21D75
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D06C8E9;
	Mon, 15 Jul 2024 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFiLzUpu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A8C156
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059220; cv=none; b=LC5KrQLVurxhuNIUW8jfAmUVUeFhYwQVP0tH4BDVGbGHeCu+o+nNsCRdyPi+/2hkPaDnGY2LTzMdmRQzNeqMyWFMX3LJ9rc1720JJMzkkWgUFSFw5bXyaQMVJzSVGKJNpHTtixiYrjwHApdw3GwGBP1zMKp4lvH+WM6LL1XoxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059220; c=relaxed/simple;
	bh=IVQhIS5l+xZNIJ3lRVf9lnaemzcGM4PBHwFfaRfLltw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLgyioSU2ssbpyQ5QDRr7RDdpeygBXZuOX6gEsxFKIqsXR+WglYAd2wM73wc/CeiWCNKDw7g2X9Tx3W9QmX7mViudPcYbG6efnevjO2X9DFdJWve7ET8Pwc3cJlHueunO+uXzLZR+RkCvjWSLrdxYcOrqWAZzieisVC0Y3+Hb/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFiLzUpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC52C32782;
	Mon, 15 Jul 2024 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059219;
	bh=IVQhIS5l+xZNIJ3lRVf9lnaemzcGM4PBHwFfaRfLltw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hFiLzUpuR9EzRnjZNX74jLU7GdOO2tbBkKQxSk6HNb70M/J7AtVNUNOOqUy0bB7Nk
	 miIrTqJ9e3F0F69dw/+5Vn3lWYhFtW2V4WKTJFMjgZkqMXdzGc236ybNa19B3pdLNU
	 qzRSs3/09Yikdld3Rp8ccCwy3d+x8kXtk+jID4rl6dW/8QAn1UWDyZh519fwffEQMB
	 Fu6ajz6KINvB6rCuvxZBUs+HKgfNN0tCEaFy0jDeZKlffn5OU06t0OZ0iAK0wqOJvc
	 nbldfPo0AZueHS98jidcJpGEGMFlkjLEkYNXen8PXzbpPzsRbBFTKidTFadTILT407
	 nxYrgBRWlTThg==
Message-ID: <fbb069c53a616db5491ec143f19db9026686d031.camel@kernel.org>
Subject: Re: [PATCH 12/14] sunrpc: introduce possibility that requested
 number of threads is different from actual
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve Dickson
	 <steved@redhat.com>
Date: Mon, 15 Jul 2024 12:00:18 -0400
In-Reply-To: <20240715074657.18174-13-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
	 <20240715074657.18174-13-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> New fields sp_nractual and sv_nractual track how many actual threads are
> running.=C2=A0 sp_nrhtreads and sv_nrthreads will be the number that were
> explicitly request.=C2=A0 Currently nractually =3D=3D nrthreads.
>=20
> sv_nractual is used for sizing UDP incoming socket space - in the rare
> case that UDP is used.=C2=A0 This is because each thread might need to ke=
ep a
> request in the skbs.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0include/linux/sunrpc/svc.h |=C2=A0 4 +++-
> =C2=A0net/sunrpc/svc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 22 +++++++++++++++-------
> =C2=A0net/sunrpc/svcsock.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
> =C2=A03 files changed, 19 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 0b414af448e0..363105fc6326 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -36,6 +36,7 @@ struct svc_pool {
> =C2=A0	unsigned int		sp_id;		/* pool id; also node id on NUMA */
> =C2=A0	struct lwq		sp_xprts;	/* pending transports */
> =C2=A0	unsigned int		sp_nrthreads;	/* # of threads in pool */
> +	unsigned int		sp_nractual;	/* # of threads running */
> =C2=A0	struct list_head	sp_all_threads;	/* all server threads */
> =C2=A0	struct llist_head	sp_idle_threads; /* idle server threads */
> =C2=A0
> @@ -69,7 +70,8 @@ struct svc_serv {
> =C2=A0	struct svc_program *	sv_program;	/* RPC program */
> =C2=A0	struct svc_stat *	sv_stats;	/* RPC statistics */
> =C2=A0	spinlock_t		sv_lock;
> -	unsigned int		sv_nrthreads;	/* # of server threads */
> +	unsigned int		sv_nrthreads;	/* # of server threads requested*/
> +	unsigned int		sv_nractual;	/* # of running threads */
> =C2=A0	unsigned int		sv_maxconn;	/* max connections allowed or
> =C2=A0						 * '0' causing max to be based
> =C2=A0						 * on number of threads. */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index d814b2cfa84f..33c1a7793f63 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -785,8 +785,12 @@ svc_pool_victim(struct svc_serv *serv, struct svc_po=
ol *target_pool,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (pool && pool->sp_nrthreads) {
> -		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> -		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> +		if (pool->sp_nrthreads <=3D pool->sp_nractual) {
> +			set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> +			set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> +			pool->sp_nractual -=3D 1;
> +			serv->sv_nractual -=3D 1;
> +		}
> =C2=A0		return pool;
> =C2=A0	}
> =C2=A0	return NULL;
> @@ -806,6 +810,12 @@ svc_start_kthreads(struct svc_serv *serv, struct svc=
_pool *pool, int nrservs)
> =C2=A0		chosen_pool =3D svc_pool_next(serv, pool, &state);
> =C2=A0		node =3D svc_pool_map_get_node(chosen_pool->sp_id);
> =C2=A0
> +		serv->sv_nrthreads +=3D 1;
> +		chosen_pool->sp_nrthreads +=3D 1;
> +
> +		if (chosen_pool->sp_nrthreads <=3D chosen_pool->sp_nractual)
> +			continue;
> +
> =C2=A0		rqstp =3D svc_prepare_thread(serv, chosen_pool, node);
> =C2=A0		if (IS_ERR(rqstp))
> =C2=A0			return PTR_ERR(rqstp);
> @@ -815,8 +825,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_=
pool *pool, int nrservs)
> =C2=A0			svc_exit_thread(rqstp);
> =C2=A0			return PTR_ERR(task);
> =C2=A0		}
> -		serv->sv_nrthreads +=3D 1;
> -		chosen_pool->sp_nrthreads +=3D 1;
> +		serv->sv_nractual +=3D 1;
> +		chosen_pool->sp_nractual +=3D 1;
> =C2=A0
> =C2=A0		rqstp->rq_task =3D task;
> =C2=A0		if (serv->sv_nrpools > 1)
> @@ -846,6 +856,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_p=
ool *pool, int nrservs)
> =C2=A0			=C2=A0=C2=A0=C2=A0 TASK_IDLE);
> =C2=A0		nrservs++;
> =C2=A0	} while (nrservs < 0);
> +	svc_sock_update_bufs(serv);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -937,13 +948,10 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
> =C2=A0void
> =C2=A0svc_exit_thread(struct svc_rqst *rqstp)
> =C2=A0{
> -	struct svc_serv	*serv =3D rqstp->rq_server;
> =C2=A0	struct svc_pool	*pool =3D rqstp->rq_pool;
> =C2=A0
> =C2=A0	list_del_rcu(&rqstp->rq_all);
> =C2=A0
> -	svc_sock_update_bufs(serv);
> -

I like that you're now only doing this once after all of the threads
are stopped. That might be worth mentioning in the changelog.

> =C2=A0	svc_rqst_free(rqstp);
> =C2=A0
> =C2=A0	clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 825ec5357691..191dbc648bd0 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -588,7 +588,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 * provides an upper bound on the number o=
f threads
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 * which will access the socket.
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 */
> -	=C2=A0=C2=A0=C2=A0 svc_sock_setbufsize(svsk, serv->sv_nrthreads + 3);
> +	=C2=A0=C2=A0=C2=A0 svc_sock_setbufsize(svsk, serv->sv_nractual + 3);
> =C2=A0
> =C2=A0	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
> =C2=A0	err =3D kernel_recvmsg(svsk->sk_sock, &msg, NULL,

--=20
Jeff Layton <jlayton@kernel.org>

