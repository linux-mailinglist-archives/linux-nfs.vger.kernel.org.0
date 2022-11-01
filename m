Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D30615437
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 22:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKAVYM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiKAVYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 17:24:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EAC1A817
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:24:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E65A21C9A;
        Tue,  1 Nov 2022 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667337844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5LepgSSf0Har3JsDH8z8sYJSWa1i0hWQyosp4+zhU0=;
        b=O3YI0dHeWDFXEdKucNYG+m0xQvfkk/rsnSzguNFwcRYX5ygFYc8Yr0OmEHgvd2tRYJKcOV
        tBYTTJNUBDfMroyrS3TK7lwxE7q4Rl59/HfrpiKUgIV5EEHKhmV1EQJc0W03P9jQXL+y0r
        Cm3nkfDq+lhXVG+1y7nddGDMgi/oDEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667337844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5LepgSSf0Har3JsDH8z8sYJSWa1i0hWQyosp4+zhU0=;
        b=6GEauokybfeXo7GyK2SdSdxMKkI/VpOg/+eviYXGrWMNcv6gNLaH2gMxxR9mzVmYHpZvgv
        /SnHgXgmnL0SeJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85EF813AE5;
        Tue,  1 Nov 2022 21:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CxECD3KOYWPleQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 01 Nov 2022 21:24:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
In-reply-to: <20221101144647.136696-4-jlayton@kernel.org>
References: <20221101144647.136696-1-jlayton@kernel.org>,
 <20221101144647.136696-4-jlayton@kernel.org>
Date:   Wed, 02 Nov 2022 08:23:58 +1100
Message-id: <166733783854.19313.2332783814411405159@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 02 Nov 2022, Jeff Layton wrote:
> The filecache refcounting is a bit non-standard for something searchable
> by RCU, in that we maintain a sentinel reference while it's hashed. This
> in turn requires that we have to do things differently in the "put"
> depending on whether its hashed, which we believe to have led to races.
>=20
> There are other problems in here too. nfsd_file_close_inode_sync can end
> up freeing an nfsd_file while there are still outstanding references to
> it, and there are a number of subtle ToC/ToU races.
>=20
> Rework the code so that the refcount is what drives the lifecycle. When
> the refcount goes to zero, then unhash and rcu free the object.
>=20
> With this change, the LRU carries a reference. Take special care to
> deal with it when removing an entry from the list.

The refcounting and lru management all look sane here.

You need to have moved the final put (and corresponding fsync) to
different threads.  I think I see you and Chuck discussing that and I
have no sense of what is "right".  But it would be nice to explain in
the comment what is being moved and why, so I could then confirm that
the code matches the intent.

Thanks,
NeilBrown


