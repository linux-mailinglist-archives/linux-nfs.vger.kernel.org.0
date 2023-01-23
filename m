Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C971E6789C8
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 22:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjAWVjo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 16:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWVjn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 16:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D810429
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674509934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+TS4Owno9GWn6Tauo9g9bdx2QfCQaEmTPpyOOvMtTA=;
        b=RLIQecjw/HUASZf2+uq6QYvrH9zkm8jNtptIl2/EguFGbmSTPL9Lw/Wdx63HAUbR6giRLC
        5+4rfUa4gfhNSjzuerlJI7IRfnq4XGQoRM3jaHWbluUCIRkGu0TkzSoutWN5SHYRr5Tz3q
        dbW6b/cYLYIGaL/YLvtnhEImaTUQDk4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-1614sjctM0mYi-Dh0recrg-1; Mon, 23 Jan 2023 16:38:52 -0500
X-MC-Unique: 1614sjctM0mYi-Dh0recrg-1
Received: by mail-qv1-f71.google.com with SMTP id df6-20020a056214080600b00534fe2ad5a3so6601039qvb.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 13:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+TS4Owno9GWn6Tauo9g9bdx2QfCQaEmTPpyOOvMtTA=;
        b=hwn89tg9lls1Hve2n1cS1hAdjn823t6hfEanXCJ5s7sYWUedeqT/b+3EZTrUlqAXc+
         CvhMTfbJrAhmsGAQI8M+G6XjMp9Z1gL7zDdwrodNtU5jhw6XjX3+svrTqvk0fw4JcQW7
         ct9nVFx5BQVSVmT7Myl//6r2Y1jQmddYDual46p/YwZ8FGPnbh/Vfo11DBeRqM8qxzxb
         jObTgfBKanzelxE1GfFvbSMMNaR7ENSdWzDVpe4gL+TG7UUtQBU0rnJ3tlNdJMGPn9jU
         2yBPhMLnRh4M6KqMTTHnHi84jiZFZh9/bqBrMNOXp71qiHO72OrATYs4pOmKEKjuPREe
         0OpA==
X-Gm-Message-State: AFqh2kpMZ/j6kUPuTSzHu5Lh60aWv8iJlz/ZJ4RSEnNMshyPChQUfAwK
        G3JiKuoNK/BET0sTIEdyF+483zv8eGYUWiNzZBBB++GdAn4wA1IaH0cnbTjPwdjQAizgnuUmcih
        lMpRJ9XQoDgXj0NtjfBaS
X-Received: by 2002:a05:6214:5c84:b0:534:b991:26ce with SMTP id lj4-20020a0562145c8400b00534b99126cemr37038608qvb.38.1674509931387;
        Mon, 23 Jan 2023 13:38:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuvLZ2Lcy6juB4B/VUcu4W0RaTo9FTufGjM/SvbM6id3HrmX1Chi5wjLxz+svGco3Z95CKayw==
X-Received: by 2002:a05:6214:5c84:b0:534:b991:26ce with SMTP id lj4-20020a0562145c8400b00534b99126cemr37038576qvb.38.1674509930956;
        Mon, 23 Jan 2023 13:38:50 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id e124-20020a37b582000000b0070617deb4b7sm175798qkf.134.2023.01.23.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:38:50 -0800 (PST)
Message-ID: <15afb0215ec76ffb54854eda8916efa4b5b3f6c3.camel@redhat.com>
Subject: Re: [PATCH RFC] NFSD: Convert filecache to rhltable
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 23 Jan 2023 16:38:50 -0500
In-Reply-To: <FB44286A-6F2C-4E41-BF22-E0FB8F2F524D@oracle.com>
References: <167293053710.2587608.15966496749656663379.stgit@manet.1015granger.net>
         <d65c6afc3f1dfd29e7cc46e1bd00b458c3f0d2f8.camel@redhat.com>
         <FB44286A-6F2C-4E41-BF22-E0FB8F2F524D@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-01-23 at 20:34 +0000, Chuck Lever III wrote:
