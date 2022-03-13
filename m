Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B197D4D7888
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 23:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiCMWFE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 18:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiCMWFE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 18:05:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED2430F47
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 15:03:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC33F210FE;
        Sun, 13 Mar 2022 22:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647209033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAAFQIb7rO6v+AEYg7BGzyDDzs/FcuVyc0AokwzzQPg=;
        b=hvlRfBRLaJnVtEzQu8m8kFNXE29kxzYZ8Y8GdFVt1ZWjwEGkrt7KHJs9a0ptPQNuZxMasW
        xGHNF7R5GK/BZJ3yciUeh0quwbWkC9KNqM6aaTgWnc/jMGKUhIVP/mYpkp4aQmmnTERqlM
        hGd8ShvIaQ6Ud2dnZcZq1JWD3Q8Ih5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647209033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAAFQIb7rO6v+AEYg7BGzyDDzs/FcuVyc0AokwzzQPg=;
        b=aKuGBbB35Ak4puHQWz1dxxy7+oPCSopczOJ94Y40nPZVxMgVqUV+DmHstCOsaiMpr0dI2i
        i/P/H/NcVlMLTyBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9262413B16;
        Sun, 13 Mar 2022 22:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tQJ9EkhqLmJRNwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 13 Mar 2022 22:03:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: avoid race between mod_timer() and del_timer_sync()
In-reply-to: <8af5700311c3ca5ea4931072f0717bb133c79dfb.camel@hammerspace.com>
References: <164670733789.31932.14711754930977072270@noble.neil.brown.name>,
 <8af5700311c3ca5ea4931072f0717bb133c79dfb.camel@hammerspace.com>
Date:   Mon, 14 Mar 2022 09:03:49 +1100
Message-id: <164720902908.7120.4478916458622123003@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 13 Mar 2022, Trond Myklebust wrote:
> On Tue, 2022-03-08 at 13:42 +1100, NeilBrown wrote:
> >=20
> > xprt_destory() claims XPRT_LOCKED and then calls del_timer_sync().
> > Both xprt_unlock_connect() and xprt_release() call
> > =C2=A0->release_xprt()
> > which drops XPRT_LOCKED and *then* xprt_schedule_autodisconnect()
> > which calls mod_timer().
> >=20
> > This may result in mod_timer() being called *after* del_timer_sync().
> > When this happens, the timer may fire long after the xprt has been
> > freed,
> > and run_timer_softirq() will probably crash.
> >=20
> > The pairing of ->release_xprt() and xprt_schedule_autodisconnect() is
> > always called under ->transport_lock.=C2=A0 So if we take ->transport_lock
> > to
> > call del_timer_sync(), we can be sure that mod_timer() will run first
> > (if it runs at all).
>=20
> xprt_destroy() never releases XPRT_LOCKED, so how could the above race
> happen?

the race would happen as xprt_destroy() is taking the lock.
One core is in xprt_destroy(), the other in xprt_unlock_connect()

   Core 1                           Core 2
                                    spin_lock(transport_lock)
                                    xprt->ops->release_xprt()
                                         aka xprt_release_xprt()
                                         This clears XPRT_LOCKED
  wait_on_bit_lock(XPRT_LOCKED)
       This doesn't need to wait
  del_timer_sync(->timer)
                                    xprt_schedule_autodisconnect()
                                      calls mod_timer(->timer)
                                    spin_unlock(transport_lock)
                                    wake_up_bit(XPRT_LOCKED)

The mod_timer() call being after del_timer_sync() is the problem.

If the wait_on_bit_lock() was just a little earlier and had to wait, it
wouldn't be woken until it was safe, so it is a small race window to
hit.

An alternate fix might be to move the xprt_schedule_autodisconnect()
call before xprt->ops->release_xprt(), but as a spinlock was already
used to group these operations, I thought it simpler to use the spinlock
to remove the race.

The only evidence I have that it is possible at all is two crash dumps
with run_timer_softirq() tripping over a corrupt timer.
The timer function is xprt_init_autodisconnect()
The ->next pointer is LIST_POISON2, so detach_timer() must have been
called on the timer, but it was still found in the list of pending
timers.

It looks like the xprt was freed just after above race, so timer was
still active, then allocated again so timer was reinitialised, then
freed again, so del_timer_sync() as called and ->next became
LIST_POISON2. At the time of the crash, the memory was unallocated.

I cannot be 100% certain this race is happening, but I cannot find any
other path by which it is even vaguely possible.

Thanks,
NeilBrown

>=20
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > =C2=A0net/sunrpc/xprt.c | 7 +++++++
> > =C2=A01 file changed, 7 insertions(+)
> >=20
> > diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> > index a02de2bddb28..5388263f8fc8 100644
> > --- a/net/sunrpc/xprt.c
> > +++ b/net/sunrpc/xprt.c
> > @@ -2112,7 +2112,14 @@ static void xprt_destroy(struct rpc_xprt
> > *xprt)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wait_on_bit_lock(&xprt->s=
tate, XPRT_LOCKED,
> > TASK_UNINTERRUPTIBLE);
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * xprt_schedule_autodisconnec=
t() can run after XPRT_LOCKED
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is cleared.=C2=A0 We use ->=
transport_lock to ensure the
> > mod_timer()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can only run *before* del_t=
ime_sync(), never after.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&xprt->transport_loc=
k);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0del_timer_sync(&xprt->tim=
er);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock(&xprt->transport_l=
ock);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Destroy sockets etc fr=
om the system workqueue so they can
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20
