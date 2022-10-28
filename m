Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A281611C15
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ1VEH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ1VEA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 17:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192AF244C72
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 14:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E02629FD
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 21:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B5AC433D6;
        Fri, 28 Oct 2022 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666991037;
        bh=AYm+LpYMhYVBCxJsC9VLgJpsYKSKz3kiL4w2XaoUnSY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PQ5XL6FZIygA57PoZWEdA1Z9Dg8F4c8r+O9wNgB7Lc/3Lr1jmtwDclh9ijWxiKbVK
         jZ9gwX8R+rSuNhJe9aYE0R7c8KjuFIgOjZE+amF2ML8NnMxFreZeqjtp4WU5CD5RCh
         8JyiF8TAGxD3b82TUwzQ5dzSkXI/L37+Bfzmtom52sKOVpumYaOVQrADzMnzXq1rPD
         q31QWFYHlGhhGOXKnb7nAZ+pONfsdt1/6W6XJbTow6CC0Yu0NOEjzXEowhFqM4+WiN
         pji1Y4J33veboKoFkxPl9mEmjow5M6eMEKvoXoe9HL3fGaiy3HFd+AyyBgDyDdlncY
         Ter5I9BTmDcDw==
Message-ID: <2fbb55230b48c2e3b29b1fb16ebe7467b90e4052.camel@kernel.org>
Subject: Re: [PATCH v3 2/4] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Fri, 28 Oct 2022 17:03:55 -0400
In-Reply-To: <3DD6D3B9-552C-470F-BF54-929497C58A4F@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-3-jlayton@kernel.org>
         <96D34180-0E11-4582-8B45-B3FD9CD8F2DB@oracle.com>
         <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
         <3DD6D3B9-552C-470F-BF54-929497C58A4F@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 20:39 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 4:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 19:49 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
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
> > > I can see a way of making this patch a lot cleaner. It looks like the=
re's
> > > a fair bit of renaming and moving of functions -- that can go in clea=
n
> > > up patches before doing the heavy lifting.
> > >=20
> >=20
> > Is this something that's really needed? I'm already basically rewriting
> > this code. Reshuffling the old code around first will take a lot of tim=
e
> > and we'll still end up with the same result.
>=20
> I did exactly this for the nfs4_file rhash changes. It took just a couple
> of hours. The outcome is that you can see exactly, in the final patch in
> that series, how the file_hashtbl -> rhltable substitution is done.
>=20
> Making sure each of the changes is more or less mechanical and obvious
> is a good way to ensure no-one is doing something incorrect. That's why
> folks like to use cocchinelle.
>=20
> Trust me, it will be much easier to figure out in a year when we have
> new bugs in this code if we split up this commit just a little.
>=20

Sigh. It seems pointless to rearrange code that is going to be replaced,
but I'll do it. It'll probably be next week though.

>=20
> > > I'm still not sold on the idea of a synchronous flush in nfsd_file_fr=
ee().
> >=20
> > I think that we need to call this there to ensure that writeback errors
> > are handled. I worry that if try to do this piecemeal, we could end up
> > missing errors when they fall off the LRU.
> >=20
> > > That feels like a deadlock waiting to happen and quite difficult to
> > > reproduce because I/O there is rarely needed. It could help to put a
> > > might_sleep() in nfsd_file_fsync(), at least, but I would prefer not =
to
> > > drive I/O in that path at all.
> >=20
> > I don't quite grok the potential for a deadlock here. nfsd_file_free
> > already has to deal with blocking activities due to it effective doing =
a
> > close(). This is just another one. That's why nfsd_file_put has a
> > might_sleep in it (to warn its callers).
>=20
> Currently nfsd_file_put() calls nfsd_file_flush(), which calls
> vfs_fsync(). That can't be called while holding a spinlock.
>=20
>=20

nfsd_file_free (and hence, nfsd_file_put) can never be called with a
spinlock held. That's true even before this set. Both functions can
block.

