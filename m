Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C475B995
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 23:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGTVcs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGTVcs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 17:32:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0925DE75
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 14:32:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A55BB220E3;
        Thu, 20 Jul 2023 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689888764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4x4Ml4uxPyWu+C1mSnyUCx5v/MLt/q4zmcvyXcWIzk=;
        b=UCRYNrGzn6IRTfJi2wjvg50bDZ5BjzWv/07XgtHflt8VM1ZwC5MTLTlvxVnicFCzLI+v5O
        AH7I9gUjgyto9quSDovOJTJTb/chE8UsbM3Ld0JXNXgUbIWTtk09Ux2mCtP/Lt4HcWEjW/
        RWBn+fTLIooiMCMuHlB3n8sQKT/s9X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689888764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4x4Ml4uxPyWu+C1mSnyUCx5v/MLt/q4zmcvyXcWIzk=;
        b=K2EAeZBsYeHdELm5VHWEtSwy6eIBujyCI8dYYhgXnyn2SqgDRHmgg+C8Rg3EjfkN2mX5Lc
        eIjBC/D020CxQvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C33E138EC;
        Thu, 20 Jul 2023 21:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DgvlL/qnuWRROwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 20 Jul 2023 21:32:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 09/14] SUNRPC: change how svc threads are asked to exit.
In-reply-to: <dc85b6837bc94e8dbcbaf41c90938616e52d8ae7.camel@kernel.org>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>,
 <168966228865.11075.10638610963240650169.stgit@noble.brown>,
 <dc85b6837bc94e8dbcbaf41c90938616e52d8ae7.camel@kernel.org>
