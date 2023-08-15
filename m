Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9B77D658
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Aug 2023 00:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbjHOWo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Aug 2023 18:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbjHOWow (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Aug 2023 18:44:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291D19B6
        for <linux-nfs@vger.kernel.org>; Tue, 15 Aug 2023 15:44:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7FE6216DA;
        Tue, 15 Aug 2023 22:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692139484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3b1gQOt1E0u8xp5cNs1LOZOMLil/C/lGalfPwJc+HfU=;
        b=CUrDqhemxspHnlbADvd0MhZlsuWAxhwNV/YCZsMJx3t0ArL++3nRhTAepq9uzoCdK3svZ7
        fnSQnkDmlWAUJTwq83dxn9IDvqrVPZ9eg9rIT/XK3A/512n3gKqQIZfTPESMGxOrRWZUB9
        +5IXmodCBgSZ4XSVhaPAGArisqQsX6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692139484;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3b1gQOt1E0u8xp5cNs1LOZOMLil/C/lGalfPwJc+HfU=;
        b=Ss1nz12CqBz25E4lXM4h/WX660aJF2VmTPBYMEYJe1vKePlZHCPbyGWCsexLALtcW0RUkP
        u0zeV0x3oA2vBbCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A4991353E;
        Tue, 15 Aug 2023 22:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5aidC9v/22TOMwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 15 Aug 2023 22:44:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 04/10] SUNRPC: change service idle list to be an llist
In-reply-to: <ZNuu6VaU8XzYuEQj@tissot.1015granger.net>
References: <20230815015426.5091-1-neilb@suse.de>,
 <20230815015426.5091-5-neilb@suse.de>,
 <ZNuu6VaU8XzYuEQj@tissot.1015granger.net>