>=20
> > On Jan 23, 2023, at 3:15 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >=20
> > On Thu, 2023-01-05 at 09:58 -0500, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > While we were converting the nfs4_file hashtable to use the kernel's
> > > resizable hashtable data structure, Neil Brown observed that the
> > > list variant (rhltable) would be better for managing nfsd_file items
> > > as well. The nfsd_file hash table will contain multiple entries for
> > > the same inode -- these should be kept together on a list. And, it
> > > could be possible for exotic or malicious client behavior to cause
> > > the hash table to resize itself on every insertion.
> > >=20
> > > A nice simplification is that rhltable_lookup() can return a list
> > > that contains only nfsd_file items that match a given inode, which
> > > enables us to eliminate specialized hash table helper functions and
> > > use the default functions provided by the rhashtable implementation).
> > >=20
> > > Since we are now storing nfsd_file items for the same inode on a
> > > single list, that effectively reduces the number of hash entries
> > > that have to be tracked in the hash table. The mininum bucket count
> > > is therefore lowered.
> > >=20
> > > Suggested-by: Neil Brown <neilb@suse.de>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > fs/nfsd/filecache.c |  289 +++++++++++++++++++-----------------------=
---------
> > > fs/nfsd/filecache.h |    9 +-
> > > 2 files changed, 115 insertions(+), 183 deletions(-)
> > >=20
> > > Just to note that this work is still in the wings. It would need to
> > > be rebased on Jeff's recent fixes and clean-ups. I'm reluctant to
> > > apply this until there is more evidence that the instability in v6.0
> > > has been duly addressed.
> > >=20
> > >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 45b2c9e3f636..f04e722bb6bc 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -74,70 +74,9 @@ static struct list_lru			nfsd_file_lru;
> > > static unsigned long			nfsd_file_flags;
> > > static struct fsnotify_group		*nfsd_file_fsnotify_group;
> > > static struct delayed_work		nfsd_filecache_laundrette;
> > > -static struct rhashtable		nfsd_file_rhash_tbl
> > > +static struct rhltable			nfsd_file_rhltable
> > > 						____cacheline_aligned_in_smp;
> > >=20
> > > -enum nfsd_file_lookup_type {
> > > -	NFSD_FILE_KEY_INODE,
> > > -	NFSD_FILE_KEY_FULL,
> > > -};
> > > -
> > > -struct nfsd_file_lookup_key {
> > > -	struct inode			*inode;
> > > -	struct net			*net;
> > > -	const struct cred		*cred;
> > > -	unsigned char			need;
> > > -	bool				gc;
> > > -	enum nfsd_file_lookup_type	type;
> > > -};
> > > -
> > > -/*
> > > - * The returned hash value is based solely on the address of an in-c=
ode
> > > - * inode, a pointer to a slab-allocated object. The entropy in such =
a
> > > - * pointer is concentrated in its middle bits.
> > > - */
> > > -static u32 nfsd_file_inode_hash(const struct inode *inode, u32 seed)
> > > -{
> > > -	unsigned long ptr =3D (unsigned long)inode;
> > > -	u32 k;
> > > -
> > > -	k =3D ptr >> L1_CACHE_SHIFT;
> > > -	k &=3D 0x00ffffff;
> > > -	return jhash2(&k, 1, seed);
> > > -}
> > > -
> > > -/**
> > > - * nfsd_file_key_hashfn - Compute the hash value of a lookup key
> > > - * @data: key on which to compute the hash value
> > > - * @len: rhash table's key_len parameter (unused)
> > > - * @seed: rhash table's random seed of the day
> > > - *
> > > - * Return value:
> > > - *   Computed 32-bit hash value
> > > - */
> > > -static u32 nfsd_file_key_hashfn(const void *data, u32 len, u32 seed)
> > > -{
> > > -	const struct nfsd_file_lookup_key *key =3D data;
> > > -
> > > -	return nfsd_file_inode_hash(key->inode, seed);
> > > -}
> > > -
> > > -/**
> > > - * nfsd_file_obj_hashfn - Compute the hash value of an nfsd_file
> > > - * @data: object on which to compute the hash value
> > > - * @len: rhash table's key_len parameter (unused)
> > > - * @seed: rhash table's random seed of the day
> > > - *
> > > - * Return value:
> > > - *   Computed 32-bit hash value
> > > - */
> > > -static u32 nfsd_file_obj_hashfn(const void *data, u32 len, u32 seed)
> > > -{
> > > -	const struct nfsd_file *nf =3D data;
> > > -
> > > -	return nfsd_file_inode_hash(nf->nf_inode, seed);
> > > -}
> > > -
> > > static bool
> > > nfsd_match_cred(const struct cred *c1, const struct cred *c2)
> > > {
> > > @@ -158,53 +97,16 @@ nfsd_match_cred(const struct cred *c1, const str=
uct cred *c2)
> > > 	return true;
> > > }
> > >=20
> > > -/**
> > > - * nfsd_file_obj_cmpfn - Match a cache item against search criteria
> > > - * @arg: search criteria
> > > - * @ptr: cache item to check
> > > - *
> > > - * Return values:
> > > - *   %0 - Item matches search criteria
> > > - *   %1 - Item does not match search criteria
> > > - */
> > > -static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
> > > -			       const void *ptr)
> > > -{
> > > -	const struct nfsd_file_lookup_key *key =3D arg->key;
> > > -	const struct nfsd_file *nf =3D ptr;
> > > -
> > > -	switch (key->type) {
> > > -	case NFSD_FILE_KEY_INODE:
> > > -		if (nf->nf_inode !=3D key->inode)
> > > -			return 1;
> > > -		break;
> > > -	case NFSD_FILE_KEY_FULL:
> > > -		if (nf->nf_inode !=3D key->inode)
> > > -			return 1;
> > > -		if (nf->nf_may !=3D key->need)
> > > -			return 1;
> > > -		if (nf->nf_net !=3D key->net)
> > > -			return 1;
> > > -		if (!nfsd_match_cred(nf->nf_cred, key->cred))
> > > -			return 1;
> > > -		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> > > -			return 1;
> > > -		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
> > > -			return 1;
> > > -		break;
> > > -	}
> > > -	return 0;
> > > -}
> > > -
> > > static const struct rhashtable_params nfsd_file_rhash_params =3D {
> > > 	.key_len		=3D sizeof_field(struct nfsd_file, nf_inode),
> > > 	.key_offset		=3D offsetof(struct nfsd_file, nf_inode),
> > > -	.head_offset		=3D offsetof(struct nfsd_file, nf_rhash),
> > > -	.hashfn			=3D nfsd_file_key_hashfn,
> > > -	.obj_hashfn		=3D nfsd_file_obj_hashfn,
> > > -	.obj_cmpfn		=3D nfsd_file_obj_cmpfn,
> > > -	/* Reduce resizing churn on light workloads */
> > > -	.min_size		=3D 512,		/* buckets */
> > > +	.head_offset		=3D offsetof(struct nfsd_file, nf_rlist),
> > > +
> > > +	/*
> > > +	 * Start with a single page hash table to reduce resizing churn
> > > +	 * on light workloads.
> > > +	 */
> > > +	.min_size		=3D 256,
> > > 	.automatic_shrinking	=3D true,
> > > };
> > >=20
> > > @@ -307,27 +209,27 @@ nfsd_file_mark_find_or_create(struct nfsd_file =
*nf, struct inode *inode)
> > > }
> > >=20
> > > static struct nfsd_file *
> > > -nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
> > > +nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char =
need,
> > > +		bool want_gc)
> > > {
> > > 	struct nfsd_file *nf;
> > >=20
> > > 	nf =3D kmem_cache_alloc(nfsd_file_slab, GFP_KERNEL);
> > > -	if (nf) {
> > > -		INIT_LIST_HEAD(&nf->nf_lru);
> > > -		nf->nf_birthtime =3D ktime_get();
> > > -		nf->nf_file =3D NULL;
> > > -		nf->nf_cred =3D get_current_cred();
> > > -		nf->nf_net =3D key->net;
> > > -		nf->nf_flags =3D 0;
> > > -		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
> > > -		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> > > -		if (key->gc)
> > > -			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> > > -		nf->nf_inode =3D key->inode;
> > > -		refcount_set(&nf->nf_ref, 1);
> > > -		nf->nf_may =3D key->need;
> > > -		nf->nf_mark =3D NULL;
> > > -	}
> > > +	if (unlikely(!nf))
> > > +		return NULL;
> > > +
> > > +	INIT_LIST_HEAD(&nf->nf_lru);
> > > +	nf->nf_birthtime =3D ktime_get();
> > > +	nf->nf_file =3D NULL;
> > > +	nf->nf_cred =3D get_current_cred();
> > > +	nf->nf_net =3D net;
> > > +	nf->nf_flags =3D want_gc ?
> > > +		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING) | BIT(NFSD_FILE_GC)=
 :
