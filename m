Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCAB76C474
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 07:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjHBFBZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 01:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjHBFBY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 01:01:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E7926BD
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 22:00:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCECA21B77;
        Wed,  2 Aug 2023 05:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690952446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2kAfuQBs4XsJScEAku/E3jIBfZ4qDOPOW8sKKCYpEc=;
        b=TdfM3cC5A3ZW4W/w+svRcoNc/dkfALBifXjSnjHhrU/laZAL4x4H80a1HhLr30D3c+nT9x
        zK9gyaFLHqClvsOxwa22+uoZ8gkHSN2RsJm5+TIDeBWd+Pp59LJo3+I7nxl3/JnozVc3nZ
        Nea0KODGMzVZVfhL95BgJr/39XEV7kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690952446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2kAfuQBs4XsJScEAku/E3jIBfZ4qDOPOW8sKKCYpEc=;
        b=B8SIKS7xE2UiHNAKlfHP18UJuZ0hw04xexMTYYt+04byZQ5ZoMdRA3JmsVSW4s+6rEGewU
        MuKNSrNLTADQTgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B89D13909;
        Wed,  2 Aug 2023 05:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fsKqDv3iyWRSWwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 02 Aug 2023 05:00:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/12] SUNRPC: rename and refactor svc_get_next_xprt().
In-reply-to: <ZMhAsTSHy4lcEdnE@tissot.1015granger.net>
References: <20230731064839.7729-1-neilb@suse.de>,
 <20230731064839.7729-7-neilb@suse.de>,
 <ZMhAsTSHy4lcEdnE@tissot.1015granger.net>
Date:   Wed, 02 Aug 2023 15:00:35 +1000
Message-id: <169095243520.32308.1308888441007177300@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 01 Aug 2023, Chuck Lever wrote:
> On Mon, Jul 31, 2023 at 04:48:33PM +1000, NeilBrown wrote:
> > svc_get_next_xprt() does a lot more than just get an xprt.  It also
> > decides if it needs to sleep, depending not only on the availability of
> > xprts, but also on the need to exit or handle external work
> > (SP_TASK_PENDING).
> >=20
> > So rename it to svc_rqst_wait_and_dequeue_work(), don't return the xprt
> > (which can easily be found in rqstp->rq_xprt), and restructure to make a
> > clear separation between waiting and dequeueing.
>=20
> For me, the most valuable part of this patch is the last part here:
> refactoring the dequeue and the wait, and deduplicating the dequeue.
>=20
>=20
> > All the scheduling-related code like try_to_freeze() and
> > kthread_should_stop() is moved into svc_rqst_wait_and_dequeue_work().
> >=20
> > Rather than calling svc_xprt_dequeue() twice (before and after deciding
> > to wait), it now calls rqst_should_sleep() twice.  If the first fails,
> > we skip all the waiting code completely.  In the waiting code we call
> > again after setting the task state in case we missed a wake-up.
> >=20
> > We now only have one call to try_to_freeze() and one call to
> > svc_xprt_dequeue().  We still have two calls to kthread_should_stop() -
> > one in rqst_should_sleep() to avoid sleeping, and one afterwards to
> > avoid dequeueing any work (it previously came after dequeueing which
> > doesn't seem right).
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  net/sunrpc/svc_xprt.c | 62 +++++++++++++++++++++----------------------
> >  1 file changed, 31 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 380fb3caea4c..67f2b34cb8e4 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -722,47 +722,51 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >  	return true;
> >  }
> > =20
> > -static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
> > +static void svc_rqst_wait_and_dequeue_work(struct svc_rqst *rqstp)
>=20
> It would be simpler to follow if you renamed this function once
> (here), and changed directly from returning struct svc_xprt to
> returning bool.

It isn't clear to me why it would be simpler, or exactly what you are
suggesting.
Should U just squash
   SUNRPC: rename and refactor svc_get_next_xprt().
and
   SUNRPC: move task-dequeueing code into svc_recv()

together?  I can see that it would make sense to move
   SUNRPC: move all of xprt handling into svc_xprt_handle()
earlier.

