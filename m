Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0122E790F5C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 02:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjIDAfU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 20:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjIDAfU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 20:35:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9308D3
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 17:35:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E24041F38C;
        Mon,  4 Sep 2023 00:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693787714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlVxjqftMmNGdp6VRIysAfAuTPdpcXaK8P1eHT6Ei10=;
        b=cp9XF3CM8E+Whxh462kYPNYsrlB72GodCv36jfsIV5I/gUW7cKCzupnYpAbhiBfHRx0CHy
        QDC6i4lKo4uXkpE+r0yIkf3yPxS9qiWYQixxsYRZ3x9ZkVboW/1yxa8YQVy72c9EbjT2va
        sch2ykMcV5IurfhqQ1BoqSk/hAK8oeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693787714;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlVxjqftMmNGdp6VRIysAfAuTPdpcXaK8P1eHT6Ei10=;
        b=CoK7loiohcfLqnS8J26gh9ZCvwVq8W8O70yhs+DlA+CSZ/kXH4yer1iNei9+wpcY0FBm+v
        l7wAupyqLhOavLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2FFD134B2;
        Mon,  4 Sep 2023 00:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0ANVFUEm9WToOAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 04 Sep 2023 00:35:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/10] SUNRPC: only have one thread waking up at a time
In-reply-to: <ZO9gHCfWzH+kegrw@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>,
 <20230830025755.21292-7-neilb@suse.de>,
 <ZO9gHCfWzH+kegrw@tissot.1015granger.net>