Date:   Fri, 21 Jul 2023 07:32:38 +1000
Message-id: <168988875822.11078.2109587591015302139@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Jul 2023, Jeff Layton wrote:
> On Tue, 2023-07-18 at 16:38 +1000, NeilBrown wrote:
> > svc threads are currently stopped using kthread_stop().  This requires
> > identifying a specific thread.  However we don't care which thread
> > stops, just as long as one does.
> >=20
> > So instead, set a flag in the svc_pool to say that a thread needs to
> > die, and have each thread check this flag instead of calling
> > kthread_should_stop().  The first to find it clear the flag and moves
> > towards shutting down.
> >=20
> > This removes an explicit dependency on sp_all_threads which will make a
> > future patch simpler.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/lockd/svc.c                |    4 ++--
> >  fs/lockd/svclock.c            |    4 ++--
> >  fs/nfs/callback.c             |    2 +-
> >  fs/nfsd/nfs4proc.c            |    8 +++++---
> >  fs/nfsd/nfssvc.c              |    2 +-
> >  include/linux/lockd/lockd.h   |    2 +-
> >  include/linux/sunrpc/svc.h    |   22 +++++++++++++++++++++-
> >  include/trace/events/sunrpc.h |    5 +++--
> >  net/sunrpc/svc.c              |   39 +++++++++++++++++------------------=
----
> >  net/sunrpc/svc_xprt.c         |    8 +++-----
> >  10 files changed, 56 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index 4f55cd42c2e6..30543edd2309 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -134,12 +134,12 @@ lockd(void *vrqstp)
> >  	 * The main request loop. We don't terminate until the last
> >  	 * NFS mount or NFS daemon has gone away.
> >  	 */
> > -	while (!kthread_should_stop()) {
> > +	while (!svc_thread_should_stop(rqstp)) {
> > =20
> >  		/* update sv_maxconn if it has changed */
> >  		rqstp->rq_server->sv_maxconn =3D nlm_max_connections;
> > =20
> > -		nlmsvc_retry_blocked();
> > +		nlmsvc_retry_blocked(rqstp);
> > =20
> >  		/*
> >  		 * Find any work to do, such as a socket with data available,
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index 3d7bd5c04b36..fd399c9bea5c 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -1009,13 +1009,13 @@ retry_deferred_block(struct nlm_block *block)
> >   * be retransmitted.
> >   */
> >  void
> > -nlmsvc_retry_blocked(void)
> > +nlmsvc_retry_blocked(struct svc_rqst *rqstp)
> >  {
> >  	unsigned long	timeout =3D MAX_SCHEDULE_TIMEOUT;
> >  	struct nlm_block *block;
> > =20
> >  	spin_lock(&nlm_blocked_lock);
> > -	while (!list_empty(&nlm_blocked) && !kthread_should_stop()) {
> > +	while (!list_empty(&nlm_blocked) && !svc_thread_should_stop(rqstp)) {
> >  		block =3D list_entry(nlm_blocked.next, struct nlm_block, b_list);
> > =20
> >  		if (block->b_when =3D=3D NLM_NEVER)
> > diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> > index 660cec36c45c..c58ec2e66aaf 100644
> > --- a/fs/nfs/callback.c
> > +++ b/fs/nfs/callback.c
> > @@ -78,7 +78,7 @@ nfs4_callback_svc(void *vrqstp)
> > =20
> >  	set_freezable();
> > =20
> > -	while (!kthread_should_stop()) {
> > +	while (!svc_thread_should_stop(rqstp)) {
> >  		/*
> >  		 * Listen for a request on the socket
> >  		 */
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 157488290676..66024ed06181 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1306,7 +1306,8 @@ extern void nfs_sb_deactive(struct super_block *sb);
> >   * setup a work entry in the ssc delayed unmount list.
> >   */
> >  static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> > -				  struct nfsd4_ssc_umount_item **nsui)
> > +				  struct nfsd4_ssc_umount_item **nsui,
> > +				  struct svc_rqst *rqstp)
> >  {
> >  	struct nfsd4_ssc_umount_item *ni =3D NULL;
> >  	struct nfsd4_ssc_umount_item *work =3D NULL;
> > @@ -1329,7 +1330,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *=
nn, char *ipaddr,
> >  			spin_unlock(&nn->nfsd_ssc_lock);
> > =20
> >  			/* allow 20secs for mount/unmount for now - revisit */
> > -			if (kthread_should_stop() ||
> > +			if (svc_thread_should_stop(rqstp) ||
> >  					(schedule_timeout(20*HZ) =3D=3D 0)) {
> >  				finish_wait(&nn->nfsd_ssc_waitq, &wait);
> >  				kfree(work);
> > @@ -1445,7 +1446,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, stru=
ct svc_rqst *rqstp,
> >  		goto out_free_rawdata;
> >  	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
> > =20
> > -	status =3D nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
> > +	status =3D nfsd4_ssc_setup_dul(nn, ipaddr, nsui, rqstp);
> >  	if (status)
> >  		goto out_free_devname;
> >  	if ((*nsui)->nsui_vfsmount)
> > @@ -1620,6 +1621,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_c=
opy *copy,
> >  	if (bytes_total =3D=3D 0)
> >  		bytes_total =3D ULLONG_MAX;
> >  	do {
> > +		/* Only async copies can be stopped here */
> >  		if (kthread_should_stop())
> >  			break;
> >  		bytes_copied =3D nfsd_copy_file_range(src, src_pos, dst, dst_pos,
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index b536b254c59e..9b282c89ea87 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -971,7 +971,7 @@ nfsd(void *vrqstp)
> >  	/*
> >  	 * The main request loop
> >  	 */
> > -	while (!kthread_should_stop()) {
> > +	while (!svc_thread_should_stop(rqstp)) {
> >  		/* Update sv_maxconn if it has changed */
> >  		rqstp->rq_server->sv_maxconn =3D nn->max_connections;
> > =20
> > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> > index 0f016d69c996..9f565416d186 100644
> > --- a/include/linux/lockd/lockd.h
> > +++ b/include/linux/lockd/lockd.h
> > @@ -282,7 +282,7 @@ __be32		  nlmsvc_testlock(struct svc_rqst *, struct n=
lm_file *,
> >  			struct nlm_host *, struct nlm_lock *,
> >  			struct nlm_lock *, struct nlm_cookie *);
> >  __be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, stru=
ct nlm_lock *);
> > -void		  nlmsvc_retry_blocked(void);
> > +void		  nlmsvc_retry_blocked(struct svc_rqst *rqstp);
> >  void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
> >  					nlm_host_match_fn_t match);
> >  void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 15d468d852b5..ea3ce1315416 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -51,6 +51,8 @@ struct svc_pool {
> >  enum {
> >  	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
> >  	SP_CONGESTED,		/* all threads are busy, none idle */
> > +	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
> > +	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
> >  };
> > =20
> >  /*
> > @@ -275,7 +277,7 @@ enum {
> >  	RQ_DROPME,	/* drop current reply */
> >  	RQ_SPLICE_OK,	/* turned off in gss privacy to prevent encrypting page
> >  			 * cache pages */
> > -	RQ_VICTIM,	/* about to be shut down */
> > +	RQ_VICTIM,	/* Have agreed to shut down */
> >  	RQ_BUSY,	/* request is busy */
> >  	RQ_DATA,	/* request has data */
> >  };
> > @@ -315,6 +317,24 @@ static inline struct sockaddr *svc_daddr(const struc=
t svc_rqst *rqst)
> >  	return (struct sockaddr *) &rqst->rq_daddr;
> >  }
> > =20
> > +/**
> > + * svc_thread_should_stop - check if this thread should stop
> > + * @rqstp: the thread that might need to stop
> > + *
> > + * To stop an svc thread, the pool flags SP_NEED_VICTIM and SP_VICTIM_RE=
MAINS
> > + * are set.  The firs thread which sees SP_NEED_VICTIM clear it becoming
> > + * the victim using this function.  It should then promptly call
> > + * svc_exit_thread() which completes the process, clearing SP_VICTIM_REM=
AINS
> > + * so the task waiting for a thread to exit can wake and continue.
> > + */
> > +static inline bool svc_thread_should_stop(struct svc_rqst *rqstp)
> > +{
> > +	if (test_and_clear_bit(SP_NEED_VICTIM, &rqstp->rq_pool->sp_flags))
> > +		set_bit(RQ_VICTIM, &rqstp->rq_flags);
> > +
> > +	return test_bit(RQ_VICTIM, &rqstp->rq_flags);
> > +}
> > +
> >  struct svc_deferred_req {
> >  	u32			prot;	/* protocol (UDP or TCP) */
> >  	struct svc_xprt		*xprt;
> > diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> > index 60c8e03268d4..c79375e37dc2 100644
> > --- a/include/trace/events/sunrpc.h
> > +++ b/include/trace/events/sunrpc.h
> > @@ -2041,8 +2041,9 @@ TRACE_EVENT(svc_xprt_enqueue,
> >  #define show_svc_pool_flags(x)						\
> >  	__print_flags(x, "|",						\
> >  		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
> > -		{ BIT(SP_CONGESTED),		"CONGESTED" })
> > -
> > +		{ BIT(SP_CONGESTED),		"CONGESTED" },		\
> > +		{ BIT(SP_NEED_VICTIM),		"NEED_VICTIM" },	\
> > +		{ BIT(SP_VICTIM_REMAINS),	"VICTIM_REMAINS" })
> >  DECLARE_EVENT_CLASS(svc_pool_scheduler_class,
> >  	TP_PROTO(
> >  		const struct svc_rqst *rqstp
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 56b4a88776d5..b18175ef74ec 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -731,19 +731,22 @@ svc_pool_next(struct svc_serv *serv, struct svc_poo=
l *pool, unsigned int *state)
> >  	return pool ? pool : &serv->sv_pools[(*state)++ % serv->sv_nrpools];
> >  }
> > =20
> > -static struct task_struct *
> > +static struct svc_pool *
> >  svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned i=
nt *state)
> >  {
> >  	unsigned int i;
> > -	struct task_struct *task =3D NULL;
> > =20
> >  	if (pool !=3D NULL) {
> >  		spin_lock_bh(&pool->sp_lock);
> > +		if (pool->sp_nrthreads)
> > +			goto found_pool;
> > +		spin_unlock_bh(&pool->sp_lock);
> > +		return NULL;
> >  	} else {
> >  		for (i =3D 0; i < serv->sv_nrpools; i++) {
> >  			pool =3D &serv->sv_pools[--(*state) % serv->sv_nrpools];
> >  			spin_lock_bh(&pool->sp_lock);
> > -			if (!list_empty(&pool->sp_all_threads))
> > +			if (pool->sp_nrthreads)
> >  				goto found_pool;
> >  			spin_unlock_bh(&pool->sp_lock);
> >  		}
> > @@ -751,16 +754,10 @@ svc_pool_victim(struct svc_serv *serv, struct svc_p=
ool *pool, unsigned int *stat
> >  	}
> > =20
> >  found_pool:
> > -	if (!list_empty(&pool->sp_all_threads)) {
> > -		struct svc_rqst *rqstp;
> > -
> > -		rqstp =3D list_entry(pool->sp_all_threads.next, struct svc_rqst, rq_al=
l);
> > -		set_bit(RQ_VICTIM, &rqstp->rq_flags);
> > -		list_del_rcu(&rqstp->rq_all);
> > -		task =3D rqstp->rq_task;
> > -	}
> > +	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > +	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> >  	spin_unlock_bh(&pool->sp_lock);
> > -	return task;
> > +	return pool;
> >  }
> > =20
> >  static int
> > @@ -801,18 +798,16 @@ svc_start_kthreads(struct svc_serv *serv, struct sv=
c_pool *pool, int nrservs)
> >  static int
> >  svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrse=
rvs)
> >  {
> > -	struct svc_rqst	*rqstp;
> > -	struct task_struct *task;
> >  	unsigned int state =3D serv->sv_nrthreads-1;
> > +	struct svc_pool *vpool;
> > =20
> >  	do {
> > -		task =3D svc_pool_victim(serv, pool, &state);
> > -		if (task =3D=3D NULL)
> > +		vpool =3D svc_pool_victim(serv, pool, &state);
> > +		if (!vpool)
> >  			break;
> > -		rqstp =3D kthread_data(task);
> > -		/* Did we lose a race to svo_function threadfn? */
> > -		if (kthread_stop(task) =3D=3D -EINTR)
> > -			svc_exit_thread(rqstp);
> > +		svc_pool_wake_idle_thread(serv, vpool);
> > +		wait_on_bit(&vpool->sp_flags, SP_VICTIM_REMAINS,
> > +			    TASK_IDLE);
>=20
> I'm not sure about this bit. Previously (AFAICT) we didn't shut down the
> threads serially. With this change, we will be. Granted we only have to
> wait until SP_VICTIM_REMAINS is clear. Does that happen early enough in
> the shutdown process that you aren't worried about this?

If by "previously" you mean "before v5.17-rc1~75^2~42", then you are
correct.
When we used send_sig to stop nfsd threads we sent the signals in a
tight loop and didn't wait.

Since then we use kthread_stop() which is synchronous.  It sets a flag,
wakes the threads, and waits on a completion.

With this patch the clear_and_wake_bit() happens very slightly
*before* the complete() which we currently wait for rather late in
exit() handling (complete_vfork_done() I think).

Thanks for the review - here and elsewhere.

NeilBrown


>=20
> >  		nrservs++;
> >  	} while (nrservs < 0);
> >  	return 0;
> > @@ -932,8 +927,6 @@ svc_exit_thread(struct svc_rqst *rqstp)
> > =20
> >  	spin_lock_bh(&pool->sp_lock);
> >  	pool->sp_nrthreads--;
> > -	if (!test_and_set_bit(RQ_VICTIM, &rqstp->rq_flags))
> > -		list_del_rcu(&rqstp->rq_all);
> >  	spin_unlock_bh(&pool->sp_lock);
> > =20
> >  	spin_lock_bh(&serv->sv_lock);
> > @@ -941,6 +934,8 @@ svc_exit_thread(struct svc_rqst *rqstp)
> >  	spin_unlock_bh(&serv->sv_lock);
> >  	svc_sock_update_bufs(serv);
> > =20
> > +	if (svc_thread_should_stop(rqstp))
> > +		clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> >  	svc_rqst_free(rqstp);
> > =20
> >  	svc_put(serv);
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 4fdf1aaa514b..948605e7043b 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -595,8 +595,6 @@ void svc_wake_up(struct svc_serv *serv)
> >  		smp_wmb();
> >  		return;
> >  	}
> > -
> > -	trace_svc_wake_up(rqstp);
> >  }
> >  EXPORT_SYMBOL_GPL(svc_wake_up);
> > =20
> > @@ -688,7 +686,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
> >  			continue;
> > =20
> >  		set_current_state(TASK_IDLE);
> > -		if (kthread_should_stop()) {
> > +		if (svc_thread_should_stop(rqstp)) {
> >  			set_current_state(TASK_RUNNING);
> >  			return false;
> >  		}
> > @@ -726,7 +724,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >  		return false;
> > =20
> >  	/* are we shutting down? */
> > -	if (kthread_should_stop())
> > +	if (svc_thread_should_stop(rqstp))
> >  		return false;
> > =20
> >  	/* are we freezing? */
> > @@ -787,7 +785,7 @@ static void svc_wait_for_work(struct svc_rqst *rqstp)
> >  	}
> >  #endif
> > =20
> > -	if (!kthread_should_stop())
> > +	if (!svc_thread_should_stop(rqstp))
> >  		percpu_counter_inc(&pool->sp_threads_no_work);
> >  	return;
> >  out_found:
> >=20
> >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

