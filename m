Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52FD4E2B44
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Mar 2022 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349657AbiCUOxR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbiCUOwm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 10:52:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE0237D9;
        Mon, 21 Mar 2022 07:51:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5AF441F37C;
        Mon, 21 Mar 2022 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647874274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbrDCR0J5XThblCguHSJHDsBNerL7VvUKIeoVcpySS8=;
        b=NJpCAfgkBTFzQ1hNrQHXNjpeVPjy7qPKmPeVrJXXXgmjX20M1MXMsFfZm+P4Nq/C+AmlUL
        DDi7Abt6TBRanpE1BC3bpw811nZxUH78/cgqDdh9ja4UnRsutBsV9DMf8/jdvG7eBjayUk
        p5aBzGnInqzCKrcNmTdDznGKtdHrDIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647874274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbrDCR0J5XThblCguHSJHDsBNerL7VvUKIeoVcpySS8=;
        b=wj2qKJ1KhORR++aHSIwKb63HUhlMn1ktDnai8hKNbRnqw7QtLZQCJIxubn1bs2zZAie/q2
        H8dVuDHFpVn4NoBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B2F8A3B88;
        Mon, 21 Mar 2022 14:51:13 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B2A77A0610; Mon, 21 Mar 2022 15:51:11 +0100 (CET)
Date:   Mon, 21 Mar 2022 15:51:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "khazhy@google.com" <khazhy@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Message-ID: <20220321145111.qz3bngofoi5r5cmh@quack3.lan>
References: <20220319001635.4097742-1-khazhy@google.com>
 <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
 <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon 21-03-22 13:56:47, Amir Goldstein wrote:
> On Mon, Mar 21, 2022 at 1:23 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 19-03-22 11:36:13, Amir Goldstein wrote:
> > > On Sat, Mar 19, 2022 at 9:02 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Fri, 2022-03-18 at 17:16 -0700, Khazhismel Kumykov wrote:
> > > > > fsnotify_add_inode_mark may allocate with GFP_KERNEL, which may
> > > > > result
> > > > > in recursing back into nfsd, resulting in deadlock. See below stack.
> > > > >
> > > > > nfsd            D    0 1591536      2 0x80004080
> > > > > Call Trace:
> > > > >  __schedule+0x497/0x630
> > > > >  schedule+0x67/0x90
> > > > >  schedule_preempt_disabled+0xe/0x10
> > > > >  __mutex_lock+0x347/0x4b0
> > > > >  fsnotify_destroy_mark+0x22/0xa0
> > > > >  nfsd_file_free+0x79/0xd0 [nfsd]
> > > > >  nfsd_file_put_noref+0x7c/0x90 [nfsd]
> > > > >  nfsd_file_lru_dispose+0x6d/0xa0 [nfsd]
> > > > >  nfsd_file_lru_scan+0x57/0x80 [nfsd]
> > > > >  do_shrink_slab+0x1f2/0x330
> > > > >  shrink_slab+0x244/0x2f0
> > > > >  shrink_node+0xd7/0x490
> > > > >  do_try_to_free_pages+0x12f/0x3b0
> > > > >  try_to_free_pages+0x43f/0x540
> > > > >  __alloc_pages_slowpath+0x6ab/0x11c0
> > > > >  __alloc_pages_nodemask+0x274/0x2c0
> > > > >  alloc_slab_page+0x32/0x2e0
> > > > >  new_slab+0xa6/0x8b0
> > > > >  ___slab_alloc+0x34b/0x520
> > > > >  kmem_cache_alloc+0x1c4/0x250
> > > > >  fsnotify_add_mark_locked+0x18d/0x4c0
> > > > >  fsnotify_add_mark+0x48/0x70
> > > > >  nfsd_file_acquire+0x570/0x6f0 [nfsd]
> > > > >  nfsd_read+0xa7/0x1c0 [nfsd]
> > > > >  nfsd3_proc_read+0xc1/0x110 [nfsd]
> > > > >  nfsd_dispatch+0xf7/0x240 [nfsd]
> > > > >  svc_process_common+0x2f4/0x610 [sunrpc]
> > > > >  svc_process+0xf9/0x110 [sunrpc]
> > > > >  nfsd+0x10e/0x180 [nfsd]
> > > > >  kthread+0x130/0x140
> > > > >  ret_from_fork+0x35/0x40
> > > > >
> > > > > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > > > > ---
> > > > >  fs/nfsd/filecache.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > Marking this RFC since I haven't actually had a chance to test this,
> > > > > we
> > > > > we're seeing this deadlock for some customers.
> > > > >
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index fdf89fcf1a0c..a14760f9b486 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -121,6 +121,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > > > > *nf)
> > > > >         struct fsnotify_mark    *mark;
> > > > >         struct nfsd_file_mark   *nfm = NULL, *new;
> > > > >         struct inode *inode = nf->nf_inode;
> > > > > +       unsigned int pflags;
> > > > >
> > > > >         do {
> > > > >                 mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
> > > > > @@ -149,7 +150,10 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > > > > *nf)
> > > > >                 new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
> > > > >                 refcount_set(&new->nfm_ref, 1);
> > > > >
> > > > > +               /* fsnotify allocates, avoid recursion back into nfsd
> > > > > */
> > > > > +               pflags = memalloc_nofs_save();
> > > > >                 err = fsnotify_add_inode_mark(&new->nfm_mark, inode,
> > > > > 0);
> > > > > +               memalloc_nofs_restore(pflags);
> > > > >
> > > > >                 /*
> > > > >                  * If the add was successful, then return the object.
> > > >
> > > > Isn't that stack trace showing a slab direct reclaim, and not a
> > > > filesystem writeback situation?
> > > >
> > > > Does memalloc_nofs_save()/restore() really fix this problem? It seems
> > > > to me that it cannot, particularly since knfsd is not a filesystem, and
> > > > so does not ever handle writeback of dirty pages.
> > > >
> > >
> > > Maybe NOFS throttles direct reclaims to the point that the problem is
> > > harder to hit?
> > >
> > > This report came in at good timing for me.
> > >
> > > It demonstrates an issue I did not predict for "volatile"' fanotify marks [1].
> > > As far as I can tell, nfsd filecache is currently the only fsnotify backend that
> > > frees fsnotify marks in memory shrinker. "volatile" fanotify marks would also
> > > be evictable in that way, so they would expose fanotify to this deadlock.
> > >
> > > For the short term, maybe nfsd filecache can avoid the problem by checking
> > > mutex_is_locked(&nfsd_file_fsnotify_group->mark_mutex) and abort the
> > > shrinker. I wonder if there is a place for a helper mutex_is_locked_by_me()?
> > >
> > > Jan,
> > >
> > > A relatively simple fix would be to allocate fsnotify_mark_connector in
> > > fsnotify_add_mark() and free it, if a connector already exists for the object.
> > > I don't think there is a good reason to optimize away this allocation
> > > for the case of a non-first group to set a mark on an object?
> >
> > Indeed, nasty. Volatile marks will add group->mark_mutex into a set of
> > locks grabbed during inode slab reclaim. So any allocation under
> > group->mark_mutex has to be GFP_NOFS now. This is not just about connector
> > allocations but also mark allocations for fanotify. Moving allocations from
> > under mark_mutex is also possible solution but passing preallocated memory
> > around is kind of ugly as well.
> 
> Yes, kind of, here is how it looks:
> https://github.com/amir73il/linux/commit/643bb6b9f664f70f68ea0393a06338673c4966b3
> https://github.com/amir73il/linux/commit/66f27fc99e46b12f1078e8e2915793040ce50ee7

Yup, not an act of beauty but bearable in the worst case :).

> > So the cleanest solution I currently see is
> > to come up with helpers like "fsnotify_lock_group() &
> > fsnotify_unlock_group()" which will lock/unlock mark_mutex and also do
> > memalloc_nofs_save / restore magic.
> >
> 
> Sounds good. Won't this cause a regression - more failures to setup new mark
> under memory pressure?

Well, yes, the chances of hitting ENOMEM under heavy memory pressure are
higher. But I don't think that much memory is consumed by connectors or
marks that the reduced chances for direct reclaim would really
substantially matter for the system as a whole.

> Should we maintain a flag in the group FSNOTIFY_GROUP_SHRINKABLE?
> and set NOFS state only in that case, so at least we don't cause regression
> for existing applications?

So that's a possibility I've left in my sleeve ;). We could do it but then
we'd also have to tell lockdep that there are two kinds of mark_mutex locks
so that it does not complain about possible reclaim deadlocks. Doable but
at this point I didn't consider it worth it unless someone comes with a bug
report from a real user scenario.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