>=20
>=20
> >  {
> >  	struct svc_pool		*pool =3D rqstp->rq_pool;
> > +	bool slept =3D false;
> > =20
> >  	/* rq_xprt should be clear on entry */
> >  	WARN_ON_ONCE(rqstp->rq_xprt);
> > =20
> > -	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
> > -	if (rqstp->rq_xprt) {
> > -		trace_svc_pool_polled(rqstp);
> > -		goto out_found;
> > +	if (rqst_should_sleep(rqstp)) {
> > +		set_current_state(TASK_IDLE);
> > +		smp_mb__before_atomic();
> > +		clear_bit(SP_CONGESTED, &pool->sp_flags);
> > +		clear_bit(RQ_BUSY, &rqstp->rq_flags);
> > +		smp_mb__after_atomic();
> > +
> > +		/* Need to test again after setting task state */
>=20
> This comment isn't illuminating. It needs to explain the "need to
> test again".

"after setting task state" was meant to be the explanation, but I guess
more words wouldn't hurt.

>=20
>=20
> > +		if (likely(rqst_should_sleep(rqstp))) {
>=20
> Is likely() still needed here?

It is ever needed?  Let's drop it.

Thanks,
NeilBrown


>=20
>=20
> > +			schedule();
> > +			slept =3D true;
> > +		} else {
> > +			__set_current_state(TASK_RUNNING);
> > +			cond_resched();
>=20
> This makes me happy. Only call cond_resched() if we didn't sleep.
>=20
>=20
> > +		}
> > +		set_bit(RQ_BUSY, &rqstp->rq_flags);
> > +		smp_mb__after_atomic();
> >  	}
> > -
> > -	set_current_state(TASK_IDLE);
> > -	smp_mb__before_atomic();
> > -	clear_bit(SP_CONGESTED, &pool->sp_flags);
> > -	clear_bit(RQ_BUSY, &rqstp->rq_flags);
> > -	smp_mb__after_atomic();
> > -
> > -	if (likely(rqst_should_sleep(rqstp)))
> > -		schedule();
> > -	else
> > -		__set_current_state(TASK_RUNNING);
> > -
> >  	try_to_freeze();
> > =20
> > -	set_bit(RQ_BUSY, &rqstp->rq_flags);
> > -	smp_mb__after_atomic();
> > +	if (kthread_should_stop())
> > +		return;
> > +
> >  	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> >  	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
> >  	if (rqstp->rq_xprt) {
> > -		trace_svc_pool_awoken(rqstp);
> > +		if (slept)
> > +			trace_svc_pool_awoken(rqstp);
> > +		else
> > +			trace_svc_pool_polled(rqstp);
>=20
> Again, it would perhaps be better if we rearranged this code first,
> and then added tracepoints. This is ... well, ugly.
>=20
>=20
> >  		goto out_found;
> >  	}
> > =20
> > -	if (kthread_should_stop())
> > -		return NULL;
> > -	percpu_counter_inc(&pool->sp_threads_no_work);
> > -	return NULL;
> > +	if (slept)
> > +		percpu_counter_inc(&pool->sp_threads_no_work);
> > +	return;
> >  out_found:
> > -	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> >  	/* Normally we will wait up to 5 seconds for any required
> >  	 * cache information to be provided.
> >  	 */
> > @@ -770,7 +774,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp)
> >  		rqstp->rq_chandle.thread_wait =3D 5*HZ;
> >  	else
> >  		rqstp->rq_chandle.thread_wait =3D 1*HZ;
> > -	return rqstp->rq_xprt;
> >  }
> > =20
> >  static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt=
 *newxpt)
> > @@ -854,12 +857,9 @@ void svc_recv(struct svc_rqst *rqstp)
> >  	if (!svc_alloc_arg(rqstp))
> >  		goto out;
> > =20
> > -	try_to_freeze();
> > -	cond_resched();
> > -	if (kthread_should_stop())
> > -		goto out;
> > +	svc_rqst_wait_and_dequeue_work(rqstp);
> > =20
> > -	xprt =3D svc_get_next_xprt(rqstp);
> > +	xprt =3D rqstp->rq_xprt;
> >  	if (!xprt)
> >  		goto out;
> > =20
> > --=20
> > 2.40.1
> >=20
>=20
> --=20
> Chuck Lever
>=20

