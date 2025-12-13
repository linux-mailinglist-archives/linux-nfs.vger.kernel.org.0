Return-Path: <linux-nfs+bounces-17082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01266CBB42F
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 22:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD26B3005298
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 21:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895CA30AABE;
	Sat, 13 Dec 2025 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiSxEMtS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2311EB5F8;
	Sat, 13 Dec 2025 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765662242; cv=none; b=lwj44JjOuCj6IR8ynkWm50lIQ5lhc52YpPf/qcTN27eAU2i+QLgUJa5XQpSqeT5OLPrbmOB0NgKUPbg5LUXbbVFkyQdUsaKo9U6+wGx1pSvWZ1M4l68BhgL9uFD/1oJE4n9pemQ8196BjrdbIBnP9L1mJ0/ZiC1WoEpJAxx3anc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765662242; c=relaxed/simple;
	bh=S89q/3uXSIJOQ+FafMNoaojOpoqdAdMWlRtM3df+vMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOpsoPjRLCL1qXxcPBXGfY/kii/f4nGseEd6oCprTvwUXiDeHNgYPYx5KIfnWme2gbMfen4pBKrQnfEnWmm50ZpQf13hKEvlOejwIJOGumiqaQyvWBgC4DMyJjsbp6eWlFokkqEpRmHILYkZ8fB8pyD+qPzWb0N+QCJw0FDzV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiSxEMtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6A2C4CEF7;
	Sat, 13 Dec 2025 21:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765662241;
	bh=S89q/3uXSIJOQ+FafMNoaojOpoqdAdMWlRtM3df+vMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QiSxEMtS1dDBM5bjz15DiPV1oPmpq+prKDVPZKWMGIGoM90LsoytGMKLrzfvehICb
	 +LgFXSp/LYYOqTemXUjprPLqtTcUTruY7ghTWLuXChTV6uUZ5kSUd06A1Jqs12It5Y
	 vaF2Judlvcroatb20ntOkI1jPvw+rhKOv5jUg/tRXX4dgjqTaKqqcVXOuz7oL1DmE1
	 6LHtbupYV7udq1RX5G6AO/zZvxTX6ShJtjZTOZh/0kzsNvgHcGL9Ez7S294ReiLp9c
	 wHfYSi8odmfTcuMP+bYtxcDa2ddO5jmmdgcgHTUL36CmCoxODezN83sEtmQWpoy4ol
	 Ows4X5krdzSEQ==
Message-ID: <c3b8dddebecbcc5ed56c9ebcf578cd4a52ba6b77.camel@kernel.org>
Subject: Re: [PATCH RFC 5/6] nfsd: adjust number of running nfsd threads
 based on activity
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 14 Dec 2025 06:43:57 +0900
In-Reply-To: <ede9496b-aaa8-41a9-8657-3a1f3cf4a9aa@app.fastmail.com>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
	 <20251213-nfsd-dynathread-v1-5-de755e59cbc4@kernel.org>
	 <ede9496b-aaa8-41a9-8657-3a1f3cf4a9aa@app.fastmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-13 at 15:54 -0500, Chuck Lever wrote:
>=20
> On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> > This patch is based on a draft patch by Neil:
> >=20
> > svc_recv() is changed to return a status.  This can be:
> >=20
> >  -ETIMEDOUT - waited for 5 seconds and found nothing to do.  This is
> >           boring.  Also there are more actual threads than really
> >           needed.
> >  -EBUSY - I did something, but there is more stuff to do and no one
> >           idle who I can wake up to do it.
> >           BTW I successful set a flag: SP_TASK_STARTING.  You better
> >           clear it.
> >  0 - just minding my own business, nothing to see here.
> >=20
> > nfsd() is changed to pay attention to this status.  In the case of
> > -ETIMEDOUT, if the service mutex can be taken (trylock), the thread
> > becomes and RQ_VICTIM so that it will exit.  In the case of -EBUSY, if
> > the actual number of threads is below the calculated maximum, a new
> > thread is started.  SP_TASK_STARTING is cleared.
>=20
> Jeff, since you reworked things to be based on a minimum rather
> than a maximum count, is this paragraph now stale?
>=20
>=20

Yes, it is. Will fix.

