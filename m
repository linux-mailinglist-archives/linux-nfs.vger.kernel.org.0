Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30AB4E25CA
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Mar 2022 12:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiCUL6r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 07:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347157AbiCUL60 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 07:58:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B812AE5;
        Mon, 21 Mar 2022 04:56:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s207so15902267oie.11;
        Mon, 21 Mar 2022 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5T6DI7AkPvB4V935ogF76yCUBMnMQ3VXXVYsoMJqvMw=;
        b=Ag0mh8SXiY6dYBBkZJk+JHK3tEx4LkqILNFbfSh8uJ3NFIMjnZnMwFlCSWmOng+m2o
         hnft/50ssxVwXlDmvEBf3VklElT/v1v/8LJNKx+6jOp4dFlCDlT+1ceMGpu/K44v0dqS
         Cx4WiLgi2zWOQB0Q1BC09qabC0IAXrNYC4+UQgfXRv8hxLfDG+7WKikJEGo3xfdAdCoy
         dTbuI6VTI/pFOO2uGmDyK2U37P3BtdpJ8BN37UbhVnoBoPBFSRoNgA7ZIPRqSpP/ZR9r
         Bcr9MLvEonQ6uPZoo8rCHndfovXUB8H0UuebkbKuC8oGAbwARQ6UjZuJ0GSIXDX2OXVJ
         6E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T6DI7AkPvB4V935ogF76yCUBMnMQ3VXXVYsoMJqvMw=;
        b=R739aLp+NoHg6d2kS4G9rZ/5vfUJ+AhQeff9BBLgLANuWdc8a4CEEZFTH73dUEofJl
         y8iV3IZPoItCRkaSXu1f4HiEGQ9ztV0q97NY6n9o4KxYARjADpVCoQEd8oLX5sV4YHhM
         kqui4GP8BbXRyWYRlkc5BOoesCuEDVZT3uryOv+1GZazpl6IAnf3gXmeHo9bIQ5Njsl2
         jTMY6PJhMrOG3oNt6H60lw0q/WrviAdaVyAKKKsyhBPRdQxUhNpl+eyOOu56fZITOmRA
         a2eb2kCTEdvywgblmSincZzgPZ/jiYVRan+KKI0hiXAULxrX913GWG+23nmwmZH8IFaa
         9RVg==
X-Gm-Message-State: AOAM530y+TwLFdJoYZMrS/pUL5n67uyP8WZXLo311s3t2OvrzyDyeTRc
        O6xZmD53+dNv5Izdf6Hl7nwKi6S5gdPPaxgU6VM=
X-Google-Smtp-Source: ABdhPJwipqjcwh11ikvZDaa6GIVJEmI4ufGlrxHAi7Hc8/978YGfWuDdNCj3n81bkSzxXxe9o9/cnjI9yfEGwTJwkCI=
X-Received: by 2002:a05:6808:994:b0:2ee:f9f3:99ec with SMTP id
 a20-20020a056808099400b002eef9f399ecmr10683387oic.98.1647863819270; Mon, 21
 Mar 2022 04:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220319001635.4097742-1-khazhy@google.com> <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com> <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
