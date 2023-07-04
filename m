Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25467466DE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 03:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGDB0b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 21:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGDB0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 21:26:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDB8186
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 18:26:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0867B2209E;
        Tue,  4 Jul 2023 01:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688433988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tF9IpNK42c94om+iDV0HYlDhsMN9YdpPaXvqL4M21Ro=;
        b=0u7nd2Uo75JOOgjdrufctBKyV+wSe8s2A4WFwzAZ6T+BO3IhIKcYjtW+9uk3qKZmxOS2wJ
        PGV9rOfJEJUBS3/X5l6zck0RCrNywFc2fguQGbhQ9ePLMLq4L+bUdqKzqGf4qZi1zzRno5
        KQE6hVDafBmQkiXxqhko8tH1O7MXlhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688433988;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tF9IpNK42c94om+iDV0HYlDhsMN9YdpPaXvqL4M21Ro=;
        b=ufAe15mwXqdNL80vZawMZkq2AcLQ+qDKp4gx8Ld/alYzLN3dmxi3E/su8gYSIHthj75ogO
        9PQBGUBBD3vRcyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C98E113276;
        Tue,  4 Jul 2023 01:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cgamHkF1o2SpfAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Jul 2023 01:26:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
In-reply-to: <168842930872.139194.10164846167275218299.stgit@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842930872.139194.10164846167275218299.stgit@manet.1015granger.net>
Date:   Tue, 04 Jul 2023 11:26:22 +1000
Message-id: <168843398253.8939.16982425023664424215@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 04 Jul 2023, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> I've noticed that client-observed server request latency goes up
> simply when the nfsd thread count is increased.
>=20
> List walking is known to be memory-inefficient. On a busy server
> with many threads, enqueuing a transport will walk the "all threads"
> list quite frequently. This also pulls in the cache lines for some
> hot fields in each svc_rqst (namely, rq_flags).

I think this text could usefully be re-written.  By this point in the
series we aren't list walking.

I'd also be curious to know what latency different you get for just this
change.

>=20
> The svc_xprt_enqueue() call that concerns me most is the one in
> svc_rdma_wc_receive(), which is single-threaded per CQ. Slowing
> down completion handling limits the total throughput per RDMA
> connection.
>=20
> So, avoid walking the "all threads" list to find an idle thread to
> wake. Instead, set up an idle bitmap and use find_next_bit, which
> should work the same way as RQ_BUSY but it will touch only the
> cachelines that the bitmap is in. Stick with atomic bit operations
> to avoid taking the pool lock.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h    |    6 ++++--
>  include/trace/events/sunrpc.h |    1 -
>  net/sunrpc/svc.c              |   27 +++++++++++++++++++++------
>  net/sunrpc/svc_xprt.c         |   30 ++++++++++++++++++++++++------
>  4 files changed, 49 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 6f8bfcd44250..27ffcf7371d0 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -35,6 +35,7 @@ struct svc_pool {
>  	spinlock_t		sp_lock;	/* protects sp_sockets */
>  	struct list_head	sp_sockets;	/* pending sockets */
>  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> +	unsigned long		*sp_idle_map;	/* idle threads */
>  	struct xarray		sp_thread_xa;
> =20
>  	/* statistics on pool operation */
> @@ -190,6 +191,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp=
);
>  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
>  				+ 2 + 1)
> =20
> +#define RPCSVC_MAXPOOLTHREADS	(4096)
> +
>  /*
>   * The context of a single thread, including the request currently being
>   * processed.
> @@ -239,8 +242,7 @@ struct svc_rqst {
>  #define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
>  						 * to prevent encrypting page
>  						 * cache pages */
> -#define	RQ_BUSY		(5)			/* request is busy */
> -#define	RQ_DATA		(6)			/* request has data */
> +#define	RQ_DATA		(5)			/* request has data */

Might this be a good opportunity to convert this to an enum ??

