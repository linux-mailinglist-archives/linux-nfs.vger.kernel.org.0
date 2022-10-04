Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BF65F4BBD
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 00:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJDWRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 18:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJDWRg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 18:17:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461669F4A
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 15:17:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B9E11F8F6;
        Tue,  4 Oct 2022 22:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664921854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YHB4eKZj4s/GZfWlDLRX3bMXEI3dxt9yepXSaHJLZ0=;
        b=n+aBkM6R7PUeAMi+lNTBp0RT1Kv85FTg5ZkfgkD7J1Vzj1xHBSLzOrrEJ7fLwov9p+IDPn
        +2gSaYwr+0SDh73+cHaJkwr/f7CwCw/igpzDRLPYBKzz7DSyb761YNxaGVmMj1mIddNDId
        5E++ICSO7xNqQgkYoa6iFyvyQ5Ib9LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664921854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YHB4eKZj4s/GZfWlDLRX3bMXEI3dxt9yepXSaHJLZ0=;
        b=A8cYlBRC61UzxAA9U+r9nAYgkgq/zUDpQD/68Vk+cJzNEn/XtYK7k9g2qAckdJ/7+dKenw
        A3+9oGI67aLLBZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18739139D2;
        Tue,  4 Oct 2022 22:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uNnWMPywPGNdKAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Oct 2022 22:17:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: nfsd: another possible delegation race
In-reply-to: <A20D72B2-097F-4240-A894-0759B53C02F4@oracle.com>
References: <166486048770.14457.133971372966856907@noble.neil.brown.name>,
 <A20D72B2-097F-4240-A894-0759B53C02F4@oracle.com>
Date:   Wed, 05 Oct 2022 09:17:29 +1100
Message-id: <166492184913.14457.15445320504611194255@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 05 Oct 2022, Chuck Lever III wrote:
> 
> > On Oct 4, 2022, at 1:14 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > Hi,
> > I have a customer who experienced a crash in nfsd which appears to be
> > related to delegation return.  I cannot completely rule-out
> >  Commit 548ec0805c39 ("nfsd: fix use-after-free due to delegation race")
> > as the kernel being used didn't have that commit, but the symptoms are
> > quite different, and while exploring I found, I think, a different
> > race.  This new race doesn't obviously address all the symptoms, but
> > maybe it does...
> > 
> > The symptoms were:
> >  1/   WARN_ON(!unhash_delegation_locked(dp));
> >    in nfs4_laundromat complained (delegation wasn't hashed!)
> >  2/   refcount_t: saturated; leaking memory
> >    This came from the refcount_inc in revoke_delegation() called from
> >    nfs4_laundromat(), a few lines below the above warning
> >  3/ BUG: kernel NULL pointer dereference, address: 0000000000000028
> >     This is from the destroy_unhashed_deleg() call at the end of
> >     that same revoke_delegation() call, which calls
> >     nfs4_unlock_deleg_lease() and passes fp->fi_deleg_file, which is
> >     NULL (!!!), to vfs_setlease().
> >  These three happened in a 200usec window.
> > 
> > What I imagine might be happening is that the nfsd_break_deleg_cb()
> > callback is called after destroy_delegation() has unhashed the deleg,
> > but before destroy_unhashed_delegation() gets called.
> > 
> > If nfsd_break_deleg_cb() is called before the unhash - and particularly
> > if nfsd_break_one_deleg()->nfsd4_run_cb() is called before, then the
> > unhash will disconnect the delegation from the recall list, and no
> > harm can be done.
> > Once vfs_setlease(F_UNLCK) is called, the callback can no longer be
> > called, so again no harm is possible.
> > 
> > Between these two is a race window.  The delegation can be put on the
> > recall list, but the deleg will be unhashed and put_deleg_file() will
> > have set fi_deleg_file to NULL - resulting in first WARNING and the
> > BUG.
> 
> That seems plausible. I've been accepting defensive patches like
> what you proposed below, so I can queue that up for v6.2 as soon as
> you post an official version.
> 
> It would help to know the kernel version where you encountered
> these symptoms, and to have a rough description of the workload;
> I assume you do not have a reliable reproducer. I'm wondering if
> there should be a bug report too (bugzilla.linux-nfs.org)?
> 
Kernel version 5.3.18 plus various backported patches SLE15-SP3 from
July 2021, so not ancient but not the most recent either.

I don't have any workload information.
bug 394 seem much the same, though details might be different.

> 
> > I cannot see how the refcount_t warning can be generated ...  so maybe
> > I've missed something.
> 
> stid refcounting does not seem reliable in the current code base.
> It's possible that the overflow is a separate issue that simply
> appeared at the same time or due to the same conditions that
> triggered the BUG.

Maybe ... though refcount is quite noisy about anything suspicious....

Aha.. The refcount is at the start of the structure.  When slub frees an
allocation, it put is on a freelist with pointers at the start of the
allocation.  So freeing an nfsd_deleg will corrupt the refcount.
So when refcount_inc() is called on a freed nfsd_deleg, we get the
"saturation" error, because pointers tend to look like negative numbers.

One would expect to see sc_type corrupt too because it is within the
first 64 bits of the start of the struct, but it is set explicitly in
revoke_delegation() which happens after the struct is freed, and is
where the crash happens.

Oh good - I think I understand it all now.  Thanks :-)

NeilBrown
