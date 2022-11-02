Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B51616C4E
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKBSfJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKBSfI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:35:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3A2F666
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 294EBB82416
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 18:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7D1C4347C;
        Wed,  2 Nov 2022 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414057;
        bh=9m8+jdRBQmcXq39ZNoRs3k2cdmnvqXCfyI3VQ589MTQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FqYnwTp/ZZ/u/j+YZBfHvYgm2JYDLuTMqc1vX7TSMvo9Cj4m/UmOOoRT5yYUVUVPL
         fRZKFS/4gEMfjytHAW40j4qKjavw1g+Y17ADrjRFrlyo5AOAW92N/CVd8uXc1RdLgu
         PFo2tUphf9gnilGCBpOVD+CBKqDq4M45Z3FH3OzHSLKqwm/MKEKDCIHAKUsGZGYROD
         kWRjmVDe17s8LonPh7I2MzhjaDq0+Neag9pvlw5KOOB0OVdSu8mM398KXmvcP+hcbD
         NP0g82xfsnDVjSaC+iw5yH0XZ7xkS9UtxfR2XVUN/gZG5xfdA0Unko2EsBS866nESz
         hf2pmb2GP4dqg==
Message-ID: <8447e78307b3effa2b1d48ac8b64d42d7b23808c.camel@kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 02 Nov 2022 14:34:16 -0400
In-Reply-To: <4E9232A2-E4C0-4877-96B1-5D745085BB05@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
         <20221101144647.136696-4-jlayton@kernel.org>
         <166733783854.19313.2332783814411405159@noble.neil.brown.name>
         <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
         <166734032156.19313.13594422911305212646@noble.neil.brown.name>
         <4ed166accb2fd4a1aa6e4013ca7639bc2e610e37.camel@kernel.org>
         <db00762c5e0b983c72bee2c6bfa4476b2090a942.camel@kernel.org>
         <4E9232A2-E4C0-4877-96B1-5D745085BB05@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-11-02 at 18:07 +0000, Chuck Lever III wrote:
>=20
> > On Nov 2, 2022, at 12:58 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Tue, 2022-11-01 at 18:42 -0400, Jeff Layton wrote:
> > > On Wed, 2022-11-02 at 09:05 +1100, NeilBrown wrote:
> > > > On Wed, 02 Nov 2022, Jeff Layton wrote:
> > > > > On Wed, 2022-11-02 at 08:23 +1100, NeilBrown wrote:
> > > > > > On Wed, 02 Nov 2022, Jeff Layton wrote:
> > > > > > > The filecache refcounting is a bit non-standard for something=
 searchable
> > > > > > > by RCU, in that we maintain a sentinel reference while it's h=
ashed. This
> > > > > > > in turn requires that we have to do things differently in the=
 "put"
> > > > > > > depending on whether its hashed, which we believe to have led=
 to races.
> > > > > > >=20
> > > > > > > There are other problems in here too. nfsd_file_close_inode_s=
ync can end
> > > > > > > up freeing an nfsd_file while there are still outstanding ref=
erences to
> > > > > > > it, and there are a number of subtle ToC/ToU races.
> > > > > > >=20
> > > > > > > Rework the code so that the refcount is what drives the lifec=
ycle. When
> > > > > > > the refcount goes to zero, then unhash and rcu free the objec=
t.
> > > > > > >=20
> > > > > > > With this change, the LRU carries a reference. Take special c=
are to
> > > > > > > deal with it when removing an entry from the list.
> > > > > >=20
> > > > > > The refcounting and lru management all look sane here.
> > > > > >=20
> > > > > > You need to have moved the final put (and corresponding fsync) =
to
> > > > > > different threads.  I think I see you and Chuck discussing that=
 and I
> > > > > > have no sense of what is "right".=20
> > > > > >=20
> > > > >=20
> > > > > Yeah, this is a tough call. I get Chuck's reticence.
> > > > >=20
> > > > > One thing we could consider is offloading the SYNC_NONE writeback
> > > > > submission to a workqueue. I'm not sure though whether that's a w=
in --
> > > > > it might just add needless context switches. OTOH, that would mak=
e it
> > > > > fairly simple to kick off writeback when the REFERENCED flag is c=
leared,
> > > > > which would probably be the best time to do it.
> > > > >=20
> > > > > An entry that ends up being harvested by the LRU scanner is going=
 to be
