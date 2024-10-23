Return-Path: <linux-nfs+bounces-7385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A69ACB49
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0634D281923
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62F1ABEBD;
	Wed, 23 Oct 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqzc09mx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B311A76AC
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690324; cv=none; b=QOaZsTUQP7gZEqLTzNqbj48iDPHvTqEexUV6Aq+VI30mH9vpZQjDLCVUeIlf+8CS/bvXxUkT5S+NW/tlwGA3aotu4d36/SeEdxAu2rW2VFxyoMKUz+20kekl83yaV8pjrJ3GufNn07aeLYzUd2fL6OxsonNngFJTBwzEyNPb9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690324; c=relaxed/simple;
	bh=ENjWj4rq6Dne/Qaum/WE/H/tRRbjmY24lADiOBFaj4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwETje94Cb0FaE9cqXvCmcqPHOhAyqHVoUoU/x0dGHBrnKXN8aQa1Ryl69HFOEYLG1c1LjIM3WAapGprWDrf6P8ROFVmpsa4DJTIlmp+8xQh819/KuT95VZ2XSm/VHoT1mSrp9zpeuOtbxT/YIslHZ96nr0KJeN/hR2fUuaMtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqzc09mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F868C4CEC6;
	Wed, 23 Oct 2024 13:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690324;
	bh=ENjWj4rq6Dne/Qaum/WE/H/tRRbjmY24lADiOBFaj4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cqzc09mxK3vNUI1JBLpvplOB+ELBz6PIh+L2Npp9UAp51bkUjMnUErRnSRxvUyZQO
	 hxKDa2bAvw3w5yS4/gkJLa4qCnwf7xE6nQ1v5zYPE9E52X4Sz5+CekOeZtMrM7tXa5
	 ROT+P3vlznQLe0zgIk9vmVG1UJ7Ck7i1K0muQ+Lsw3hp0ktwenlt6ZmT+eBG/d4kon
	 CLvhnzWFCCpvagS1lP+TpES4ujCBxKXTL6srg82e9nEHtOO38zjjMm5ZeZZL7VkFmz
	 BQEtMMpCz5sMegwj6rq7CwvwLbe/yL/2srP9tmphqF7J8rDqF4DXKZ8ZoVGXgQa+IH
	 Lvh8vKuAHe+kA==
Message-ID: <54df72ac86885254e15f5529a99eae01ac16e1c0.camel@kernel.org>
Subject: Re: [PATCH 6/6] sunrpc: introduce possibility that requested number
 of threads is different from actual
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Wed, 23 Oct 2024 09:32:00 -0400
In-Reply-To: <20241023024222.691745-7-neilb@suse.de>
References: <20241023024222.691745-1-neilb@suse.de>
	 <20241023024222.691745-7-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 13:37 +1100, NeilBrown wrote:
> New fields sp_nractual and sv_nractual track how many actual threads are
> running.  sp_nrhtreads and sv_nrthreads will be the number that were
> explicitly request.  Currently nractually =3D=3D nrthreads.
>=20
> sv_nractual is used for sizing UDP incoming socket space - in the rare
> case that UDP is used.  This is because each thread might need to keep a
> request in the skbs.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc.h |  6 ++++--
>  net/sunrpc/svc.c           | 22 +++++++++++++++-------
>  net/sunrpc/svcsock.c       |  2 +-
>  3 files changed, 20 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 9d288a673705..3f2c90061b4a 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -36,7 +36,8 @@
>  struct svc_pool {
>  	unsigned int		sp_id;		/* pool id; also node id on NUMA */
>  	struct lwq		sp_xprts;	/* pending transports */
> -	unsigned int		sp_nrthreads;	/* # of threads in pool */
> +	unsigned int		sp_nrthreads;	/* # of threads requested for pool */
> +	unsigned int		sp_nractual;	/* # of threads running */
>  	struct list_head	sp_all_threads;	/* all server threads */
>  	struct llist_head	sp_idle_threads; /* idle server threads */
> =20
> @@ -71,7 +72,8 @@ struct svc_serv {
>  	struct svc_stat *	sv_stats;	/* RPC statistics */
>  	spinlock_t		sv_lock;
>  	unsigned int		sv_nprogs;	/* Number of sv_programs */
> -	unsigned int		sv_nrthreads;	/* # of server threads */
> +	unsigned int		sv_nrthreads;	/* # of server threads requested*/
> +	unsigned int		sv_nractual;	/* # of running threads */
>  	unsigned int		sv_max_payload;	/* datagram payload size */
>  	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
>  	unsigned int		sv_xdrsize;	/* XDR buffer size */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index bd4f02b34f44..d332f9d3d875 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -781,8 +781,12 @@ svc_pool_victim(struct svc_serv *serv, struct svc_po=
ol *target_pool,
>  	}
> =20
>  	if (pool && pool->sp_nrthreads) {
> -		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> -		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> +		if (pool->sp_nrthreads <=3D pool->sp_nractual) {
> +			set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> +			set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> +			pool->sp_nractual -=3D 1;
> +			serv->sv_nractual -=3D 1;
> +		}

This is a little strange. It decrements the thread counts before the
threads actually exit. So, these counts are really just aspirational at
this point. Not a bug, just a note to myself while I am going over
this.

>  		return pool;
>  	}
>  	return NULL;
> @@ -803,6 +807,12 @@ svc_start_kthreads(struct svc_serv *serv, struct svc=
_pool *pool, int nrservs)
>  		chosen_pool =3D svc_pool_next(serv, pool, &state);
>  		node =3D svc_pool_map_get_node(chosen_pool->sp_id);
> =20
> +		serv->sv_nrthreads +=3D 1;
> +		chosen_pool->sp_nrthreads +=3D 1;
> +
> +		if (chosen_pool->sp_nrthreads <=3D chosen_pool->sp_nractual)
> +			continue;
> +
>  		rqstp =3D svc_prepare_thread(serv, chosen_pool, node);
>  		if (!rqstp)
>  			return -ENOMEM;
> @@ -812,8 +822,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_=
pool *pool, int nrservs)
>  			svc_exit_thread(rqstp);
>  			return PTR_ERR(task);
>  		}
> -		serv->sv_nrthreads +=3D 1;
> -		chosen_pool->sp_nrthreads +=3D 1;
> +		serv->sv_nractual +=3D 1;
> +		chosen_pool->sp_nractual +=3D 1;
> =20
>  		rqstp->rq_task =3D task;
>  		if (serv->sv_nrpools > 1)
> @@ -850,6 +860,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_p=
ool *pool, int nrservs)
>  			    TASK_IDLE);
>  		nrservs++;
>  	} while (nrservs < 0);
> +	svc_sock_update_bufs(serv);

Nice little change here. No need to do this on every thread exit --
just do it once when they're all done. This change probably should be
split into a separate patch.

>  	return 0;
>  }
> =20
> @@ -955,13 +966,10 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
>  void
>  svc_exit_thread(struct svc_rqst *rqstp)
>  {
> -	struct svc_serv	*serv =3D rqstp->rq_server;
>  	struct svc_pool	*pool =3D rqstp->rq_pool;
> =20
>  	list_del_rcu(&rqstp->rq_all);
> =20
> -	svc_sock_update_bufs(serv);
> -
>  	svc_rqst_free(rqstp);
> =20
>  	clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 825ec5357691..191dbc648bd0 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -588,7 +588,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
>  	     * provides an upper bound on the number of threads
>  	     * which will access the socket.
>  	     */
> -	    svc_sock_setbufsize(svsk, serv->sv_nrthreads + 3);
> +	    svc_sock_setbufsize(svsk, serv->sv_nractual + 3);
> =20
>  	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
>  	err =3D kernel_recvmsg(svsk->sk_sock, &msg, NULL,

Other than maybe splitting that one change into a separate patch, this
looks good to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

