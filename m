Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE90475B877
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGTUCx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 16:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGTUCw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 16:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D02733
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 13:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549C061C37
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 20:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF1EC433C8;
        Thu, 20 Jul 2023 20:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689883368;
        bh=SvieGcw8gPEiqy2JZD9xuvadM4O2boLVCOdgo14NCEM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TtnuEWJAi070k2GAarr0C39NSp2YoGn6MYYpIqedrJHoboZMEujyifm19pKy7bh8U
         ZdnV9SpHb7RGr/Kz3SuIvDU5vVvJvzToX6VgfXnmZb/Y2vRm9Y8VvSkfdWAKU06b6N
         gazB3MLpoMW9j7PzaXbGQonSypd08Eusti9hX3SZfQRlSgbqt3xM18z2AjEjyoiDCB
         3riu9/DVE2XCxV5v9tp1DHs1B7fMyq7frVpLcr28XbsrR982fQTd67ujnSDBfZ55eB
         x24+7DP9Aj8fOlXvdM57U+nq/9Ce7cr+3Cy4vOEv1VMBZR1C60HAiBhh/tIcEqk3Wk
         QcM11s30eTaHg==
Message-ID: <32d10c61803c83d4e4812c84a3080728acb91061.camel@kernel.org>
Subject: Re: [PATCH 04/14] SUNRPC: change svc_recv() to return void.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 20 Jul 2023 16:02:47 -0400
In-Reply-To: <168966228862.11075.10086063375287695723.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
         <168966228862.11075.10086063375287695723.stgit@noble.brown>
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
> svc_recv() currently returns a 0 on success or one of two errors:
>  - -EAGAIN means no message was successfully received
>  - -EINTR means the thread has been told to stop
>=20
> Previously nfsd would stop as the result of a signal as well as
> following kthread_stop().  In that case the difference was useful: EINTR
> means stop unconditionally.  EAGAIN means stop if kthread_should_stop(),
> continue otherwise.
>=20
> Now threads only exit when kthread_should_stop() so we don't need the
> distinction.
>=20
> So have all threads test kthread_should_stop() (most do), and return
> simple success/failure from svc_recv().

The patch makes sense, but the above sentence doesn't. You're making
svc_recv void return, but you're returning simple success/failure?

