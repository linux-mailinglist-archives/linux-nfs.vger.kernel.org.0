Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F1747ABE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jul 2023 02:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGEAeb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 20:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAea (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 20:34:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F85910F1
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 17:34:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A4471FEB8;
        Wed,  5 Jul 2023 00:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688517262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LqUP08qx08dtTlXBgzrVhLJk8vY8th7Nck+wwGBz+Q=;
        b=V4W3snMkjqI4KvJxSe1YYCvks0neLe3FnpfQzklcHY3mMx6FEWCXuBDKslnLw+qh+ADOt4
        8BIfHoaGmtPQCGEo+gJ7wAOzm+wT93eomfzEitwULa/5ltv50vOcoOxK7asOwIP6Qw2Kt0
        KykbKNdjSMrAHEh/vpCVuV+8MfWwBJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688517262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LqUP08qx08dtTlXBgzrVhLJk8vY8th7Nck+wwGBz+Q=;
        b=ClnAJ1nQ3H+2+59W64Mu6SyGqI6bj7lRFqhEYYa5+zwkINgIWLEkHIoautJQoybyKO9RnZ
        BD6h0SkMpeykjqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B110134F3;
        Wed,  5 Jul 2023 00:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CuGjM4u6pGQKCAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 05 Jul 2023 00:34:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "Jeff Layton" <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
In-reply-to: <5A969052-0872-4C04-AE8C-C989B54A9CEB@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842930872.139194.10164846167275218299.stgit@manet.1015granger.net>,
 <168843398253.8939.16982425023664424215@noble.neil.brown.name>,
 <ZKN9xmRn+EN/TQwY@manet.1015granger.net>,
 <168843704829.8939.9406594114602623376@noble.neil.brown.name>,
 <5A969052-0872-4C04-AE8C-C989B54A9CEB@oracle.com>
Date:   Wed, 05 Jul 2023 10:34:16 +1000
Message-id: <168851725628.8939.16614680783638523525@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 05 Jul 2023, Chuck Lever III wrote:
>=20
> > On Jul 3, 2023, at 10:17 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Tue, 04 Jul 2023, Chuck Lever wrote:
> >> On Tue, Jul 04, 2023 at 11:26:22AM +1000, NeilBrown wrote:
> >>> On Tue, 04 Jul 2023, Chuck Lever wrote:
> >>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>>=20
> >>>> I've noticed that client-observed server request latency goes up
> >>>> simply when the nfsd thread count is increased.
> >>>>=20
> >>>> List walking is known to be memory-inefficient. On a busy server
> >>>> with many threads, enqueuing a transport will walk the "all threads"
> >>>> list quite frequently. This also pulls in the cache lines for some
> >>>> hot fields in each svc_rqst (namely, rq_flags).
> >>>=20
> >>> I think this text could usefully be re-written.  By this point in the
> >>> series we aren't list walking.
> >>>=20
> >>> I'd also be curious to know what latency different you get for just this
> >>> change.
> >>=20
> >> Not much of a latency difference at lower thread counts.
> >>=20
> >> The difference I notice is that with the spinlock version of
> >> pool_wake_idle_thread, there is significant lock contention as
> >> the thread count increases, and the throughput result of my fio
> >> test is lower (outside the result variance).
> >>=20
> >>=20
> >>>> The svc_xprt_enqueue() call that concerns me most is the one in
> >>>> svc_rdma_wc_receive(), which is single-threaded per CQ. Slowing
> >>>> down completion handling limits the total throughput per RDMA
> >>>> connection.
> >>>>=20
> >>>> So, avoid walking the "all threads" list to find an idle thread to
> >>>> wake. Instead, set up an idle bitmap and use find_next_bit, which
> >>>> should work the same way as RQ_BUSY but it will touch only the
> >>>> cachelines that the bitmap is in. Stick with atomic bit operations
> >>>> to avoid taking the pool lock.
> >>>>=20
> >>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >>>> ---
> >>>> include/linux/sunrpc/svc.h    |    6 ++++--
> >>>> include/trace/events/sunrpc.h |    1 -
> >>>> net/sunrpc/svc.c              |   27 +++++++++++++++++++++------
> >>>> net/sunrpc/svc_xprt.c         |   30 ++++++++++++++++++++++++------
> >>>> 4 files changed, 49 insertions(+), 15 deletions(-)
> >>>>=20
> >>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> >>>> index 6f8bfcd44250..27ffcf7371d0 100644
> >>>> --- a/include/linux/sunrpc/svc.h
> >>>> +++ b/include/linux/sunrpc/svc.h
> >>>> @@ -35,6 +35,7 @@ struct svc_pool {
> >>>> spinlock_t sp_lock; /* protects sp_sockets */
> >>>> struct list_head sp_sockets; /* pending sockets */
> >>>> unsigned int sp_nrthreads; /* # of threads in pool */
> >>>> + unsigned long *sp_idle_map; /* idle threads */
> >>>> struct xarray sp_thread_xa;
> >>>>=20
> >>>> /* statistics on pool operation */
> >>>> @@ -190,6 +191,8 @@ extern u32 svc_max_payload(const struct svc_rqst *=
rqstp);
> >>>> #define RPCSVC_MAXPAGES ((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
> >>>> + 2 + 1)
> >>>>=20
> >>>> +#define RPCSVC_MAXPOOLTHREADS (4096)
> >>>> +
> >>>> /*
> >>>>  * The context of a single thread, including the request currently bei=
ng
> >>>>  * processed.
> >>>> @@ -239,8 +242,7 @@ struct svc_rqst {
> >>>> #define RQ_SPLICE_OK (4) /* turned off in gss privacy
> >>>> * to prevent encrypting page
> >>>> * cache pages */
> >>>> -#define RQ_BUSY (5) /* request is busy */
> >>>> -#define RQ_DATA (6) /* request has data */
> >>>> +#define RQ_DATA (5) /* request has data */
> >>>=20
> >>> Might this be a good opportunity to convert this to an enum ??
> >>>=20
> >>>> unsigned long rq_flags; /* flags field */
> >>>> u32 rq_thread_id; /* xarray index */
> >>>> ktime_t rq_qtime; /* enqueue time */
> >>>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunr=
pc.h
> >>>> index ea43c6059bdb..c07824a254bf 100644
> >>>> --- a/include/trace/events/sunrpc.h
> >>>> +++ b/include/trace/events/sunrpc.h
> >>>> @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
> >>>> svc_rqst_flag(USEDEFERRAL) \
> >>>> svc_rqst_flag(DROPME) \
> >>>> svc_rqst_flag(SPLICE_OK) \
> >>>> - svc_rqst_flag(BUSY) \
> >>>> svc_rqst_flag_end(DATA)
> >>>>=20
> >>>> #undef svc_rqst_flag
> >>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> >>>> index ef350f0d8925..d0278e5190ba 100644
> >>>> --- a/net/sunrpc/svc.c
> >>>> +++ b/net/sunrpc/svc.c
> >>>> @@ -509,6 +509,12 @@ __svc_create(struct svc_program *prog, unsigned i=
nt bufsize, int npools,
> >>>> INIT_LIST_HEAD(&pool->sp_sockets);
> >>>> spin_lock_init(&pool->sp_lock);
> >>>> xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
> >>>> + /* All threads initially marked "busy" */
> >>>> + pool->sp_idle_map =3D
> >>>> + bitmap_zalloc_node(RPCSVC_MAXPOOLTHREADS, GFP_KERNEL,
> >>>> +   svc_pool_map_get_node(i));
> >>>> + if (!pool->sp_idle_map)
> >>>> + return NULL;
> >>>>=20
> >>>> percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> >>>> percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> >>>> @@ -596,6 +602,8 @@ svc_destroy(struct kref *ref)
> >>>> percpu_counter_destroy(&pool->sp_threads_starved);
> >>>>=20
> >>>> xa_destroy(&pool->sp_thread_xa);
> >>>> + bitmap_free(pool->sp_idle_map);
> >>>> + pool->sp_idle_map =3D NULL;
> >>>> }
> >>>> kfree(serv->sv_pools);
> >>>> kfree(serv);
> >>>> @@ -647,7 +655,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_p=
ool *pool, int node)
> >>>>=20
> >>>> folio_batch_init(&rqstp->rq_fbatch);
> >>>>=20
> >>>> - __set_bit(RQ_BUSY, &rqstp->rq_flags);
> >>>> rqstp->rq_server =3D serv;
> >>>> rqstp->rq_pool =3D pool;
> >>>>=20
> >>>> @@ -677,7 +684,7 @@ static struct svc_rqst *
> >>>> svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int n=
ode)
> >>>> {
> >>>> static const struct xa_limit limit =3D {
> >>>> - .max =3D U32_MAX,
> >>>> + .max =3D RPCSVC_MAXPOOLTHREADS,
> >>>> };
> >>>> struct svc_rqst *rqstp;
> >>>> int ret;
> >>>> @@ -722,12 +729,19 @@ struct svc_rqst *svc_pool_wake_idle_thread(struc=
t svc_serv *serv,
> >>>>   struct svc_pool *pool)
> >>>> {
> >>>> struct svc_rqst *rqstp;
> >>>> - unsigned long index;
> >>>> + unsigned long bit;
> >>>>=20
> >>>> - xa_for_each(&pool->sp_thread_xa, index, rqstp) {
> >>>> - if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> >>>> + /* Check the pool's idle bitmap locklessly so that multiple
> >>>> + * idle searches can proceed concurrently.
> >>>> + */
> >>>> + for_each_set_bit(bit, pool->sp_idle_map, pool->sp_nrthreads) {
> >>>> + if (!test_and_clear_bit(bit, pool->sp_idle_map))
> >>>> continue;
> >>>=20
> >>> I would really rather the map was "sp_busy_map". (initialised with bitm=
ap_fill())
> >>> Then you could "test_and_set_bit_lock()" and later "clear_bit_unlock()"
> >>> and so get all the required memory barriers.
> >>> What we are doing here is locking a particular thread for a task, so
> >>> "lock" is an appropriate description of what is happening.
> >>> See also svc_pool_thread_mark_* below.
> >>>=20
> >>>>=20
> >>>> + rqstp =3D xa_load(&pool->sp_thread_xa, bit);
> >>>> + if (!rqstp)
> >>>> + break;
> >>>> +
> >>>> WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> >>>> wake_up_process(rqstp->rq_task);
> >>>> percpu_counter_inc(&pool->sp_threads_woken);
> >>>> @@ -767,7 +781,8 @@ svc_pool_victim(struct svc_serv *serv, struct svc_=
pool *pool, unsigned int *stat
> >>>> }
> >>>>=20
> >>>> found_pool:
> >>>> - rqstp =3D xa_find(&pool->sp_thread_xa, &zero, U32_MAX, XA_PRESENT);
> >>>> + rqstp =3D xa_find(&pool->sp_thread_xa, &zero, RPCSVC_MAXPOOLTHREADS,
> >>>> + XA_PRESENT);
> >>>> if (rqstp) {
> >>>> __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
> >>>> task =3D rqstp->rq_task;
> >>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> >>>> index 7709120b45c1..2844b32c16ea 100644
> >>>> --- a/net/sunrpc/svc_xprt.c
> >>>> +++ b/net/sunrpc/svc_xprt.c
> >>>> @@ -735,6 +735,25 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >>>> return true;
> >>>> }
> >>>>=20
> >>>> +static void svc_pool_thread_mark_idle(struct svc_pool *pool,
> >>>> +      struct svc_rqst *rqstp)
> >>>> +{
> >>>> + smp_mb__before_atomic();
> >>>> + set_bit(rqstp->rq_thread_id, pool->sp_idle_map);
> >>>> + smp_mb__after_atomic();
> >>>> +}
> >>>=20
> >>> There memory barriers above and below bother me.  There is no comment
> >>> telling me what they are protecting against.
> >>> I would rather svc_pool_thread_mark_idle - which unlocks the thread -
> >>> were
> >>>=20
> >>>    clear_bit_unlock(rqstp->rq_thread_id, pool->sp_busy_map);
> >>>=20
> >>> and  that svc_pool_thread_mark_busy were
> >>>=20
> >>>   test_and_set_bit_lock(rqstp->rq_thread_id, pool->sp_busy_map);
> >>>=20
> >>> Then it would be more obvious what was happening.
> >>=20
> >> Not obvious to me, but that's very likely because I'm not clear what
> >> clear_bit_unlock() does. :-)
> >=20
> > In general, any "lock" operation (mutex, spin, whatever) is (and must
> > be) and "acquire" type operations which imposes a memory barrier so that
> > read requests *after* the lock cannot be satisfied with data from
> > *before* the lock.  The read must access data after the lock.
> > Conversely any "unlock" operations is a "release" type operation which
> > imposes a memory barrier so that any write request *before* the unlock
> > must not be delayed until *after* the unlock.  The write must complete
> > before the unlock.
> >=20
> > This is exactly what you would expect of locking - it creates a closed
> > code region that is properly ordered w.r.t comparable closed regions.
> >=20
> > test_and_set_bit_lock() and clear_bit_unlock() provide these expected
> > semantics for bit operations.
>=20
> Your explanation is more clear than what I read in Documentation/atomic*
> so thanks. I feel a little more armed to make good use of it.
>=20
>=20
> > New code should (almost?) never have explicit memory barriers like
> > smp_mb__after_atomic().
> > It should use one of the many APIs with _acquire or _release suffixes,
> > or with the more explicit _lock or _unlock.
>=20
> Out of curiosity, is "should never have explicit memory barriers"
> documented somewhere? I've been accused of skimming when I read, so
> I might have missed it.

My wife says I only read every second word of emails :-)

I don't know that it is documented anywhere (maybe I should submit a
patch).  The statement was really my personal rule that seems to be the
natural sequel for the introduction of the many _acquire and _release
interfaces.

NeilBrown
