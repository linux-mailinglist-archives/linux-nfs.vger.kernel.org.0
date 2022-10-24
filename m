Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA63460C041
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiJYA4l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJYA41 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:56:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3BE19C071
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 16:43:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1091821F8A;
        Mon, 24 Oct 2022 23:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666655013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oNflTYrUtKeGHbigd/52YVI+9qI6umOHNZoYA5xTAE=;
        b=b3GEbAiyZWK/S+gQh5Fb0sJog3gsIWNy7j5H/lm5+XBtOPnu+Symej8HTOekz3ChEdNm4H
        sbj8IA63+CXmaLh9IIDRlH0kxoWxP79NltPfWVZQRotLZxVsHgqwmMSN4eE+vNzeJARNFA
        keBmh46HFjQs1a/V2pbCnowmJ3/tsuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666655013;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oNflTYrUtKeGHbigd/52YVI+9qI6umOHNZoYA5xTAE=;
        b=xVr63MOM2WhFqoqPO19p9MAJ8xEs0i7tujVzeqIl9Cedp9RPCMHf6AFA0AwZNH/8AloALx
        b/DeUWkXaMOjBTDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2279813A79;
        Mon, 24 Oct 2022 23:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OzotMiMjV2MfKQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 23:43:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 13/13] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <166665109477.50761.4457095370494745929.stgit@klimt.1015granger.net>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>,
 <166665109477.50761.4457095370494745929.stgit@klimt.1015granger.net>
Date:   Tue, 25 Oct 2022 10:43:28 +1100
Message-id: <166665500851.12462.15192873887843652314@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever wrote:
> fh_match() is costly, especially when filehandles are large (as is
> the case for NFSv4). It needs to be used sparingly when searching
> data structures. Unfortunately, with common workloads, I see
> multiple thousands of objects stored in file_hashtbl[], which always
> has only 256 buckets, which makes the hash chains quite lengthy.
>=20
> Walking long hash chains with the state_lock held blocks other
> activity that needs that lock.
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
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |   64 +++++++++++++++++++++++++----------------------=
----
>  fs/nfsd/state.h     |    4 ---
>  2 files changed, 31 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 681cb2daa843..5b90e5a6a04f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -591,11 +591,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rcu)
>  void
>  put_nfs4_file(struct nfs4_file *fi)
>  {
> -	might_lock(&state_lock);
> -
> -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
> +	if (refcount_dec_and_test(&fi->fi_ref)) {
>  		remove_nfs4_file_locked(fi);
> -		spin_unlock(&state_lock);
>  		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>  		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
>  		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> @@ -709,20 +706,6 @@ static unsigned int ownerstr_hashval(struct xdr_netobj=
 *ownername)
>  	return ret & OWNER_HASH_MASK;
>  }
> =20
> -/* hash table for nfs4_file */
> -#define FILE_HASH_BITS                   8
> -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
> -
> -static unsigned int file_hashval(const struct svc_fh *fh)
> -{
> -	struct inode *inode =3D d_inode(fh->fh_dentry);
> -
> -	/* XXX: why not (here & in file cache) use inode? */
> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
> -}
> -
> -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> -
>  static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
> =20
>  static const struct rhashtable_params nfs4_file_rhash_params =3D {
> @@ -4683,12 +4666,13 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct=
 net *net)
>  static noinline_for_stack struct nfs4_file *
>  find_nfs4_file(const struct svc_fh *fhp)
>  {
> -	unsigned int hashval =3D file_hashval(fhp);
> +	struct rhlist_head *tmp, *list;
>  	struct nfs4_file *fi =3D NULL;
> =20
>  	rcu_read_lock();
> -	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
> -				 lockdep_is_held(&state_lock)) {
> +	list =3D rhltable_lookup(&nfs4_file_rhltable, fhp,
> +			       nfs4_file_rhash_params);
> +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
>  		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>  			if (!refcount_inc_not_zero(&fi->fi_ref))
>  				fi =3D NULL;
> @@ -4708,33 +4692,45 @@ find_nfs4_file(const struct svc_fh *fhp)
>  static noinline_for_stack struct nfs4_file *
>  insert_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
>  {
> -	unsigned int hashval =3D file_hashval(fhp);
> +	struct rhlist_head *tmp, *list;
>  	struct nfs4_file *ret =3D NULL;
>  	bool alias_found =3D false;
>  	struct nfs4_file *fi;
> +	int err;
> =20
> -	spin_lock(&state_lock);
> -	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
> -				 lockdep_is_held(&state_lock)) {
> +	rcu_read_lock();
> +

As mentioned separately, we need some sort of lock around this loop and
the later insert.

> +	list =3D rhltable_lookup(&nfs4_file_rhltable, fhp,
> +			       nfs4_file_rhash_params);
> +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
>  		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>  			if (refcount_inc_not_zero(&fi->fi_ref))
>  				ret =3D fi;
>  		} else if (d_inode(fhp->fh_dentry) =3D=3D fi->fi_inode)
>  			fi->fi_aliased =3D alias_found =3D true;

This d_inde)( =3D=3D fi->fi_inode test is no longer relevant.  Everything in
the list must have the same inode.  Best remove it.

Thanks,
NeilBrown

>  	}
> -	if (likely(ret =3D=3D NULL)) {
> -		init_nfs4_file(fhp, new);
> -		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
> -		new->fi_aliased =3D alias_found;
> -		ret =3D new;
> -	}
> -	spin_unlock(&state_lock);
> +	if (ret)
> +		goto out_unlock;
> +
> +	init_nfs4_file(fhp, new);
> +	err =3D rhltable_insert_key(&nfs4_file_rhltable, fhp,
> +				  &new->fi_rlist,
> +				  nfs4_file_rhash_params);
> +	if (err)
> +		goto out_unlock;
> +
> +	new->fi_aliased =3D alias_found;
> +	ret =3D new;
> +
> +out_unlock:
> +	rcu_read_unlock();
>  	return ret;
>  }
> =20
>  static noinline_for_stack void remove_nfs4_file_locked(struct nfs4_file *f=
i)
>  {
> -	hlist_del_rcu(&fi->fi_hash);
> +	rhltable_remove(&nfs4_file_rhltable, &fi->fi_rlist,
> +			nfs4_file_rhash_params);
>  }
> =20
>  /*
> @@ -5624,6 +5620,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct sv=
c_fh *current_fh, struct nf
>  	 * If not found, create the nfs4_file struct
>  	 */
>  	fp =3D insert_nfs4_file(open->op_file, current_fh);
> +	if (unlikely(!fp))
> +		return nfserr_jukebox;
>  	if (fp !=3D open->op_file) {
>  		status =3D nfs4_check_deleg(cl, open, &dp);
>  		if (status)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 190fc7e418a4..eadd7f465bf5 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -536,16 +536,12 @@ struct nfs4_clnt_odstate {
>   * inode can have multiple filehandles associated with it, so there is
>   * (potentially) a many to one relationship between this struct and struct
>   * inode.
> - *
> - * These are hashed by filehandle in the file_hashtbl, which is protected =
by
> - * the global state_lock spinlock.
>   */
>  struct nfs4_file {
>  	refcount_t		fi_ref;
>  	struct inode *		fi_inode;
>  	bool			fi_aliased;
>  	spinlock_t		fi_lock;
> -	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
>  	struct rhlist_head	fi_rlist;
>  	struct list_head        fi_stateids;
>  	union {
>=20
>=20
>=20