> Also change some helpers that svc_recv() uses to not bother with an
> error code, returning a bool in once case, and NULL for failure in
> another.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/lockd/svc.c                 |    9 +++------
>  fs/nfs/callback.c              |    5 +----
>  fs/nfsd/nfssvc.c               |    8 ++------
>  include/linux/sunrpc/svcsock.h |    2 +-
>  net/sunrpc/svc_xprt.c          |   27 +++++++++++----------------
>  5 files changed, 18 insertions(+), 33 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 91ef139a7757..a43b63e46127 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -116,7 +116,6 @@ static void set_grace_period(struct net *net)
>  static int
>  lockd(void *vrqstp)
>  {
> -	int		err =3D 0;
>  	struct svc_rqst *rqstp =3D vrqstp;
>  	struct net *net =3D &init_net;
>  	struct lockd_net *ln =3D net_generic(net, lockd_net_id);
> @@ -139,12 +138,10 @@ lockd(void *vrqstp)
>  		timeout =3D nlmsvc_retry_blocked();
> =20
>  		/*
> -		 * Find a socket with data available and call its
> -		 * recvfrom routine.
> +		 * Find any work to do, such as a socket with data available,
> +		 * and do the work.
>  		 */
> -		err =3D svc_recv(rqstp, timeout);
> -		if (err =3D=3D -EAGAIN || err =3D=3D -EINTR)
> -			continue;
> +		svc_recv(rqstp, timeout);
>  	}
>  	if (nlmsvc_ops)
>  		nlmsvc_invalidate_all();
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 2d94384bd6a9..914d2402ca98 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -74,7 +74,6 @@ static int nfs4_callback_up_net(struct svc_serv *serv, =
struct net *net)
>  static int
>  nfs4_callback_svc(void *vrqstp)
>  {
> -	int err;
>  	struct svc_rqst *rqstp =3D vrqstp;
> =20
>  	set_freezable();
> @@ -83,9 +82,7 @@ nfs4_callback_svc(void *vrqstp)
>  		/*
>  		 * Listen for a request on the socket
>  		 */
> -		err =3D svc_recv(rqstp, MAX_SCHEDULE_TIMEOUT);
> -		if (err =3D=3D -EAGAIN || err =3D=3D -EINTR)
> -			continue;
> +		svc_recv(rqstp, MAX_SCHEDULE_TIMEOUT);
>  	}
> =20
>  	svc_exit_thread(rqstp);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 3e08cc746870..5bf48c33986e 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -953,7 +953,6 @@ nfsd(void *vrqstp)
>  	struct svc_xprt *perm_sock =3D list_entry(rqstp->rq_server->sv_permsock=
s.next, typeof(struct svc_xprt), xpt_list);
>  	struct net *net =3D perm_sock->xpt_net;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -	int err;
> =20
>  	/* At this point, the thread shares current->fs
>  	 * with the init process. We need to create files with the
> @@ -972,7 +971,7 @@ nfsd(void *vrqstp)
>  	/*
>  	 * The main request loop
>  	 */
> -	for (;;) {
> +	while (!kthread_should_stop()) {
>  		/* Update sv_maxconn if it has changed */
>  		rqstp->rq_server->sv_maxconn =3D nn->max_connections;
> =20
> @@ -980,10 +979,7 @@ nfsd(void *vrqstp)
>  		 * Find a socket with data available and call its
>  		 * recvfrom routine.
>  		 */
> -		while ((err =3D svc_recv(rqstp, 60*60*HZ)) =3D=3D -EAGAIN)
> -			;
> -		if (err =3D=3D -EINTR)
> -			break;
> +		svc_recv(rqstp, 60*60*HZ);
>  		validate_process_creds();
>  	}
> =20
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsoc=
k.h
> index 55446136499f..fb5c98069356 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -64,7 +64,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock *s=
vsk)
>   * Function prototypes.
>   */
>  void		svc_close_net(struct svc_serv *, struct net *);
> -int		svc_recv(struct svc_rqst *, long);
> +void		svc_recv(struct svc_rqst *, long);
>  void		svc_send(struct svc_rqst *rqstp);
>  void		svc_drop(struct svc_rqst *);
>  void		svc_sock_update_bufs(struct svc_serv *serv);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index c808f6d60c99..67825eef8646 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -664,7 +664,7 @@ static void svc_check_conn_limits(struct svc_serv *se=
rv)
>  	}
>  }
> =20
> -static int svc_alloc_arg(struct svc_rqst *rqstp)
> +static bool svc_alloc_arg(struct svc_rqst *rqstp)
>  {
>  	struct svc_serv *serv =3D rqstp->rq_server;
>  	struct xdr_buf *arg =3D &rqstp->rq_arg;
> @@ -689,7 +689,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  		set_current_state(TASK_IDLE);
>  		if (kthread_should_stop()) {
>  			set_current_state(TASK_RUNNING);
> -			return -EINTR;
> +			return false;
>  		}
>  		trace_svc_alloc_arg_err(pages, ret);
>  		memalloc_retry_wait(GFP_KERNEL);
> @@ -708,7 +708,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  	arg->tail[0].iov_len =3D 0;
> =20
>  	rqstp->rq_xid =3D xdr_zero;
> -	return 0;
> +	return true;
>  }
> =20
>  static bool
> @@ -773,9 +773,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp, long timeout)
>  	if (!time_left)
>  		percpu_counter_inc(&pool->sp_threads_timedout);
>  	if (kthread_should_stop())
> -		return ERR_PTR(-EINTR);
> +		return NULL;
>  	percpu_counter_inc(&pool->sp_threads_no_work);
> -	return ERR_PTR(-EAGAIN);
> +	return NULL;
>  out_found:
>  	/* Normally we will wait up to 5 seconds for any required
>  	 * cache information to be provided.
> @@ -856,32 +856,27 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, =
struct svc_xprt *xprt)
>   * organised not to touch any cachelines in the shared svc_serv
>   * structure, only cachelines in the local svc_pool.
>   */
> -int svc_recv(struct svc_rqst *rqstp, long timeout)
> +void svc_recv(struct svc_rqst *rqstp, long timeout)
>  {
>  	struct svc_xprt		*xprt =3D NULL;
>  	struct svc_serv		*serv =3D rqstp->rq_server;
> -	int			len, err;
> +	int			len;
> =20
> -	err =3D svc_alloc_arg(rqstp);
> -	if (err)
> +	if (!svc_alloc_arg(rqstp))
>  		goto out;
> =20
>  	try_to_freeze();
>  	cond_resched();
> -	err =3D -EINTR;
>  	if (kthread_should_stop())
>  		goto out;
> =20
>  	xprt =3D svc_get_next_xprt(rqstp, timeout);
> -	if (IS_ERR(xprt)) {
> -		err =3D PTR_ERR(xprt);
> +	if (!xprt)
>  		goto out;
> -	}
> =20
>  	len =3D svc_handle_xprt(rqstp, xprt);
> =20
>  	/* No data, incomplete (TCP) read, or accept() */
> -	err =3D -EAGAIN;
>  	if (len <=3D 0)
>  		goto out_release;
> =20
> @@ -896,12 +891,12 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
>  	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
>  	rqstp->rq_stime =3D ktime_get();
>  	svc_process(rqstp);
> -	return 0;
> +	return;
>  out_release:
>  	rqstp->rq_res.len =3D 0;
>  	svc_xprt_release(rqstp);
>  out:
> -	return err;
> +	return;
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
> =20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
