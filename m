Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49474DD56
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 20:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGJS3A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 14:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJS3A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 14:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9393AB
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 11:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1116112E
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 18:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D8BC433C7;
        Mon, 10 Jul 2023 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689013737;
        bh=xNvLLXCOrUIJDTP9B9LIFNTSRlzQAxpnf13xnpTYU6s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fy8GzremgXzPZA94Y22RuGmlq4F2IDxAPjR1tUcKvPHR7qR0r5Zu9G2HUGRjdHhIc
         LkXHXT3kO0KH0E25IYtulbkWfdrVh9sRn5fSfT6YoZTKKrkJ1LffU8Pow9QR/+encb
         1EBi9b5CCE2FNPcTtRjozRBkrDWH/4zZaaCgmFyMD+dBmKfXmF6o/9sv7UeDZmtMKG
         hZigXO17ljhqPU9pLyEjXE6eyKFdvSiWmjvyRiJxyFCMSSe7+WeW3Xu23MB7/TeeZF
         +8DcsJnZz5YFpEFf3TRIT01BqXFT0PIKBvE3sPdxRGkfJnW41OepKK/GU8/aUeILYj
         JNoo0DO6H3ajQ==
Message-ID: <f6320e113f9ba505638a774ae33adda68575cec4.camel@kernel.org>
Subject: Re: [PATCH v3 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, david@fromorbit.com
Date:   Mon, 10 Jul 2023 14:28:56 -0400
In-Reply-To: <168900737297.7514.333293207540036098.stgit@manet.1015granger.net>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
         <168900737297.7514.333293207540036098.stgit@manet.1015granger.net>
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

On Mon, 2023-07-10 at 12:42 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> I've noticed that client-observed server request latency goes up
> simply when the nfsd thread count is increased.
>=20
> Walking the whole set of pool threads is memory-inefficient. On a
> busy server with many threads, enqueuing a transport will visit all
> the threads in the pool quite frequently. This also pulls in the
> cache lines for some hot fields in each svc_rqst (namely, rq_flags).
>=20
> The svc_xprt_enqueue() call that concerns me most is the one in
> svc_rdma_wc_receive(), which is single-threaded per CQ. Slowing
> down completion handling limits the total throughput per RDMA
> connection.
>=20
> Instead, set up a busy bitmap and use find_next_clear_bit, which
> should work the same way as RQ_BUSY but will touch only the cache
> lines that the bitmap is in. Stick with atomic bit operations to
> avoid taking a spinlock during the search.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h    |    6 ++++--
>  include/trace/events/sunrpc.h |    1 -
>  net/sunrpc/svc.c              |   24 +++++++++++++++++++-----
>  net/sunrpc/svc_xprt.c         |   26 ++++++++++++++++++++------
>  4 files changed, 43 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 86377506a514..6669f3eb9ed4 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -35,6 +35,7 @@ struct svc_pool {
>  	spinlock_t		sp_lock;	/* protects sp_sockets */
>  	struct list_head	sp_sockets;	/* pending sockets */
>  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> +	unsigned long		*sp_busy_map;	/* running threads */
>  	struct xarray		sp_thread_xa;
> =20
>  	/* statistics on pool operation */
> @@ -191,6 +192,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqs=
tp);
>  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
>  				+ 2 + 1)
> =20
> +#define RPCSVC_MAXPOOLTHREADS	(4096)
> +
>  /*
>   * The context of a single thread, including the request currently being
>   * processed.
> @@ -240,8 +243,7 @@ struct svc_rqst {
>  #define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
>  						 * to prevent encrypting page
>  						 * cache pages */
> -#define	RQ_BUSY		(5)			/* request is busy */
> -#define	RQ_DATA		(6)			/* request has data */
> +#define	RQ_DATA		(5)			/* request has data */
>  	unsigned long		rq_flags;	/* flags field */
>  	u32			rq_thread_id;	/* xarray index */
>  	ktime_t			rq_qtime;	/* enqueue time */
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.=
h
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
> index 109d7f047385..f6305b66fd28 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -509,6 +509,12 @@ __svc_create(struct svc_program *prog, unsigned int =
bufsize, int npools,
>  		INIT_LIST_HEAD(&pool->sp_sockets);
>  		spin_lock_init(&pool->sp_lock);
>  		xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
> +		pool->sp_busy_map =3D
> +			bitmap_alloc_node(RPCSVC_MAXPOOLTHREADS, GFP_KERNEL,
> +					  svc_pool_map_get_node(i));
> +		if (!pool->sp_busy_map)
> +			return NULL;
> +		bitmap_fill(pool->sp_busy_map, RPCSVC_MAXPOOLTHREADS);
> =20
>  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
>  		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> @@ -598,6 +604,8 @@ svc_destroy(struct kref *ref)
>  		percpu_counter_destroy(&pool->sp_threads_no_work);
> =20
>  		xa_destroy(&pool->sp_thread_xa);
> +		bitmap_free(pool->sp_busy_map);
> +		pool->sp_busy_map =3D NULL;
>  	}
>  	kfree(serv->sv_pools);
>  	kfree(serv);
> @@ -649,7 +657,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool=
 *pool, int node)
> =20
>  	folio_batch_init(&rqstp->rq_fbatch);
> =20
> -	__set_bit(RQ_BUSY, &rqstp->rq_flags);
>  	rqstp->rq_server =3D serv;
>  	rqstp->rq_pool =3D pool;
> =20
> @@ -679,7 +686,7 @@ static struct svc_rqst *
>  svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int nod=
e)
>  {
>  	struct xa_limit limit =3D {
> -		.max =3D U32_MAX,
> +		.max =3D RPCSVC_MAXPOOLTHREADS,
>  	};
>  	struct svc_rqst	*rqstp;
>  	int ret;
> @@ -724,12 +731,19 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct s=
vc_serv *serv,
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
> +	for_each_clear_bit(bit, pool->sp_busy_map, pool->sp_nrthreads) {
> +		if (test_and_set_bit(bit, pool->sp_busy_map))
>  			continue;
>=20
>=20

I wonder if we also need to set the sp_busy_map bit when we're trying to
shrink the threadpool? It seems like the code above that is trying to
find a thread to do work could race with the task being killed, such
that we try to take up a task that is no longer functional.

> =20
> +		rqstp =3D xa_load(&pool->sp_thread_xa, bit);
> +		if (!rqstp)
> +			break;
> +
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>  		wake_up_process(rqstp->rq_task);
>  		percpu_counter_inc(&pool->sp_threads_woken);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index db40f771b60a..f9c9babe0cba 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -735,6 +735,21 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	return true;
>  }
> =20
> +static void svc_pool_thread_mark_idle(struct svc_pool *pool,
> +				      struct svc_rqst *rqstp)
> +{
> +	clear_bit_unlock(rqstp->rq_thread_id, pool->sp_busy_map);
> +}
> +
> +/*
> + * Note: If we were awoken, then this rqstp has already been marked busy=
.
> + */
> +static void svc_pool_thread_mark_busy(struct svc_pool *pool,
> +				      struct svc_rqst *rqstp)
> +{
> +	test_and_set_bit_lock(rqstp->rq_thread_id, pool->sp_busy_map);
> +}
> +
>  static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long t=
imeout)
>  {
>  	struct svc_pool		*pool =3D rqstp->rq_pool;
> @@ -756,18 +771,17 @@ static struct svc_xprt *svc_get_next_xprt(struct sv=
c_rqst *rqstp, long timeout)
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

--=20
Jeff Layton <jlayton@kernel.org>
