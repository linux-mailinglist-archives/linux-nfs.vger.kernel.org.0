Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7249A679
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 03:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350263AbiAYCIm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 21:08:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34914 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2364027AbiAXXqi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 18:46:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A5F761F380;
        Mon, 24 Jan 2022 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643067994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1VqbzJOlGaifaJnTpeWcxfAXBKCS/nij+vQJOJ3HYI=;
        b=gd9YP1OwwM9EE18VcdplcmS8vgRb11eFIMf2Idn01IxEEFN7FGU1LkehFkDnHXqHObFMiQ
        iZL5byRajJgg0yxB0KlaDLqzWMled8a6Ids3nyx50h1YpmTTJr+uwdLkhWW+5ucoCWwHVa
        uBmcqTeCY/ZVqEkTaBTpwcFtLOkmZMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643067994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1VqbzJOlGaifaJnTpeWcxfAXBKCS/nij+vQJOJ3HYI=;
        b=MvM1UsnPFohYkN7sJghezQxpFZ/Attv7WTV0IKxefUlEXEaJxuoYuNEA8wE3l7SDPZ2zRP
        /3TsjuIJ6mWOhsAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC79213CDE;
        Mon, 24 Jan 2022 23:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bXMeGVg672HJdgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 23:46:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: dynamic management of nfsd thread count
In-reply-to: <EF3A3E35-FD8F-4ADF-AAFD-A120D83F80F5@oracle.com>
References: <EF3A3E35-FD8F-4ADF-AAFD-A120D83F80F5@oracle.com>
Date:   Tue, 25 Jan 2022 10:46:18 +1100
Message-id: <164306797808.8775.17626755733657689261@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022, Chuck Lever III wrote:
> Hi Neil-
>=20
> The clean-up of NFSD thread management has been merged into v5.17-rc.
> I'm wondering if you have thought more about how to implement dynamic
> management.

I have some scraps of code but nothing much.
My plan is to have threads exit after they have been around for "a
while" and have new threads be created when there is "apparent need".

I think there always needs to be at least one thread (as thread creation
can fail, or block for a long time), but if there are > 1 and a thread
finds that it has nothing immediately to do, and it has been over (e.g.)
5 minutes since it was created, then it exits.  So there will always be
gentle downward pressure on the number of threads.

When data arrives on a transport and there is no thread available to
process it, then we need to consider starting a new thread.  This is by
far the most interesting part.  I think we want a rate limit as a
function of the number of threads already existing.
e.g.:=20
  if there are fewer than "nr_threads" threads, then start a thread.
  if there are between "nr_threads" and "8*nr_threads", then schedule a threa=
d to
     start in 10ms unless that has already been scheduled
  if there are more than "8*nr_threads", then don't start new threads

Obviously there are some magic numbers in there that need to be
justified, and I don't have any justification as yet.
The "10ms" should ideally be related to the typical request-processing
time (mean? max? mid-range?)
The "8*nr_threads" should probably be separately configurable, with
something like that value as a default.

So with the default of 4 (or 8?) threads, the count will quickly grow to
that number if there is any load, then slowly grow beyond that as load
persists.
It would be nice to find a way to measure if the nfsd threads are
overloading the system in some way, but I haven't yet thought about what
that might mean.

>=20
> One thing that occurred to me was that there was a changeset that
> attempted to convert NFSD threads into work queues. We merged some
> of that but stopped when it was found that work queue scheduling
> seems to have some worst case behavior that sometimes impacts the
> performance of the Linux NFS server.
>=20
> The part of that work that was merged is now vestigial, and might
> need to be reverted before proceeding with dynamic NFSD thread
> management. For example:
>=20
>  476 void svc_xprt_enqueue(struct svc_xprt *xprt)
>  477 {
>  478         if (test_bit(XPT_BUSY, &xprt->xpt_flags))
>  479                 return;
>  480         xprt->xpt_server->sv_ops->svo_enqueue_xprt(xprt);
>  481 }
>  482 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
>=20
> The svo_enqueue_xprt method was to be different for the different
> scheduling mechanisms. But to this day there is only one method
> defined: svc_xprt_do_enqueue()
>=20
> Do you have plans to use this or discard it? If not, I'd like to
> see that it is removed eventually, as virtual functions are
> more costly than they used to be thanks to Spectre/Meltdown, and
> this one is invoked multiple times per RPC.

I think this can go - I see no use for it.

I suspect svo_module can go as well - I don't think the thread is ever
the thing that primarily keeps a module active.
svo_shutdown can go too.  any code that calls svc_shutdown_net() knows
what the shutdown function should be, and so can call it directly.

svo_function is useful, but as it is the only thing in sv_ops that is
needed, we can drop the sv_ops structure and just have a pointer to the
svo_function directly in the svc_serv.

I'm happy to provide patches for all this if you like.

NeilBrown