In-Reply-To: <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 21 Mar 2022 13:56:47 +0200
Message-ID: <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "khazhy@google.com" <khazhy@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 21, 2022 at 1:23 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 19-03-22 11:36:13, Amir Goldstein wrote:
> > On Sat, Mar 19, 2022 at 9:02 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
> > >
> > > On Fri, 2022-03-18 at 17:16 -0700, Khazhismel Kumykov wrote:
> > > > fsnotify_add_inode_mark may allocate with GFP_KERNEL, which may
> > > > result
> > > > in recursing back into nfsd, resulting in deadlock. See below stack.
> > > >
> > > > nfsd            D    0 1591536      2 0x80004080
> > > > Call Trace:
> > > >  __schedule+0x497/0x630
> > > >  schedule+0x67/0x90
> > > >  schedule_preempt_disabled+0xe/0x10
> > > >  __mutex_lock+0x347/0x4b0
> > > >  fsnotify_destroy_mark+0x22/0xa0
> > > >  nfsd_file_free+0x79/0xd0 [nfsd]
> > > >  nfsd_file_put_noref+0x7c/0x90 [nfsd]
> > > >  nfsd_file_lru_dispose+0x6d/0xa0 [nfsd]
> > > >  nfsd_file_lru_scan+0x57/0x80 [nfsd]
> > > >  do_shrink_slab+0x1f2/0x330
> > > >  shrink_slab+0x244/0x2f0
> > > >  shrink_node+0xd7/0x490
> > > >  do_try_to_free_pages+0x12f/0x3b0
> > > >  try_to_free_pages+0x43f/0x540
> > > >  __alloc_pages_slowpath+0x6ab/0x11c0
> > > >  __alloc_pages_nodemask+0x274/0x2c0
> > > >  alloc_slab_page+0x32/0x2e0
> > > >  new_slab+0xa6/0x8b0
> > > >  ___slab_alloc+0x34b/0x520
> > > >  kmem_cache_alloc+0x1c4/0x250
> > > >  fsnotify_add_mark_locked+0x18d/0x4c0
> > > >  fsnotify_add_mark+0x48/0x70
> > > >  nfsd_file_acquire+0x570/0x6f0 [nfsd]
> > > >  nfsd_read+0xa7/0x1c0 [nfsd]
> > > >  nfsd3_proc_read+0xc1/0x110 [nfsd]
> > > >  nfsd_dispatch+0xf7/0x240 [nfsd]
> > > >  svc_process_common+0x2f4/0x610 [sunrpc]
> > > >  svc_process+0xf9/0x110 [sunrpc]
> > > >  nfsd+0x10e/0x180 [nfsd]
> > > >  kthread+0x130/0x140
> > > >  ret_from_fork+0x35/0x40
> > > >
> > > > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > > > ---
> > > >  fs/nfsd/filecache.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > Marking this RFC since I haven't actually had a chance to test this,
> > > > we
> > > > we're seeing this deadlock for some customers.
> > > >
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index fdf89fcf1a0c..a14760f9b486 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -121,6 +121,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > > > *nf)
> > > >         struct fsnotify_mark    *mark;
> > > >         struct nfsd_file_mark   *nfm = NULL, *new;
> > > >         struct inode *inode = nf->nf_inode;
> > > > +       unsigned int pflags;
> > > >
> > > >         do {
> > > >                 mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
> > > > @@ -149,7 +150,10 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > > > *nf)
> > > >                 new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
> > > >                 refcount_set(&new->nfm_ref, 1);
> > > >
> > > > +               /* fsnotify allocates, avoid recursion back into nfsd
> > > > */
> > > > +               pflags = memalloc_nofs_save();
> > > >                 err = fsnotify_add_inode_mark(&new->nfm_mark, inode,
> > > > 0);
> > > > +               memalloc_nofs_restore(pflags);
> > > >
> > > >                 /*
> > > >                  * If the add was successful, then return the object.
> > >
> > > Isn't that stack trace showing a slab direct reclaim, and not a
> > > filesystem writeback situation?
> > >
> > > Does memalloc_nofs_save()/restore() really fix this problem? It seems
> > > to me that it cannot, particularly since knfsd is not a filesystem, and
> > > so does not ever handle writeback of dirty pages.
> > >
> >
> > Maybe NOFS throttles direct reclaims to the point that the problem is
> > harder to hit?
> >
> > This report came in at good timing for me.
> >
> > It demonstrates an issue I did not predict for "volatile"' fanotify marks [1].
> > As far as I can tell, nfsd filecache is currently the only fsnotify backend that
> > frees fsnotify marks in memory shrinker. "volatile" fanotify marks would also
> > be evictable in that way, so they would expose fanotify to this deadlock.
> >
> > For the short term, maybe nfsd filecache can avoid the problem by checking
> > mutex_is_locked(&nfsd_file_fsnotify_group->mark_mutex) and abort the
> > shrinker. I wonder if there is a place for a helper mutex_is_locked_by_me()?
> >
> > Jan,
> >
> > A relatively simple fix would be to allocate fsnotify_mark_connector in
> > fsnotify_add_mark() and free it, if a connector already exists for the object.
> > I don't think there is a good reason to optimize away this allocation
> > for the case of a non-first group to set a mark on an object?
>
> Indeed, nasty. Volatile marks will add group->mark_mutex into a set of
> locks grabbed during inode slab reclaim. So any allocation under
> group->mark_mutex has to be GFP_NOFS now. This is not just about connector
> allocations but also mark allocations for fanotify. Moving allocations from
> under mark_mutex is also possible solution but passing preallocated memory
> around is kind of ugly as well.

Yes, kind of, here is how it looks:
https://github.com/amir73il/linux/commit/643bb6b9f664f70f68ea0393a06338673c4966b3
https://github.com/amir73il/linux/commit/66f27fc99e46b12f1078e8e2915793040ce50ee7

> So the cleanest solution I currently see is
> to come up with helpers like "fsnotify_lock_group() &
> fsnotify_unlock_group()" which will lock/unlock mark_mutex and also do
> memalloc_nofs_save / restore magic.
>

Sounds good. Won't this cause a regression - more failures to setup new mark
under memory pressure?

Should we maintain a flag in the group FSNOTIFY_GROUP_SHRINKABLE?
and set NOFS state only in that case, so at least we don't cause regression
for existing applications?

Thanks,
Amir.
