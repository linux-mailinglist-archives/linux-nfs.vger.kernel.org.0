Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB576A3E3
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjGaWFU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGaWFO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 18:05:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1225E8
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 15:05:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62BA11F88D;
        Mon, 31 Jul 2023 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690841112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaVeUgdOjOCvA4nNTdhrDKHxQQjulw5CAhE7/CeCIxk=;
        b=xZxVRV52pAEaSChsfqgaL0UcTCGPXDE93ckgiCtjEHtxVtLNw4KdENbOKKFv5mKFpYw+Fx
        cgs2IwB5zi7uokqF40AVximfXWwrkJeYzKp6iw9qk0YJlo61S6yx+5BrbSa9G1XZZOJevQ
        i/A+MWxFX2jtG31ToZV4bmf7voV0vc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690841112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaVeUgdOjOCvA4nNTdhrDKHxQQjulw5CAhE7/CeCIxk=;
        b=IOH//gFkxZvu6ZoNwlpLTzoQifulzvHiw2gjz3N+DjIV49BYTyAjIB5TmM8dLcjXZYwEC8
        Gs88t0WE33e6+bDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 219F8133F7;
        Mon, 31 Jul 2023 22:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U2iKMRYwyGTxIAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 22:05:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/12] SUNRPC: make rqst_should_sleep() idempotent()
In-reply-to: <ZMfDa8YRUH3Lm15p@tissot.1015granger.net>
References: <20230731064839.7729-1-neilb@suse.de>,
 <20230731064839.7729-2-neilb@suse.de>,
 <ZMfDa8YRUH3Lm15p@tissot.1015granger.net>
Date:   Tue, 01 Aug 2023 08:05:06 +1000
Message-id: <169084110651.32308.3326402203041564605@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 01 Aug 2023, Chuck Lever wrote:
> On Mon, Jul 31, 2023 at 04:48:28PM +1000, NeilBrown wrote:
> > Based on its name you would think that rqst_should_sleep() would be
> > read-only, not changing anything.  But it fact it will clear
> > SP_TASK_PENDING if that was set.  This is surprising, and it blurs the
> > line between "check for work to do" and "dequeue work to do".
>=20
> I agree that rqst_should_sleep() sounds like it should be a
> predicate without side effects.
>=20
>=20
> > So change the "test_and_clear" to simple "test" and clear the bit once
> > the thread has decided to wake up and return to the caller.
> >=20
> > With this, it makes sense to *always* set SP_TASK_PENDING when asked,
> > rather than only to set it if no thread could be woken up.
>=20
> I'm lost here. Why does always setting TASK_PENDING now make sense?
> If there's no task pending, won't this trigger a wake up when there
> is nothing to do?

Clearly Jedi mind tricks don't work on you...  I'll have to try logic
instead.

 This separation of "test" and "clear" is a first step in re-organising
 the queueing of tasks around a clear pattern of "client queues a task",
 "service checks if any tasks are queued" and "service dequeues and
 performs a task".  The first step for TASK_PENDING doesn't quite follow
 a clear pattern as the flag is only set (the work is only queued) if
 no thread could be immediately woken.  This imposes on the
 implementation of the service.  For example, whenever a service is
 woken it *must* return to the caller of svc_recv(), just in case it was
 woken by svc_wake_up().  It cannot test if there is work to do, and if
 not - go back to sleep.  It provides a cleaner implementation of the
 pattern to *always* queue the work.  i.e. *always* set the flag.  Which
 ever thread first sees and clears the flag will return to caller and
 perform the required work.  If the woken thread doesn't find anything
 to do, it could go back to sleep (though currently it doesn't).

If that more convincing?

Thanks,
NeilBrown


>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  net/sunrpc/svc_xprt.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index cd92cb54132d..380fb3caea4c 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -581,8 +581,8 @@ void svc_wake_up(struct svc_serv *serv)
> >  {
> >  	struct svc_pool *pool =3D &serv->sv_pools[0];
> > =20
> > -	if (!svc_pool_wake_idle_thread(serv, pool))
> > -		set_bit(SP_TASK_PENDING, &pool->sp_flags);
> > +	set_bit(SP_TASK_PENDING, &pool->sp_flags);
> > +	svc_pool_wake_idle_thread(serv, pool);
> >  }
> >  EXPORT_SYMBOL_GPL(svc_wake_up);
> > =20
> > @@ -704,7 +704,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >  	struct svc_pool		*pool =3D rqstp->rq_pool;
> > =20
> >  	/* did someone call svc_wake_up? */
> > -	if (test_and_clear_bit(SP_TASK_PENDING, &pool->sp_flags))
> > +	if (test_bit(SP_TASK_PENDING, &pool->sp_flags))
> >  		return false;
> > =20
> >  	/* was a socket queued? */
> > @@ -750,6 +750,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp)
> > =20
> >  	set_bit(RQ_BUSY, &rqstp->rq_flags);
> >  	smp_mb__after_atomic();
> > +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>=20
> Why wouldn't this go before the smp_mb__after_atomic()?
>=20
>=20
> >  	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
> >  	if (rqstp->rq_xprt) {
> >  		trace_svc_pool_awoken(rqstp);
> > @@ -761,6 +762,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp)
> >  	percpu_counter_inc(&pool->sp_threads_no_work);
> >  	return NULL;
> >  out_found:
> > +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>=20
> clear_bit_unlock ?
>=20
> >  	/* Normally we will wait up to 5 seconds for any required
> >  	 * cache information to be provided.
> >  	 */
> > --=20
> > 2.40.1
> >=20
>=20
> --=20
> Chuck Lever
>=20

