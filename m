Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC678D1D8
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 03:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjH3BxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbjH3BxF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 21:53:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E11EFC
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 18:53:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D93F81F45F;
        Wed, 30 Aug 2023 01:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693360379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sekPh/27wVvjKg39LWDKWYZZlYJzdyjhV9cOO5LdLZA=;
        b=AR0oZE5IUI2k+nlx94t1UpU/CccWofjDA36nctW4YQyL+KPaSwNxktw7LIj6f5Y9QefWmz
        fBgoSoqse5hDpdLY13zk0l4Hdoqp1KAEFMytkvZTQJbqeRDjL1czuTbQDJvR9h4Ng4LP3i
        D8pebLGz8r3tV9bODJsHAnwxJHDDWP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693360379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sekPh/27wVvjKg39LWDKWYZZlYJzdyjhV9cOO5LdLZA=;
        b=MlawLBlCmdrepakFpndixh4OaLZXwsov4teUu+vEBEcBCracReFTAUneF/sThlyHH2Kxfq
        XYWtxBQh3DxPzPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 500B613441;
        Wed, 30 Aug 2023 01:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5KdYAfqg7mRsSAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 01:52:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/7] SUNRPC: change service idle list to be an llist
In-reply-to: <ZN+T+y+lwQ2XrXLM@tissot.1015granger.net>
References: <20230818014512.26880-1-neilb@suse.de>,
 <20230818014512.26880-2-neilb@suse.de>,
 <ZN+T+y+lwQ2XrXLM@tissot.1015granger.net>
Date:   Wed, 30 Aug 2023 11:52:54 +1000
Message-id: <169336037466.5133.16675228163799112773@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 19 Aug 2023, Chuck Lever wrote:
> On Fri, Aug 18, 2023 at 11:45:06AM +1000, NeilBrown wrote:
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
> > we set TASK_FREEZABLE before scheduling.  This makes is safe to
> > schedule() when a freeze is pending.  As we now loop waiting to be
> > removed from the idle queue, this is a cleaner way to handle freezing.
> >=20
> > task_state_index() incorrectly identifies a task with
> >    TASK_IDLE | TASK_FREEZABLE
> > as 'D'.  So fix __task_state_index to ignore extra flags on TASK_IDLE
> > just as it ignores extra flags on other states.
>=20
> Let's split the task_state_index() change into a separate patch
> that can be sent to the scheduler maintainers for their Review/Ack.
>=20

I've sent that to appropriate people.  It doesn't really matter if it
lands before or after we change sunrpc to use TASK_FREEZABLE.  The only
problem is that nfsd threads look like "D" in a ps listing rather than
"I".  The actually behaviour of the threads isn't changed.