> > > +		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING);
> > > +	nf->nf_inode =3D inode;
> > > +	refcount_set(&nf->nf_ref, 1);
> > > +	nf->nf_may =3D need;
> > > +	nf->nf_mark =3D NULL;
> > > 	return nf;
> > > }
> > >=20
> > > @@ -362,8 +264,8 @@ nfsd_file_hash_remove(struct nfsd_file *nf)
> > >=20
> > > 	if (nfsd_file_check_write_error(nf))
> > > 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > > -	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
> > > -			       nfsd_file_rhash_params);
> > > +	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
> > > +			nfsd_file_rhash_params);
> > > }
> > >=20
> > > static bool
> > > @@ -680,21 +582,19 @@ static struct shrinker	nfsd_file_shrinker =3D {
> > > static void
> > > nfsd_file_queue_for_close(struct inode *inode, struct list_head *disp=
ose)
> > > {
> > > -	struct nfsd_file_lookup_key key =3D {
> > > -		.type	=3D NFSD_FILE_KEY_INODE,
> > > -		.inode	=3D inode,
> > > -	};
> > > -	struct nfsd_file *nf;
> > > -
> > > 	rcu_read_lock();
> > > 	do {
> > > +		struct rhlist_head *list;
> > > +		struct nfsd_file *nf;
> > > 		int decrement =3D 1;
> > >=20
> > > -		nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> > > +		list =3D rhltable_lookup(&nfsd_file_rhltable, &inode,
> > > 				       nfsd_file_rhash_params);
> > > -		if (!nf)
> > > +		if (!list)
> > > 			break;
> > >=20
> >=20
> > Rather than redriving the lookup multiple times in the loop, would it b=
e
> > better to just search once and then walk the resulting list with
> > rhl_for_each_entry_rcu, all while holding the rcu_read_lock?
>=20
> That would be nice, but as you and I have discussed before:
>=20
> On every iteration, we're possibly calling nfsd_file_unhash(), which
> changes the list. So we have to invoke rhltable_lookup() again to get
> the updated version of that list.
>=20
> As far as I can see there's no "_safe" version of rhl_for_each_entry.
>=20
> I think the best we can do is not redrive the lookup if we didn't
> unhash anything. I'm not sure that will fit easily with the
> nfsd_file_cond_queue thingie you just added in nfsd-fixes.
>=20
> Perhaps it should also drop the RCU read lock on each iteration in
> case it finds a lot of inodes that match the lookup criteria.
>=20

I could be wrong, but it looks like you're safe to traverse the list
even in the case of removals, assuming the objects themselves are
rcu-freed. AFAICT, the object's ->next pointer is not changed when it's
removed from the table. After all, we're not holding a "real" lock here
so the object could be removed by another task at any time.

It would be nice if this were documented though.

>=20
> > > +		nf =3D container_of(list, struct nfsd_file, nf_rlist);
> > > +
> > > 		/* If we raced with someone else unhashing, ignore it */
> > > 		if (!nfsd_file_unhash(nf))
> > > 			continue;
> > > @@ -836,7 +736,7 @@ nfsd_file_cache_init(void)
> > > 	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1)
> > > 		return 0;
> > >=20
> > > -	ret =3D rhashtable_init(&nfsd_file_rhash_tbl, &nfsd_file_rhash_para=
ms);
> > > +	ret =3D rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params)=
;
> > > 	if (ret)
> > > 		return ret;
> > >=20
> > > @@ -904,7 +804,7 @@ nfsd_file_cache_init(void)
> > > 	nfsd_file_mark_slab =3D NULL;
> > > 	destroy_workqueue(nfsd_filecache_wq);
> > > 	nfsd_filecache_wq =3D NULL;
> > > -	rhashtable_destroy(&nfsd_file_rhash_tbl);
> > > +	rhltable_destroy(&nfsd_file_rhltable);
> > > 	goto out;
> > > }
> > >=20
> > > @@ -922,7 +822,7 @@ __nfsd_file_cache_purge(struct net *net)
> > > 	struct nfsd_file *nf;
> > > 	LIST_HEAD(dispose);
> > >=20
> > > -	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
> > > +	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
> > > 	do {
> > > 		rhashtable_walk_start(&iter);
> > >=20
> > > @@ -1031,7 +931,7 @@ nfsd_file_cache_shutdown(void)
> > > 	nfsd_file_mark_slab =3D NULL;
> > > 	destroy_workqueue(nfsd_filecache_wq);
> > > 	nfsd_filecache_wq =3D NULL;
> > > -	rhashtable_destroy(&nfsd_file_rhash_tbl);
> > > +	rhltable_destroy(&nfsd_file_rhltable);
> > >=20
> > > 	for_each_possible_cpu(i) {
> > > 		per_cpu(nfsd_file_cache_hits, i) =3D 0;
> > > @@ -1042,6 +942,36 @@ nfsd_file_cache_shutdown(void)
> > > 	}
> > > }
> > >=20
> > > +static struct nfsd_file *
> > > +nfsd_file_lookup_locked(const struct net *net, const struct cred *cr=
ed,
> > > +			struct inode *inode, unsigned char need,
> > > +			bool want_gc)
> > > +{
> > > +	struct rhlist_head *tmp, *list;
> > > +	struct nfsd_file *nf;
> > > +
> > > +	list =3D rhltable_lookup(&nfsd_file_rhltable, &inode,
> > > +			       nfsd_file_rhash_params);
> > > +	rhl_for_each_entry_rcu(nf, tmp, list, nf_rlist) {
> > > +		if (nf->nf_may !=3D need)
> > > +			continue;
> > > +		if (nf->nf_net !=3D net)
> > > +			continue;
> > > +		if (!nfsd_match_cred(nf->nf_cred, cred))
> > > +			continue;
> > > +		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D want_gc)
> > > +			continue;
> > > +		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
> > > +			continue;
> > > +
> > > +		/* If it was on the LRU, reuse that reference. */
> > > +		if (nfsd_file_lru_remove(nf))
> > > +			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
> > > +		return nf;
> > > +	}
> > > +	return NULL;
> > > +}
> > > +
> > > /**
> > >  * nfsd_file_is_cached - are there any cached open files for this ino=
de?
> > >  * @inode: inode to check
> > > @@ -1056,15 +986,12 @@ nfsd_file_cache_shutdown(void)
> > > bool
> > > nfsd_file_is_cached(struct inode *inode)
> > > {
> > > -	struct nfsd_file_lookup_key key =3D {
> > > -		.type	=3D NFSD_FILE_KEY_INODE,
> > > -		.inode	=3D inode,
> > > -	};
> > > -	bool ret =3D false;
> > > -
> > > -	if (rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> > > -				   nfsd_file_rhash_params) !=3D NULL)
> > > -		ret =3D true;
> > > +	bool ret;
> > > +
> > > +	rcu_read_lock();
> > > +	ret =3D (rhltable_lookup(&nfsd_file_rhltable, &inode,
> > > +			       nfsd_file_rhash_params) !=3D NULL);
> > > +	rcu_read_unlock();
> > > 	trace_nfsd_file_is_cached(inode, (int)ret);
> > > 	return ret;
> > > }
> > > @@ -1074,14 +1001,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > 		     unsigned int may_flags, struct nfsd_file **pnf,
> > > 		     bool open, bool want_gc)
> > > {
> > > -	struct nfsd_file_lookup_key key =3D {
> > > -		.type	=3D NFSD_FILE_KEY_FULL,
> > > -		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
> > > -		.net	=3D SVC_NET(rqstp),
> > > -		.gc	=3D want_gc,
> > > -	};
> > > +	unsigned char need =3D may_flags & NFSD_FILE_MAY_MASK;
> > > +	struct net *net =3D SVC_NET(rqstp);
> > > +	struct nfsd_file *new, *nf;
> > > +	const struct cred *cred;
> > > 	bool open_retry =3D true;
> > > -	struct nfsd_file *nf;
> > > +	struct inode *inode;
> > > 	__be32 status;
> > > 	int ret;
> > >=20
> > > @@ -1089,32 +1014,38 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> > > 	if (status !=3D nfs_ok)
> > > 		return status;
> > > -	key.inode =3D d_inode(fhp->fh_dentry);
> > > -	key.cred =3D get_current_cred();
> > > +	inode =3D d_inode(fhp->fh_dentry);
> > > +	cred =3D get_current_cred();
> > >=20
> > > retry:
> > > -	rcu_read_lock();
> > > -	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> > > -			       nfsd_file_rhash_params);
> > > -	if (nf)
> > > -		nf =3D nfsd_file_get(nf);
> > > -	rcu_read_unlock();
> > > -
> > > -	if (nf) {
> > > -		if (nfsd_file_lru_remove(nf))
> > > -			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
> > > -		goto wait_for_construction;
> > > +	if (open) {
> > > +		rcu_read_lock();
> > > +		nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> > > +		rcu_read_unlock();
> > > +		if (nf)
> > > +			goto wait_for_construction;
> > > 	}
> > >=20
> > > -	nf =3D nfsd_file_alloc(&key, may_flags);
> > > -	if (!nf) {
> > > +	new =3D nfsd_file_alloc(net, inode, need, want_gc);
> > > +	if (!new) {
> > > 		status =3D nfserr_jukebox;
> > > 		goto out_status;
> > > 	}
> > > +	rcu_read_lock();
> > > +	spin_lock(&inode->i_lock);
> > > +	nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> > > +	if (unlikely(nf)) {
> > > +		spin_unlock(&inode->i_lock);
> > > +		rcu_read_unlock();
> > > +		nfsd_file_slab_free(&new->nf_rcu);
> > > +		goto wait_for_construction;
> > > +	}
> > > +	nf =3D new;
> > > +	ret =3D rhltable_insert(&nfsd_file_rhltable, &nf->nf_rlist,
> > > +			      nfsd_file_rhash_params);
> > > +	spin_unlock(&inode->i_lock);
> > > +	rcu_read_unlock();
> > >=20
> > > -	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
> > > -					   &key, &nf->nf_rhash,
> > > -					   nfsd_file_rhash_params);
> > > 	if (likely(ret =3D=3D 0))
> > > 		goto open_file;
> > >=20
> > > @@ -1122,7 +1053,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > > 	nf =3D NULL;
> > > 	if (ret =3D=3D -EEXIST)
> > > 		goto retry;
> > > -	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
> > > +	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
> > > 	status =3D nfserr_jukebox;
> > > 	goto out_status;
> > >=20
> > > @@ -1131,7 +1062,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > >=20
> > > 	/* Did construction of this file fail? */
> > > 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > > -		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
> > > +		trace_nfsd_file_cons_err(rqstp, inode, may_flags, nf);
> > > 		if (!open_retry) {
> > > 			status =3D nfserr_jukebox;
> > > 			goto out;
> > > @@ -1157,14 +1088,14 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> > > 	}
> > >=20
> > > out_status:
> > > -	put_cred(key.cred);
> > > +	put_cred(cred);
> > > 	if (open)
> > > -		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
> > > +		trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
> > > 	return status;
> > >=20
> > > open_file:
> > > 	trace_nfsd_file_alloc(nf);
> > > -	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
> > > +	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, inode);
> > > 	if (nf->nf_mark) {
> > > 		if (open) {
> > > 			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
> > > @@ -1178,7 +1109,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> > > 	 * If construction failed, or we raced with a call to unlink()
> > > 	 * then unhash.
> > > 	 */
> > > -	if (status =3D=3D nfs_ok && key.inode->i_nlink =3D=3D 0)
> > > +	if (status !=3D nfs_ok || inode->i_nlink =3D=3D 0)
> > > 		status =3D nfserr_jukebox;
> > > 	if (status !=3D nfs_ok)
> > > 		nfsd_file_unhash(nf);
> > > @@ -1273,7 +1204,7 @@ int nfsd_file_cache_stats_show(struct seq_file =
*m, void *v)
> > > 		lru =3D list_lru_count(&nfsd_file_lru);
> > >=20
> > > 		rcu_read_lock();
> > > -		ht =3D &nfsd_file_rhash_tbl;
> > > +		ht =3D &nfsd_file_rhltable.ht;
> > > 		count =3D atomic_read(&ht->nelems);
> > > 		tbl =3D rht_dereference_rcu(ht->tbl, ht);
> > > 		buckets =3D tbl->size;
> > > @@ -1289,7 +1220,7 @@ int nfsd_file_cache_stats_show(struct seq_file =
*m, void *v)
> > > 		evictions +=3D per_cpu(nfsd_file_evictions, i);
> > > 	}
> > >=20
> > > -	seq_printf(m, "total entries: %u\n", count);
> > > +	seq_printf(m, "total inodes: %u\n", count);
> > > 	seq_printf(m, "hash buckets:  %u\n", buckets);
> > > 	seq_printf(m, "lru entries:   %lu\n", lru);
> > > 	seq_printf(m, "cache hits:    %lu\n", hits);
> > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > index b7efb2c3ddb1..7d3b35771565 100644
> > > --- a/fs/nfsd/filecache.h
> > > +++ b/fs/nfsd/filecache.h
> > > @@ -29,9 +29,8 @@ struct nfsd_file_mark {
> > >  * never be dereferenced, only used for comparison.
> > >  */
> > > struct nfsd_file {
> > > -	struct rhash_head	nf_rhash;
> > > -	struct list_head	nf_lru;
> > > -	struct rcu_head		nf_rcu;
> > > +	struct rhlist_head	nf_rlist;
> > > +	void			*nf_inode;
> > > 	struct file		*nf_file;
> > > 	const struct cred	*nf_cred;
> > > 	struct net		*nf_net;
> > > @@ -40,10 +39,12 @@ struct nfsd_file {
> > > #define NFSD_FILE_REFERENCED	(2)
> > > #define NFSD_FILE_GC		(3)
> > > 	unsigned long		nf_flags;
> > > -	struct inode		*nf_inode;	/* don't deref */
> > > 	refcount_t		nf_ref;
> > > 	unsigned char		nf_may;
> > > +
> > > 	struct nfsd_file_mark	*nf_mark;
> > > +	struct list_head	nf_lru;
> > > +	struct rcu_head		nf_rcu;
> > > 	ktime_t			nf_birthtime;
> > > };
> > >=20
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@redhat.com>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@redhat.com>

