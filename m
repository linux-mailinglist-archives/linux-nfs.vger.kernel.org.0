Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A60614800
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 11:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKAK5D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAK5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 06:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD0C75B
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 03:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBADA61559
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 10:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0E9C433D6;
        Tue,  1 Nov 2022 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667300219;
        bh=LZWEFinzIT09dvqwOLLBwYimGleIWZC9y2fJcrGLlPI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X3iE12Wzb5nC8ecgKptda/AC0BRwL0VisXr2H4tvKQRZLRlU8q0Za0p4jNJjkNBBa
         NTrPo1rgqzEEwFJ0sem7Q/JnfkjxfQLCfYraV3+nFkBLB4SnVwO9j4lgeF+K5G5cdi
         SYYVPVsX+9gbpl0ux3s4JveiO4hxNoun+t7Ue1cD/A7IJ+bd7u9pKTaUa8pGY/7MF9
         /25cYl89YaDCvLQp77yRZ/Qs8ZRi053imANH1wLEfeNbNVsUXfP9BPumCFQpXVwpKe
         lywW5LrcyV9avbsOYI7TwMu+OUCe7BrDFUPG6hRcFMPGiUns63kiHLYJ5UG183UzEP
         N0Xf7rf9T2wjA==
Message-ID: <532fc2aaacb4d32da8fd8007d937f0d6a32a0348.camel@kernel.org>
Subject: Re: [PATCH v4 3/5] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 01 Nov 2022 06:56:57 -0400
In-Reply-To: <9BF1F1BF-8665-4F01-9CD5-1FFA62DEEB43@oracle.com>
References: <20221031113742.26480-1-jlayton@kernel.org>
         <20221031113742.26480-4-jlayton@kernel.org>
         <9BF1F1BF-8665-4F01-9CD5-1FFA62DEEB43@oracle.com>
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

On Mon, 2022-10-31 at 20:45 +0000, Chuck Lever III wrote:
>=20
> > On Oct 31, 2022, at 7:37 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > The filecache refcounting is a bit non-standard for something searchabl=
e
> > by RCU, in that we maintain a sentinel reference while it's hashed. Thi=
s
> > in turn requires that we have to do things differently in the "put"
> > depending on whether its hashed, which we believe to have led to races.
> >=20
> > There are other problems in here too. nfsd_file_close_inode_sync can en=
d
> > up freeing an nfsd_file while there are still outstanding references to
> > it, and there are a number of subtle ToC/ToU races.
> >=20
> > Rework the code so that the refcount is what drives the lifecycle. When
> > the refcount goes to zero, then unhash and rcu free the object.
> >=20
> > With this change, the LRU carries a reference. Take special care to
> > deal with it when removing an entry from the list.
>=20
> ....removing an entry from the dispose list, or the LRU?
>=20
> I spent today reviewing and testing this series, and
> comparing its behavior to the behavior of the current
> code base. A few general comments below:
>=20

Thanks for the review!

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 247 +++++++++++++++++++++-----------------------
> > fs/nfsd/trace.h     |   1 +
> > 2 files changed, 121 insertions(+), 127 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index ce80b6a80ffc..d928c5e38eeb 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1,6 +1,12 @@
> > // SPDX-License-Identifier: GPL-2.0
> > /*
> >  * The NFSD open file cache.
> > + *
> > + * Each nfsd_file is created in response to client activity -- either =
regular
> > + * file I/O for v2/v3, or opening a file for v4. Files opened via v4 a=
re
> > + * cleaned up as soon as their refcount goes to 0.  Entries for v2/v3 =
are
> > + * flagged with NFSD_FILE_GC. On their last put, they are added to the=
 LRU for
> > + * eventual disposal if they aren't used again within a short time per=
iod.
>=20
> Trond and I discussed intentionally not using the terms "v4-only"
> and "v2/3" in the filecache comments and function names. That's
> why the flag is called GC and not, say, NFSV3. Can the new comments
> stick with gc and nogc?
>=20

This comment is explaining that v2/v3 _are_ GC entries. I can just
remove this comment I guess, but converting all the mentions to gc/non-
gc in this comment will make it nonsensical.

>=20
> >  */
> >=20
> > #include <linux/hash.h>
> > @@ -301,8 +307,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
> > 		if (key->gc)
> > 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> > 		nf->nf_inode =3D key->inode;
> > -		/* nf_ref is pre-incremented for hash table */
> > -		refcount_set(&nf->nf_ref, 2);
> > +		refcount_set(&nf->nf_ref, 1);
> > 		nf->nf_may =3D key->need;
> > 		nf->nf_mark =3D NULL;
> > 	}
> > @@ -351,23 +356,25 @@ nfsd_file_unhash(struct nfsd_file *nf)
> > 	return false;
> > }
> >=20
>=20
> There's still no explanation in the code of why writeback is
> needed for GC files. I can write a patch to add that, say,
> right here as a documenting comment for nfsd_file_free, if
> you agree.
>=20
>=20