> > To support the above, some code is split out of svc_start_kthreads()
> > into svc_new_thread().
> >=20
> > I think we want memory pressure to be able to push a thread into
> > returning -ETIMEDOUT.  That can come later.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfssvc.c               | 35 ++++++++++++++++++++-
> >  fs/nfsd/trace.h                | 35 +++++++++++++++++++++
> >  include/linux/sunrpc/svc.h     |  2 ++
> >  include/linux/sunrpc/svcsock.h |  2 +-
> >  net/sunrpc/svc.c               | 69 ++++++++++++++++++++++++----------=
--------
> >  net/sunrpc/svc_xprt.c          | 45 ++++++++++++++++++++++-----
> >  6 files changed, 148 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index=20
> > 993ed338764b0ccd7bdfb76bd6fbb5dc6ab4022d..26c3a6cb1f400f1b757d26f6ba77e=
27deb7e8ee2=20
> > 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -896,9 +896,11 @@ static int
> >  nfsd(void *vrqstp)
> >  {
> >  	struct svc_rqst *rqstp =3D (struct svc_rqst *) vrqstp;
> > +	struct svc_pool *pool =3D rqstp->rq_pool;
> >  	struct svc_xprt *perm_sock =3D=20
> > list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct=20
> > svc_xprt), xpt_list);
> >  	struct net *net =3D perm_sock->xpt_net;
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	bool have_mutex =3D false;
> >=20
> >  	/* At this point, the thread shares current->fs
> >  	 * with the init process. We need to create files with the
> > @@ -916,7 +918,36 @@ nfsd(void *vrqstp)
> >  	 * The main request loop
> >  	 */
> >  	while (!svc_thread_should_stop(rqstp)) {
> > -		svc_recv(rqstp);
> > +		switch (svc_recv(rqstp)) {
> > +		case -ETIMEDOUT: /* Nothing to do */
> > +			if (mutex_trylock(&nfsd_mutex)) {
> > +				if (pool->sp_nrthreads > pool->sp_nrthrmin) {
> > +					trace_nfsd_dynthread_kill(net, pool);
> > +					set_bit(RQ_VICTIM, &rqstp->rq_flags);
> > +					have_mutex =3D true;
> > +				} else
> > +					mutex_unlock(&nfsd_mutex);
> > +			} else {
> > +				trace_nfsd_dynthread_trylock_fail(net, pool);
> > +			}
> > +			break;
> > +		case -EBUSY: /* Too much to do */
> > +			if (pool->sp_nrthreads < pool->sp_nrthrmax &&
> > +			    mutex_trylock(&nfsd_mutex)) {
> > +				// check no idle threads?
>=20
> Can this comment be clarified? It looks like a note-to-self, that maybe
> something is unfinished.
>=20

That's leftover from Neil's original patch. I'm not sure what his
thinking was there. I'll plan to remove it.

>=20
> > +				if (pool->sp_nrthreads < pool->sp_nrthrmax) {
> > +					trace_nfsd_dynthread_start(net, pool);
> > +					svc_new_thread(rqstp->rq_server, pool);
> > +				}
> > +				mutex_unlock(&nfsd_mutex);
> > +			} else {
> > +				trace_nfsd_dynthread_trylock_fail(net, pool);
> > +			}
> > +			clear_bit(SP_TASK_STARTING, &pool->sp_flags);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> >  		nfsd_file_net_dispose(nn);
> >  	}
> >=20
> > @@ -924,6 +955,8 @@ nfsd(void *vrqstp)
> >=20
> >  	/* Release the thread */
> >  	svc_exit_thread(rqstp);
> > +	if (have_mutex)
> > +		mutex_unlock(&nfsd_mutex);
> >  	return 0;
> >  }
> >=20
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index=20
> > 5ae2a611e57f4b4e51a4d9eb6e0fccb66ad8d288..8885fd9bead98ebf55379d68ab9c3=
701981a5150=20
> > 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -91,6 +91,41 @@ DEFINE_EVENT(nfsd_xdr_err_class, nfsd_##name##_err, =
\
> >  DEFINE_NFSD_XDR_ERR_EVENT(garbage_args);
> >  DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> >=20
> > +DECLARE_EVENT_CLASS(nfsd_dynthread_class,
> > +	TP_PROTO(
> > +		const struct net *net,
> > +		const struct svc_pool *pool
> > +	),
> > +	TP_ARGS(net, pool),
> > +	TP_STRUCT__entry(
> > +		__field(unsigned int, netns_ino)
> > +		__field(unsigned int, pool_id)
> > +		__field(unsigned int, nrthreads)
> > +		__field(unsigned int, nrthrmin)
> > +		__field(unsigned int, nrthrmax)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->netns_ino =3D net->ns.inum;
> > +		__entry->pool_id =3D pool->sp_id;
> > +		__entry->nrthreads =3D pool->sp_nrthreads;
> > +		__entry->nrthrmin =3D pool->sp_nrthrmin;
> > +		__entry->nrthrmax =3D pool->sp_nrthrmax;
> > +	),
> > +	TP_printk("pool=3D%u nrthreads=3D%u nrthrmin=3D%u nrthrmax=3D%u",
> > +		__entry->pool_id, __entry->nrthreads,
> > +		__entry->nrthrmin, __entry->nrthrmax
> > +	)
> > +);
> > +
> > +#define DEFINE_NFSD_DYNTHREAD_EVENT(name) \
> > +DEFINE_EVENT(nfsd_dynthread_class, nfsd_dynthread_##name, \
> > +	TP_PROTO(const struct net *net, const struct svc_pool *pool), \
> > +	TP_ARGS(net, pool))
> > +
> > +DEFINE_NFSD_DYNTHREAD_EVENT(start);
> > +DEFINE_NFSD_DYNTHREAD_EVENT(kill);
> > +DEFINE_NFSD_DYNTHREAD_EVENT(trylock_fail);
> > +
> >  #define show_nfsd_may_flags(x)						\
> >  	__print_flags(x, "|",						\
> >  		{ NFSD_MAY_EXEC,		"EXEC" },		\
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index=20
> > 35bd3247764ae8dc5dcdfffeea36f7cfefd13372..f47e19c9bd9466986438766e9ab7b=
4c71cda1ba6=20
> > 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -55,6 +55,7 @@ enum {
> >  	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
> >  	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
> >  	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
> > +	SP_TASK_STARTING,	/* Task has started but not added to idle yet */
> >  };
> >=20
> >=20
> > @@ -442,6 +443,7 @@ struct svc_serv *svc_create(struct svc_program *,=
=20
> > unsigned int,
> >  bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> >  					 struct page *page);
> >  void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
> > +int		   svc_new_thread(struct svc_serv *serv, struct svc_pool *pool);
> >  void		   svc_exit_thread(struct svc_rqst *);
> >  struct svc_serv *  svc_create_pooled(struct svc_program *prog,
> >  				     unsigned int nprog,
> > diff --git a/include/linux/sunrpc/svcsock.h=20
> > b/include/linux/sunrpc/svcsock.h
> > index=20
> > de37069aba90899be19b1090e6e90e509a3cf530..5c87d3fedd33e7edf5ade32e60523=
cae7e9ebaba=20
> > 100644
> > --- a/include/linux/sunrpc/svcsock.h
> > +++ b/include/linux/sunrpc/svcsock.h
> > @@ -61,7 +61,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock=
=20
> > *svsk)
> >  /*
> >   * Function prototypes.
> >   */
> > -void		svc_recv(struct svc_rqst *rqstp);
> > +int		svc_recv(struct svc_rqst *rqstp);
> >  void		svc_send(struct svc_rqst *rqstp);
> >  int		svc_addsock(struct svc_serv *serv, struct net *net,
> >  			    const int fd, char *name_return, const size_t len,
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index=20
> > dc818158f8529b62dcf96c91bd9a9d4ab21df91f..9fca2dd340037f82baa4936766ebe=
0e38c3f0d85=20
> > 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -714,9 +714,6 @@ svc_prepare_thread(struct svc_serv *serv, struct=
=20
> > svc_pool *pool, int node)
> >=20
> >  	rqstp->rq_err =3D -EAGAIN; /* No error yet */
> >=20
> > -	serv->sv_nrthreads +=3D 1;
> > -	pool->sp_nrthreads +=3D 1;
> > -
> >  	/* Protected by whatever lock the service uses when calling
> >  	 * svc_set_num_threads()
> >  	 */
> > @@ -763,45 +760,57 @@ void svc_pool_wake_idle_thread(struct svc_pool *p=
ool)
> >  }
> >  EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
> >=20
> > -static int
> > -svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int n=
rservs)
> > +int svc_new_thread(struct svc_serv *serv, struct svc_pool *pool)
>=20
> Is now an exported function, should get a kdoc comment.
>=20

ACK.

>=20
> >  {
> >  	struct svc_rqst	*rqstp;
> >  	struct task_struct *task;
> >  	int node;
> >  	int err;
> >=20
> > -	do {
> > -		nrservs--;
> > -		node =3D svc_pool_map_get_node(pool->sp_id);
> > -
> > -		rqstp =3D svc_prepare_thread(serv, pool, node);
> > -		if (!rqstp)
> > -			return -ENOMEM;
> > -		task =3D kthread_create_on_node(serv->sv_threadfn, rqstp,
> > -					      node, "%s", serv->sv_name);
> > -		if (IS_ERR(task)) {
> > -			svc_exit_thread(rqstp);
> > -			return PTR_ERR(task);
> > -		}
> > +	node =3D svc_pool_map_get_node(pool->sp_id);
> >=20
> > -		rqstp->rq_task =3D task;
> > -		if (serv->sv_nrpools > 1)
> > -			svc_pool_map_set_cpumask(task, pool->sp_id);
> > +	rqstp =3D svc_prepare_thread(serv, pool, node);
> > +	if (!rqstp)
> > +		return -ENOMEM;
> > +	set_bit(SP_TASK_STARTING, &pool->sp_flags);
> > +	task =3D kthread_create_on_node(serv->sv_threadfn, rqstp,
> > +				      node, "%s", serv->sv_name);
> > +	if (IS_ERR(task)) {
> > +		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
> > +		svc_exit_thread(rqstp);
>=20
> svc_exit_thread() decrements serv->sv_nrthreads and pool->sp_nrthreads
> but this call site hasn't incremented them yet. Perhaps this error
> flow needs a simpler clean-up than calling svc_exit_thread().
>=20

ACK. I'll give that a harder look.

>=20
> > +		return PTR_ERR(task);
> > +	}
> >=20
> > -		svc_sock_update_bufs(serv);
> > -		wake_up_process(task);
> > +	serv->sv_nrthreads +=3D 1;
> > +	pool->sp_nrthreads +=3D 1;
> >=20
> > -		wait_var_event(&rqstp->rq_err, rqstp->rq_err !=3D -EAGAIN);
> > -		err =3D rqstp->rq_err;
> > -		if (err) {
> > -			svc_exit_thread(rqstp);
> > -			return err;
> > -		}
> > -	} while (nrservs > 0);
> > +	rqstp->rq_task =3D task;
> > +	if (serv->sv_nrpools > 1)
> > +		svc_pool_map_set_cpumask(task, pool->sp_id);
> >=20
> > +	svc_sock_update_bufs(serv);
> > +	wake_up_process(task);
> > +
> > +	wait_var_event(&rqstp->rq_err, rqstp->rq_err !=3D -EAGAIN);
> > +	err =3D rqstp->rq_err;
> > +	if (err) {
> > +		svc_exit_thread(rqstp);
> > +		return err;
> > +	}
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(svc_new_thread);
> > +
> > +static int
> > +svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int n=
rservs)
> > +{
> > +	int err =3D 0;
> > +
> > +	while (!err && nrservs--)
> > +		err =3D svc_new_thread(serv, pool);
> > +
> > +	return err;
> > +}
> >=20
> >  static int
> >  svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int=
=20
> > nrservs)
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index=20
> > 6973184ff6675211b4338fac80105894e9c8d4df..9612334300c8dae38720a0f5c61c0=
f505432ec2f=20
> > 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -714,15 +714,22 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
> >  	return true;
> >  }
> >=20
> > -static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
> > +static bool nfsd_schedule_timeout(long timeout)
>=20
> Perhaps svc_schedule_timeout() is a more appropriate name for
> a function that resides in net/sunrpc/svc_xprt.c.
>=20

