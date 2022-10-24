Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074E6098E2
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 05:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJXDah (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Oct 2022 23:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJXDaJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Oct 2022 23:30:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3BBB09
        for <linux-nfs@vger.kernel.org>; Sun, 23 Oct 2022 20:26:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E56D21C5F;
        Mon, 24 Oct 2022 03:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666582017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OWIK9/j1t4IQqfXtRe1N+nZaLKdiWkpZ7CXxTskniQ=;
        b=v6hXpGgGuZu9MXl1kAeDFcKPyh+tSJBn+pHm3Sa8fZr5tlm6aVIlr7BVZYbRvahcA3luI6
        G6Yk/1m2OtfhVY7r+c0vvQy9u9o0cZG+U/jaXToxDc2UOg3Q7Y0QMOhJKvn2QwsA/ItGRI
        pB4bAFyJ7RicJRMqB5de4EPDguE0aSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666582017;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OWIK9/j1t4IQqfXtRe1N+nZaLKdiWkpZ7CXxTskniQ=;
        b=hcmRHP1yMTFch61qbM+1k8FJ8DOUmL2t0MY12UBzMd817wKMy+2qum7L7T49vtLlBliVpA
        OTSgkrX9MDSrGTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FD7E13494;
        Mon, 24 Oct 2022 03:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GelDFQAGVmNJTAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 03:26:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>,
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
Date:   Mon, 24 Oct 2022 14:26:53 +1100
Message-id: <166658201312.12462.15430126129561479021@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 19 Oct 2022, Chuck Lever wrote:
> fh_match() is costly, especially when filehandles are large (as is
> the case for NFSv4). It needs to be used sparingly when searching
> data structures. Unfortunately, with common workloads, I see
> multiple thousands of objects stored in file_hashtbl[], which always
> has only 256 buckets, which makes the hash chains quite lengthy.
>=20
> Walking long hash chains with the state_lock held blocks other
> activity that needs that lock.

Using a bit-spin-lock for each hash chain would be a simple fix if this
was the only concern.  See for example fscache_hash_cookie().
I'm not at all against using rhltables, but thought I would mention that
there are other options.

>=20
> To help mitigate the cost of searching with fh_match(), replace the
> nfs4_file hash table with an rhashtable, which can dynamically
> resize its bucket array to minimize hash chain length. The ideal for
> this use case is one bucket per inode.
>=20
> The result is an improvement in the latency of NFSv4 operations
> and the reduction of nfsd CPU utilization due to the cost of
> fh_match() and the CPU cache misses incurred while walking long
> hash chains in the nfs4_file hash table.
>=20
> Note that hash removal is no longer protected by the state_lock.
> This is because insert_nfs4_file() takes the RCU read lock then the
> state_lock. rhltable_remove() takes the RCU read lock internally;
> if remove_nfs4_file() took the state_lock before calling
> rhltable_remove(), that would result in a lock inversion.

As mentioned separately, lock inversion is not relevant for
rcu_read_lock().
Also, I cannot see any need for state_lock to be used for protecting
additions to, or removals from, the rhash table.

>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |  215 +++++++++++++++++++++++++++++++++++------------=
----
>  fs/nfsd/state.h     |    5 -
>  2 files changed, 147 insertions(+), 73 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2b850de288cf..a63334ad61f6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -44,7 +44,9 @@
>  #include <linux/jhash.h>
>  #include <linux/string_helpers.h>
>  #include <linux/fsnotify.h>
> +#include <linux/rhashtable.h>
>  #include <linux/nfs_ssc.h>
> +
>  #include "xdr4.h"
>  #include "xdr4cb.h"
>  #include "vfs.h"
> @@ -84,6 +86,7 @@ static bool check_for_locks(struct nfs4_file *fp, struct =
nfs4_lockowner *lowner)
>  static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
>  void nfsd4_end_grace(struct nfsd_net *nn);
>  static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpnt=
f_state *cps);
> +static void remove_nfs4_file(struct nfs4_file *fi);
> =20
>  /* Locking: */
> =20
> @@ -577,11 +580,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rcu)
>  void
>  put_nfs4_file(struct nfs4_file *fi)
>  {
> -	might_lock(&state_lock);
> -
> -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
> -		hlist_del_rcu(&fi->fi_hash);
> -		spin_unlock(&state_lock);
> +	if (refcount_dec_and_test(&fi->fi_ref)) {
> +		remove_nfs4_file(fi);
>  		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>  		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
>  		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> @@ -695,19 +695,82 @@ static unsigned int ownerstr_hashval(struct xdr_netob=
j *ownername)
>  	return ret & OWNER_HASH_MASK;
>  }
> =20
> -/* hash table for nfs4_file */
> -#define FILE_HASH_BITS                   8
> -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
> +static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
> +
> +/*
> + * The returned hash value is based solely on the address of an in-code
> + * inode, a pointer to a slab-allocated object. The entropy in such a
> + * pointer is concentrated in its middle bits.
> + */
> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
> +{
> +	u32 k;
> +
> +	k =3D ((unsigned long)inode) >> L1_CACHE_SHIFT;
> +	return jhash2(&k, 1, seed);

I still don't think this makes any sense at all.

        return jhash2(&inode, sizeof(inode)/4, seed);

uses all of the entropy, which is best for rhashtables.

> +}
> =20
> -static unsigned int file_hashval(struct svc_fh *fh)
> +/**
> + * nfs4_file_key_hashfn - Compute the hash value of a lookup key
> + * @data: key on which to compute the hash value
> + * @len: rhash table's key_len parameter (unused)
> + * @seed: rhash table's random seed of the day
> + *
> + * Return value:
> + *   Computed 32-bit hash value
> + */
> +static u32 nfs4_file_key_hashfn(const void *data, u32 len, u32 seed)
>  {
> -	struct inode *inode =3D d_inode(fh->fh_dentry);
> +	const struct svc_fh *fhp =3D data;
> =20
> -	/* XXX: why not (here & in file cache) use inode? */
> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
> +	return nfs4_file_inode_hash(d_inode(fhp->fh_dentry), seed);
>  }
> =20
> -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> +/**
> + * nfs4_file_obj_hashfn - Compute the hash value of an nfs4_file object
> + * @data: object on which to compute the hash value
> + * @len: rhash table's key_len parameter (unused)
> + * @seed: rhash table's random seed of the day
> + *
> + * Return value:
> + *   Computed 32-bit hash value
> + */
> +static u32 nfs4_file_obj_hashfn(const void *data, u32 len, u32 seed)
> +{
> +	const struct nfs4_file *fi =3D data;
> +
> +	return nfs4_file_inode_hash(fi->fi_inode, seed);
> +}
> +
> +/**
> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
> + * @arg: search criteria
> + * @ptr: cache item to check
> + *
> + * Return values:
> + *   %0 - Success; item matches search criteria
> + */
> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
> +			       const void *ptr)
> +{
> +	const struct svc_fh *fhp =3D arg->key;
> +	const struct nfs4_file *fi =3D ptr;
> +
> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
> +}

This doesn't make sense.  Maybe the subtleties of rhl-tables are a bit
obscure.

An rhltable is like an rhashtable except that insertion can never fail.=20
Multiple entries with the same key can co-exist in a linked list.
Lookup does not return an entry but returns a linked list of entries.

For the nfs4_file table this isn't really a good match (though I
previously thought it was).  Insertion must be able to fail if an entry
with the same filehandle exists.

One approach that might work would be to take the inode->i_lock after a
lookup fails then repeat the lookup and if it fails again, do the
insert.  This keeps the locking fine-grained but means we don't have to
depend on insert failing.

So the hash and cmp functions would only look at the inode pointer.
If lookup returns something, we would walk the list calling fh_match()
to see if we have the right entry - all under RCU and using
refcount_inc_not_zero() when we find the matching filehandle.

NeilBrown