>  	unsigned long		rq_flags;	/* flags field */
>  	u32			rq_thread_id;	/* xarray index */
>  	ktime_t			rq_qtime;	/* enqueue time */
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index ea43c6059bdb..c07824a254bf 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
>  	svc_rqst_flag(USEDEFERRAL)					\
>  	svc_rqst_flag(DROPME)						\
>  	svc_rqst_flag(SPLICE_OK)					\
> -	svc_rqst_flag(BUSY)						\
>  	svc_rqst_flag_end(DATA)
> =20
>  #undef svc_rqst_flag
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index ef350f0d8925..d0278e5190ba 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -509,6 +509,12 @@ __svc_create(struct svc_program *prog, unsigned int bu=
fsize, int npools,
>  		INIT_LIST_HEAD(&pool->sp_sockets);
>  		spin_lock_init(&pool->sp_lock);
>  		xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
> +		/* All threads initially marked "busy" */
> +		pool->sp_idle_map =3D
> +			bitmap_zalloc_node(RPCSVC_MAXPOOLTHREADS, GFP_KERNEL,
> +					   svc_pool_map_get_node(i));
> +		if (!pool->sp_idle_map)
> +			return NULL;
> =20
>  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
>  		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> @@ -596,6 +602,8 @@ svc_destroy(struct kref *ref)
>  		percpu_counter_destroy(&pool->sp_threads_starved);
> =20
>  		xa_destroy(&pool->sp_thread_xa);
> +		bitmap_free(pool->sp_idle_map);
> +		pool->sp_idle_map =3D NULL;
>  	}
>  	kfree(serv->sv_pools);
>  	kfree(serv);
> @@ -647,7 +655,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *=
pool, int node)
> =20
>  	folio_batch_init(&rqstp->rq_fbatch);
> =20
> -	__set_bit(RQ_BUSY, &rqstp->rq_flags);
>  	rqstp->rq_server =3D serv;
>  	rqstp->rq_pool =3D pool;
> =20
> @@ -677,7 +684,7 @@ static struct svc_rqst *
>  svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>  {
>  	static const struct xa_limit limit =3D {
> -		.max =3D U32_MAX,
> +		.max =3D RPCSVC_MAXPOOLTHREADS,
>  	};
>  	struct svc_rqst	*rqstp;
>  	int ret;
> @@ -722,12 +729,19 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc=
_serv *serv,
>  					   struct svc_pool *pool)
>  {
>  	struct svc_rqst	*rqstp;
> -	unsigned long index;
> +	unsigned long bit;
> =20
> -	xa_for_each(&pool->sp_thread_xa, index, rqstp) {
> -		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> +	/* Check the pool's idle bitmap locklessly so that multiple
> +	 * idle searches can proceed concurrently.
> +	 */
> +	for_each_set_bit(bit, pool->sp_idle_map, pool->sp_nrthreads) {
> +		if (!test_and_clear_bit(bit, pool->sp_idle_map))
>  			continue;

I would really rather the map was "sp_busy_map". (initialised with bitmap_fil=
l())
Then you could "test_and_set_bit_lock()" and later "clear_bit_unlock()"
and so get all the required memory barriers.
What we are doing here is locking a particular thread for a task, so
"lock" is an appropriate description of what is happening.
See also svc_pool_thread_mark_* below.

> =20
> +		rqstp =3D xa_load(&pool->sp_thread_xa, bit);
> +		if (!rqstp)
> +			break;
> +
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>  		wake_up_process(rqstp->rq_task);
>  		percpu_counter_inc(&pool->sp_threads_woken);
> @@ -767,7 +781,8 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool =
*pool, unsigned int *stat
>  	}
> =20
>  found_pool:
> -	rqstp =3D xa_find(&pool->sp_thread_xa, &zero, U32_MAX, XA_PRESENT);
> +	rqstp =3D xa_find(&pool->sp_thread_xa, &zero, RPCSVC_MAXPOOLTHREADS,
> +			XA_PRESENT);
>  	if (rqstp) {
>  		__xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
>  		task =3D rqstp->rq_task;
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 7709120b45c1..2844b32c16ea 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -735,6 +735,25 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	return true;
>  }
> =20
> +static void svc_pool_thread_mark_idle(struct svc_pool *pool,
> +				      struct svc_rqst *rqstp)
> +{
> +	smp_mb__before_atomic();
> +	set_bit(rqstp->rq_thread_id, pool->sp_idle_map);
> +	smp_mb__after_atomic();
> +}

There memory barriers above and below bother me.  There is no comment
telling me what they are protecting against.
I would rather svc_pool_thread_mark_idle - which unlocks the thread -
were

    clear_bit_unlock(rqstp->rq_thread_id, pool->sp_busy_map);

and  that svc_pool_thread_mark_busy were

   test_and_set_bit_lock(rqstp->rq_thread_id, pool->sp_busy_map);

Then it would be more obvious what was happening.

Thanks,
NeilBrown

> +
> +/*
> + * Note: If we were awoken, then this rqstp has already been marked busy.
> + */
> +static void svc_pool_thread_mark_busy(struct svc_pool *pool,
> +				      struct svc_rqst *rqstp)
> +{
> +	smp_mb__before_atomic();
> +	clear_bit(rqstp->rq_thread_id, pool->sp_idle_map);
> +	smp_mb__after_atomic();
> +}
> +
>  static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long tim=
eout)
>  {
>  	struct svc_pool		*pool =3D rqstp->rq_pool;
> @@ -756,18 +775,17 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp, long timeout)
>  	set_current_state(TASK_INTERRUPTIBLE);
>  	smp_mb__before_atomic();
>  	clear_bit(SP_CONGESTED, &pool->sp_flags);
> -	clear_bit(RQ_BUSY, &rqstp->rq_flags);
> -	smp_mb__after_atomic();
> =20
> -	if (likely(rqst_should_sleep(rqstp)))
> +	if (likely(rqst_should_sleep(rqstp))) {
> +		svc_pool_thread_mark_idle(pool, rqstp);
>  		time_left =3D schedule_timeout(timeout);
> -	else
> +	} else
>  		__set_current_state(TASK_RUNNING);
> =20
>  	try_to_freeze();
> =20
> -	set_bit(RQ_BUSY, &rqstp->rq_flags);
> -	smp_mb__after_atomic();
> +	svc_pool_thread_mark_busy(pool, rqstp);
> +
>  	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
>  	if (rqstp->rq_xprt) {
>  		trace_svc_pool_awoken(rqstp);
>=20
>=20
>=20