> > What's the deadlock scenario you envision?
>=20
> OK, filp_close() does call f_op->flush(). So we have this call
> here and there aren't problems today. I still say this is a
> problem waiting to occur, but I guess I can live with it.
>=20
> If filp_close() already calls f_op->flush(), why do we need an
> explicit vfs_fsync() there?
>=20
>=20

->flush doesn't do anything on some filesystems, and while it does
return an error code today, it should have been a void return function.
The error from it can't be counted on.

vfs_fsync is what ensures that everything gets written back and returns
info about writeback errors. I don't see a way around calling it at
least once before we close a file, if we want to keep up the "trick" of
resetting the verifier when we see errors.

IMO, the goal ought to be to ensure that we don't end up having to do
any writeback when we get to GC'ing it, and that's what patch 4/4 should
do.


> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > fs/nfsd/filecache.c | 357 ++++++++++++++++++++++-------------------=
---
> > > > fs/nfsd/trace.h     |   5 +-
> > > > 2 files changed, 178 insertions(+), 184 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index f8ebbf7daa18..d928c5e38eeb 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -1,6 +1,12 @@
> > > > // SPDX-License-Identifier: GPL-2.0
> > > > /*
> > > > * The NFSD open file cache.
> > > > + *
> > > > + * Each nfsd_file is created in response to client activity -- eit=
her regular
> > > > + * file I/O for v2/v3, or opening a file for v4. Files opened via =
v4 are
> > > > + * cleaned up as soon as their refcount goes to 0.  Entries for v2=
/v3 are
> > > > + * flagged with NFSD_FILE_GC. On their last put, they are added to=
 the LRU for
> > > > + * eventual disposal if they aren't used again within a short time=
 period.
> > > > */
> > > >=20
> > > > #include <linux/hash.h>
> > > > @@ -301,55 +307,22 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *=
key, unsigned int may)
> > > > 		if (key->gc)
> > > > 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> > > > 		nf->nf_inode =3D key->inode;
> > > > -		/* nf_ref is pre-incremented for hash table */
> > > > -		refcount_set(&nf->nf_ref, 2);
> > > > +		refcount_set(&nf->nf_ref, 1);
> > > > 		nf->nf_may =3D key->need;
> > > > 		nf->nf_mark =3D NULL;
> > > > 	}
> > > > 	return nf;
> > > > }
> > > >=20
> > > > -static bool
> > > > -nfsd_file_free(struct nfsd_file *nf)
> > > > -{
> > > > -	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime))=
;
> > > > -	bool flush =3D false;
> > > > -
> > > > -	this_cpu_inc(nfsd_file_releases);
> > > > -	this_cpu_add(nfsd_file_total_age, age);
> > > > -
> > > > -	trace_nfsd_file_put_final(nf);
> > > > -	if (nf->nf_mark)
> > > > -		nfsd_file_mark_put(nf->nf_mark);
> > > > -	if (nf->nf_file) {
> > > > -		get_file(nf->nf_file);
> > > > -		filp_close(nf->nf_file, NULL);
> > > > -		fput(nf->nf_file);
> > > > -		flush =3D true;
> > > > -	}
> > > > -
> > > > -	/*
> > > > -	 * If this item is still linked via nf_lru, that's a bug.
> > > > -	 * WARN and leak it to preserve system stability.
> > > > -	 */
> > > > -	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> > > > -		return flush;
> > > > -
> > > > -	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > > -	return flush;
> > > > -}
> > > > -
> > > > -static bool
> > > > -nfsd_file_check_writeback(struct nfsd_file *nf)
> > > > +static void
> > > > +nfsd_file_fsync(struct nfsd_file *nf)
> > > > {
> > > > 	struct file *file =3D nf->nf_file;
> > > > -	struct address_space *mapping;
> > > >=20
> > > > 	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > -		return false;
> > > > -	mapping =3D file->f_mapping;
> > > > -	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> > > > -		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > > > +		return;
> > > > +	if (vfs_fsync(file, 1) !=3D 0)
> > > > +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > > > }
> > > >=20
> > > > static int
> > > > @@ -362,30 +335,6 @@ nfsd_file_check_write_error(struct nfsd_file *=
nf)
> > > > 	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_=
err));
> > > > }
> > > >=20
> > > > -static void
> > > > -nfsd_file_flush(struct nfsd_file *nf)
> > > > -{
> > > > -	struct file *file =3D nf->nf_file;
> > > > -
> > > > -	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > -		return;
> > > > -	if (vfs_fsync(file, 1) !=3D 0)
> > > > -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > > > -}
> > > > -
> > > > -static void nfsd_file_lru_add(struct nfsd_file *nf)
> > > > -{
> > > > -	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> > > > -		trace_nfsd_file_lru_add(nf);
> > > > -}
> > > > -
> > > > -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> > > > -{
> > > > -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> > > > -		trace_nfsd_file_lru_del(nf);
> > > > -}
> > > > -
> > > > static void
> > > > nfsd_file_hash_remove(struct nfsd_file *nf)
> > > > {
> > > > @@ -408,53 +357,66 @@ nfsd_file_unhash(struct nfsd_file *nf)
> > > > }
> > > >=20
> > > > static void
> > > > -nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_hea=
d *dispose)
> > > > +nfsd_file_free(struct nfsd_file *nf)
> > > > {
> > > > -	trace_nfsd_file_unhash_and_dispose(nf);
> > > > -	if (nfsd_file_unhash(nf)) {
> > > > -		/* caller must call nfsd_file_dispose_list() later */
> > > > -		nfsd_file_lru_remove(nf);
> > > > -		list_add(&nf->nf_lru, dispose);
> > > > +	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime))=
;
> > > > +
> > > > +	trace_nfsd_file_free(nf);
> > > > +
> > > > +	this_cpu_inc(nfsd_file_releases);
> > > > +	this_cpu_add(nfsd_file_total_age, age);
> > > > +
> > > > +	nfsd_file_unhash(nf);
> > > > +	nfsd_file_fsync(nf);
> > > > +
> > > > +	if (nf->nf_mark)
> > > > +		nfsd_file_mark_put(nf->nf_mark);
> > > > +	if (nf->nf_file) {
> > > > +		get_file(nf->nf_file);
> > > > +		filp_close(nf->nf_file, NULL);
> > > > +		fput(nf->nf_file);
> > > > 	}
> > > > +
> > > > +	/*
> > > > +	 * If this item is still linked via nf_lru, that's a bug.
> > > > +	 * WARN and leak it to preserve system stability.
> > > > +	 */
> > > > +	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> > > > +		return;
> > > > +
> > > > +	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > > }
> > > >=20
> > > > -static void
> > > > -nfsd_file_put_noref(struct nfsd_file *nf)
> > > > +static bool
> > > > +nfsd_file_check_writeback(struct nfsd_file *nf)
> > > > {
> > > > -	trace_nfsd_file_put(nf);
> > > > +	struct file *file =3D nf->nf_file;
> > > > +	struct address_space *mapping;
> > > >=20
> > > > -	if (refcount_dec_and_test(&nf->nf_ref)) {
> > > > -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> > > > -		nfsd_file_lru_remove(nf);
> > > > -		nfsd_file_free(nf);
> > > > -	}
> > > > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > +		return false;
> > > > +	mapping =3D file->f_mapping;
> > > > +	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> > > > +		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> > > > }
> > > >=20
> > > > -static void
> > > > -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> > > > +static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > > > {
> > > > -	if (nfsd_file_unhash(nf))
> > > > -		nfsd_file_put_noref(nf);
> > > > +	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> > > > +		trace_nfsd_file_lru_add(nf);
> > > > +		return true;
> > > > +	}
> > > > +	return false;
> > > > }
> > > >=20
> > > > -void
> > > > -nfsd_file_put(struct nfsd_file *nf)
> > > > +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> > > > {
> > > > -	might_sleep();
> > > > -
> > > > -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> > > > -		nfsd_file_lru_add(nf);
> > > > -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> > > > -		nfsd_file_unhash_and_put(nf);
> > > > -
> > > > -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > > -		nfsd_file_flush(nf);
> > > > -		nfsd_file_put_noref(nf);
> > > > -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) =
{
> > > > -		nfsd_file_put_noref(nf);
> > > > -		nfsd_file_schedule_laundrette();
> > > > -	} else
> > > > -		nfsd_file_put_noref(nf);
> > > > +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> > > > +		trace_nfsd_file_lru_del(nf);
> > > > +		return true;
> > > > +	}
> > > > +	return false;
> > > > }
> > > >=20
> > > > struct nfsd_file *
> > > > @@ -465,36 +427,77 @@ nfsd_file_get(struct nfsd_file *nf)
> > > > 	return NULL;
> > > > }
> > > >=20
> > > > -static void
> > > > -nfsd_file_dispose_list(struct list_head *dispose)
> > > > +/**
> > > > + * nfsd_file_unhash_and_queue - unhash a file and queue it to the =
dispose list
> > > > + * @nf: nfsd_file to be unhashed and queued
> > > > + * @dispose: list to which it should be queued
> > > > + *
> > > > + * Attempt to unhash a nfsd_file and queue it to the given list. E=
ach file
> > > > + * will have a reference held on behalf of the list. That referenc=
e may come
> > > > + * from the LRU, or we may need to take one. If we can't get a ref=
erence,
> > > > + * ignore it altogether.
> > > > + */
> > > > +static bool
> > > > +nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head =
*dispose)
> > > > {
> > > > -	struct nfsd_file *nf;
> > > > +	trace_nfsd_file_unhash_and_queue(nf);
> > > > +	if (nfsd_file_unhash(nf)) {
> > > > +		/*
> > > > +		 * If we remove it from the LRU, then just use that
> > > > +		 * reference for the dispose list. Otherwise, we need
> > > > +		 * to take a reference. If that fails, just ignore
> > > > +		 * the file altogether.
> > > > +		 */
> > > > +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> > > > +			return false;
> > > > +		list_add(&nf->nf_lru, dispose);
> > > > +		return true;
> > > > +	}
> > > > +	return false;
> > > > +}
> > > >=20
> > > > -	while(!list_empty(dispose)) {
> > > > -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> > > > -		list_del_init(&nf->nf_lru);
> > > > -		nfsd_file_flush(nf);
> > > > -		nfsd_file_put_noref(nf);
> > > > +/**
> > > > + * nfsd_file_put - put the reference to a nfsd_file
> > > > + * @nf: nfsd_file of which to put the reference
> > > > + *
> > > > + * Put a reference to a nfsd_file. In the v4 case, we just put the
> > > > + * reference immediately. In the v2/3 case, if the reference would=
 be
> > > > + * the last one, the put it on the LRU instead to be cleaned up la=
ter.
> > > > + */
> > > > +void
> > > > +nfsd_file_put(struct nfsd_file *nf)
> > > > +{
> > > > +	trace_nfsd_file_put(nf);
> > > > +
> > > > +	/*
> > > > +	 * The HASHED check is racy. We may end up with the occasional
> > > > +	 * unhashed entry on the LRU, but they should get cleaned up
> > > > +	 * like any other.
> > > > +	 */
> > > > +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> > > > +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > > +		/*
> > > > +		 * If this is the last reference (nf_ref =3D=3D 1), then transfe=
r
> > > > +		 * it to the LRU. If the add to the LRU fails, just put it as
> > > > +		 * usual.
> > > > +		 */
> > > > +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > > > +			return;
> > > > 	}
> > > > +	if (refcount_dec_and_test(&nf->nf_ref))
> > > > +		nfsd_file_free(nf);
> > > > }
> > > >=20
> > > > static void
> > > > -nfsd_file_dispose_list_sync(struct list_head *dispose)
> > > > +nfsd_file_dispose_list(struct list_head *dispose)
> > > > {
> > > > -	bool flush =3D false;
> > > > 	struct nfsd_file *nf;
> > > >=20
> > > > 	while(!list_empty(dispose)) {
> > > > 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> > > > 		list_del_init(&nf->nf_lru);
> > > > -		nfsd_file_flush(nf);
> > > > -		if (!refcount_dec_and_test(&nf->nf_ref))
> > > > -			continue;
> > > > -		if (nfsd_file_free(nf))
> > > > -			flush =3D true;
> > > > +		nfsd_file_free(nf);
> > > > 	}
> > > > -	if (flush)
> > > > -		flush_delayed_fput();
> > > > }
> > > >=20
> > > > static void
> > > > @@ -564,21 +567,8 @@ nfsd_file_lru_cb(struct list_head *item, struc=
t list_lru_one *lru,
> > > > 	struct list_head *head =3D arg;
> > > > 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru=
);
> > > >=20
> > > > -	/*
> > > > -	 * Do a lockless refcount check. The hashtable holds one referenc=
e, so
> > > > -	 * we look to see if anything else has a reference, or if any hav=
e
> > > > -	 * been put since the shrinker last ran. Those don't get unhashed=
 and
> > > > -	 * released.
> > > > -	 *
> > > > -	 * Note that in the put path, we set the flag and then decrement =
the
> > > > -	 * counter. Here we check the counter and then test and clear the=
 flag.
> > > > -	 * That order is deliberate to ensure that we can do this lockles=
sly.
> > > > -	 */
> > > > -	if (refcount_read(&nf->nf_ref) > 1) {
> > > > -		list_lru_isolate(lru, &nf->nf_lru);
> > > > -		trace_nfsd_file_gc_in_use(nf);
> > > > -		return LRU_REMOVED;
> > > > -	}
> > > > +	/* We should only be dealing with v2/3 entries here */
> > > > +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> > > >=20
> > > > 	/*
> > > > 	 * Don't throw out files that are still undergoing I/O or
> > > > @@ -589,40 +579,30 @@ nfsd_file_lru_cb(struct list_head *item, stru=
ct list_lru_one *lru,
> > > > 		return LRU_SKIP;
> > > > 	}
> > > >=20
> > > > +	/* If it was recently added to the list, skip it */
> > > > 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> > > > 		trace_nfsd_file_gc_referenced(nf);
> > > > 		return LRU_ROTATE;
> > > > 	}
> > > >=20
> > > > -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > > -		trace_nfsd_file_gc_hashed(nf);
> > > > -		return LRU_SKIP;
> > > > +	/*
> > > > +	 * Put the reference held on behalf of the LRU. If it wasn't the =
last
> > > > +	 * one, then just remove it from the LRU and ignore it.
> > > > +	 */
> > > > +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> > > > +		trace_nfsd_file_gc_in_use(nf);
> > > > +		list_lru_isolate(lru, &nf->nf_lru);
> > > > +		return LRU_REMOVED;
> > > > 	}
> > > >=20
> > > > +	/* Refcount went to zero. Unhash it and queue it to the dispose l=
ist */
> > > > +	nfsd_file_unhash(nf);
> > > > 	list_lru_isolate_move(lru, &nf->nf_lru, head);
> > > > 	this_cpu_inc(nfsd_file_evictions);
> > > > 	trace_nfsd_file_gc_disposed(nf);
> > > > 	return LRU_REMOVED;
> > > > }
> > > >=20
> > > > -/*
> > > > - * Unhash items on @dispose immediately, then queue them on the
> > > > - * disposal workqueue to finish releasing them in the background.
> > > > - *
> > > > - * cel: Note that between the time list_lru_shrink_walk runs and
> > > > - * now, these items are in the hash table but marked unhashed.
> > > > - * Why release these outside of lru_cb ? There's no lock ordering
> > > > - * problem since lru_cb currently takes no lock.
> > > > - */
> > > > -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> > > > -{
> > > > -	struct nfsd_file *nf;
> > > > -
> > > > -	list_for_each_entry(nf, dispose, nf_lru)
> > > > -		nfsd_file_hash_remove(nf);
> > > > -	nfsd_file_dispose_list_delayed(dispose);
> > > > -}
> > > > -
> > > > static void
> > > > nfsd_file_gc(void)
> > > > {
> > > > @@ -632,7 +612,7 @@ nfsd_file_gc(void)
> > > > 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > > > 			    &dispose, list_lru_count(&nfsd_file_lru));
> > > > 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > > > -	nfsd_file_gc_dispose_list(&dispose);
> > > > +	nfsd_file_dispose_list_delayed(&dispose);
> > > > }
> > > >=20
> > > > static void
> > > > @@ -657,7 +637,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct s=
hrink_control *sc)
> > > > 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> > > > 				   nfsd_file_lru_cb, &dispose);
> > > > 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lr=
u));
> > > > -	nfsd_file_gc_dispose_list(&dispose);
> > > > +	nfsd_file_dispose_list_delayed(&dispose);
> > > > 	return ret;
> > > > }
> > > >=20
> > > > @@ -668,8 +648,11 @@ static struct shrinker	nfsd_file_shrinker =3D =
{
> > > > };
> > > >=20
> > > > /*
> > > > - * Find all cache items across all net namespaces that match @inod=
e and
> > > > - * move them to @dispose. The lookup is atomic wrt nfsd_file_acqui=
re().
> > > > + * Find all cache items across all net namespaces that match @inod=
e, unhash
> > > > + * them, take references and then put them on @dispose if that was=
 successful.
> > > > + *
> > > > + * The nfsd_file objects on the list will be unhashed, and each wi=
ll have a
> > > > + * reference taken.
> > > > */
> > > > static unsigned int
> > > > __nfsd_file_close_inode(struct inode *inode, struct list_head *disp=
ose)
> > > > @@ -687,52 +670,59 @@ __nfsd_file_close_inode(struct inode *inode, =
struct list_head *dispose)
> > > > 				       nfsd_file_rhash_params);
> > > > 		if (!nf)
> > > > 			break;
> > > > -		nfsd_file_unhash_and_dispose(nf, dispose);
> > > > -		count++;
> > > > +
> > > > +		if (nfsd_file_unhash_and_queue(nf, dispose))
> > > > +			count++;
> > > > 	} while (1);
> > > > 	rcu_read_unlock();
> > > > 	return count;
> > > > }
> > > >=20
> > > > /**
> > > > - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_f=
ile
> > > > + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> > > > * @inode: inode of the file to attempt to remove
> > > > *
> > > > - * Unhash and put, then flush and fput all cache items associated =
with @inode.
> > > > + * Unhash and put all cache item associated with @inode.
> > > > */
> > > > -void
> > > > -nfsd_file_close_inode_sync(struct inode *inode)
> > > > +static unsigned int
> > > > +nfsd_file_close_inode(struct inode *inode)
> > > > {
> > > > -	LIST_HEAD(dispose);
> > > > +	struct nfsd_file *nf;
> > > > 	unsigned int count;
> > > > +	LIST_HEAD(dispose);
> > > >=20
> > > > 	count =3D __nfsd_file_close_inode(inode, &dispose);
> > > > -	trace_nfsd_file_close_inode_sync(inode, count);
> > > > -	nfsd_file_dispose_list_sync(&dispose);
> > > > +	trace_nfsd_file_close_inode(inode, count);
> > > > +	if (count) {
> > > > +		while(!list_empty(&dispose)) {
> > > > +			nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> > > > +			list_del_init(&nf->nf_lru);
> > > > +			trace_nfsd_file_closing(nf);
> > > > +			if (refcount_dec_and_test(&nf->nf_ref))
> > > > +				nfsd_file_free(nf);
> > > > +		}
> > > > +	}
> > > > +	return count;
> > > > }
> > > >=20
> > > > /**
> > > > - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> > > > + * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_f=
ile
> > > > * @inode: inode of the file to attempt to remove
> > > > *
> > > > - * Unhash and put all cache item associated with @inode.
> > > > + * Unhash and put, then flush and fput all cache items associated =
with @inode.
> > > > */
> > > > -static void
> > > > -nfsd_file_close_inode(struct inode *inode)
> > > > +void
> > > > +nfsd_file_close_inode_sync(struct inode *inode)
> > > > {
> > > > -	LIST_HEAD(dispose);
> > > > -	unsigned int count;
> > > > -
> > > > -	count =3D __nfsd_file_close_inode(inode, &dispose);
> > > > -	trace_nfsd_file_close_inode(inode, count);
> > > > -	nfsd_file_dispose_list_delayed(&dispose);
> > > > +	if (nfsd_file_close_inode(inode))
> > > > +		flush_delayed_fput();
> > > > }
> > > >=20
> > > > /**
> > > > * nfsd_file_delayed_close - close unused nfsd_files
> > > > * @work: dummy
> > > > *
> > > > - * Walk the LRU list and close any entries that have not been used=
 since
> > > > + * Walk the LRU list and destroy any entries that have not been us=
ed since
> > > > * the last scan.
> > > > */
> > > > static void
> > > > @@ -890,7 +880,7 @@ __nfsd_file_cache_purge(struct net *net)
> > > > 		while (!IS_ERR_OR_NULL(nf)) {
> > > > 			if (net && nf->nf_net !=3D net)
> > > > 				continue;
> > > > -			nfsd_file_unhash_and_dispose(nf, &dispose);
> > > > +			nfsd_file_unhash_and_queue(nf, &dispose);
> > > > 			nf =3D rhashtable_walk_next(&iter);
> > > > 		}
> > > >=20
> > > > @@ -1054,8 +1044,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp,=
 struct svc_fh *fhp,
