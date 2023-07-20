Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3788A75B87A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 22:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGTUFY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGTUFX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 16:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0F1BE2
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 13:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D80361BBD
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330E1C433C8;
        Thu, 20 Jul 2023 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689883521;
        bh=grwDD5o8o7xVZtR4fFQs4SZuqZyA04p8J9uDVQU/6X8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F60Ta+RkSv7z2z3+NIGMAOlMFHZCjA7pmi6WxwFUEDYuE1GKQzB0qXmOA/LwoqXR4
         TDdcgZhFC+X7N5U5VzLCcLegstOC/ll3tbto3JsP4S3024hvbbBRSLNWfsyxot0D+M
         ap8zL70bT0Z4GRvXVUvQSGfE7HsPO5b4RK9bD9G7U4hlvmjW4IZ+lzWxFwaNKb0ZVQ
         tNciAydgXSQ+e96Fm4rurKbVjOMX+zhNzy7GSwBBiOrRzexA4cilvqxSOB7hC2tmp8
         UKaKo3ltFIAjig8ayNPR4tw4Ciy5koGdowYg8mMVtfmWhEFmGcab1KlF66SuertEGU
         mXrUjL5gnS3fw==
Message-ID: <f51e5a2ff9afe8787cd17dc1ba7d74e4fa7ac3c6.camel@kernel.org>
Subject: Re: [PATCH 02/14] nfsd: don't allow nfsd threads to be signalled.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 20 Jul 2023 16:05:20 -0400
In-Reply-To: <168966228860.11075.10973222274248478768.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
         <168966228860.11075.10973222274248478768.stgit@noble.brown>
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
> The original implementation of nfsd used signals to stop threads during
> shutdown.
> In Linux 2.3.46pre5 nfsd gained the ability to shutdown threads
> internally it if was asked to run "0" threads.  After this user-space
> transitioned to using "rpc.nfsd 0" to stop nfsd and sending signals to
> threads was no longer an important part of the API.
>=20
> In Commit 3ebdbe5203a8 ("SUNRPC: discard svo_setup and rename
> svc_set_num_threads_sync()") (v5.17-rc1~75^2~41) we finally removed the
> use of signals for stopping threads, using kthread_stop() instead.
>=20
> This patch makes the "obvious" next step and removes the ability to
> signal nfsd threads - or any svc threads.  nfsd stops allowing signals
> and we don't check for their delivery any more.
>=20
> This will allow for some simplification in later patches.
>=20
> A change worth noting is in nfsd4_ssc_setup_dul().  There was previously
> a signal_pending() check which would only succeed when the thread was
> being shut down.  It should really have tested kthread_should_stop() as
> well.  Now it just does the later, not the former.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/callback.c     |    9 +--------
>  fs/nfsd/nfs4proc.c    |    4 ++--
>  fs/nfsd/nfssvc.c      |   12 ------------
>  net/sunrpc/svc_xprt.c |   16 ++++++----------
>  4 files changed, 9 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 456af7d230cf..46a0a2d6962e 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -80,9 +80,6 @@ nfs4_callback_svc(void *vrqstp)
>  	set_freezable();
> =20
>  	while (!kthread_freezable_should_stop(NULL)) {
> -
> -		if (signal_pending(current))
> -			flush_signals(current);
>  		/*
>  		 * Listen for a request on the socket
>  		 */
> @@ -112,11 +109,7 @@ nfs41_callback_svc(void *vrqstp)
>  	set_freezable();
> =20
>  	while (!kthread_freezable_should_stop(NULL)) {
> -
> -		if (signal_pending(current))
> -			flush_signals(current);
> -
> -		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_INTERRUPTIBLE);
> +		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_IDLE);
>  		spin_lock_bh(&serv->sv_cb_lock);
>  		if (!list_empty(&serv->sv_cb_list)) {
>  			req =3D list_first_entry(&serv->sv_cb_list,
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d8e7a533f9d2..157488290676 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1325,11 +1325,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net=
 *nn, char *ipaddr,
>  		if (ni->nsui_busy) {
>  			/*  wait - and try again */
>  			prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
> -				TASK_INTERRUPTIBLE);
> +				TASK_IDLE);
>  			spin_unlock(&nn->nfsd_ssc_lock);
> =20
>  			/* allow 20secs for mount/unmount for now - revisit */
> -			if (signal_pending(current) ||
> +			if (kthread_should_stop() ||
>  					(schedule_timeout(20*HZ) =3D=3D 0)) {
>  				finish_wait(&nn->nfsd_ssc_waitq, &wait);
>  				kfree(work);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 97830e28c140..439fca195925 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -965,15 +965,6 @@ nfsd(void *vrqstp)
> =20
>  	current->fs->umask =3D 0;
> =20
> -	/*
> -	 * thread is spawned with all signals set to SIG_IGN, re-enable
> -	 * the ones that will bring down the thread
> -	 */
> -	allow_signal(SIGKILL);
> -	allow_signal(SIGHUP);
> -	allow_signal(SIGINT);
> -	allow_signal(SIGQUIT);
> -
>  	atomic_inc(&nfsdstats.th_cnt);
> =20
>  	set_freezable();
> @@ -998,9 +989,6 @@ nfsd(void *vrqstp)
>  		validate_process_creds();
>  	}
> =20
> -	/* Clear signals before calling svc_exit_thread() */
> -	flush_signals(current);
> -
>  	atomic_dec(&nfsdstats.th_cnt);
> =20
>  out:
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 71b19d0ed642..93395606a0ba 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -686,8 +686,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  			/* Made progress, don't sleep yet */
>  			continue;
> =20
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		if (signalled() || kthread_should_stop()) {
> +		set_current_state(TASK_IDLE);
> +		if (kthread_should_stop()) {
>  			set_current_state(TASK_RUNNING);
>  			return -EINTR;
>  		}
> @@ -725,7 +725,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  		return false;
> =20
>  	/* are we shutting down? */
> -	if (signalled() || kthread_should_stop())
> +	if (kthread_should_stop())
>  		return false;
> =20
>  	/* are we freezing? */
> @@ -749,11 +749,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc=
_rqst *rqstp, long timeout)
>  		goto out_found;
>  	}
> =20
> -	/*
> -	 * We have to be able to interrupt this wait
> -	 * to bring down the daemons ...
> -	 */
> -	set_current_state(TASK_INTERRUPTIBLE);
> +	set_current_state(TASK_IDLE);
>  	smp_mb__before_atomic();
>  	clear_bit(SP_CONGESTED, &pool->sp_flags);
>  	clear_bit(RQ_BUSY, &rqstp->rq_flags);
> @@ -776,7 +772,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp, long timeout)
> =20
>  	if (!time_left)
>  		percpu_counter_inc(&pool->sp_threads_timedout);
> -	if (signalled() || kthread_should_stop())
> +	if (kthread_should_stop())
>  		return ERR_PTR(-EINTR);
>  	percpu_counter_inc(&pool->sp_threads_no_work);
>  	return ERR_PTR(-EAGAIN);
> @@ -873,7 +869,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
>  	try_to_freeze();
>  	cond_resched();
>  	err =3D -EINTR;
> -	if (signalled() || kthread_should_stop())
> +	if (kthread_should_stop())
>  		goto out;
> =20
>  	xprt =3D svc_get_next_xprt(rqstp, timeout);
>=20
>=20

LGTM

Reviewed-by: Jeff Layton <jlayton@kernel.org>