>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 247 ++++++++++++++++++++++----------------------
>  fs/nfsd/trace.h     |   1 +
>  2 files changed, 123 insertions(+), 125 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 0bf3727455e2..e67297ad12bf 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -303,8 +303,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsig=
ned int may)
>  		if (key->gc)
>  			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>  		nf->nf_inode =3D key->inode;
> -		/* nf_ref is pre-incremented for hash table */
> -		refcount_set(&nf->nf_ref, 2);
> +		refcount_set(&nf->nf_ref, 1);
>  		nf->nf_may =3D key->need;
>  		nf->nf_mark =3D NULL;
>  	}
> @@ -353,24 +352,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
>  	return false;
>  }
> =20
> -static bool
> +static void
>  nfsd_file_free(struct nfsd_file *nf)
>  {
>  	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
> -	bool flush =3D false;
> =20
>  	trace_nfsd_file_free(nf);
> =20
>  	this_cpu_inc(nfsd_file_releases);
>  	this_cpu_add(nfsd_file_total_age, age);
> =20
> +	nfsd_file_unhash(nf);
> +
> +	/*
> +	 * We call fsync here in order to catch writeback errors. It's not
> +	 * strictly required by the protocol, but an nfsd_file coule get
> +	 * evicted from the cache before a COMMIT comes in. If another
> +	 * task were to open that file in the interim and scrape the error,
> +	 * then the client may never see it. By calling fsync here, we ensure
> +	 * that writeback happens before the entry is freed, and that any
> +	 * errors reported result in the write verifier changing.
> +	 */
> +	nfsd_file_fsync(nf);
> +
>  	if (nf->nf_mark)
>  		nfsd_file_mark_put(nf->nf_mark);
>  	if (nf->nf_file) {
>  		get_file(nf->nf_file);
>  		filp_close(nf->nf_file, NULL);
>  		fput(nf->nf_file);
> -		flush =3D true;
>  	}
> =20
>  	/*
> @@ -378,10 +388,9 @@ nfsd_file_free(struct nfsd_file *nf)
>  	 * WARN and leak it to preserve system stability.
>  	 */
>  	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
> -		return flush;
> +		return;
> =20
>  	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> -	return flush;
>  }
> =20
>  static bool
> @@ -397,17 +406,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>  }
> =20
> -static void nfsd_file_lru_add(struct nfsd_file *nf)
> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>  {
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>  		trace_nfsd_file_lru_add(nf);
> +		return true;
> +	}
> +	return false;
>  }
> =20
> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>  {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
>  		trace_nfsd_file_lru_del(nf);
> +		return true;
> +	}
> +	return false;
>  }
> =20
>  struct nfsd_file *
> @@ -418,86 +433,80 @@ nfsd_file_get(struct nfsd_file *nf)
>  	return NULL;
>  }
> =20
> -static void
> +/**
> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the dispose =
list
> + * @nf: nfsd_file to be unhashed and queued
> + * @dispose: list to which it should be queued
> + *
> + * Attempt to unhash a nfsd_file and queue it to the given list. Each file
> + * will have a reference held on behalf of the list. That reference may co=
me
> + * from the LRU, or we may need to take one. If we can't get a reference,
> + * ignore it altogether.
> + */
> +static bool
>  nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
>  {
>  	trace_nfsd_file_unhash_and_queue(nf);
>  	if (nfsd_file_unhash(nf)) {
> -		/* caller must call nfsd_file_dispose_list() later */
> -		nfsd_file_lru_remove(nf);
> +		/*
> +		 * If we remove it from the LRU, then just use that
> +		 * reference for the dispose list. Otherwise, we need
> +		 * to take a reference. If that fails, just ignore
> +		 * the file altogether.
> +		 */
> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
> +			return false;
>  		list_add(&nf->nf_lru, dispose);
> +		return true;
>  	}
> +	return false;
>  }
> =20
> -static void
> -nfsd_file_put_noref(struct nfsd_file *nf)
> -{
> -	trace_nfsd_file_put(nf);
> -
> -	if (refcount_dec_and_test(&nf->nf_ref)) {
> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> -	}
> -}
> -
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
> + * reference immediately. In the GC case, if the reference would be
> + * the last one, the put it on the LRU instead to be cleaned up later.
> + */
>  void
>  nfsd_file_put(struct nfsd_file *nf)
>  {
>  	might_sleep();
> +	trace_nfsd_file_put(nf);
> =20
> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
> -		nfsd_file_lru_add(nf);
> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> -		nfsd_file_unhash_and_put(nf);
> -
> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> -		nfsd_file_put_noref(nf);
> -		nfsd_file_schedule_laundrette();
> -	} else
> -		nfsd_file_put_noref(nf);
> -}
> -
> -static void
> -nfsd_file_dispose_list(struct list_head *dispose)
> -{
> -	struct nfsd_file *nf;
> -
> -	while(!list_empty(dispose)) {
> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
> -		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
> -		nfsd_file_put_noref(nf);
> +	/*
> +	 * The HASHED check is racy. We may end up with the occasional
> +	 * unhashed entry on the LRU, but they should get cleaned up
> +	 * like any other.
> +	 */
> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +		/*
> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> +		 * it to the LRU. If the add to the LRU fails, just put it as
> +		 * usual.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
> +			nfsd_file_schedule_laundrette();
> +			return;
> +		}
>  	}
> +	if (refcount_dec_and_test(&nf->nf_ref))
> +		nfsd_file_free(nf);
>  }
> =20
>  static void
> -nfsd_file_dispose_list_sync(struct list_head *dispose)
> +nfsd_file_dispose_list(struct list_head *dispose)
>  {
> -	bool flush =3D false;
>  	struct nfsd_file *nf;
> =20
>  	while(!list_empty(dispose)) {
>  		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del_init(&nf->nf_lru);
> -		nfsd_file_fsync(nf);
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
> @@ -567,21 +576,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_l=
ru_one *lru,
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
> +	/* We should only be dealing with GC entries here */
> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> =20
>  	/*
>  	 * Don't throw out files that are still undergoing I/O or
> @@ -592,40 +588,30 @@ nfsd_file_lru_cb(struct list_head *item, struct list_=
lru_one *lru,
>  		return LRU_SKIP;
>  	}
> =20
> +	/* If it was recently added to the list, skip it */
>  	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>  		trace_nfsd_file_gc_referenced(nf);
>  		return LRU_ROTATE;
>  	}
> =20
> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		trace_nfsd_file_gc_hashed(nf);
> -		return LRU_SKIP;
> +	/*
> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
> +	 * one, then just remove it from the LRU and ignore it.
> +	 */
> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
> +		trace_nfsd_file_gc_in_use(nf);
> +		list_lru_isolate(lru, &nf->nf_lru);
> +		return LRU_REMOVED;
>  	}
> =20
> +	/* Refcount went to zero. Unhash it and queue it to the dispose list */
> +	nfsd_file_unhash(nf);
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
> @@ -635,7 +621,7 @@ nfsd_file_gc(void)
>  	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>  			    &dispose, list_lru_count(&nfsd_file_lru));
>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
>  }
> =20
>  static void
> @@ -660,7 +646,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_co=
ntrol *sc)
>  	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
>  				   nfsd_file_lru_cb, &dispose);
>  	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_gc_dispose_list(&dispose);
> +	nfsd_file_dispose_list_delayed(&dispose);
>  	return ret;
>  }
> =20
> @@ -671,8 +657,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
>  };
> =20
>  /*
> - * Find all cache items across all net namespaces that match @inode and
> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire().
> + * Find all cache items across all net namespaces that match @inode, unhash
> + * them, take references and then put them on @dispose if that was success=
ful.
> + *
> + * The nfsd_file objects on the list will be unhashed, and each will have a
> + * reference taken.
>   */
>  static unsigned int
>  __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
> @@ -690,8 +679,9 @@ __nfsd_file_close_inode(struct inode *inode, struct lis=
t_head *dispose)
>  				       nfsd_file_rhash_params);
>  		if (!nf)
>  			break;
> -		nfsd_file_unhash_and_queue(nf, dispose);
> -		count++;
> +
> +		if (nfsd_file_unhash_and_queue(nf, dispose))
> +			count++;
>  	} while (1);
>  	rcu_read_unlock();
>  	return count;
> @@ -703,15 +693,23 @@ __nfsd_file_close_inode(struct inode *inode, struct l=
ist_head *dispose)
>   *
>   * Unhash and put all cache item associated with @inode.
>   */
> -static void
> +static unsigned int
>  nfsd_file_close_inode(struct inode *inode)
>  {
> -	LIST_HEAD(dispose);
> +	struct nfsd_file *nf;
>  	unsigned int count;
> +	LIST_HEAD(dispose);
> =20
>  	count =3D __nfsd_file_close_inode(inode, &dispose);
>  	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	while(!list_empty(&dispose)) {
> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
> +		list_del_init(&nf->nf_lru);
> +		trace_nfsd_file_closing(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
> +	}
> +	return count;
>  }
> =20
>  /**
> @@ -723,19 +721,15 @@ nfsd_file_close_inode(struct inode *inode)
>  void
>  nfsd_file_close_inode_sync(struct inode *inode)
>  {
> -	LIST_HEAD(dispose);
> -	unsigned int count;
> -
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode_sync(inode, count);
> -	nfsd_file_dispose_list_sync(&dispose);
> +	if (nfsd_file_close_inode(inode))
> +		flush_delayed_fput();
>  }
> =20
>  /**
>   * nfsd_file_delayed_close - close unused nfsd_files
>   * @work: dummy
>   *
> - * Walk the LRU list and close any entries that have not been used since
> + * Walk the LRU list and destroy any entries that have not been used since
>   * the last scan.
>   */
>  static void
> @@ -1056,8 +1050,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	rcu_read_lock();
>  	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>  			       nfsd_file_rhash_params);
> -	if (nf)
> -		nf =3D nfsd_file_get(nf);
> +	if (nf) {
> +		if (!nfsd_file_lru_remove(nf))
> +			nf =3D nfsd_file_get(nf);
> +	}
>  	rcu_read_unlock();
>  	if (nf)
>  		goto wait_for_construction;
> @@ -1092,11 +1088,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  			goto out;
>  		}
>  		open_retry =3D false;
> -		nfsd_file_put_noref(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
>  		goto retry;
>  	}
> =20
> -	nfsd_file_lru_remove(nf);
>  	this_cpu_inc(nfsd_file_cache_hits);
> =20
>  	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_fl=
ags));
> @@ -1106,7 +1102,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  			this_cpu_inc(nfsd_file_acquisitions);
>  		*pnf =3D nf;
>  	} else {
> -		nfsd_file_put(nf);
> +		if (refcount_dec_and_test(&nf->nf_ref))
> +			nfsd_file_free(nf);
>  		nf =3D NULL;
>  	}
> =20
> @@ -1133,7 +1130,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	 * then unhash.
>  	 */
>  	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
> -		nfsd_file_unhash_and_put(nf);
> +		nfsd_file_unhash(nf);
>  	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>  	smp_mb__after_atomic();
>  	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 940252482fd4..a44ded06af87 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
> =20
>  TRACE_EVENT(nfsd_file_alloc,
> --=20
> 2.38.1
>=20
>=20