Date:   Wed, 16 Aug 2023 08:44:39 +1000
Message-id: <169213947940.11073.14765809649639298670@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 16 Aug 2023, Chuck Lever wrote:
> On Tue, Aug 15, 2023 at 11:54:20AM +1000, NeilBrown wrote:
> > With an llist we don't need to take a lock to add a thread to the list,
> > though we still need a lock to remove it.  That will go in the next
> > patch.
> >=20
> > Unlike double-linked lists, a thread cannot reliably remove itself from
> > the list.  Only the first thread can be removed, and that can change
> > asynchronously.  So some care is needed.
> >=20
> > We already check if there is pending work to do, so we are unlikely to
> > add ourselves to the idle list and then want to remove ourselves again.
> >=20
> > If we DO find something needs to be done after adding ourselves to the
> > list, we simply wake up the first thread on the list.  If that was us,
> > we successfully removed ourselves and can continue.  If it was some
> > other thread, they will do the work that needs to be done.  We can
> > safely sleep until woken.
> >=20
> > We also remove the test on freezing() from rqst_should_sleep().  Instead
> > we always try_to_freeze() before scheduling, which is needed as we now
> > schedule() in a loop waiting to be removed from the idle queue.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/sunrpc/svc.h | 14 ++++++-----
> >  net/sunrpc/svc.c           | 13 +++++-----
> >  net/sunrpc/svc_xprt.c      | 50 +++++++++++++++++++-------------------
> >  3 files changed, 40 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 22b3018ebf62..5216f95411e3 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -37,7 +37,7 @@ struct svc_pool {
> >  	struct list_head	sp_sockets;	/* pending sockets */
> >  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> >  	struct list_head	sp_all_threads;	/* all server threads */
> > -	struct list_head	sp_idle_threads; /* idle server threads */
> > +	struct llist_head	sp_idle_threads; /* idle server threads */
> > =20
> >  	/* statistics on pool operation */
> >  	struct percpu_counter	sp_messages_arrived;
> > @@ -186,7 +186,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqs=
tp);
> >   */
> >  struct svc_rqst {
> >  	struct list_head	rq_all;		/* all threads list */
> > -	struct list_head	rq_idle;	/* On the idle list */
> > +	struct llist_node	rq_idle;	/* On the idle list */
> >  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
> >  	struct svc_xprt *	rq_xprt;	/* transport ptr */
> > =20
> > @@ -270,22 +270,24 @@ enum {
> >   * svc_thread_set_busy - mark a thread as busy
> >   * @rqstp: the thread which is now busy
> >   *
> > - * If rq_idle is "empty", the thread must be busy.
> > + * By convention a thread is busy if rq_idle.next points to rq_idle.
> > + * This ensures it is not on the idle list.
> >   */
> >  static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
> >  {
> > -	INIT_LIST_HEAD(&rqstp->rq_idle);
> > +	rqstp->rq_idle.next =3D &rqstp->rq_idle;
> >  }
> > =20
> >  /**
> >   * svc_thread_busy - check if a thread as busy
> >   * @rqstp: the thread which might be busy
> >   *
> > - * If rq_idle is "empty", the thread must be busy.
> > + * By convention a thread is busy if rq_idle.next points to rq_idle.
> > + * This ensures it is not on the idle list.
> >   */
> >  static inline bool svc_thread_busy(struct svc_rqst *rqstp)
> >  {
> > -	return list_empty(&rqstp->rq_idle);
> > +	return rqstp->rq_idle.next =3D=3D &rqstp->rq_idle;
> >  }
> > =20
> >  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq=
_bc_net)
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 051f08c48418..addbf28ea50a 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -510,7 +510,7 @@ __svc_create(struct svc_program *prog, unsigned int b=
ufsize, int npools,
> >  		pool->sp_id =3D i;
> >  		INIT_LIST_HEAD(&pool->sp_sockets);
> >  		INIT_LIST_HEAD(&pool->sp_all_threads);
> > -		INIT_LIST_HEAD(&pool->sp_idle_threads);
> > +		init_llist_head(&pool->sp_idle_threads);
> >  		spin_lock_init(&pool->sp_lock);
> > =20
> >  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> > @@ -701,15 +701,16 @@ svc_prepare_thread(struct svc_serv *serv, struct sv=
c_pool *pool, int node)
> >  void svc_pool_wake_idle_thread(struct svc_pool *pool)
> >  {
> >  	struct svc_rqst	*rqstp;
> > +	struct llist_node *ln;
> > =20
> >  	rcu_read_lock();
> >  	spin_lock_bh(&pool->sp_lock);
> > -	rqstp =3D list_first_entry_or_null(&pool->sp_idle_threads,
> > -					 struct svc_rqst, rq_idle);
> > -	if (rqstp)
> > -		list_del_init(&rqstp->rq_idle);
> > +	ln =3D llist_del_first(&pool->sp_idle_threads);
> >  	spin_unlock_bh(&pool->sp_lock);
> > -	if (rqstp) {
> > +	if (ln) {
> > +		rqstp =3D llist_entry(ln, struct svc_rqst, rq_idle);
> > +		svc_thread_set_busy(rqstp);
> > +
> >  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> >  		wake_up_process(rqstp->rq_task);
> >  		rcu_read_unlock();
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index fa0d854a5596..7cb71effda0b 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -715,10 +715,6 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >  	if (svc_thread_should_stop(rqstp))
> >  		return false;
> > =20
> > -	/* are we freezing? */
> > -	if (freezing(current))
> > -		return false;
> > -
> >  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> >  	if (svc_is_backchannel(rqstp)) {
> >  		if (!list_empty(&rqstp->rq_server->sv_cb_list))
> > @@ -735,29 +731,32 @@ static void svc_rqst_wait_for_work(struct svc_rqst =
*rqstp)
> > =20
> >  	if (rqst_should_sleep(rqstp)) {
> >  		set_current_state(TASK_IDLE);
> > -		spin_lock_bh(&pool->sp_lock);
> > -		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> > -		spin_unlock_bh(&pool->sp_lock);
> > +		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> > +
> > +		if (unlikely(!rqst_should_sleep(rqstp)))
> > +			/* maybe there were no idle threads when some work
> > +			 * became ready and so nothing was woken.  We've just
> > +			 * become idle so someone can to the work - maybe us.
> > +			 * But we cannot reliably remove ourselves from the
> > +			 * idle list - we can only remove the first task which
> > +			 * might be us, and might not.
> > +			 * So remove and wake it, then schedule().  If it was
> > +			 * us, we won't sleep.  If it is some other thread, they
> > +			 * will do the work.
> > +			 */
> > +			svc_pool_wake_idle_thread(pool);
> > =20
> > -		/* Need to check should_sleep() again after
> > -		 * setting task state in case a wakeup happened
> > -		 * between testing and setting.
> > +		/* We mustn't continue while on the idle list, and we
> > +		 * cannot remove outselves reliably.  The only "work"
> > +		 * we can do while on the idle list is to freeze.
> > +		 * So loop until someone removes us
> >  		 */
> > -		if (rqst_should_sleep(rqstp)) {
> > +		while (!svc_thread_busy(rqstp)) {
> > +			try_to_freeze();
>=20
> For testing, I've applied up to this patch. When nfsd is started
> I now get this splat:
>=20
> do not call blocking ops when !TASK_RUNNING; state=3D402 set at [<000000001=
e3d6995>] svc_recv+0x40/0x252 [sunrpc]

Thanks.  I didn't have the right CONFIG options to trigger that warning.
I do now.
I'm not surprised I got something wrong with freezing.  I did some
research and now I see the part of freezing that I was missing.
This incremental patch

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 7cb71effda0b..81327001e074 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -730,7 +730,7 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 	struct svc_pool *pool =3D rqstp->rq_pool;
=20
 	if (rqst_should_sleep(rqstp)) {
-		set_current_state(TASK_IDLE);
+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
=20
 		if (unlikely(!rqst_should_sleep(rqstp)))
@@ -752,9 +752,8 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 		 * So loop until someone removes us
 		 */
 		while (!svc_thread_busy(rqstp)) {
-			try_to_freeze();
 			schedule();
-			set_current_state(TASK_IDLE);
+			set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		}
 		__set_current_state(TASK_RUNNING);
 	} else {


fixes that issue.  "TASK_FREEZABLE" was the missing bit.  I'll need to
look back at the other patches and probably introduce this earlier.

Thanks,
NeilBrown



> WARNING: CPU: 3 PID: 1228 at kernel/sched/core.c:10112 __might_sleep+0x52/0=
x6a
> Modules linked in: 8021q garp stp mrp llc rfkill rpcrdma rdma_ucm ib_srpt i=
b_isert iscsi_target_mod snd_hda_codec_realtek target_core_mod intel>
> CPU: 3 PID: 1228 Comm: lockd Not tainted 6.5.0-rc6-00060-gd10a6b1ad2a1 #1
> Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
> RIP: 0010:__might_sleep+0x52/0x6a
> Code: 00 00 74 28 80 3d 45 40 d5 01 00 75 1f 48 8b 90 f0 1a 00 00 48 c7 c7 =
b3 d6 49 9b c6 05 2e 40 d5 01 01 48 89 d1 e8 e6 a2 fc ff <0f> 0b 44 >
> RSP: 0018:ffffb3e3836abe68 EFLAGS: 00010286
> RAX: 000000000000006f RBX: ffffffffc0c20599 RCX: 0000000000000027
> RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: 0000000000000001
> RBP: ffffb3e3836abe78 R08: 0000000000000000 R09: ffffb3e380e70020
> R10: 0000000000000000 R11: ffffa0ae94aa4c00 R12: 0000000000000035
> R13: ffffa0ae94bfa040 R14: ffffa0ae9e85c010 R15: ffffa0ae94bfa040
> FS:  0000000000000000(0000) GS:ffffa0bdbfd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f59c2611760 CR3: 000000069ec34006 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? show_regs+0x5d/0x64
>  ? __might_sleep+0x52/0x6a
>  ? __warn+0xab/0x132
>  ? report_bug+0xd0/0x144
>  ? __might_sleep+0x52/0x6a
>  ? handle_bug+0x45/0x74
>  ? exc_invalid_op+0x18/0x68
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? __might_sleep+0x52/0x6a
>  ? __might_sleep+0x52/0x6a
>  try_to_freeze.isra.0+0x15/0x3d [sunrpc]
>  svc_recv+0x97/0x252 [sunrpc]
>  ? __pfx_lockd+0x10/0x10 [lockd]
>  lockd+0x6b/0xda [lockd]
>  kthread+0x10d/0x115
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2a/0x43
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
>=20
>=20
> >  			schedule();
> > -		} else {
> > -			__set_current_state(TASK_RUNNING);
> > -			cond_resched();
> > -		}
> > -
> > -		/* We *must* be removed from the list before we can continue.
> > -		 * If we were woken, this is already done
> > -		 */
> > -		if (!svc_thread_busy(rqstp)) {
> > -			spin_lock_bh(&pool->sp_lock);
> > -			list_del_init(&rqstp->rq_idle);
> > -			spin_unlock_bh(&pool->sp_lock);
> > +			set_current_state(TASK_IDLE);
> >  		}
> > +		__set_current_state(TASK_RUNNING);
> >  	} else {
> >  		cond_resched();
> >  	}
> > @@ -870,9 +869,10 @@ void svc_recv(struct svc_rqst *rqstp)
> >  		struct svc_xprt *xprt =3D rqstp->rq_xprt;
> > =20
> >  		/* Normally we will wait up to 5 seconds for any required
> > -		 * cache information to be provided.
> > +		 * cache information to be provided.  When there are no
> > +		 * idle threads, we reduce the wait time.
> >  		 */
> > -		if (!list_empty(&pool->sp_idle_threads))
> > +		if (pool->sp_idle_threads.first)
> >  			rqstp->rq_chandle.thread_wait =3D 5 * HZ;
> >  		else
> >  			rqstp->rq_chandle.thread_wait =3D 1 * HZ;
> > --=20
> > 2.40.1
> >=20
>=20
> --=20
> Chuck Lever
>=20

