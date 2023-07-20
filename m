Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64A75B8AC
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 22:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGTUY4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 16:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGTUYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 16:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB31719
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 13:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983C861C5E
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 20:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B66C433C7;
        Thu, 20 Jul 2023 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689884164;
        bh=G5BS8j3FD2mAuRVzazWNHDyuykO0+MDzwKGngIvCjP8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o6QEVkFBjgaoOOB0gpklZiYgYgZyBEQR3WjmJYnfMK92rCZgwWux7gi5FuJOmrp77
         ocNDgRfdMqD8Qeg3VCubX1e7WaKSgNC+BQJsQ36hx7E9zvO2RCBV5+hwYlyj9jVXAO
         67wC1Vo9SCd4SIiL05gK0G3jH0NykH91IXG0Qxy8sqFSTeQPt5gbLkfsyJcCENVU8E
         8bMOW4qfQaT5lX4vkq5bbSRBZ3BsitYcXepxxergNHLouWcnJAlIK2kdIEBppsB8Vs
         sJ/BPuOJKCBi5yyLwaabqkKS9SsPMCdgba3Yllj59kd6D3OoJjk7s4FkD2tGXZ3Ouc
         2GNLiHOwc82TQ==
Message-ID: <78fa83d60b756a1cb1dde0ad813adb605b71e558.camel@kernel.org>
Subject: Re: [PATCH 08/14] SUNRPC: integrate back-channel processing with
 svc_recv() and svc_process()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 20 Jul 2023 16:16:02 -0400
In-Reply-To: <168966228864.11075.5425376786095915126.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
         <168966228864.11075.5425376786095915126.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-18 at 16:38 +1000, NeilBrown wrote:
> Using svc_recv() and svc_process() for (NFSv4.1) back-channel handling
> means we have just one mechanism for waking threads.
>=20
> Also change kthread_freezable_should_stop() in nfs4_callback_svc() to
> kthread_should_stop() as used elsewhere.
> kthread_freezable_should_stop() effectively adds a try_to_freeze() call,
> and svc_recv() already contains that at an appropriate place.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/callback.c                 |   46 ++-----------------------------=
----
>  include/linux/sunrpc/svc.h        |    6 +++--
>  net/sunrpc/backchannel_rqst.c     |    8 ++----
>  net/sunrpc/svc.c                  |    2 +-
>  net/sunrpc/svc_xprt.c             |   48 +++++++++++++++++++++++++++++++=
+++++-
>  net/sunrpc/xprtrdma/backchannel.c |    2 +-
>  6 files changed, 58 insertions(+), 54 deletions(-)
>=20
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index c47834970224..660cec36c45c 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -78,7 +78,7 @@ nfs4_callback_svc(void *vrqstp)
> =20
>  	set_freezable();
> =20
> -	while (!kthread_freezable_should_stop(NULL)) {
> +	while (!kthread_should_stop()) {
>  		/*
>  		 * Listen for a request on the socket
>  		 */
> @@ -90,45 +90,6 @@ nfs4_callback_svc(void *vrqstp)
>  }
> =20
>  #if defined(CONFIG_NFS_V4_1)
> -/*
> - * The callback service for NFSv4.1 callbacks
> - */
> -static int
> -nfs41_callback_svc(void *vrqstp)
> -{
> -	struct svc_rqst *rqstp =3D vrqstp;
> -	struct svc_serv *serv =3D rqstp->rq_server;
> -	struct rpc_rqst *req;
> -	int error;
> -	DEFINE_WAIT(wq);
> -
> -	set_freezable();
> -
> -	while (!kthread_freezable_should_stop(NULL)) {
> -		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_IDLE);
> -		spin_lock_bh(&serv->sv_cb_lock);
> -		if (!list_empty(&serv->sv_cb_list)) {
> -			req =3D list_first_entry(&serv->sv_cb_list,
> -					struct rpc_rqst, rq_bc_list);
> -			list_del(&req->rq_bc_list);
> -			spin_unlock_bh(&serv->sv_cb_lock);
> -			finish_wait(&serv->sv_cb_waitq, &wq);
> -			dprintk("Invoking bc_svc_process()\n");
> -			error =3D bc_svc_process(serv, req, rqstp);
> -			dprintk("bc_svc_process() returned w/ error code=3D %d\n",
> -				error);
> -		} else {
> -			spin_unlock_bh(&serv->sv_cb_lock);
> -			if (!kthread_should_stop())
> -				schedule();
> -			finish_wait(&serv->sv_cb_waitq, &wq);
> -		}
> -	}
> -
> -	svc_exit_thread(rqstp);
> -	return 0;
> -}
> -
>  static inline void nfs_callback_bc_serv(u32 minorversion, struct rpc_xpr=
t *xprt,
>  		struct svc_serv *serv)
>  {
> @@ -241,10 +202,7 @@ static struct svc_serv *nfs_callback_create_svc(int =
minorversion)
>  			cb_info->users);
> =20
>  	threadfn =3D nfs4_callback_svc;
> -#if defined(CONFIG_NFS_V4_1)
> -	if (minorversion)
> -		threadfn =3D nfs41_callback_svc;
> -#else
> +#if !defined(CONFIG_NFS_V4_1)
>  	if (minorversion)
>  		return ERR_PTR(-ENOTSUPP);
>  #endif
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 83f31a09c853..15d468d852b5 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -92,8 +92,6 @@ struct svc_serv {
>  						 * that arrive over the same
>  						 * connection */
>  	spinlock_t		sv_cb_lock;	/* protects the svc_cb_list */
> -	wait_queue_head_t	sv_cb_waitq;	/* sleep here if there are no
> -						 * entries in the svc_cb_list */
>  	bool			sv_bc_enabled;	/* service uses backchannel */
>  #endif /* CONFIG_SUNRPC_BACKCHANNEL */
>  };
> @@ -202,6 +200,10 @@ struct svc_rqst {
>  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
>  	struct svc_xprt *	rq_xprt;	/* transport ptr */
> =20
> +#if defined(CONFIG_SUNRPC_BACKCHANNEL)
> +	struct rpc_rqst		*rq_cb;		/* callback to be handled */
> +#endif
> +
>  	struct sockaddr_storage	rq_addr;	/* peer address */
>  	size_t			rq_addrlen;
>  	struct sockaddr_storage	rq_daddr;	/* dest addr of request
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.=
c
> index 65a6c6429a53..60b8d310bb27 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -349,10 +349,8 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_x=
prt *xprt, __be32 xid)
>  }
> =20
>  /*
> - * Add callback request to callback list.  The callback
> - * service sleeps on the sv_cb_waitq waiting for new
> - * requests.  Wake it up after adding enqueing the
> - * request.
> + * Add callback request to callback list.  Wake a thread
> + * on the first pool (usually the only pool) to handle it.
>   */
>  void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
>  {
> @@ -371,6 +369,6 @@ void xprt_complete_bc_request(struct rpc_rqst *req, u=
int32_t copied)
>  	xprt_get(xprt);
>  	spin_lock(&bc_serv->sv_cb_lock);
>  	list_add(&req->rq_bc_list, &bc_serv->sv_cb_list);
> -	wake_up(&bc_serv->sv_cb_waitq);
>  	spin_unlock(&bc_serv->sv_cb_lock);
> +	svc_pool_wake_idle_thread(bc_serv, &bc_serv->sv_pools[0]);
>  }
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 170eabc03988..56b4a88776d5 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -440,7 +440,6 @@ __svc_init_bc(struct svc_serv *serv)
>  {
>  	INIT_LIST_HEAD(&serv->sv_cb_list);
>  	spin_lock_init(&serv->sv_cb_lock);
> -	init_waitqueue_head(&serv->sv_cb_waitq);
>  }
>  #else
>  static void
> @@ -724,6 +723,7 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc=
_serv *serv,
>  	percpu_counter_inc(&pool->sp_threads_starved);
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
> =20
>  static struct svc_pool *
>  svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int=
 *state)
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index c7095ff7d5fd..4fdf1aaa514b 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -17,6 +17,7 @@
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/sunrpc/svcsock.h>
>  #include <linux/sunrpc/xprt.h>
> +#include <linux/sunrpc/bc_xprt.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <trace/events/sunrpc.h>
> @@ -732,6 +733,13 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	if (freezing(current))
>  		return false;
> =20
> +#if defined(CONFIG_SUNRPC_BACKCHANNEL)
> +	if (svc_is_backchannel(rqstp)) {
> +		if (!list_empty(&rqstp->rq_server->sv_cb_list))
> +			return false;
> +	}
> +#endif
> +
>  	return true;
>  }
> =20
> @@ -754,12 +762,31 @@ static void svc_wait_for_work(struct svc_rqst *rqst=
p)
> =20
>  	set_bit(RQ_BUSY, &rqstp->rq_flags);
>  	smp_mb__after_atomic();
> +
>  	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
>  	if (rqstp->rq_xprt) {
>  		trace_svc_pool_awoken(rqstp);
>  		goto out_found;
>  	}
> =20
> +#if defined(CONFIG_SUNRPC_BACKCHANNEL)
> +	if (svc_is_backchannel(rqstp)) {
> +		struct svc_serv *serv =3D rqstp->rq_server;
> +		struct rpc_rqst *req;
> +
> +		spin_lock_bh(&serv->sv_cb_lock);
> +		req =3D list_first_entry_or_null(&serv->sv_cb_list,
> +					       struct rpc_rqst, rq_bc_list);
> +		if (req) {
> +			list_del(&req->rq_bc_list);
> +			rqstp->rq_cb =3D req;
> +		}
> +		spin_unlock_bh(&serv->sv_cb_lock);
> +		if (rqstp->rq_cb)
> +			goto out_found;
> +	}
> +#endif
> +
>  	if (!kthread_should_stop())
>  		percpu_counter_inc(&pool->sp_threads_no_work);
>  	return;
> @@ -853,7 +880,7 @@ void svc_recv(struct svc_rqst *rqstp)
>  	svc_wait_for_work(rqstp);
> =20
>  	if (rqstp->rq_xprt) {
> -		struct svc_serv	*serv =3D rqstp->rq_server;
> +		struct svc_serv *serv =3D rqstp->rq_server;
>  		struct svc_xprt *xprt =3D rqstp->rq_xprt;
>  		int len;
> =20
> @@ -878,6 +905,25 @@ void svc_recv(struct svc_rqst *rqstp)
>  			svc_process(rqstp);
>  		}
>  	}
> +#if defined(CONFIG_SUNRPC_BACKCHANNEL)
> +	if (svc_is_backchannel(rqstp)) {
> +		struct rpc_rqst *cb;
> +		int error;
> +
> +		if (!rqstp->rq_cb)
> +			return;
> +
> +		cb =3D rqstp->rq_cb;
> +		rqstp->rq_cb =3D NULL;
> +
> +		dprintk("Invoking bc_svc_process()\n");
> +		error =3D bc_svc_process(rqstp->rq_server, cb, rqstp);
> +		dprintk("bc_svc_process() returned w/ error code=3D %d\n",
> +			error);
> +		return;
> +	}
> +#endif
> +
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
> =20
> diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/back=
channel.c
> index e4d84a13c566..f1e1d4909434 100644
> --- a/net/sunrpc/xprtrdma/backchannel.c
> +++ b/net/sunrpc/xprtrdma/backchannel.c
> @@ -267,7 +267,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_x=
prt,
>  	list_add(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
>  	spin_unlock(&bc_serv->sv_cb_lock);
> =20
> -	wake_up(&bc_serv->sv_cb_waitq);
> +	svc_pool_wake_idle_thread(bc_serv, &bc_serv->sv_pools[0]);
> =20
>  	r_xprt->rx_stats.bcall_count++;
>  	return;
>=20
>=20

Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