Date:   Mon, 04 Sep 2023 10:35:10 +1000
Message-id: <169378771006.27865.5331797570871156115@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 31 Aug 2023, Chuck Lever wrote:
> On Wed, Aug 30, 2023 at 12:54:49PM +1000, NeilBrown wrote:
> > Currently if several items of work become available in quick succession,
> > that number of threads (if available) will be woken.  By the time some
> > of them wake up another thread that was already cache-warm might have
> > come along and completed the work.  Anecdotal evidence suggests as many
> > as 15% of wakes find nothing to do once they get to the point of
> > looking.
> >=20
> > This patch changes svc_pool_wake_idle_thread() to wake the first thread
> > on the queue but NOT remove it.  Subsequent calls will wake the same
> > thread.  Once that thread starts it will dequeue itself and after
> > dequeueing some work to do, it will wake the next thread if there is more
> > work ready.  This results in a more orderly increase in the number of
> > busy threads.
> >=20
> > As a bonus, this allows us to reduce locking around the idle queue.
> > svc_pool_wake_idle_thread() no longer needs to take a lock (beyond
> > rcu_read_lock()) as it doesn't manipulate the queue, it just looks at
> > the first item.
> >=20
> > The thread itself can avoid locking by using the new
> > llist_del_first_this() interface.  This will safely remove the thread
> > itself if it is the head.  If it isn't the head, it will do nothing.
> > If multiple threads call this concurrently only one will succeed.  The
> > others will do nothing, so no corruption can result.
> >=20
> > If a thread wakes up and finds that it cannot dequeue itself that means
> > either
> > - that it wasn't woken because it was the head of the queue.  Maybe the
> >   freezer woke it.  In that case it can go back to sleep (after trying
> >   to freeze of course).
> > - some other thread found there was nothing to do very recently, and
> >   placed itself on the head of the queue in front of this thread.
> >   It must check again after placing itself there, so it can be deemed to
> >   be responsible for any pending work, and this thread can go back to
> >   sleep until woken.
> >=20
> > No code ever tests for busy threads any more.  Only each thread itself
> > cares if it is busy.  So svc_thread_busy() is no longer needed.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/sunrpc/svc.h | 11 -----------
> >  net/sunrpc/svc.c           | 14 ++++++--------
> >  net/sunrpc/svc_xprt.c      | 35 ++++++++++++++++++++++-------------
> >  3 files changed, 28 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index ad4572630335..dafa362b4fdd 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -266,17 +266,6 @@ enum {
> >  	RQ_DATA,		/* request has data */
> >  };
> > =20
> > -/**
> > - * svc_thread_busy - check if a thread as busy
> > - * @rqstp: the thread which might be busy
> > - *
> > - * A thread is only busy when it is not an the idle list.
> > - */
> > -static inline bool svc_thread_busy(const struct svc_rqst *rqstp)
> > -{
> > -	return !llist_on_list(&rqstp->rq_idle);
> > -}
> > -
> >  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq=
_bc_net)
> > =20
> >  /*
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 5673f30db295..3267d740235e 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -642,7 +642,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool=
 *pool, int node)
> > =20
> >  	folio_batch_init(&rqstp->rq_fbatch);
> > =20
> > -	init_llist_node(&rqstp->rq_idle);
> >  	rqstp->rq_server =3D serv;
> >  	rqstp->rq_pool =3D pool;
> > =20
> > @@ -704,17 +703,16 @@ void svc_pool_wake_idle_thread(struct svc_pool *poo=
l)
> >  	struct llist_node *ln;
> > =20
> >  	rcu_read_lock();
> > -	spin_lock_bh(&pool->sp_lock);
> > -	ln =3D llist_del_first_init(&pool->sp_idle_threads);
> > -	spin_unlock_bh(&pool->sp_lock);
> > +	ln =3D READ_ONCE(pool->sp_idle_threads.first);
> >  	if (ln) {
> >  		rqstp =3D llist_entry(ln, struct svc_rqst, rq_idle);
> > -
> >  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> > -		wake_up_process(rqstp->rq_task);
> > +		if (!task_is_running(rqstp->rq_task)) {
> > +			wake_up_process(rqstp->rq_task);
> > +			trace_svc_wake_up(rqstp->rq_task->pid);
> > +			percpu_counter_inc(&pool->sp_threads_woken);
> > +		}
> >  		rcu_read_unlock();
> > -		percpu_counter_inc(&pool->sp_threads_woken);
> > -		trace_svc_wake_up(rqstp->rq_task->pid);
> >  		return;
> >  	}
> >  	rcu_read_unlock();
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 17c43bde35c9..a51570a4cbf2 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -732,20 +732,16 @@ static void svc_rqst_wait_for_work(struct svc_rqst =
*rqstp)
> >  	if (rqst_should_sleep(rqstp)) {
> >  		set_current_state(TASK_IDLE | TASK_FREEZABLE);
> >  		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> > +		if (likely(rqst_should_sleep(rqstp)))
> > +			schedule();
> > =20
> > -		if (unlikely(!rqst_should_sleep(rqstp)))
> > -			/* Work just became available.  This thread cannot simply
> > -			 * choose not to sleep as it *must* wait until removed.
> > -			 * So wake the first waiter - whether it is this
> > -			 * thread or some other, it will get the work done.
> > +		while (!llist_del_first_this(&pool->sp_idle_threads,
> > +					     &rqstp->rq_idle)) {
> > +			/* Cannot @rqstp from idle list, so some other thread
>=20
> I was not aware that "@rqstp" was a verb.  ;-)
>=20
> Maybe the nice new comment that you are deleting just above here
> would be appropriate to move here.
>=20
>=20
> > +			 * must have queued itself after finding
> > +			 * no work to do, so they have taken responsibility
> > +			 * for any outstanding work.
> >  			 */
> > -			svc_pool_wake_idle_thread(pool);
> > -
> > -		/* Since a thread cannot remove itself from an llist,
> > -		 * schedule until someone else removes @rqstp from
> > -		 * the idle list.
> > -		 */
> > -		while (!svc_thread_busy(rqstp)) {
> >  			schedule();
> >  			set_current_state(TASK_IDLE | TASK_FREEZABLE);
> >  		}
> > @@ -835,6 +831,15 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, =
struct svc_xprt *xprt)
> >  	svc_xprt_release(rqstp);
> >  }
> > =20
> > +static void wake_next(struct svc_rqst *rqstp)
>=20
> Nit: I would prefer a subsystem-specific name for this little guy.
> Makes it a little easier to distinguish from generic scheduler
> functions when looking at perf output.
>=20
> How about "svc_thread_wake_next" ?
>=20
>=20
> > +{
> > +	if (!rqst_should_sleep(rqstp))
>=20
> rqst_should_sleep() should also get a better name IMO, but that
> helper was added many patches ago. If you agree to a change, I can
> do that surgery.

What new name are you suggesting?  svc_rqst_should_sleep()?
I'm happy for you to change it to anything that you think is an
improvement, and to do the surgery.

I'll address the eariler comments and resend at least this patch.

Thanks,
NeilBrown


>=20
>=20
> > +		/* More work pending after I dequeued some,
> > +		 * wake another worker
> > +		 */
> > +		svc_pool_wake_idle_thread(rqstp->rq_pool);
> > +}
> > +
> >  /**
> >   * svc_recv - Receive and process the next request on any transport
> >   * @rqstp: an idle RPC service thread
> > @@ -854,13 +859,16 @@ void svc_recv(struct svc_rqst *rqstp)
> > =20
> >  	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> > =20
> > -	if (svc_thread_should_stop(rqstp))
> > +	if (svc_thread_should_stop(rqstp)) {
> > +		wake_next(rqstp);
> >  		return;
> > +	}
> > =20
> >  	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
> >  	if (rqstp->rq_xprt) {
> >  		struct svc_xprt *xprt =3D rqstp->rq_xprt;
> > =20
> > +		wake_next(rqstp);
> >  		/* Normally we will wait up to 5 seconds for any required
> >  		 * cache information to be provided.  When there are no
> >  		 * idle threads, we reduce the wait time.
> > @@ -885,6 +893,7 @@ void svc_recv(struct svc_rqst *rqstp)
> >  		if (req) {
> >  			list_del(&req->rq_bc_list);
> >  			spin_unlock_bh(&serv->sv_cb_lock);
> > +			wake_next(rqstp);
> > =20
> >  			svc_process_bc(req, rqstp);
> >  			return;
> > --=20
> > 2.41.0
> >=20
>=20
> --=20
> Chuck Lever
>=20

