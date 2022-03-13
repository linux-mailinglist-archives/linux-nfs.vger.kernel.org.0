Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A484D78C1
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiCMXi4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 19:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiCMXi4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 19:38:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0845F13EB9
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 16:37:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 999F121102;
        Sun, 13 Mar 2022 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647214664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dla9KEMSVko15AJLZY8yIKkEagzAWjlWUm7tze1A3Ro=;
        b=jVz9eF8uqZVZO4/SmYibTn9/Sc0lqGwYBLRhzBTXuNCerusiklXxUKR+9Pg0ZgE2WO8RZa
        9rph5fN83qxZXHfHU21rsEHCAlh/cWUyVP95zR3xrG0wlNrAXrNMSH0WYpWzZ8u1hb/7xn
        wmgI3HTcFInDaQWwP0h55LNTOejlzCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647214664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dla9KEMSVko15AJLZY8yIKkEagzAWjlWUm7tze1A3Ro=;
        b=nlz9zvaR2RP6Lx6IT3anP3qzcg3HLgWznqvvHEwqU2qxzOZTFAPJs59Yws2IqGkQs72E2l
        +ePVOQQ/rlCdQ9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7990C13B18;
        Sun, 13 Mar 2022 23:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pqmzDUeALmKJTQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 13 Mar 2022 23:37:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: avoid race between mod_timer() and del_timer_sync()
In-reply-to: <fc573816f371092d259242448b774e7497dbc5d3.camel@hammerspace.com>
References: <164670733789.31932.14711754930977072270@noble.neil.brown.name>,
 <8af5700311c3ca5ea4931072f0717bb133c79dfb.camel@hammerspace.com>,
 <164720902908.7120.4478916458622123003@noble.neil.brown.name>,
 <fc573816f371092d259242448b774e7497dbc5d3.camel@hammerspace.com>
Date:   Mon, 14 Mar 2022 10:37:40 +1100
Message-id: <164721466019.11933.16099062109185493938@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 14 Mar 2022, Trond Myklebust wrote:
> On Mon, 2022-03-14 at 09:03 +1100, NeilBrown wrote:
> > On Sun, 13 Mar 2022, Trond Myklebust wrote:
> > > On Tue, 2022-03-08 at 13:42 +1100, NeilBrown wrote:
> > > >=20
> > > > xprt_destory() claims XPRT_LOCKED and then calls
> > > > del_timer_sync().
> > > > Both xprt_unlock_connect() and xprt_release() call
> > > > =C2=A0->release_xprt()
> > > > which drops XPRT_LOCKED and *then* xprt_schedule_autodisconnect()
> > > > which calls mod_timer().
> > > >=20
> > > > This may result in mod_timer() being called *after*
> > > > del_timer_sync().
> > > > When this happens, the timer may fire long after the xprt has
> > > > been
> > > > freed,
> > > > and run_timer_softirq() will probably crash.
> > > >=20
> > > > The pairing of ->release_xprt() and
> > > > xprt_schedule_autodisconnect() is
> > > > always called under ->transport_lock.=C2=A0 So if we take -
> > > > >transport_lock
> > > > to
> > > > call del_timer_sync(), we can be sure that mod_timer() will run
> > > > first
> > > > (if it runs at all).
> > >=20
> > > xprt_destroy() never releases XPRT_LOCKED, so how could the above
> > > race
> > > happen?
> >=20
> > the race would happen as xprt_destroy() is taking the lock.
> > One core is in xprt_destroy(), the other in xprt_unlock_connect()
> >=20
> > =C2=A0=C2=A0 Core 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Core 2
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(tra=
nsport_lock)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xprt->ops->re=
lease_xprt()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 aka xprt_release_xprt()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 This clears XPRT_LOCKED
> > =C2=A0 wait_on_bit_lock(XPRT_LOCKED)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This doesn't need to wait
> > =C2=A0 del_timer_sync(->timer)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xprt_schedule=
_autodisconnect()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
alls mod_timer(->timer)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(t=
ransport_lock)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_bit(X=
PRT_LOCKED)
> >=20
> > The mod_timer() call being after del_timer_sync() is the problem.
> >=20
> > If the wait_on_bit_lock() was just a little earlier and had to wait,
> > it
> > wouldn't be woken until it was safe, so it is a small race window to
> > hit.
> >=20
> > An alternate fix might be to move the xprt_schedule_autodisconnect()
> > call before xprt->ops->release_xprt(), but as a spinlock was already
> > used to group these operations, I thought it simpler to use the
> > spinlock
> > to remove the race.
> >=20
> > The only evidence I have that it is possible at all is two crash
> > dumps
> > with run_timer_softirq() tripping over a corrupt timer.
> > The timer function is xprt_init_autodisconnect()
> > The ->next pointer is LIST_POISON2, so detach_timer() must have been
> > called on the timer, but it was still found in the list of pending
> > timers.
> >=20
> > It looks like the xprt was freed just after above race, so timer was
> > still active, then allocated again so timer was reinitialised, then
> > freed again, so del_timer_sync() as called and ->next became
> > LIST_POISON2. At the time of the crash, the memory was unallocated.
> >=20
> > I cannot be 100% certain this race is happening, but I cannot find
> > any
> > other path by which it is even vaguely possible.
>=20
> The above looks plausible, and I think this patch is the correct one.=C2=A0

Thanks.

> The one additional change I suggest is that we also move the
> wake_up_bit() in xprt_connect_unlock() inside the spinlock, so that we
> avoid a potential use-after-free.

I had a look and I don't think this is needed.
wake_up_bit() doesn't dereference the pointer.  It hashes the address
together with the bit to choose a wake_queue to wake up.
The wake_bit_function() which might be called as part of that wakeup
will test_bit() the given bit at the given address, but only after
the address has been found to match an address that something is waiting
on.  So that something must hold a reference to stop the memory being
freed.

However, as I was looking, I was reminded of the use of XPRT_LOCKED in
sysfs.c which isn't safe.
Two sysfs functions use wait_on_bit_lock() to wait for XPRT_LOCKED.
However most places that clear XPRT_LOCKED don't generate a wakeup,
so these can wait indefinitely.  This can easily be reproduced by
writing "online" to "xprt_state" in a tight loop while there is
concurrent NFS traffic.=20

If we wanted to add a wake_up_bit() whenever XPRT_LOCKED is cleared,
that would be remove that race and it would trivially put wake_up_bit()
inside the spinlock anyway.

I'm not sure all those wakeups are really warranted, but it isn't clear
to me what the sysfs functions should be waiting for, so I'm not
certain.

Thanks,
NeilBrown
