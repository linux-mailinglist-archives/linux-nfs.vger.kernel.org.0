Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED24E3C8D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 11:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiCVKjP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Mar 2022 06:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiCVKjO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Mar 2022 06:39:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507918020C;
        Tue, 22 Mar 2022 03:37:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA2ED1F37C;
        Tue, 22 Mar 2022 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647945465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmbUswLJoIAaiGeCon8zxgA+Ily6/JQQW3FtwFLIyVQ=;
        b=EGp9LJf8pvt0tM2iT2vBf2GUcktImAOaYYMJUqQbOHTO2xyfWiL2prt8XyKhUqxj1IVMA3
        atpJ3+sDilSPm2Iv6wBQgLsTmIL/9WrHCOgFRVVdo4eWmdx00dx/mNHAjLAOrPIN3UCCEd
        jb1VJIhhYVH15JsKUO+kzs9yrh23s8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647945465;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmbUswLJoIAaiGeCon8zxgA+Ily6/JQQW3FtwFLIyVQ=;
        b=3JVJ1Yl6N+w3j/zqml7u8u8upXTbA9FT34zEjq/Hbk9pt/pQgnT8THFshn3Kl0VPkOF9N7
        X08AOQiR+as64HDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A07FA3B81;
        Tue, 22 Mar 2022 10:37:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1829EA0610; Tue, 22 Mar 2022 11:37:44 +0100 (CET)
Date:   Tue, 22 Mar 2022 11:37:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jack@suse.cz" <jack@suse.cz>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Message-ID: <20220322103744.niejj6ovzxyfej74@quack3.lan>
References: <20220319001635.4097742-1-khazhy@google.com>
 <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
 <31f7822e84583235d84b8c7be24360c46c7450f7.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31f7822e84583235d84b8c7be24360c46c7450f7.camel@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon 21-03-22 22:50:11, Trond Myklebust wrote:
> On Mon, 2022-03-21 at 12:23 +0100, Jan Kara wrote:
> > On Sat 19-03-22 11:36:13, Amir Goldstein wrote:
> > > On Sat, Mar 19, 2022 at 9:02 AM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > > 
> > > > On Fri, 2022-03-18 at 17:16 -0700, Khazhismel Kumykov wrote:
> > > > > fsnotify_add_inode_mark may allocate with GFP_KERNEL, which may
> > > > > result
> > > > > in recursing back into nfsd, resulting in deadlock. See below
> > > > > stack.
> > > > > 
> > > > > nfsd            D    0 1591536      2 0x80004080
> > > > > Call Trace:
> > > > >  __schedule+0x497/0x630
> > > > >  schedule+0x67/0x90
> > > > >  schedule_preempt_disabled+0xe/0x10
> > > > >  __mutex_lock+0x347/0x4b0
> > > > >  fsnotify_destroy_mark+0x22/0xa0
> > > > >  nfsd_file_free+0x79/0xd0 [nfsd]
> > > > >  nfsd_file_put_noref+0x7c/0x90 [nfsd]
> > > > >  nfsd_file_lru_dispose+0x6d/0xa0 [nfsd]
> > > > >  nfsd_file_lru_scan+0x57/0x80 [nfsd]
> > > > >  do_shrink_slab+0x1f2/0x330
> > > > >  shrink_slab+0x244/0x2f0
> > > > >  shrink_node+0xd7/0x490
> > > > >  do_try_to_free_pages+0x12f/0x3b0
> > > > >  try_to_free_pages+0x43f/0x540
> > > > >  __alloc_pages_slowpath+0x6ab/0x11c0
> > > > >  __alloc_pages_nodemask+0x274/0x2c0
> > > > >  alloc_slab_page+0x32/0x2e0
> > > > >  new_slab+0xa6/0x8b0
> > > > >  ___slab_alloc+0x34b/0x520
> > > > >  kmem_cache_alloc+0x1c4/0x250
> > > > >  fsnotify_add_mark_locked+0x18d/0x4c0
> > > > >  fsnotify_add_mark+0x48/0x70
> > > > >  nfsd_file_acquire+0x570/0x6f0 [nfsd]
> > > > >  nfsd_read+0xa7/0x1c0 [nfsd]
> > > > >  nfsd3_proc_read+0xc1/0x110 [nfsd]
> > > > >  nfsd_dispatch+0xf7/0x240 [nfsd]
> > > > >  svc_process_common+0x2f4/0x610 [sunrpc]
> > > > >  svc_process+0xf9/0x110 [sunrpc]
> > > > >  nfsd+0x10e/0x180 [nfsd]
> > > > >  kthread+0x130/0x140
> > > > >  ret_from_fork+0x35/0x40
> > > > > 
> > > > > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > > > > ---
> > > > >  fs/nfsd/filecache.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > > 
> > > > > Marking this RFC since I haven't actually had a chance to test
> > > > > this,
> > > > > we
> > > > > we're seeing this deadlock for some customers.
> > > > > 
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index fdf89fcf1a0c..a14760f9b486 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -121,6 +121,7 @@ nfsd_file_mark_find_or_create(struct
> > > > > nfsd_file
> > > > > *nf)
> > > > >         struct fsnotify_mark    *mark;
> > > > >         struct nfsd_file_mark   *nfm = NULL, *new;
> > > > >         struct inode *inode = nf->nf_inode;
> > > > > +       unsigned int pflags;
> > > > > 
> > > > >         do {
> > > > >                 mutex_lock(&nfsd_file_fsnotify_group-
> > > > > >mark_mutex);
> > > > > @@ -149,7 +150,10 @@ nfsd_file_mark_find_or_create(struct
> > > > > nfsd_file
> > > > > *nf)
> > > > >                 new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
> > > > >                 refcount_set(&new->nfm_ref, 1);
> > > > > 
> > > > > +               /* fsnotify allocates, avoid recursion back
> > > > > into nfsd
> > > > > */
> > > > > +               pflags = memalloc_nofs_save();
> > > > >                 err = fsnotify_add_inode_mark(&new->nfm_mark,
> > > > > inode,
> > > > > 0);
> > > > > +               memalloc_nofs_restore(pflags);
> > > > > 
> > > > >                 /*
> > > > >                  * If the add was successful, then return the
> > > > > object.
> > > > 
> > > > Isn't that stack trace showing a slab direct reclaim, and not a
> > > > filesystem writeback situation?
> > > > 
> > > > Does memalloc_nofs_save()/restore() really fix this problem? It
> > > > seems
> > > > to me that it cannot, particularly since knfsd is not a
> > > > filesystem, and
> > > > so does not ever handle writeback of dirty pages.
> > > > 
> > > 
> > > Maybe NOFS throttles direct reclaims to the point that the problem
> > > is
> > > harder to hit?
> > > 
> > > This report came in at good timing for me.
> > > 
> > > It demonstrates an issue I did not predict for "volatile"' fanotify
> > > marks [1].
> > > As far as I can tell, nfsd filecache is currently the only fsnotify
> > > backend that
> > > frees fsnotify marks in memory shrinker. "volatile" fanotify marks
> > > would also
> > > be evictable in that way, so they would expose fanotify to this
> > > deadlock.
> > > 
> > > For the short term, maybe nfsd filecache can avoid the problem by
> > > checking
> > > mutex_is_locked(&nfsd_file_fsnotify_group->mark_mutex) and abort
> > > the
> > > shrinker. I wonder if there is a place for a helper
> > > mutex_is_locked_by_me()?
> > > 
> > > Jan,
> > > 
> > > A relatively simple fix would be to allocate
> > > fsnotify_mark_connector in
> > > fsnotify_add_mark() and free it, if a connector already exists for
> > > the object.
> > > I don't think there is a good reason to optimize away this
> > > allocation
> > > for the case of a non-first group to set a mark on an object?
> > 
> > Indeed, nasty. Volatile marks will add group->mark_mutex into a set
> > of
> > locks grabbed during inode slab reclaim. So any allocation under
> > group->mark_mutex has to be GFP_NOFS now. This is not just about
> > connector
> > allocations but also mark allocations for fanotify. Moving
> > allocations from
> > under mark_mutex is also possible solution but passing preallocated
> > memory
> > around is kind of ugly as well. So the cleanest solution I currently
> > see is
> > to come up with helpers like "fsnotify_lock_group() &
> > fsnotify_unlock_group()" which will lock/unlock mark_mutex and also
> > do
> > memalloc_nofs_save / restore magic. 
> 
> As has already been reported, the problem was fixed in Linux 5.5 by the
> garbage collector rewrite, and so this is no longer an issue.

Sorry, I was not clear enough I guess. NFS is not a problem since 5.5 as
you say. But Amir has changes in the works after which any filesystem inode
reclaim could end up in exactly the same path (calling
fsnotify_destroy_mark() from clear_inode()). So these changes would
introduce the same deadlock NFS was prone to before 5.5.

> In addition, please note that memalloc_nofs_save/restore and the use of
> GFP_NOFS was never a solution, because it does not prevent the kind of
> direct reclaim that was happening here. You'd have to enforce
> GFP_NOWAIT allocations, afaics.

GFP_NOFS should solve the above problem because with GFP_NOFS we cannot
enter inode reclaim from the memory allocation and thus end up freeing
marks.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
