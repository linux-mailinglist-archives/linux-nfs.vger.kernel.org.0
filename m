Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE44974ED6C
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 13:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGKL5X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGKL5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 07:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD010C0
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 04:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAA7A61499
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 11:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4DC433C8;
        Tue, 11 Jul 2023 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689076637;
        bh=gbY4+7lmp7/kIxHBP3RT4MehhVg36aI6WkgkjB7hJKg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ahP0WSl0hV6qPmR/KgFskHvnER5C4G+dDcyDkV5B0RxILV6Umdh6Eu2xj4w4DwrAG
         hL3MK7YC/HWrvKXNyNoFB3y/h0MmNCWzqUUwbq6z1gq+S5Fb+eZo+9xyNGKoEE50+8
         +qAqi+eEksNNlju92LOsN2+rbvcUmy31RbQaMW/JOgycpCDGkwNFBgX/IQJq/ER1Rt
         HEhuHMFQe471mg2nWBFLdyZKRuxIkQWwddf+ocPrt8UoiH2gt9oq/UmD1NOTVqxyZx
         orvpAzLHNpXuV+5WNE8VV5SpU4sP7V5u5z4iM8xDiYblJ7WchpWsW0ZGZpRGtVaQDe
         HKGwYBibSCs6Q==
Message-ID: <c0a221115e2bae7910b9e4ab6eacdc745f320b43.camel@kernel.org>
Subject: Re: [PATCH v3 8/9] SUNRPC: Replace sp_threads_all with an xarray
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Neil Brown <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>
Date:   Tue, 11 Jul 2023 07:57:15 -0400
In-Reply-To: <ZKy9Q1wX/xPx5Mbu@manet.1015granger.net>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
         <168900736644.7514.16807799597793601214.stgit@manet.1015granger.net>
         <9de14c8ef8584545ceef2179f0b57f84ef7706fe.camel@kernel.org>
         <0D6735B0-77A8-4710-8EE7-1F8E382A139B@oracle.com>
         <2909e8cfc2cbd218372e78f5e215759722faba51.camel@kernel.org>
         <ZKy9Q1wX/xPx5Mbu@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-07-10 at 22:24 -0400, Chuck Lever wrote:
> On Mon, Jul 10, 2023 at 09:06:02PM -0400, Jeff Layton wrote:
> > On Tue, 2023-07-11 at 00:58 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jul 10, 2023, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > On Mon, 2023-07-10 at 12:42 -0400, Chuck Lever wrote:
> > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > >=20
> > > > > We want a thread lookup operation that can be done with RCU only,
> > > > > but also we want to avoid the linked-list walk, which does not sc=
ale
> > > > > well in the number of pool threads.
> > > > >=20
> > > > > This patch splits out the use of the sp_lock to protect the set
> > > > > of threads. Svc thread information is now protected by the xarray=
's
> > > > > lock (when making thread count changes) and the RCU read lock (wh=
en
> > > > > only looking up a thread).
> > > > >=20
> > > > > Since thread count changes are done only via nfsd filesystem API,
> > > > > which runs only in process context, we can safely dispense with t=
he
> > > > > use of a bottom-half-disabled lock.
> > > > >=20
> > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > ---
> > > > > fs/nfsd/nfssvc.c              |    3 +-
> > > > > include/linux/sunrpc/svc.h    |   11 +++----
> > > > > include/trace/events/sunrpc.h |   47 ++++++++++++++++++++++++++++=
-
> > > > > net/sunrpc/svc.c              |   67 +++++++++++++++++++++++++---=
-------------
> > > > > net/sunrpc/svc_xprt.c         |    2 +
> > > > > 5 files changed, 94 insertions(+), 36 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > > > index 2154fa63c5f2..d42b2a40c93c 100644
> > > > > --- a/fs/nfsd/nfssvc.c
> > > > > +++ b/fs/nfsd/nfssvc.c
> > > > > @@ -62,8 +62,7 @@ static __be32 nfsd_init_request(struct svc_rqst=
 *,
> > > > >  * If (out side the lock) nn->nfsd_serv is non-NULL, then it must=
 point to a
> > > > >  * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0=
 (unless
> > > > >  * nn->keep_active is set).  That number of nfsd threads must
> > > > > - * exist and each must be listed in ->sp_all_threads in some ent=
ry of
> > > > > - * ->sv_pools[].
> > > > > + * exist and each must be listed in some entry of ->sv_pools[].
> > > > >  *
> > > > >  * Each active thread holds a counted reference on nn->nfsd_serv,=
 as does
> > > > >  * the nn->keep_active flag and various transient calls to svc_ge=
t().
> > > > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/sv=
c.h
> > > > > index 9dd3b16cc4c2..86377506a514 100644
> > > > > --- a/include/linux/sunrpc/svc.h
> > > > > +++ b/include/linux/sunrpc/svc.h
> > > > > @@ -32,10 +32,10 @@
> > > > >  */
> > > > > struct svc_pool {
> > > > > unsigned int sp_id;     /* pool id; also node id on NUMA */
> > > > > - spinlock_t sp_lock; /* protects all fields */
> > > > > + spinlock_t sp_lock; /* protects sp_sockets */
> > > > > struct list_head sp_sockets; /* pending sockets */
> > > > > unsigned int sp_nrthreads; /* # of threads in pool */
> > > > > - struct list_head sp_all_threads; /* all server threads */
> > > > > + struct xarray sp_thread_xa;
> > > > >=20
> > > > > /* statistics on pool operation */
> > > > > struct percpu_counter sp_messages_arrived;
> > > > > @@ -196,7 +196,6 @@ extern u32 svc_max_payload(const struct svc_r=
qst *rqstp);
> > > > >  * processed.
> > > > >  */
> > > > > struct svc_rqst {
> > > > > - struct list_head rq_all; /* all threads list */
> > > > > struct rcu_head rq_rcu_head; /* for RCU deferred kfree */
> > > > > struct svc_xprt * rq_xprt; /* transport ptr */
> > > > >=20
> > > > > @@ -241,10 +240,10 @@ struct svc_rqst {
> > > > > #define RQ_SPLICE_OK (4) /* turned off in gss privacy
> > > > > * to prevent encrypting page
> > > > > * cache pages */
> > > > > -#define RQ_VICTIM (5) /* about to be shut down */
> > > > > -#define RQ_BUSY (6) /* request is busy */
> > > > > -#define RQ_DATA (7) /* request has data */
> > > > > +#define RQ_BUSY (5) /* request is busy */
> > > > > +#define RQ_DATA (6) /* request has data */
> > > > > unsigned long rq_flags; /* flags field */
> > > > > + u32 rq_thread_id; /* xarray index */
> > > > > ktime_t rq_qtime; /* enqueue time */
> > > > >=20
> > > > > void * rq_argp; /* decoded arguments */
> > > > > diff --git a/include/trace/events/sunrpc.h b/include/trace/events=
/sunrpc.h
> > > > > index 60c8e03268d4..ea43c6059bdb 100644
> > > > > --- a/include/trace/events/sunrpc.h
> > > > > +++ b/include/trace/events/sunrpc.h
> > > > > @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
> > > > > svc_rqst_flag(USEDEFERRAL) \
> > > > > svc_rqst_flag(DROPME) \
> > > > > svc_rqst_flag(SPLICE_OK) \
> > > > > - svc_rqst_flag(VICTIM) \
> > > > > svc_rqst_flag(BUSY) \
> > > > > svc_rqst_flag_end(DATA)
> > > > >=20
> > > > > @@ -2118,6 +2117,52 @@ TRACE_EVENT(svc_pool_starved,
> > > > > )
> > > > > );
> > > > >=20
> > > > > +DECLARE_EVENT_CLASS(svc_thread_lifetime_class,
> > > > > + TP_PROTO(
> > > > > + const struct svc_serv *serv,
> > > > > + const struct svc_pool *pool,
> > > > > + const struct svc_rqst *rqstp
> > > > > + ),
> > > > > +
> > > > > + TP_ARGS(serv, pool, rqstp),
> > > > > +
> > > > > + TP_STRUCT__entry(
> > > > > + __string(name, serv->sv_name)
> > > > > + __field(int, pool_id)
> > > > > + __field(unsigned int, nrthreads)
> > > > > + __field(unsigned long, pool_flags)
> > > > > + __field(u32, thread_id)
> > > > > + __field(const void *, rqstp)
> > > > > + ),
> > > > > +
> > > > > + TP_fast_assign(
> > > > > + __assign_str(name, serv->sv_name);
> > > > > + __entry->pool_id =3D pool->sp_id;
> > > > > + __entry->nrthreads =3D pool->sp_nrthreads;
> > > > > + __entry->pool_flags =3D pool->sp_flags;
> > > > > + __entry->thread_id =3D rqstp->rq_thread_id;
> > > > > + __entry->rqstp =3D rqstp;
> > > > > + ),
> > > > > +
> > > > > + TP_printk("service=3D%s pool=3D%d pool_flags=3D%s nrthreads=3D%=
u thread_id=3D%u",
> > > > > + __get_str(name), __entry->pool_id,
> > > > > + show_svc_pool_flags(__entry->pool_flags),
> > > > > + __entry->nrthreads, __entry->thread_id
> > > > > + )
> > > > > +);
> > > > > +
> > > > > +#define DEFINE_SVC_THREAD_LIFETIME_EVENT(name) \
> > > > > + DEFINE_EVENT(svc_thread_lifetime_class, svc_pool_##name, \
> > > > > + TP_PROTO( \
> > > > > + const struct svc_serv *serv, \
> > > > > + const struct svc_pool *pool, \
> > > > > + const struct svc_rqst *rqstp \
> > > > > + ), \
> > > > > + TP_ARGS(serv, pool, rqstp))
> > > > > +
> > > > > +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_init);
> > > > > +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_exit);
> > > > > +
> > > > > DECLARE_EVENT_CLASS(svc_xprt_event,
> > > > > TP_PROTO(
> > > > > const struct svc_xprt *xprt
> > > > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > > > index ad29df00b454..109d7f047385 100644
> > > > > --- a/net/sunrpc/svc.c
> > > > > +++ b/net/sunrpc/svc.c
> > > > > @@ -507,8 +507,8 @@ __svc_create(struct svc_program *prog, unsign=
ed int bufsize, int npools,
> > > > >=20
> > > > > pool->sp_id =3D i;
> > > > > INIT_LIST_HEAD(&pool->sp_sockets);
> > > > > - INIT_LIST_HEAD(&pool->sp_all_threads);
> > > > > spin_lock_init(&pool->sp_lock);
> > > > > + xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
> > > > >=20
> > > > > percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> > > > > percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> > > > > @@ -596,6 +596,8 @@ svc_destroy(struct kref *ref)
> > > > > percpu_counter_destroy(&pool->sp_threads_timedout);
> > > > > percpu_counter_destroy(&pool->sp_threads_starved);
> > > > > percpu_counter_destroy(&pool->sp_threads_no_work);
> > > > > +
> > > > > + xa_destroy(&pool->sp_thread_xa);
> > > > > }
> > > > > kfree(serv->sv_pools);
> > > > > kfree(serv);
> > > > > @@ -676,7 +678,11 @@ EXPORT_SYMBOL_GPL(svc_rqst_alloc);
> > > > > static struct svc_rqst *
> > > > > svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, =
int node)
> > > > > {
> > > > > + struct xa_limit limit =3D {
> > > > > + .max =3D U32_MAX,
> > > > > + };
> > > > > struct svc_rqst *rqstp;
> > > > > + int ret;
> > > > >=20
> > > > > rqstp =3D svc_rqst_alloc(serv, pool, node);
> > > > > if (!rqstp)
> > > > > @@ -687,11 +693,21 @@ svc_prepare_thread(struct svc_serv *serv, s=
truct svc_pool *pool, int node)
> > > > > serv->sv_nrthreads +=3D 1;
> > > > > spin_unlock_bh(&serv->sv_lock);
> > > > >=20
> > > > > - spin_lock_bh(&pool->sp_lock);
> > > > > + xa_lock(&pool->sp_thread_xa);
> > > > > + ret =3D __xa_alloc(&pool->sp_thread_xa, &rqstp->rq_thread_id, r=
qstp,
> > > > > + limit, GFP_KERNEL);
> > > > > + if (ret) {
> > > > > + xa_unlock(&pool->sp_thread_xa);
> > > > > + goto out_free;
> > > > > + }
> > > > > pool->sp_nrthreads++;
> > > > > - list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
> > > > > - spin_unlock_bh(&pool->sp_lock);
> > > > > + xa_unlock(&pool->sp_thread_xa);
> > > > > + trace_svc_pool_thread_init(serv, pool, rqstp);
> > > > > return rqstp;
> > > > > +
> > > > > +out_free:
> > > > > + svc_rqst_free(rqstp);
> > > > > + return ERR_PTR(ret);
> > > > > }
> > > > >=20
> > > > > /**
> > > > > @@ -708,19 +724,17 @@ struct svc_rqst *svc_pool_wake_idle_thread(=
struct svc_serv *serv,
> > > > >   struct svc_pool *pool)
> > > > > {
> > > > > struct svc_rqst *rqstp;
> > > > > + unsigned long index;
> > > > >=20
> > > > > - rcu_read_lock();
> > > >=20
> > > >=20
> > > > While it does do its own locking, the resulting object that xa_for_=
each
> > > > returns needs some protection too. Between xa_for_each returning a =
rqstp
> > > > and calling test_and_set_bit, could the rqstp be freed? I suspect s=
o,
> > > > and I think you probably need to keep the rcu_read_lock() call abov=
e.
> > >=20
> > > Should I keep the rcu_read_lock() even with the bitmap/xa_load
> > > version of svc_pool_wake_idle_thread() in 9/9 ?
> > >=20
> >=20
> > Yeah, I think you have to. We're not doing real locking on the search o=
r
> > taking references, so nothing else will ensure that the rqstp will stic=
k
> > around once you've found it. I think you have to hold it until after
> > wake_up_process (at least).
>=20
> I can keep the RCU read lock around the search and xa_load(). But
> I notice that the code we're replacing releases the RCU read lock
> before calling wake_up_process(). Not saying that's right, but we
> haven't had a problem reported.
>=20
>=20

Understood. Given that we're not sleeping in that section, it's quite
possible that the RCU callbacks just never have a chance to run before
we wake the thing up and so you never hit the problem.

Still, I think it'd be best to just keep the rcu_read_lock around that
whole block. It's relatively cheap and safe to take it recursively, and
that makes it explicit that the found rqst mustn't vanish before the
wakeup is done.

> > > > > - list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
> > > > > + xa_for_each(&pool->sp_thread_xa, index, rqstp) {
> > > > > if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> > > > > continue;
> > > > >=20
> > > > > - rcu_read_unlock();
> > > > > WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> > > > > wake_up_process(rqstp->rq_task);
> > > > > percpu_counter_inc(&pool->sp_threads_woken);
> > > > > return rqstp;
> > > > > }
> > > > > - rcu_read_unlock();
> > > > >=20
> > > >=20
> > > > I wonder if this can race with svc_pool_victim below? Can we end up
> > > > waking a thread that's already on its way out of the pool? Maybe th=
is is
> > > > addressed in your next patch though...
> > > >=20
> > > > > trace_svc_pool_starved(serv, pool);
> > > > > percpu_counter_inc(&pool->sp_threads_starved);
> > > > > @@ -736,32 +750,33 @@ svc_pool_next(struct svc_serv *serv, struct=
 svc_pool *pool, unsigned int *state)
> > > > > static struct task_struct *
> > > > > svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, uns=
igned int *state)
> > > > > {
> > > > > - unsigned int i;
> > > > > struct task_struct *task =3D NULL;
> > > > > + struct svc_rqst *rqstp;
> > > > > + unsigned int i;
> > > > >=20
> > > > > if (pool !=3D NULL) {
> > > > > - spin_lock_bh(&pool->sp_lock);
> > > > > + xa_lock(&pool->sp_thread_xa);
> > > > > + if (!pool->sp_nrthreads)
> > > > > + goto out;
> > > > > } else {
> > > > > for (i =3D 0; i < serv->sv_nrpools; i++) {
> > > > > pool =3D &serv->sv_pools[--(*state) % serv->sv_nrpools];
> > > > > - spin_lock_bh(&pool->sp_lock);
> > > > > - if (!list_empty(&pool->sp_all_threads))
> > > > > + xa_lock(&pool->sp_thread_xa);
> > > > > + if (pool->sp_nrthreads)
> > > > > goto found_pool;
> > > > > - spin_unlock_bh(&pool->sp_lock);
> > > > > + xa_unlock(&pool->sp_thread_xa);
> > > > > }
> > > > > return NULL;
> > > > > }
> > > > >=20
> > > > > found_pool:
> > > > > - if (!list_empty(&pool->sp_all_threads)) {
> > > > > - struct svc_rqst *rqstp;
> > > > > -
> > > > > - rqstp =3D list_entry(pool->sp_all_threads.next, struct svc_rqst=
, rq_all);
> > > > > - set_bit(RQ_VICTIM, &rqstp->rq_flags);
> > > > > - list_del_rcu(&rqstp->rq_all);
> > > > > + rqstp =3D xa_load(&pool->sp_thread_xa, pool->sp_nrthreads - 1);
> > > > > + if (rqstp) {
> > > > > + __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
> > > > > task =3D rqstp->rq_task;
> > > > > }
> > > > > - spin_unlock_bh(&pool->sp_lock);
> > > > > +out:
> > > > > + xa_unlock(&pool->sp_thread_xa);
> > > > > return task;
> > > > > }
> > > > >=20
> > > > > @@ -843,9 +858,9 @@ svc_set_num_threads(struct svc_serv *serv, st=
ruct svc_pool *pool, int nrservs)
> > > > > if (pool =3D=3D NULL) {
> > > > > nrservs -=3D serv->sv_nrthreads;
> > > > > } else {
> > > > > - spin_lock_bh(&pool->sp_lock);
> > > > > + xa_lock(&pool->sp_thread_xa);
> > > > > nrservs -=3D pool->sp_nrthreads;
> > > > > - spin_unlock_bh(&pool->sp_lock);
> > > > > + xa_unlock(&pool->sp_thread_xa);
> > > > > }
> > > > >=20
> > > > > if (nrservs > 0)
> > > > > @@ -932,11 +947,11 @@ svc_exit_thread(struct svc_rqst *rqstp)
> > > > > struct svc_serv *serv =3D rqstp->rq_server;
> > > > > struct svc_pool *pool =3D rqstp->rq_pool;
> > > > >=20
> > > > > - spin_lock_bh(&pool->sp_lock);
> > > > > + xa_lock(&pool->sp_thread_xa);
> > > > > pool->sp_nrthreads--;
> > > > > - if (!test_and_set_bit(RQ_VICTIM, &rqstp->rq_flags))
> > > > > - list_del_rcu(&rqstp->rq_all);
> > > > > - spin_unlock_bh(&pool->sp_lock);
> > > > > + __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
> > > > > + xa_unlock(&pool->sp_thread_xa);
> > > > > + trace_svc_pool_thread_exit(serv, pool, rqstp);
> > > > >=20
> > > > > spin_lock_bh(&serv->sv_lock);
> > > > > serv->sv_nrthreads -=3D 1;
> > > > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > > > index 6c2a702aa469..db40f771b60a 100644
> > > > > --- a/net/sunrpc/svc_xprt.c
> > > > > +++ b/net/sunrpc/svc_xprt.c
> > > > > @@ -46,7 +46,7 @@ static LIST_HEAD(svc_xprt_class_list);
> > > > >=20
> > > > > /* SMP locking strategy:
> > > > >  *
> > > > > - * svc_pool->sp_lock protects most of the fields of that pool.
> > > > > + * svc_pool->sp_lock protects sp_sockets.
> > > > >  * svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpc=
nt.
> > > > >  * when both need to be taken (rare), svc_serv->sv_lock is first.
> > > > >  * The "service mutex" protects svc_serv->sv_nrthread.
> > > > >=20
> > > > >=20
> > > >=20
> > > > Looks like a nice clean conversion otherwise!
> > > > --=20
> > > > Jeff Layton <jlayton@kernel.org>
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>