Sounds good.

>=20
> > +{
> > +	return schedule_timeout(timeout) =3D=3D 0;
> > +}
> > +
> > +static bool svc_thread_wait_for_work(struct svc_rqst *rqstp)
> >  {
> >  	struct svc_pool *pool =3D rqstp->rq_pool;
> > +	bool did_timeout =3D false;
> >=20
> >  	if (svc_thread_should_sleep(rqstp)) {
> >  		set_current_state(TASK_IDLE | TASK_FREEZABLE);
> >  		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> > +		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
> >  		if (likely(svc_thread_should_sleep(rqstp)))
> > -			schedule();
> > +			did_timeout =3D nfsd_schedule_timeout(5 * HZ);
> >=20
> >  		while (!llist_del_first_this(&pool->sp_idle_threads,
> >  					     &rqstp->rq_idle)) {
> > @@ -734,7 +741,10 @@ static void svc_thread_wait_for_work(struct=20
> > svc_rqst *rqstp)
> >  			 * for this new work.  This thread can safely sleep
> >  			 * until woken again.
> >  			 */
> > -			schedule();
> > +			if (did_timeout)
> > +				did_timeout =3D nfsd_schedule_timeout(HZ);
> > +			else
> > +				did_timeout =3D nfsd_schedule_timeout(5 * HZ);
> >  			set_current_state(TASK_IDLE | TASK_FREEZABLE);
> >  		}
> >  		__set_current_state(TASK_RUNNING);
> > @@ -742,6 +752,7 @@ static void svc_thread_wait_for_work(struct=20
> > svc_rqst *rqstp)
> >  		cond_resched();
> >  	}
> >  	try_to_freeze();
> > +	return did_timeout;
> >  }
> >=20
> >  static void svc_add_new_temp_xprt(struct svc_serv *serv, struct=20
> > svc_xprt *newxpt)
> > @@ -825,6 +836,8 @@ static void svc_handle_xprt(struct svc_rqst *rqstp,=
=20
> > struct svc_xprt *xprt)
> >=20
> >  static void svc_thread_wake_next(struct svc_rqst *rqstp)
> >  {
> > +	clear_bit(SP_TASK_STARTING, &rqstp->rq_pool->sp_flags);
> > +
> >  	if (!svc_thread_should_sleep(rqstp))
> >  		/* More work pending after I dequeued some,
> >  		 * wake another worker
> > @@ -839,21 +852,31 @@ static void svc_thread_wake_next(struct svc_rqst =
*rqstp)
> >   * This code is carefully organised not to touch any cachelines in
> >   * the shared svc_serv structure, only cachelines in the local
> >   * svc_pool.
> > + *
> > + * Returns -ETIMEDOUT if idle for an extended period
> > + *         -EBUSY is there is more work to do than available threads
> > + *         0 otherwise.
> >   */
> > -void svc_recv(struct svc_rqst *rqstp)
> > +int svc_recv(struct svc_rqst *rqstp)
> >  {
> >  	struct svc_pool *pool =3D rqstp->rq_pool;
> > +	bool did_wait;
> > +	int ret =3D 0;
> >=20
> >  	if (!svc_alloc_arg(rqstp))
> > -		return;
> > +		return ret;
> > +
> > +	did_wait =3D svc_thread_wait_for_work(rqstp);
> >=20
> > -	svc_thread_wait_for_work(rqstp);
> > +	if (did_wait && svc_thread_should_sleep(rqstp) &&
> > +	    pool->sp_nrthrmin && (pool->sp_nrthreads > pool->sp_nrthrmin))
> > +		ret =3D -ETIMEDOUT;
> >=20
> >  	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> >=20
> >  	if (svc_thread_should_stop(rqstp)) {
> >  		svc_thread_wake_next(rqstp);
> > -		return;
> > +		return ret;
> >  	}
> >=20
> >  	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
> > @@ -867,8 +890,13 @@ void svc_recv(struct svc_rqst *rqstp)
> >  		 */
> >  		if (pool->sp_idle_threads.first)
> >  			rqstp->rq_chandle.thread_wait =3D 5 * HZ;
> > -		else
> > +		else {
> >  			rqstp->rq_chandle.thread_wait =3D 1 * HZ;
> > +			if (!did_wait &&
> > +			    !test_and_set_bit(SP_TASK_STARTING,
> > +					      &pool->sp_flags))
> > +				ret =3D -EBUSY;
> > +		}
> >=20
> >  		trace_svc_xprt_dequeue(rqstp);
> >  		svc_handle_xprt(rqstp, xprt);
> > @@ -887,6 +915,7 @@ void svc_recv(struct svc_rqst *rqstp)
> >  		}
> >  	}
> >  #endif
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(svc_recv);
> >=20
> >=20
> > --=20
> > 2.52.0
>=20
> The extensive use of atomic bit ops here is a little worrying.
> Those can be costly -- and the sp_flags field is going to get
> poked at by more and more threads as the pool's thread count
> increases.
>=20

The current way that threading works is dependent on this today. We
could consider a spinlock and a non-atomic bitops, but that might be
even worse. I'll have to think about that.

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>

