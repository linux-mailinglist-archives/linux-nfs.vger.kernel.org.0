Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825565F6B47
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiJFQMs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiJFQMq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:12:46 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E7AC3BF
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:12:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i3so1322474qkl.3
        for <linux-nfs@vger.kernel.org>; Thu, 06 Oct 2022 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HCX+4IwfE3Ky7f8/Ljjr2v2DiXJ+RDgbWQh618AhpE=;
        b=RbRsINpxm+mAFoG4Bw2HjFE1n+BgQPbrflHRUYlu5u+5BFsANYTF/mwwOlMZ1RaWma
         GVtfDubserJgD4MvOBrtzNsxyNJHoHjgDcUf9duCOcJZiO2YYMloqiEKAyS0hjiox6mb
         6eBLzf6yVfPYpug2z4OpGxThguvc4NpLQT0b0M1SX2dO2LxzOucFrEUM5TnB1vnB+xub
         mA3MEqqYNDJ5Z4ptHcHR0YXD0zB7AXD3hcWbcv9zRbmDw2guaDmkpoeKY/9X7qpLxXtT
         GP6yXf816vYkfsnXpwopR1RIJPKzRa7WBnrCsqyAO25aZP0Vl5mbnShB9D4S1RsacTE0
         HZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HCX+4IwfE3Ky7f8/Ljjr2v2DiXJ+RDgbWQh618AhpE=;
        b=lm5mchVAybIzw7+l96WfcZnMHwpb+94nQ4yUqzIwAscTys2GuqdM27DPUXAMAujpMG
         dimyaJVMn/ui+bpaVqCnNS71KiVw/CxRpvno9ZRcRrda6aSiutjGTG+oezvZ32ogGvvc
         J9SZRa+Abjxh/jVrry4PzBKCnwnPQtuURqZmarO9INH7OswcN1AKhG0qU2tECDBkBT48
         0oisJIY+6k82QzbqraThTu9mYNoaw+izHX6e6wML/eyb+Xsh7i1onZBkYuagY01Y2gro
         NJQjqDREyRQHLv1djPKM/LFp3QwFAFtq440Fck7/r53d+CDejTTt9/txnUvSlpBxB0Iv
         QTrA==
X-Gm-Message-State: ACrzQf01GijJZFC5Ull9ZbGXj0ap5sCvHdeQEv0qNcoFADHVqsg4FKDD
        2v/5Va0fLGTRwWZ/Z6nb/MgQ3Q==
X-Google-Smtp-Source: AMsMyM5UbJhvK04RhoLckL9AS7pjhrQ1SvkEFC/4Td8mrTOYx6WtyQlAcdh18pgnkJDwJAHfytBeKQ==
X-Received: by 2002:a37:657:0:b0:6e4:5b18:cdc2 with SMTP id 84-20020a370657000000b006e45b18cdc2mr654408qkg.255.1665072763121;
        Thu, 06 Oct 2022 09:12:43 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id b6-20020ac812c6000000b0035a70a25651sm16413538qtj.55.2022.10.06.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:12:42 -0700 (PDT)
Message-ID: <ca8c3501e8a4a0e81e95aaaca49e00852d7cc045.camel@poochiereds.net>
Subject: Re: [PATCH RFC 7/9] NFSD: Use rhashtable for managing nfs4_file
 objects
From:   Jeff Layton <jlayton@poochiereds.net>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 06 Oct 2022 12:12:41 -0400
In-Reply-To: <339F3E66-C90C-441A-916C-A41F3193E228@oracle.com>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
         <166498178061.1527.15489022568685172014.stgit@manet.1015granger.net>
         <339F3E66-C90C-441A-916C-A41F3193E228@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-10-05 at 15:11 +0000, Chuck Lever III wrote:
>=20
> > On Oct 5, 2022, at 10:56 AM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
> >=20
> > fh_match() is expensive to use for hash chains that contain more
> > than a few objects. With common workloads, I see multiple thousands
> > of objects stored in file_hashtbl[], which always has only 256
> > buckets.
> >=20
> > Replace it with an rhashtable, which dynamically resizes its bucket
> > array to keep hash chains short.
> >=20
> > This also enables the removal of the use of state_lock to serialize
> > operations on the new rhashtable.
> >=20
> > The result is an improvement in the latency of NFSv4 operations
> > and the reduction of nfsd CPU utilization due to the cache misses
> > of walking long hash chains in file_hashtbl.
> >=20
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> > fs/nfsd/nfs4state.c |  229 +++++++++++++++++++++++++++++++++++---------=
-------
> > fs/nfsd/state.h     |    5 -
> > 2 files changed, 158 insertions(+), 76 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 2b850de288cf..06499b9481a6 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -44,7 +44,9 @@
> > #include <linux/jhash.h>
> > #include <linux/string_helpers.h>
> > #include <linux/fsnotify.h>
> > +#include <linux/rhashtable.h>
> > #include <linux/nfs_ssc.h>
> > +
> > #include "xdr4.h"
> > #include "xdr4cb.h"
> > #include "vfs.h"
> > @@ -84,6 +86,7 @@ static bool check_for_locks(struct nfs4_file *fp, str=
uct nfs4_lockowner *lowner)
> > static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
> > void nfsd4_end_grace(struct nfsd_net *nn);
> > static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_c=
pntf_state *cps);
> > +static void unhash_nfs4_file(struct nfs4_file *fp);
> >=20
> > /* Locking: */
> >=20
> > @@ -577,11 +580,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *r=
cu)
> > void
> > put_nfs4_file(struct nfs4_file *fi)
> > {
> > -	might_lock(&state_lock);
> > -
> > -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
> > -		hlist_del_rcu(&fi->fi_hash);
> > -		spin_unlock(&state_lock);
> > +	if (refcount_dec_and_test(&fi->fi_ref)) {
> > +		unhash_nfs4_file(fi);
> > 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
> > 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
> > 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> > @@ -695,19 +695,85 @@ static unsigned int ownerstr_hashval(struct xdr_n=
etobj *ownername)
> > 	return ret & OWNER_HASH_MASK;
> > }
> >=20
> > -/* hash table for nfs4_file */
> > -#define FILE_HASH_BITS                   8
> > -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
> > +static struct rhashtable nfs4_file_rhashtbl ____cacheline_aligned_in_s=
mp;
> >=20
> > -static unsigned int file_hashval(struct svc_fh *fh)
> > +/*
> > + * The returned hash value is based solely on the address of an in-cod=
e
> > + * inode, a pointer to a slab-allocated object. The entropy in such a
> > + * pointer is concentrated in its middle bits.
> > + */
> > +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
> > +{
> > +	unsigned long ptr =3D (unsigned long)inode;
> > +	u32 k;
> > +
> > +	k =3D ptr >> L1_CACHE_SHIFT;
> > +	k &=3D 0x00ffffff;
> > +	return jhash2(&k, 1, seed);
> > +}
> > +
> > +/**
> > + * nfs4_file_key_hashfn - Compute the hash value of a lookup key
> > + * @data: key on which to compute the hash value
> > + * @len: rhash table's key_len parameter (unused)
> > + * @seed: rhash table's random seed of the day
> > + *
> > + * Return value:
> > + *   Computed 32-bit hash value
> > + */
> > +static u32 nfs4_file_key_hashfn(const void *data, u32 len, u32 seed)
> > {
> > -	struct inode *inode =3D d_inode(fh->fh_dentry);
> > +	const struct svc_fh *fhp =3D data;
> >=20
> > -	/* XXX: why not (here & in file cache) use inode? */
> > -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
> > +	return nfs4_file_inode_hash(d_inode(fhp->fh_dentry), seed);
> > }
> >=20
> > -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> > +/**
> > + * nfs4_file_obj_hashfn - Compute the hash value of an nfs4_file objec=
t
> > + * @data: object on which to compute the hash value
> > + * @len: rhash table's key_len parameter (unused)
> > + * @seed: rhash table's random seed of the day
> > + *
> > + * Return value:
> > + *   Computed 32-bit hash value
> > + */
> > +static u32 nfs4_file_obj_hashfn(const void *data, u32 len, u32 seed)
> > +{
> > +	const struct nfs4_file *fi =3D data;
> > +
> > +	return nfs4_file_inode_hash(fi->fi_inode, seed);
> > +}
> > +
> > +/**
> > + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
> > + * @arg: search criteria
> > + * @ptr: cache item to check
> > + *
> > + * Return values:
> > + *   %0 - Item matches search criteria
> > + *   %1 - Item does not match search criteria
> > + */
> > +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
> > +			       const void *ptr)
> > +{
> > +	const struct svc_fh *fhp =3D arg->key;
> > +	const struct nfs4_file *fi =3D ptr;
> > +
> > +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
> > +}
> > +
> > +static const struct rhashtable_params nfs4_file_rhash_params =3D {
> > +	.key_len		=3D sizeof_field(struct nfs4_file, fi_inode),
> > +	.key_offset		=3D offsetof(struct nfs4_file, fi_inode),
> > +	.head_offset		=3D offsetof(struct nfs4_file, fi_rhash),
> > +	.hashfn			=3D nfs4_file_key_hashfn,
> > +	.obj_hashfn		=3D nfs4_file_obj_hashfn,
> > +	.obj_cmpfn		=3D nfs4_file_obj_cmpfn,
> > +
> > +	/* Reduce resizing churn on light workloads */
> > +	.min_size		=3D 512,		/* buckets */
> > +	.automatic_shrinking	=3D true,
> > +};
> >=20
> > /*
> >  * Check if courtesy clients have conflicting access and resolve it if =
possible
> > @@ -4251,11 +4317,8 @@ static struct nfs4_file *nfsd4_alloc_file(void)
> > }
> >=20
> > /* OPEN Share state helper functions */
> > -static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
> > -				struct nfs4_file *fp)
> > +static void init_nfs4_file(const struct svc_fh *fh, struct nfs4_file *=
fp)
> > {
> > -	lockdep_assert_held(&state_lock);
> > -
> > 	refcount_set(&fp->fi_ref, 1);
> > 	spin_lock_init(&fp->fi_lock);
> > 	INIT_LIST_HEAD(&fp->fi_stateids);
> > @@ -4273,7 +4336,6 @@ static void nfsd4_init_file(struct svc_fh *fh, un=
signed int hashval,
> > 	INIT_LIST_HEAD(&fp->fi_lo_states);
> > 	atomic_set(&fp->fi_lo_recalls, 0);
> > #endif
> > -	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
> > }
> >=20
> > void
> > @@ -4626,71 +4688,84 @@ move_to_close_lru(struct nfs4_ol_stateid *s, st=
ruct net *net)
> > 		nfs4_put_stid(&last->st_stid);
> > }
> >=20
> > -/* search file_hashtbl[] for file */
> > -static struct nfs4_file *
> > -find_file_locked(struct svc_fh *fh, unsigned int hashval)
> > +static struct nfs4_file *find_nfs4_file(const struct svc_fh *fhp)
> > {
> > -	struct nfs4_file *fp;
> > +	struct nfs4_file *fi;
> >=20
> > -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> > -				lockdep_is_held(&state_lock)) {
> > -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> > -			if (refcount_inc_not_zero(&fp->fi_ref))
> > -				return fp;
> > -		}
> > -	}
> > -	return NULL;
> > +	rcu_read_lock();
> > +	fi =3D rhashtable_lookup(&nfs4_file_rhashtbl, fhp,
> > +			       nfs4_file_rhash_params);
> > +	if (fi)
> > +		if (!refcount_inc_not_zero(&fi->fi_ref))
> > +			fi =3D NULL;
> > +	rcu_read_unlock();
> > +	return fi;
> > }
> >=20
> > -static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc=
_fh *fh,
> > -				     unsigned int hashval)
> > +static void check_nfs4_file_aliases_locked(struct nfs4_file *new,
> > +					   const struct svc_fh *fhp)
> > {
> > -	struct nfs4_file *fp;
> > -	struct nfs4_file *ret =3D NULL;
> > -	bool alias_found =3D false;
> > +	struct rhashtable *ht =3D &nfs4_file_rhashtbl;
> > +	struct rhash_lock_head __rcu *const *bkt;
> > +	struct rhashtable_compare_arg arg =3D {
> > +		.ht	=3D ht,
> > +		.key	=3D fhp,
> > +	};
> > +	struct bucket_table *tbl;
> > +	struct rhash_head *he;
> > +	unsigned int hash;
> >=20
> > -	spin_lock(&state_lock);
> > -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
> > -				 lockdep_is_held(&state_lock)) {
> > -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
> > -			if (refcount_inc_not_zero(&fp->fi_ref))
> > -				ret =3D fp;
> > -		} else if (d_inode(fh->fh_dentry) =3D=3D fp->fi_inode)
> > -			fp->fi_aliased =3D alias_found =3D true;
> > -	}
> > -	if (likely(ret =3D=3D NULL)) {
> > -		nfsd4_init_file(fh, hashval, new);
> > -		new->fi_aliased =3D alias_found;
> > -		ret =3D new;
> > +	/*
> > +	 * rhashtable guarantees small buckets, thus this loop stays
> > +	 * efficient.
> > +	 */
> > +	rcu_read_lock();
> > +	tbl =3D rht_dereference_rcu(ht->tbl, ht);
> > +	hash =3D rht_key_hashfn(ht, tbl, fhp, nfs4_file_rhash_params);
> > +	bkt =3D rht_bucket(tbl, hash);
> > +	rht_for_each_rcu_from(he, rht_ptr_rcu(bkt), tbl, hash) {
> > +		struct nfs4_file *fi;
> > +
> > +		fi =3D rht_obj(ht, he);
> > +		if (nfs4_file_obj_cmpfn(&arg, fi) =3D=3D 0)
> > +			continue;
> > +		if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode) {
> > +			fi->fi_aliased =3D true;
> > +			new->fi_aliased =3D true;
> > +		}
> > 	}
> > -	spin_unlock(&state_lock);
> > -	return ret;
> > +	rcu_read_unlock();
> > }
> >=20
> > -static struct nfs4_file * find_file(struct svc_fh *fh)
> > +static noinline struct nfs4_file *
> > +find_or_hash_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp=
)
> > {
> > -	struct nfs4_file *fp;
> > -	unsigned int hashval =3D file_hashval(fh);
> > +	struct nfs4_file *fi;
> >=20
> > -	rcu_read_lock();
> > -	fp =3D find_file_locked(fh, hashval);
> > -	rcu_read_unlock();
> > -	return fp;
> > -}
> > +	init_nfs4_file(fhp, new);
> >=20
> > -static struct nfs4_file *
> > -find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
> > -{
> > -	struct nfs4_file *fp;
> > -	unsigned int hashval =3D file_hashval(fh);
> > +	fi =3D rhashtable_lookup_get_insert_key(&nfs4_file_rhashtbl,
> > +					      fhp, &new->fi_rhash,
> > +					      nfs4_file_rhash_params);
> > +	if (!fi) {
> > +		fi =3D new;
> > +		goto check_aliases;
> > +	}
> > +	if (IS_ERR(fi))		/* or BUG? */
> > +		return NULL;
> > +	if (!refcount_inc_not_zero(&fi->fi_ref))
> > +		fi =3D new;
>=20
> Ah, hrm. Given what we just had to do to nfsd_file_do_acquire(),
> maybe this needs the same fix to hang onto the RCU read lock
> while dicking with the nfs4_file object's reference count?
>=20
>=20

Yes. Probably we should just merge this patch if you want a fix for
mainline:

    nfsd: rework hashtable handling in nfsd_do_file_acquire


> > -	rcu_read_lock();
> > -	fp =3D find_file_locked(fh, hashval);
> > -	rcu_read_unlock();
> > -	if (fp)
> > -		return fp;
> > +check_aliases:
> > +	check_nfs4_file_aliases_locked(fi, fhp);
> > +
> > +	return fi;
> > +}
> >=20
> > -	return insert_file(new, fh, hashval);
> > +static void unhash_nfs4_file(struct nfs4_file *fi)
> > +{
> > +	rhashtable_remove_fast(&nfs4_file_rhashtbl, &fi->fi_rhash,
> > +			       nfs4_file_rhash_params);
> > }
> >=20
> > /*
> > @@ -4703,9 +4778,10 @@ nfs4_share_conflict(struct svc_fh *current_fh, u=
nsigned int deny_type)
> > 	struct nfs4_file *fp;
> > 	__be32 ret =3D nfs_ok;
> >=20
> > -	fp =3D find_file(current_fh);
> > +	fp =3D find_nfs4_file(current_fh);
> > 	if (!fp)
> > 		return ret;
> > +
> > 	/* Check for conflicting share reservations */
> > 	spin_lock(&fp->fi_lock);
> > 	if (fp->fi_share_deny & deny_type)
> > @@ -5548,7 +5624,9 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struc=
t svc_fh *current_fh, struct nf
> > 	 * and check for delegations in the process of being recalled.
> > 	 * If not found, create the nfs4_file struct
> > 	 */
> > -	fp =3D find_or_add_file(open->op_file, current_fh);
> > +	fp =3D find_or_hash_nfs4_file(open->op_file, current_fh);
> > +	if (unlikely(!fp))
> > +		return nfserr_jukebox;
> > 	if (fp !=3D open->op_file) {
> > 		status =3D nfs4_check_deleg(cl, open, &dp);
> > 		if (status)
> > @@ -7905,10 +7983,16 @@ nfs4_state_start(void)
> > {
> > 	int ret;
> >=20
> > -	ret =3D nfsd4_create_callback_queue();
> > +	ret =3D rhashtable_init(&nfs4_file_rhashtbl, &nfs4_file_rhash_params)=
;
> > 	if (ret)
> > 		return ret;
> >=20
> > +	ret =3D nfsd4_create_callback_queue();
> > +	if (ret) {
> > +		rhashtable_destroy(&nfs4_file_rhashtbl);
> > +		return ret;
> > +	}
> > +
> > 	set_max_delegations();
> > 	return 0;
> > }
> > @@ -7939,6 +8023,7 @@ nfs4_state_shutdown_net(struct net *net)
> >=20
> > 	nfsd4_client_tracking_exit(net);
> > 	nfs4_state_destroy_net(net);
> > +	rhashtable_destroy(&nfs4_file_rhashtbl);
> > #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > 	nfsd4_ssc_shutdown_umount(nn);
> > #endif
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index ae596dbf8667..879f085bc39e 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -536,16 +536,13 @@ struct nfs4_clnt_odstate {
> >  * inode can have multiple filehandles associated with it, so there is
> >  * (potentially) a many to one relationship between this struct and str=
uct
> >  * inode.
> > - *
> > - * These are hashed by filehandle in the file_hashtbl, which is protec=
ted by
> > - * the global state_lock spinlock.
> >  */
> > struct nfs4_file {
> > 	refcount_t		fi_ref;
> > 	struct inode *		fi_inode;
> > 	bool			fi_aliased;
> > 	spinlock_t		fi_lock;
> > -	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
> > +	struct rhash_head	fi_rhash;
> > 	struct list_head        fi_stateids;
> > 	union {
> > 		struct list_head	fi_delegations;
> >=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@poochiereds.net>