I'll add something here.

> > -static bool
> > +static void
> > nfsd_file_free(struct nfsd_file *nf)
> > {
> > 	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> > -	bool flush =3D false;
> > +
> > +	trace_nfsd_file_free(nf);
>=20
> Maybe move this tracepoint in 2/5 instead? Or just leave it
> where it was. Up to you.
>=20

Sure, done.

>=20
> >=20
> > 	this_cpu_inc(nfsd_file_releases);
> > 	this_cpu_add(nfsd_file_total_age, age);
> >=20
> > -	trace_nfsd_file_free(nf);
> > +	nfsd_file_unhash(nf);
> > +	nfsd_file_fsync(nf);
> > +
> > 	if (nf->nf_mark)
> > 		nfsd_file_mark_put(nf->nf_mark);
> > 	if (nf->nf_file) {
> > 		get_file(nf->nf_file);
> > 		filp_close(nf->nf_file, NULL);
> > 		fput(nf->nf_file);
> > -		flush =3D true;
> > 	}
> >=20
> > 	/*
> > @@ -375,10 +382,9 @@ nfsd_file_free(struct nfsd_file *nf)
> > 	 * WARN and leak it to preserve system stability.
> > 	 */
> > 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> > -		return flush;
> > +		return;
> >=20
> > 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > -	return flush;
> > }
> >=20
> > static bool
> > @@ -394,17 +400,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> > 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > }
> >=20
> > -static void nfsd_file_lru_add(struct nfsd_file *nf)
> > +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > {
> > 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> > +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> > 		trace_nfsd_file_lru_add(nf);
> > +		return true;
> > +	}
> > +	return false;
> > }
> >=20
> > -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> > +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> > {
> > -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> > +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> > 		trace_nfsd_file_lru_del(nf);
> > +		return true;
> > +	}
> > +	return false;
> > }
> >=20
> > struct nfsd_file *
> > @@ -415,86 +427,77 @@ nfsd_file_get(struct nfsd_file *nf)
> > 	return NULL;
> > }
> >=20
> > -static void
> > +/**
> > + * nfsd_file_unhash_and_queue - unhash a file and queue it to the disp=
ose list
> > + * @nf: nfsd_file to be unhashed and queued
> > + * @dispose: list to which it should be queued
> > + *
> > + * Attempt to unhash a nfsd_file and queue it to the given list. Each =
file
> > + * will have a reference held on behalf of the list. That reference ma=
y come
> > + * from the LRU, or we may need to take one. If we can't get a referen=
ce,
> > + * ignore it altogether.
> > + */
> > +static bool
> > nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *disp=
ose)
> > {
> > 	trace_nfsd_file_unhash_and_queue(nf);
> > 	if (nfsd_file_unhash(nf)) {
> > -		/* caller must call nfsd_file_dispose_list() later */
> > -		nfsd_file_lru_remove(nf);
> > +		/*
> > +		 * If we remove it from the LRU, then just use that
> > +		 * reference for the dispose list. Otherwise, we need
> > +		 * to take a reference. If that fails, just ignore
> > +		 * the file altogether.
> > +		 */
> > +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> > +			return false;
> > 		list_add(&nf->nf_lru, dispose);
> > +		return true;
> > 	}
> > +	return false;
> > }
> >=20
> > -static void
> > -nfsd_file_put_noref(struct nfsd_file *nf)
> > -{
> > -	trace_nfsd_file_put(nf);
> > -
> > -	if (refcount_dec_and_test(&nf->nf_ref)) {
> > -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> > -		nfsd_file_lru_remove(nf);
> > -		nfsd_file_free(nf);
> > -	}
> > -}
> > -
> > -static void
> > -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> > -{
> > -	if (nfsd_file_unhash(nf))
> > -		nfsd_file_put_noref(nf);
> > -}
> > -
> > +/**
> > + * nfsd_file_put - put the reference to a nfsd_file
> > + * @nf: nfsd_file of which to put the reference
> > + *
> > + * Put a reference to a nfsd_file. In the v4 case, we just put the
> > + * reference immediately. In the v2/3 case, if the reference would be
> > + * the last one, the put it on the LRU instead to be cleaned up later.
> > + */
> > void
> > nfsd_file_put(struct nfsd_file *nf)
> > {
> > -	might_sleep();
>=20
> The might_sleep() annotation should be added back to nfsd_file_fsync()
> or its callers. It might give more useful warnings if you were to
> annotate the external API functions (as was done here) rather than
> internal helper functions.
>=20

Actually, it's probably better in nfsd_file_put(). That'll give us more
coverage.

>=20
> > -
> > -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> > -		nfsd_file_lru_add(nf);
> > -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> > -		nfsd_file_unhash_and_put(nf);
> > -
> > -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > -		nfsd_file_fsync(nf);
> > -		nfsd_file_put_noref(nf);
> > -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> > -		nfsd_file_put_noref(nf);
> > -		nfsd_file_schedule_laundrette();
>=20
> This might be the only caller of nfsd_file_schedule_laundrette.
> How does the laundrette get scheduled now?
>=20

Good point. I think we need to schedule it any time an entry is added to
the LRU.

> > -	} else
> > -		nfsd_file_put_noref(nf);
> > -}
> > -
> > -static void
> > -nfsd_file_dispose_list(struct list_head *dispose)
> > -{
> > -	struct nfsd_file *nf;
> > +	trace_nfsd_file_put(nf);
> >=20
> > -	while(!list_empty(dispose)) {
> > -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> > -		list_del_init(&nf->nf_lru);
> > -		nfsd_file_fsync(nf);
> > -		nfsd_file_put_noref(nf);
> > +	/*
> > +	 * The HASHED check is racy. We may end up with the occasional
> > +	 * unhashed entry on the LRU, but they should get cleaned up
> > +	 * like any other.
> > +	 */
> > +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> > +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > +		/*
> > +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> > +		 * it to the LRU. If the add to the LRU fails, just put it as
> > +		 * usual.
> > +		 */
> > +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > +			return;
> > 	}
> > +	if (refcount_dec_and_test(&nf->nf_ref))
> > +		nfsd_file_free(nf);
> > }
> >=20
> > static void
> > -nfsd_file_dispose_list_sync(struct list_head *dispose)
> > +nfsd_file_dispose_list(struct list_head *dispose)
> > {
> > -	bool flush =3D false;
> > 	struct nfsd_file *nf;
> >=20
> > 	while(!list_empty(dispose)) {
> > 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> > 		list_del_init(&nf->nf_lru);
> > -		nfsd_file_fsync(nf);
> > -		if (!refcount_dec_and_test(&nf->nf_ref))
> > -			continue;
> > -		if (nfsd_file_free(nf))
> > -			flush =3D true;
> > +		nfsd_file_free(nf);
> > 	}
> > -	if (flush)
> > -		flush_delayed_fput();
> > }
> >=20
> > static void
> > @@ -564,21 +567,8 @@ nfsd_file_lru_cb(struct list_head *item, struct li=
st_lru_one *lru,
> > 	struct list_head *head =3D arg;
> > 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
> >=20
> > -	/*
> > -	 * Do a lockless refcount check. The hashtable holds one reference, s=
o
> > -	 * we look to see if anything else has a reference, or if any have
> > -	 * been put since the shrinker last ran. Those don't get unhashed and
> > -	 * released.
> > -	 *
> > -	 * Note that in the put path, we set the flag and then decrement the
> > -	 * counter. Here we check the counter and then test and clear the fla=
g.
> > -	 * That order is deliberate to ensure that we can do this locklessly.
> > -	 */
> > -	if (refcount_read(&nf->nf_ref) > 1) {
> > -		list_lru_isolate(lru, &nf->nf_lru);
> > -		trace_nfsd_file_gc_in_use(nf);
> > -		return LRU_REMOVED;
> > -	}
> > +	/* We should only be dealing with v2/3 entries here */
> > +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> >=20
> > 	/*
> > 	 * Don't throw out files that are still undergoing I/O or
> > @@ -589,40 +579,30 @@ nfsd_file_lru_cb(struct list_head *item, struct l=
ist_lru_one *lru,
> > 		return LRU_SKIP;
> > 	}
> >=20
> > +	/* If it was recently added to the list, skip it */
> > 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> > 		trace_nfsd_file_gc_referenced(nf);
> > 		return LRU_ROTATE;
> > 	}
> >=20
> > -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > -		trace_nfsd_file_gc_hashed(nf);
> > -		return LRU_SKIP;
> > +	/*
> > +	 * Put the reference held on behalf of the LRU. If it wasn't the last
> > +	 * one, then just remove it from the LRU and ignore it.
> > +	 */
> > +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> > +		trace_nfsd_file_gc_in_use(nf);
> > +		list_lru_isolate(lru, &nf->nf_lru);
> > +		return LRU_REMOVED;
> > 	}
> >=20
> > +	/* Refcount went to zero. Unhash it and queue it to the dispose list =
*/
> > +	nfsd_file_unhash(nf);
> > 	list_lru_isolate_move(lru, &nf->nf_lru, head);
> > 	this_cpu_inc(nfsd_file_evictions);
> > 	trace_nfsd_file_gc_disposed(nf);
> > 	return LRU_REMOVED;
> > }
> >=20
> > -/*
> > - * Unhash items on @dispose immediately, then queue them on the
> > - * disposal workqueue to finish releasing them in the background.
> > - *
> > - * cel: Note that between the time list_lru_shrink_walk runs and
> > - * now, these items are in the hash table but marked unhashed.
> > - * Why release these outside of lru_cb ? There's no lock ordering
> > - * problem since lru_cb currently takes no lock.
> > - */
> > -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> > -{
> > -	struct nfsd_file *nf;
> > -
> > -	list_for_each_entry(nf, dispose, nf_lru)
> > -		nfsd_file_hash_remove(nf);
> > -	nfsd_file_dispose_list_delayed(dispose);
> > -}
> > -
> > static void
> > nfsd_file_gc(void)
> > {
> > @@ -632,7 +612,7 @@ nfsd_file_gc(void)
> > 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > 			    &dispose, list_lru_count(&nfsd_file_lru));
> > 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > -	nfsd_file_gc_dispose_list(&dispose);
> > +	nfsd_file_dispose_list_delayed(&dispose);
> > }
> >=20
> > static void
> > @@ -657,7 +637,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrin=
k_control *sc)
> > 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> > 				   nfsd_file_lru_cb, &dispose);
> > 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> > -	nfsd_file_gc_dispose_list(&dispose);
> > +	nfsd_file_dispose_list_delayed(&dispose);
> > 	return ret;
> > }
> >=20
> > @@ -668,8 +648,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
> > };
> >=20
> > /*
> > - * Find all cache items across all net namespaces that match @inode an=
d
> > - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire()=
.
> > + * Find all cache items across all net namespaces that match @inode, u=
nhash
> > + * them, take references and then put them on @dispose if that was suc=
cessful.
> > + *
> > + * The nfsd_file objects on the list will be unhashed, and each will h=
ave a
> > + * reference taken.
> >  */
> > static unsigned int
> > __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> > @@ -687,8 +670,9 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
> > 				       nfsd_file_rhash_params);
> > 		if (!nf)
> > 			break;
> > -		nfsd_file_unhash_and_queue(nf, dispose);
> > -		count++;
> > +
> > +		if (nfsd_file_unhash_and_queue(nf, dispose))
> > +			count++;
> > 	} while (1);
> > 	rcu_read_unlock();
> > 	return count;
> > @@ -700,15 +684,25 @@ __nfsd_file_close_inode(struct inode *inode, stru=
ct list_head *dispose)
> >  *
> >  * Unhash and put all cache item associated with @inode.
> >  */
> > -static void
> > +static unsigned int
> > nfsd_file_close_inode(struct inode *inode)
> > {
> > -	LIST_HEAD(dispose);
> > +	struct nfsd_file *nf;
> > 	unsigned int count;
> > +	LIST_HEAD(dispose);
> >=20
> > 	count =3D __nfsd_file_close_inode(inode, &dispose);
> > 	trace_nfsd_file_close_inode(inode, count);
> > -	nfsd_file_dispose_list_delayed(&dispose);
> > +	if (count) {
>=20
> Why is it necessary to check @count? I would think that
> the the empty list check would be sufficient.
>=20
>=20

It's not necessary. I'll change it.

> > +		while(!list_empty(&dispose)) {
> > +			nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> > +			list_del_init(&nf->nf_lru);
> > +			trace_nfsd_file_closing(nf);
> > +			if (refcount_dec_and_test(&nf->nf_ref))
> > +				nfsd_file_free(nf);
> > +		}
> > +	}
> > +	return count;
> > }
> >=20
> > /**
> > @@ -720,19 +714,15 @@ nfsd_file_close_inode(struct inode *inode)
> > void
> > nfsd_file_close_inode_sync(struct inode *inode)
> > {
> > -	LIST_HEAD(dispose);
> > -	unsigned int count;
> > -
> > -	count =3D __nfsd_file_close_inode(inode, &dispose);
> > -	trace_nfsd_file_close_inode_sync(inode, count);
> > -	nfsd_file_dispose_list_sync(&dispose);
> > +	if (nfsd_file_close_inode(inode))
> > +		flush_delayed_fput();
> > }
> >=20
> > /**
> >  * nfsd_file_delayed_close - close unused nfsd_files
> >  * @work: dummy
> >  *
> > - * Walk the LRU list and close any entries that have not been used sin=
ce
> > + * Walk the LRU list and destroy any entries that have not been used s=
ince
> >  * the last scan.
> >  */
> > static void
> > @@ -1054,8 +1044,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> > 	rcu_read_lock();
> > 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> > 			       nfsd_file_rhash_params);
> > -	if (nf)
> > -		nf =3D nfsd_file_get(nf);
> > +	if (nf) {
> > +		if (!nfsd_file_lru_remove(nf))
> > +			nf =3D nfsd_file_get(nf);
> > +	}
> > 	rcu_read_unlock();
> > 	if (nf)
> > 		goto wait_for_construction;
> > @@ -1090,11 +1082,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > 			goto out;
> > 		}
> > 		open_retry =3D false;
> > -		nfsd_file_put_noref(nf);
> > +		if (refcount_dec_and_test(&nf->nf_ref))
> > +			nfsd_file_free(nf);
> > 		goto retry;
> > 	}
> >=20
> > -	nfsd_file_lru_remove(nf);
> > 	this_cpu_inc(nfsd_file_cache_hits);
> >=20
> > 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may=
_flags));
> > @@ -1104,7 +1096,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> > 			this_cpu_inc(nfsd_file_acquisitions);
> > 		*pnf =3D nf;
> > 	} else {
> > -		nfsd_file_put(nf);
> > +		if (refcount_dec_and_test(&nf->nf_ref))
> > +			nfsd_file_free(nf);
> > 		nf =3D NULL;
> > 	}
> >=20
> > @@ -1131,7 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> > 	 * then unhash.
> > 	 */
> > 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> > -		nfsd_file_unhash_and_put(nf);
> > +		nfsd_file_unhash(nf);
> > 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> > 	smp_mb__after_atomic();
> > 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 940252482fd4..a44ded06af87 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
> > DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
> > DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
> > DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> > +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
> > DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
> >=20
> > TRACE_EVENT(nfsd_file_alloc,
> > --=20
> > 2.38.1
> >=20

Thanks again for the review!
--=20
Jeff Layton <jlayton@kernel.org>