>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/sched.h      |  4 +--
> >  include/linux/sunrpc/svc.h | 14 ++++++-----
> >  net/sunrpc/svc.c           | 13 +++++-----
> >  net/sunrpc/svc_xprt.c      | 51 +++++++++++++++++++-------------------
> >  4 files changed, 42 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 609bde814cb0..a5f3badcb629 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1666,7 +1666,7 @@ static inline unsigned int __task_state_index(unsig=
ned int tsk_state,
> > =20
> >  	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
> > =20
> > -	if (tsk_state =3D=3D TASK_IDLE)
> > +	if ((tsk_state & TASK_IDLE) =3D=3D TASK_IDLE)
> >  		state =3D TASK_REPORT_IDLE;
> > =20
> >  	/*
> > @@ -1674,7 +1674,7 @@ static inline unsigned int __task_state_index(unsig=
ned int tsk_state,
> >  	 * to userspace, we can make this appear as if the task has gone through
> >  	 * a regular rt_mutex_lock() call.
> >  	 */
> > -	if (tsk_state =3D=3D TASK_RTLOCK_WAIT)
> > +	if (tsk_state & TASK_RTLOCK_WAIT)
> >  		state =3D TASK_UNINTERRUPTIBLE;
> > =20
> >  	return fls(state);
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
>=20
> I don't understand the comment "This ensures it is not on the idle
> list." svc_thread_set_busy() is called in two places: The first
> when an svc_rqst is created, and once directly after an
> llist_del_first() has been done. @rqstp is already not on the
> idle list in either case.

"ensures" is the wrong word.  Maybe I meant "assures" or even "records".
I change it to
 * This will never be the case for threads on the idle list.

>=20
> What really needs an explanation here is that there's no
> existing utility to check whether an llist_node is on a list or
> not.

I guess no-one found the need before...
Though I note that md/raid5.c has a bit flag STRIPE_ON_RELEASE_LIST
to check if the stripe is on a llist.  So it could use that
functionality.

I would happily include a patch to add this to llist.h, except that by
the end of the series we don't need it any more...
Maybe I should do it anyway?
>=20
>=20
> >  /**
> >   * svc_thread_busy - check if a thread as busy
> >   * @rqstp: the thread which might be busy
> >   *
> > - * If rq_idle is "empty", the thread must be busy.
> > + * By convention a thread is busy if rq_idle.next points to rq_idle.
> > + * This ensures it is not on the idle list.
>=20
> This function doesn't modify the thread, so it can't ensure it
> is not on the idle list.
I changed that to

 * This will never be the case for threads on the idle list.

too.

>=20
>=20
> >   */
> >  static inline bool svc_thread_busy(struct svc_rqst *rqstp)
>=20
> const struct svc_rqst *rqstp

ack.

>=20
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
> > index fa0d854a5596..81327001e074 100644
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
> > @@ -734,30 +730,32 @@ static void svc_rqst_wait_for_work(struct svc_rqst =
*rqstp)
> >  	struct svc_pool *pool =3D rqstp->rq_pool;
> > =20
> >  	if (rqst_should_sleep(rqstp)) {
> > -		set_current_state(TASK_IDLE);
> > -		spin_lock_bh(&pool->sp_lock);
> > -		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> > -		spin_unlock_bh(&pool->sp_lock);
> > +		set_current_state(TASK_IDLE | TASK_FREEZABLE);
>=20
> I'm trying to learn about the semantics of IDLE|FREEZABLE, but there
> isn't another instance of this flag combination in the kernel.

No - which I why no one else notice that the state reported by ps was
wrong.=20
Quite a few places use INTERRUPTIBLE|FREEZABLE which is much the same
thing except sunrpc threads don't want interrupts.

My interpretation of FREEZABLE is that it avoids the need to check for
freezing, or to freeze.  A higher-level interface.

>=20
>=20
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
>=20
> Large block comments suggest that this code doesn't document itself
> very well.

Self documenting code is best, but when the logic is subtle and
unfamiliar, a bit of text can help.
Of course the logic is quite familiar to me now and doesn't seem so
subtle, so I wonder if any comment it needed.
>=20
> At least, some of the textual redundancy can be removed, though this
> comment and the next are removed or replaced in later patches. I'll
> leave it up to you to find an approach that is a bit cleaner.

Is now:
	/* Work just became available.  This thread cannot simply
	 * choose not to sleep as it *must* wait until removed.
	 * So wake the first waiter - whether it is this
	 * thread or some other, it will get the work done.
	 */


>=20
>=20
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
>=20
> Here and above, the use of "we" obscures the explanation. What is
> "we" in this context? I think it might be "this thread" or @rqstp,
> but I can't be certain. For instance:
>=20
> 		/* Since a thread cannot remove itself from an llist,
> 		 * schedule until someone else removes @rqstp from
> 		 * the idle list.
> 		 */

Looks good - thanks.

>=20
>=20
> > -		if (rqst_should_sleep(rqstp)) {
> > +		while (!svc_thread_busy(rqstp)) {
>=20
> I need to convince myself that this while() can't possibly result in
> an infinite loop.
>=20

It cannot be a busy-loop because we set state and call schedule().
It could loop for a long time if there is no work to do.
But at service shutdown, everything will be removed from the busy list
and woken, so the loop will exit then.

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
> > +			set_current_state(TASK_IDLE | TASK_FREEZABLE);
> >  		}
> > +		__set_current_state(TASK_RUNNING);
> >=20
> >  	} else {
> >  		cond_resched();
> >  	}
>=20
> There's a try_to_freeze() call just after this hunk. Is there a
> reason to invoke cond_resched(); before freezing?

try_to_freeze() can compile to {return false;}.  Even when not, it
usually does not more than tests a global variable.  So the presence of
try_to_freeze() has no bearing on the use of cond_resched().

>=20
>=20
> > @@ -870,9 +868,10 @@ void svc_recv(struct svc_rqst *rqstp)
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

I'll send a new batch today I hope.  I decided to move lwq into lib/
and make all the changes to llist in separate patches.

Thanks,
NeilBrown