> > > > > touched by it at least twice: once to clear the REFERENCED flag, =
and
> > > > > again ~2s later to reap it.
> > > > >=20
> > > > > If we schedule writeback when we clear the flag then we have a pr=
etty
> > > > > good indication that nothing else is going to be using it (though=
 I
> > > > > think we need to clear REFERENCED even when nfsd_file_check_write=
back
> > > > > returns true -- I'll fix that in the coming series).
> > > > >=20
> > > > > In any case, I'd probably like to do that sort of change in a sep=
arate
> > > > > series after we get the first part sorted.
> > > > >=20
> > > > > > But it would be nice to explain in
> > > > > > the comment what is being moved and why, so I could then confir=
m that
> > > > > > the code matches the intent.
> > > > > >=20
> > > > >=20
> > > > > I'm happy to add comments, but I'm a little unclear on what you'r=
e
> > > > > confused by here. It's a bit too big of a patch for me to give a =
full
> > > > > play-by-play description. Can you elaborate on what you'd like to=
 see?
> > > > >=20
> > > >=20
> > > > I don't need blow-by-blow, but all the behavioural changes should a=
t
> > > > least be flagged in the intro, and possibly explained.
> > > > The one I particularly noticed is in nfsd_file_close_inode() which
> > > > previously used nfsd_file_dispose_list() which hands the final clos=
e off
> > > > to nfsd_filecache_wq.
> > > > But this patch now does the final close in-line so an fsnotify even=
t
> > > > might now do the fsync.  I was assuming that was deliberate and wan=
ted
> > > > it to be explained.  But maybe it wasn't deliberate?
> > > >=20
> > >=20
> > > Good catch! That wasn't a deliberate change, or at least I missed the
> > > subtlety that the earlier code attempted to avoid it. fsnotify callba=
cks
> > > are run under the srcu_read_lock. I don't think we want to run a fsyn=
c
> > > under that if we can at all help it.
> > >=20
> > > What we can probably do is unhash it and dequeue it from the LRU, and
> > > then do a refcount_dec_and_test. If that comes back true, we can then
> > > queue it to the nfsd_fcache_disposal infrastructure to be closed and
> > > freed. I'll have a look at that tomorrow.
> > >=20
> >=20
> > Ok, I looked over the notification handling in here again and there is =
a
> > bit of a dilemma:
> >=20
> > Neil is correct that we currently just put the reference directly in th=
e
> > notification callback, and if we put the last reference at that point
> > then we could end up waiting on writeback.
>=20
> I expect that for an unlink, that is the common case.
>=20
>=20
> > There are two notification callbacks:
> >=20
> > 1/ fanotify callback to tell us when the link count on a file has gone
> > to 0.
> >=20
> > 2/ the setlease_notifier which is called when someone wants to do a
> > setlease
> >=20
> > ...both are called under the srcu_read_lock(), and they are both fairly
> > similar situations. We call different functions for them today, but we
> > may be OK to unify them since their needs are similar.
> >=20
> > When I originally added these, I made them synchronous because it's bes=
t
> > if nfsd can clean up and get out the way quickly when either of these
> > events happen. At that time though, the code didn't call vfs_fsync at
> > all, much less always on the last put.
> >=20
> > We have a couple of options:
> >=20
> > 1/ just continue to do them synchronously: We can sleep under the
> > srcu_read_lock, so we can do both of those synchronously, but blocking
> > it for a long period of time could cause latency issues elsewhere.
> >=20
> > 2/ move them to the delayed freeing infrastructure. That should be fine
> > but we could end doing stuff like silly renaming when someone deletes a=
n
> > open file on an NFS reexport.
>=20
> Isn't the NFS re-export case handled already by nfsd_file_close_inode_syn=
c() ?
> In that case, the fsync / close is done synchronously before the unlink, =
but
> the caller is an nfsd thread, so that should be safe.
>=20
>=20
> > Thoughts? What's the best approach here?
> >=20
> > Maybe we should just leave them synchronous for now, and plan to addres=
s
> > this in a later set?
>=20
> I need to collect some experimental evidence, but we shouldn't be adding
> or removing notification calls with your patch set. It ought to be safe
> to leave it for a subsequent fix.
>=20
>=20

My current plan is to have the notifier callbacks call
nfsd_file_close_inode which will unhash the things and put them on the
per-net dispose list and schedule the disposal workqueue job. So, those
will get cleaned up asynchronously and we shouldn't block the srcu
callbacks at all.

For the nfsd rename/unlink cases, we'll close things out synchronously,
as we always have. I think this is probably the safest compromise for
the moment and we can work to optimize other cases later.


> > > > The movement of flush_delayed_fput() threw me at first, but I think=
 I
> > > > understand it now - the new code for close_inode_sync is much clean=
er,
> > > > not needing dispose_list_sync.
> > > >=20
> > >=20
> > > Yep, I think this is cleaner too.
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
