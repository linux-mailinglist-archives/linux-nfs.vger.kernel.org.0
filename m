Return-Path: <linux-nfs+bounces-2597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE5F895010
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD3DB23C20
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1F95B694;
	Tue,  2 Apr 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1OqN2J0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648E5A4D8
	for <linux-nfs@vger.kernel.org>; Tue,  2 Apr 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053781; cv=none; b=to8tyqtTQAPMO4ZtBHV1qe+1M1H9zN7wkbi2mJmPFcxkMUDu4e2akjxQwiRSJyVlA/IoAdyZ75VMakLVqs+wtlI9G43Q0Gce5QJrfErHCrK0pzrh12N6+Qjg69jWyUNQOvajp5+AfMXuqkhV7jStcq7Ah2ZLu/4vWky3TWnS4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053781; c=relaxed/simple;
	bh=7WthMvi0TYGprHb/um0Eqw8dvL0NBVUoo8S/cmTXPN4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4UQ2S/kq8l3ligr84yRcqAPXHCSoH8NKrfBo/+oHlTSc3+5yr1isbltFEne6E5UQ+sD/WxugKJGxrM1lXfunZviJZtXDwjogHqCpGgq3KPdGm8rIThwA/lm24DFEdl6foy2uZjRgGnU+j7kXErrxL7nGDXGi6duKuPnkN2hRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1OqN2J0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59DBC43390;
	Tue,  2 Apr 2024 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712053780;
	bh=7WthMvi0TYGprHb/um0Eqw8dvL0NBVUoo8S/cmTXPN4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=A1OqN2J0pkrZETN6XSTHmkgw1YAytFlSjQkYaXzTYZW3imQB+KSCuooGNy2wJqE05
	 xZNnIP/Sp0qODvRlE8E0twR5nzMvxlkvGXOsz0YjTQj3hmxqKwsdCrHQMEgF0mz9gp
	 Qphm8w7/AnHBwmm06YvBZN1Z5zt2hX//AHbE42DzJ4jd88VBH0yTt+3ZQVoVLZvroc
	 6nDZxpK0cyTAk/xgXUjSrRqhyP5QNvaCMeSqQriiiKILqsHq42CMQcBHGgjGhHcy6S
	 JVP9lrVvDJWyHqENlFjSqL4G1DNRQZLLPyygRfcVdOpo6DL9pxq1djNctOiYg43UoI
	 cNTy2YN0wESKQ==
Message-ID: <c9337d1e9e955e7235280d95fb56db07a9dd0dbb.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Move callback_wq into struct nfs4_client
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date: Tue, 02 Apr 2024 06:29:39 -0400
In-Reply-To: <171200183231.5439.7855646322906072619.stgit@klimt.1015granger.net>
References: 
	<171200183231.5439.7855646322906072619.stgit@klimt.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-01 at 16:05 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Commit 883820366747 ("nfsd: update workqueue creation") made the