> > > > 	rcu_read_lock();
> > > > 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> > > > 			       nfsd_file_rhash_params);
> > > > -	if (nf)
> > > > -		nf =3D nfsd_file_get(nf);
> > > > +	if (nf) {
> > > > +		if (!nfsd_file_lru_remove(nf))
> > > > +			nf =3D nfsd_file_get(nf);
> > > > +	}
> > > > 	rcu_read_unlock();
> > > > 	if (nf)
> > > > 		goto wait_for_construction;
> > > > @@ -1090,11 +1082,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp=
, struct svc_fh *fhp,
> > > > 			goto out;
> > > > 		}
> > > > 		open_retry =3D false;
> > > > -		nfsd_file_put_noref(nf);
> > > > +		if (refcount_dec_and_test(&nf->nf_ref))
> > > > +			nfsd_file_free(nf);
> > > > 		goto retry;
> > > > 	}
> > > >=20
> > > > -	nfsd_file_lru_remove(nf);
> > > > 	this_cpu_inc(nfsd_file_cache_hits);
> > > >=20
> > > > 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file),=
 may_flags));
> > > > @@ -1104,7 +1096,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > > 			this_cpu_inc(nfsd_file_acquisitions);
> > > > 		*pnf =3D nf;
> > > > 	} else {
> > > > -		nfsd_file_put(nf);
> > > > +		if (refcount_dec_and_test(&nf->nf_ref))
> > > > +			nfsd_file_free(nf);
> > > > 		nf =3D NULL;
> > > > 	}
> > > >=20
> > > > @@ -1131,7 +1124,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > > 	 * then unhash.
> > > > 	 */
> > > > 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> > > > -		nfsd_file_unhash_and_put(nf);
> > > > +		nfsd_file_unhash(nf);
> > > > 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
> > > > 	smp_mb__after_atomic();
> > > > 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > index b09ab4f92d43..a44ded06af87 100644
> > > > --- a/fs/nfsd/trace.h
> > > > +++ b/fs/nfsd/trace.h
> > > > @@ -903,10 +903,11 @@ DEFINE_EVENT(nfsd_file_class, name, \
> > > > 	TP_PROTO(struct nfsd_file *nf), \
> > > > 	TP_ARGS(nf))
> > > >=20
> > > > -DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
> > > > +DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
> > > > DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
> > > > DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> > > > -DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_dispose);
> > > > +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
> > > > +DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
> > > >=20
> > > > TRACE_EVENT(nfsd_file_alloc,
> > > > 	TP_PROTO(
> > > > --=20
> > > > 2.37.3
> > > >=20
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> > >=20
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
