Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737BE60DF5F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 13:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiJZLRq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiJZLRh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 07:17:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA5CD5FB
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 04:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F9F7B821B4
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 11:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16B5C433D7;
        Wed, 26 Oct 2022 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666783046;
        bh=pqpV9d9GcFQNmw2mV/NfjeEpCz700wY17euT+SZwMTY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cTrmCIqvca0oEXmT79ToqZMka6hOmVHXHeeqzsVWO1hpnPxhPFigdipOksUTzBZL6
         30ifRx2z8OD8nrxNuMo4PSAyziMaHA7QNHSqPyd/9Djxjnn/jqU7c/NckrC4jx19bs
         FaRZ7QCxUNHnuuZ1PLu4CifeLHte2mjhOZed9Y1W6IUrOvcWiK+3heHnvQvJAf+UfQ
         l6aKu8AmYVqO1CnOkUm4If9SS6tBRxdVcU1jr/n3hY4oQwnjNP/7rg9EDdOkeoBXNv
         1EqRhAMCOAPrAcE1g2l92Zu9F2Jjq8G0kxJH5mg14QajFTFfD+Iqwi7qUdZO2p3pIQ
         DNfDYUC0JgvDg==
Message-ID: <0ecc06032cddee06eab66e68c10c39c1a4fe4662.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Date:   Wed, 26 Oct 2022 07:17:24 -0400
In-Reply-To: <20221026081539.219755-2-jlayton@kernel.org>
References: <20221026081539.219755-1-jlayton@kernel.org>
         <20221026081539.219755-2-jlayton@kernel.org>
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