> callback_wq single-threaded, presumably to protect modifications of
> cl_cb_client. See documenting comment for nfsd4_process_cb_update().
>=20
> However, cl_cb_client is per-lease. There's no other reason that all
> callback operations need to be dispatched via a single thread. The
> single threading here means all client callbacks can be blocked by a
> problem with one client.
>=20
> Change the NFSv4 callback client so it serializes per-lease instead
> of serializing all NFSv4 callback operations on the server.
>=20
> Reported-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c |   37 +++++++++++++------------------------
>  fs/nfsd/nfs4state.c    |   14 +++++++-------
>  fs/nfsd/state.h        |    4 ++--
>  3 files changed, 22 insertions(+), 33 deletions(-)
>=20
> This has seen some light testing with a single client, and has been
> pushed to the nfsd-testing branch of:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 87c9547989f6..cf87ace7a1b0 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -978,19 +978,21 @@ static int max_cb_time(struct net *net)
>  	return max(((u32)nn->nfsd4_lease)/10, 1u) * HZ;
>  }
> =20
> -static struct workqueue_struct *callback_wq;
> -
>  static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
>  {
> -	trace_nfsd_cb_queue(cb->cb_clp, cb);
> -	return queue_delayed_work(callback_wq, &cb->cb_work, 0);
> +	struct nfs4_client *clp =3D cb->cb_clp;
> +
> +	trace_nfsd_cb_queue(clp, cb);
> +	return queue_delayed_work(clp->cl_callback_wq, &cb->cb_work, 0);
>  }
> =20
>  static void nfsd4_queue_cb_delayed(struct nfsd4_callback *cb,
>  				   unsigned long msecs)
>  {
> -	trace_nfsd_cb_queue(cb->cb_clp, cb);
> -	queue_delayed_work(callback_wq, &cb->cb_work,
> +	struct nfs4_client *clp =3D cb->cb_clp;
> +
> +	trace_nfsd_cb_queue(clp, cb);
> +	queue_delayed_work(clp->cl_callback_wq, &cb->cb_work,
>  			   msecs_to_jiffies(msecs));
>  }
> =20
> @@ -1161,7 +1163,7 @@ void nfsd4_probe_callback(struct nfs4_client *clp)
>  void nfsd4_probe_callback_sync(struct nfs4_client *clp)
>  {
>  	nfsd4_probe_callback(clp);
> -	flush_workqueue(callback_wq);
> +	flush_workqueue(clp->cl_callback_wq);
>  }
> =20
>  void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn =
*conn)
> @@ -1380,19 +1382,6 @@ static const struct rpc_call_ops nfsd4_cb_ops =3D =
{
>  	.rpc_release =3D nfsd4_cb_release,
>  };
> =20
> -int nfsd4_create_callback_queue(void)
> -{
> -	callback_wq =3D alloc_ordered_workqueue("nfsd4_callbacks", 0);
> -	if (!callback_wq)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -void nfsd4_destroy_callback_queue(void)
> -{
> -	destroy_workqueue(callback_wq);
> -}
> -
>  /* must be called under the state lock */
>  void nfsd4_shutdown_callback(struct nfs4_client *clp)
>  {
> @@ -1406,7 +1395,7 @@ void nfsd4_shutdown_callback(struct nfs4_client *cl=
p)
>  	 * client, destroy the rpc client, and stop:
>  	 */
>  	nfsd4_run_cb(&clp->cl_cb_null);
> -	flush_workqueue(callback_wq);
> +	flush_workqueue(clp->cl_callback_wq);
>  	nfsd41_cb_inflight_wait_complete(clp);
>  }
> =20
> @@ -1428,9 +1417,9 @@ static struct nfsd4_conn * __nfsd4_find_backchannel=
(struct nfs4_client *clp)
> =20
>  /*
>   * Note there isn't a lot of locking in this code; instead we depend on
> - * the fact that it is run from the callback_wq, which won't run two
> - * work items at once.  So, for example, callback_wq handles all access
> - * of cl_cb_client and all calls to rpc_create or rpc_shutdown_client.
> + * the fact that it is run from clp->cl_callback_wq, which won't run two
> + * work items at once.  So, for example, clp->cl_callback_wq handles all
> + * access of cl_cb_client and all calls to rpc_create or rpc_shutdown_cl=
ient.
>   */
>  static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
>  {
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2ece3092a4e3..19e15c093f0a 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2233,6 +2233,10 @@ static struct nfs4_client *alloc_client(struct xdr=
_netobj name,
>  						 GFP_KERNEL);
>  	if (!clp->cl_ownerstr_hashtbl)
>  		goto err_no_hashtbl;
> +	clp->cl_callback_wq =3D alloc_ordered_workqueue("nfsd4_callbacks", 0);
> +	if (!clp->cl_callback_wq)
> +		goto err_no_callback_wq;
> +
>  	for (i =3D 0; i < OWNER_HASH_SIZE; i++)
>  		INIT_LIST_HEAD(&clp->cl_ownerstr_hashtbl[i]);
>  	INIT_LIST_HEAD(&clp->cl_sessions);
> @@ -2255,6 +2259,8 @@ static struct nfs4_client *alloc_client(struct xdr_=
netobj name,
>  	spin_lock_init(&clp->cl_lock);
>  	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>  	return clp;
> +err_no_callback_wq:
> +	kfree(clp->cl_ownerstr_hashtbl);
>  err_no_hashtbl:
>  	kfree(clp->cl_name.data);
>  err_no_name:
> @@ -2268,6 +2274,7 @@ static void __free_client(struct kref *k)
>  	struct nfs4_client *clp =3D container_of(c, struct nfs4_client, cl_nfsd=
fs);
> =20
>  	free_svc_cred(&clp->cl_cred);
> +	destroy_workqueue(clp->cl_callback_wq);
>  	kfree(clp->cl_ownerstr_hashtbl);
>  	kfree(clp->cl_name.data);
>  	kfree(clp->cl_nii_domain.data);
> @@ -8644,12 +8651,6 @@ nfs4_state_start(void)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D nfsd4_create_callback_queue();
> -	if (ret) {
> -		rhltable_destroy(&nfs4_file_rhltable);
> -		return ret;
> -	}
> -
>  	set_max_delegations();
>  	return 0;
>  }
> @@ -8690,7 +8691,6 @@ nfs4_state_shutdown_net(struct net *net)
>  void
>  nfs4_state_shutdown(void)
>  {
> -	nfsd4_destroy_callback_queue();
>  	rhltable_destroy(&nfs4_file_rhltable);
>  }
> =20
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 0400441c87c1..f42d8d782c84 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -408,6 +408,8 @@ struct nfs4_client {
>  					 1 << NFSD4_CLIENT_CB_KILL)
>  #define NFSD4_CLIENT_CB_RECALL_ANY	(6)
>  	unsigned long		cl_flags;
> +
> +	struct workqueue_struct *cl_callback_wq;
>  	const struct cred	*cl_cb_cred;
>  	struct rpc_clnt		*cl_cb_client;
>  	u32			cl_cb_ident;
> @@ -735,8 +737,6 @@ extern void nfsd4_change_callback(struct nfs4_client =
*clp, struct nfs4_cb_conn *
>  extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client =
*clp,
>  		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
>  extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
> -extern int nfsd4_create_callback_queue(void);
> -extern void nfsd4_destroy_callback_queue(void);
>  extern void nfsd4_shutdown_callback(struct nfs4_client *);
>  extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
>  extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_net=
obj name,
>=20
>=20
>=20

Looks good.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

