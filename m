Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185B9615535
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 23:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKAWmh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 18:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKAWmg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 18:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545D65CA
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 15:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 326BC61646
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 22:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7E7C433C1;
        Tue,  1 Nov 2022 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667342554;
        bh=q+DN04Z1E9B0mOWXAsSRyABm72HV6xvzKfYPb7XFiRE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J5hByNea6l1tKIonpCkbRPLTJ9ZKu8LmBPl/gZnHNAnaQSugh9L+uZcwNDvAJ6M6u
         dYyJq7oGZS8y84yzR2uw146OOCkQgEvQC5uZGttTh7zntgQSVzBlD2sZBppoYS6GF9
         JNRE4c2RnmPE0Jr4GTzgyxhGxwNHJLtwEKSbL8mbl8+Fyx9u3YuG/RkBtCtG/k4EHr
         EfqwGjq1l2iA0pwGc7BFYkUAMhUyCuW6a/FLepta2o4Xd3eY1Ovw5Q1jzBJ5zDxxit
         YVYSzV9Ld0lGmIVSJFrzbn11QjQiK1my0r121IKFUHksifiQREt55j/6Q6h3dDLGvO
         VIu6fr4ZDj53w==
Message-ID: <4ed166accb2fd4a1aa6e4013ca7639bc2e610e37.camel@kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Tue, 01 Nov 2022 18:42:32 -0400
In-Reply-To: <166734032156.19313.13594422911305212646@noble.neil.brown.name>
References: <20221101144647.136696-1-jlayton@kernel.org>
        , <20221101144647.136696-4-jlayton@kernel.org>
        , <166733783854.19313.2332783814411405159@noble.neil.brown.name>
        , <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
         <166734032156.19313.13594422911305212646@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-11-02 at 09:05 +1100, NeilBrown wrote:
> On Wed, 02 Nov 2022, Jeff Layton wrote:
> > On Wed, 2022-11-02 at 08:23 +1100, NeilBrown wrote:
> > > On Wed, 02 Nov 2022, Jeff Layton wrote:
> > > > The filecache refcounting is a bit non-standard for something searc=
hable
> > > > by RCU, in that we maintain a sentinel reference while it's hashed.=
 This
> > > > in turn requires that we have to do things differently in the "put"
> > > > depending on whether its hashed, which we believe to have led to ra=
ces.
> > > >=20
> > > > There are other problems in here too. nfsd_file_close_inode_sync ca=
n end
> > > > up freeing an nfsd_file while there are still outstanding reference=
s to
> > > > it, and there are a number of subtle ToC/ToU races.
> > > >=20
> > > > Rework the code so that the refcount is what drives the lifecycle. =
When
> > > > the refcount goes to zero, then unhash and rcu free the object.
> > > >=20
> > > > With this change, the LRU carries a reference. Take special care to
> > > > deal with it when removing an entry from the list.
> > >=20
> > > The refcounting and lru management all look sane here.
> > >=20
> > > You need to have moved the final put (and corresponding fsync) to
> > > different threads.  I think I see you and Chuck discussing that and I
> > > have no sense of what is "right".=A0
> > >=20
> >=20
> > Yeah, this is a tough call. I get Chuck's reticence.
> >=20
> > One thing we could consider is offloading the SYNC_NONE writeback
> > submission to a workqueue. I'm not sure though whether that's a win --
> > it might just add needless context switches. OTOH, that would make it
> > fairly simple to kick off writeback when the REFERENCED flag is cleared=
,
> > which would probably be the best time to do it.
> >=20
> > An entry that ends up being harvested by the LRU scanner is going to be
> > touched by it at least twice: once to clear the REFERENCED flag, and
> > again ~2s later to reap it.
> >=20
> > If we schedule writeback when we clear the flag then we have a pretty
> > good indication that nothing else is going to be using it (though I
> > think we need to clear REFERENCED even when nfsd_file_check_writeback
> > returns true -- I'll fix that in the coming series).
> >=20
> > In any case, I'd probably like to do that sort of change in a separate
> > series after we get the first part sorted.
> >=20
> > > But it would be nice to explain in
> > > the comment what is being moved and why, so I could then confirm that
> > > the code matches the intent.
> > >=20
> >=20
> > I'm happy to add comments, but I'm a little unclear on what you're
> > confused by here. It's a bit too big of a patch for me to give a full
> > play-by-play description. Can you elaborate on what you'd like to see?
> >=20
>=20
> I don't need blow-by-blow, but all the behavioural changes should at
> least be flagged in the intro, and possibly explained.
> The one I particularly noticed is in nfsd_file_close_inode() which
> previously used nfsd_file_dispose_list() which hands the final close off
> to nfsd_filecache_wq.
> But this patch now does the final close in-line so an fsnotify event
> might now do the fsync.  I was assuming that was deliberate and wanted
> it to be explained.  But maybe it wasn't deliberate?
>=20

Good catch! That wasn't a deliberate change, or at least I missed the
subtlety that the earlier code attempted to avoid it. fsnotify callbacks
are run under the srcu_read_lock. I don't think we want to run a fsync
under that if we can at all help it.

What we can probably do is unhash it and dequeue it from the LRU, and
then do a refcount_dec_and_test. If that comes back true, we can then
queue it to the nfsd_fcache_disposal infrastructure to be closed and
freed. I'll have a look at that tomorrow.

> The movement of flush_delayed_fput() threw me at first, but I think I
> understand it now - the new code for close_inode_sync is much cleaner,
> not needing dispose_list_sync.
>=20

Yep, I think this is cleaner too.

--=20
Jeff Layton <jlayton@kernel.org>