On Wed, 2022-10-26 at 04:15 -0400, Jeff Layton wrote:
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed.
> This in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, etc.
>=20
> Another issue: nfsd_file_close_inode_sync can end up freeing an
> nfsd_file while there are still outstanding references to it.
>=20
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 202 ++++++++++++++++++++------------------------
>  1 file changed, 92 insertions(+), 110 deletions(-)
>=20
> This passes some basic smoke testing and I think closes a number of
> races in this code. I also think the result is a bit simpler and easier
> to follow now.
>=20
> I looked for some ways to break this up into multiple patches, but I
> didn't find any. This changes the underlying rules of how the
> refcounting works, and I didn't see a way to split that up and still
> have it remain bisectable.
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 918d67cec1ad..6c2f4f2c56a6 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Open file cache.
> - *
> - * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
> + * The NFSD open file cache.
>   */
> =20
>  #include <linux/hash.h>
> @@ -303,8 +302,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, uns=
igned int may)
>  		if (key->gc)
>  			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>  		nf->nf_inode =3D key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
>  		nf->nf_may =3D key->need;
>  		nf->nf_mark =3D NULL;
>  	}
> @@ -376,11 +374,15 @@ nfsd_file_flush(struct nfsd_file *nf)
>  		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
>  }
> =20
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>  {
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&

The above condition is wrong, I think. We only want to add the object to
the LRU if it _is_ hashed.

> +	    list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>  		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
>  }
> =20
>  static void nfsd_file_lru_remove(struct nfsd_file *nf)
> @@ -410,7 +412,7 @@ nfsd_file_unhash(struct nfsd_file *nf)
>  	return false;
>  }
> =20
> -static void
> +static bool
>  nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dis=
pose)
>  {
>  	trace_nfsd_file_unhash_and_dispose(nf);
> @@ -418,46 +420,48 @@ nfsd_file_unhash_and_dispose(struct nfsd_file *nf, =
struct list_head *dispose)
>  		/* caller must call nfsd_file_dispose_list() later */
>  		nfsd_file_lru_remove(nf);
>  		list_add(&nf->nf_lru, dispose);
> +		return true;
>  	}
> +	return false;
>  }
> =20
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> +static bool
> +__nfsd_file_put(struct nfsd_file *nf)
>  {
> -	trace_nfsd_file_put(nf);
> -
> +	/* v4 case: don't wait for GC */
>  	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> +		nfsd_file_unhash(nf);
>  		nfsd_file_lru_remove(nf);
>  		nfsd_file_free(nf);
> +		return true;
>  	}
> +	return false;
>  }
> =20
> -static void
> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
> -{
> -	if (nfsd_file_unhash(nf))
> -		nfsd_file_put_noref(nf);
> -}
> -
> +/**
> + * nfsd_file_put - put the reference to a nfsd_file
> + * @nf: nfsd_file of which to put the reference
> + *
> + * Put a reference to a nfsd_file. In the v4 case, we just put the
> + * reference immediately. In the v2/3 case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
>  void
>  nfsd_file_put(struct nfsd_file *nf)
>  {
> -	might_sleep();
> -
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> +	trace_nfsd_file_put(nf);
> =20
> -	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
> -		nfsd_file_flush(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D =
1) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> +	/* NFSv2/3 case */
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> +		 * it to the LRU. If the add to the LRU fails, just put it as
> +		 * usual.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> +			return;
> +	}
> +	__nfsd_file_put(nf);
>  }
> =20
>  struct nfsd_file *
> @@ -477,27 +481,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
>  		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del_init(&nf->nf_lru);
>  		nfsd_file_flush(nf);
> -		nfsd_file_put_noref(nf);
> -	}
> -}
> -
> -static void
> -nfsd_file_dispose_list_sync(struct list_head *dispose)
> -{
> -	bool flush =3D false;
> -	struct nfsd_file *nf;
> -
> -	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_flush(nf);
> -		if (!refcount_dec_and_test(&nf->nf_ref))
> -			continue;
> -		if (nfsd_file_free(nf))
> -			flush =3D true;
> +		nfsd_file_free(nf);
>  	}
> -	if (flush)
> -		flush_delayed_fput();
>  }
> =20
>  static void
> @@ -567,21 +552,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
>  	struct list_head *head =3D arg;
>  	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
> =20
> -	/*
> -	 * Do a lockless refcount check. The hashtable holds one reference, so
> -	 * we look to see if anything else has a reference, or if any have
> -	 * been put since the shrinker last ran. Those don't get unhashed and
> -	 * released.
> -	 *
> -	 * Note that in the put path, we set the flag and then decrement the
> -	 * counter. Here we check the counter and then test and clear the flag.
> -	 * That order is deliberate to ensure that we can do this locklessly.
> -	 */
> -	if (refcount_read(&nf->nf_ref) > 1) {
> -		list_lru_isolate(lru, &nf->nf_lru);
> -		trace_nfsd_file_gc_in_use(nf);
> -		return LRU_REMOVED;
> -	}
> +	/* We should only be dealing with v2/3 entries here */
> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> =20
>  	/*
>  	 * Don't throw out files that are still undergoing I/O or
> @@ -592,40 +564,30 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
>  		return LRU_SKIP;
>  	}
> =20
> +	/* If it was recently referenced, then skip it */
>  	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>  		trace_nfsd_file_gc_referenced(nf);
>  		return LRU_ROTATE;
>  	}
> =20
> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_hashed(nf);
> -		return LRU_SKIP;
> +	/*
> +	 * Put the LRU reference. If it wasn't the last one, then something
> +	 * took a reference to it recently (or REFERENCED would have
> +	 * been set). Just remove it from the LRU and ignore it.
> +	 */
> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +		trace_nfsd_file_gc_in_use(nf);
> +		list_lru_isolate(lru, &nf->nf_lru);
> +		return LRU_REMOVED;
>  	}
> =20
> +	/* Refcount went to zero. Queue it to the dispose list */
>  	list_lru_isolate_move(lru, &nf->nf_lru, head);
>  	this_cpu_inc(nfsd_file_evictions);
>  	trace_nfsd_file_gc_disposed(nf);
>  	return LRU_REMOVED;
>  }
> =20
> -/*
> - * Unhash items on @dispose immediately, then queue them on the
> - * disposal workqueue to finish releasing them in the background.
> - *
> - * cel: Note that between the time list_lru_shrink_walk runs and
> - * now, these items are in the hash table but marked unhashed.
> - * Why release these outside of lru_cb ? There's no lock ordering
> - * problem since lru_cb currently takes no lock.
> - */
> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	list_for_each_entry(nf, dispose, nf_lru)
> -		nfsd_file_hash_remove(nf);
> -	nfsd_file_dispose_list_delayed(dispose);
> -}
> -
>  static void
>  nfsd_file_gc(void)
>  {
> @@ -635,7 +597,7 @@ nfsd_file_gc(void)
>  	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>  			    &dispose, list_lru_count(&nfsd_file_lru));
>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
>  }
> =20
>  static void
> @@ -660,7 +622,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_=
control *sc)
>  	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
>  				   nfsd_file_lru_cb, &dispose);
>  	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
>  	return ret;
>  }
> =20
> @@ -671,8 +633,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
>  };
> =20
>  /*
> - * Find all cache items across all net namespaces that match @inode and
> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
> + * Find all cache items across all net namespaces that match @inode, unh=
ash
> + * them, take references and then put them on @dispose if that was succe=
ssful.
> + *
> + * The nfsd_file objects on the list will be unhashed but holding a refe=
rence
> + * to them. The caller must ensure that the references clean things up.
>   */
>  static unsigned int
>  __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> @@ -690,45 +655,62 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
>  				       nfsd_file_rhash_params);
>  		if (!nf)
>  			break;
> -		nfsd_file_unhash_and_dispose(nf, dispose);
> -		count++;
> +
> +		/* Ignore it if it's already unhashed */
> +		if (!nfsd_file_unhash_and_dispose(nf, dispose))
> +			continue;
> +
> +		/* Ignore it if we can't get a reference */
> +		if (nfsd_file_get(nf))
> +			count++;
> +		else
> +			list_del_init(&nf->nf_lru);
>  	} while (1);
>  	rcu_read_unlock();
>  	return count;
>  }
> =20
>  /**
> - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
> + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>   * @inode: inode of the file to attempt to remove
>   *
> - * Unhash and put, then flush and fput all cache items associated with @=
inode.
> + * Unhash and put all cache item associated with @inode.
>   */
> -void
> -nfsd_file_close_inode_sync(struct inode *inode)
> +static void
> +nfsd_file_close_inode(struct inode *inode)
>  {
>  	LIST_HEAD(dispose);
>  	unsigned int count;
> =20
>  	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
> +	trace_nfsd_file_close_inode(inode, count);
> +	nfsd_file_dispose_list_delayed(&dispose);
>  }
> =20
>  /**
> - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> + * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
>   * @inode: inode of the file to attempt to remove
>   *
> - * Unhash and put all cache item associated with @inode.
> + * Unhash and put, then flush and fput all cache items associated with @=
inode.
>   */
> -static void
> -nfsd_file_close_inode(struct inode *inode)
> +void
> +nfsd_file_close_inode_sync(struct inode *inode)
>  {
> +	struct nfsd_file *nf;
>  	LIST_HEAD(dispose);
>  	unsigned int count;
> =20
>  	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	trace_nfsd_file_close_inode_sync(inode, count);
> +	if (!count)
> +		return;
> +	while(!list_empty(&dispose)) {
> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> +		list_del_init(&nf->nf_lru);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> +	}
> +	flush_delayed_fput();
>  }
> =20
>  /**
> @@ -1094,7 +1076,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  			goto out;
>  		}
>  		open_retry =3D false;
> -		nfsd_file_put_noref(nf);
> +		nfsd_file_put(nf);
>  		goto retry;
>  	}
> =20
> @@ -1135,7 +1117,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	 * then unhash.
>  	 */
>  	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> -		nfsd_file_unhash_and_put(nf);
> +		nfsd_file_put(nf);
>  	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>  	smp_mb__after_atomic();
>  	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);

--=20
Jeff Layton <jlayton@kernel.org>
