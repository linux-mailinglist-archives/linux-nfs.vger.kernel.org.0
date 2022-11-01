Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A746153AF
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 21:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKAU74 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKAU7z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 16:59:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D631AF0A
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 13:59:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72E8B1F898;
        Tue,  1 Nov 2022 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667336392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfYR9km+ERrMczAp5ZFDzo0VILq5C9YnAs7U6eH9Xh8=;
        b=v8/Wgp+dG4J8Vwn2BgPfJT9wj0unrphhtaJ/MsONxIRGKASTIDRgR8EaHZEGrY9B4iTser
        ZGShZGqlznlxsGbJ0c3Pa3w1wYcMxXPwF2XCksfuAOUMDhgS/ccXNHVYHiCG+SU4VU0Xpf
        I8M8Yf1+soEl27AHm3Qw46oUO0hHuTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667336392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfYR9km+ERrMczAp5ZFDzo0VILq5C9YnAs7U6eH9Xh8=;
        b=PB5UZX15aKduonPQjh2TeseScWCR8/uSNxrkLoMAtFwOUFeya8qMX/p772KfhCZ4vDRY6u
        EQe93YddqEeuLsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 042D913AAF;
        Tue,  1 Nov 2022 20:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jYCVK8aIYWNScAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 01 Nov 2022 20:59:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 2/5] nfsd: reorganize filecache.c
In-reply-to: <20221101144647.136696-3-jlayton@kernel.org>
References: <20221101144647.136696-1-jlayton@kernel.org>,
 <20221101144647.136696-3-jlayton@kernel.org>
Date:   Wed, 02 Nov 2022 07:59:45 +1100
Message-id: <166733638596.19313.9057078687442470708@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 02 Nov 2022, Jeff Layton wrote:
> In a coming patch, we're going to rework how the filecache refcounting
> works. Move some code around in the function to reduce the churn in the
> later patches, and rename some of the functions with (hopefully) clearer
> names. This should introduce no functional changes.

Just for future reference, it can help to list here which functions
changed names and what the new names are.  It makes review that little
bit easier.
I think:
   nfsd_file_flush -> nfsd_file_fsync
   nfsd_file_unhash_and_dispose -> nfsd_file_unhash_and_queue

That patch make it look like
   nfsd_file_unhash -> nfsd_file_get
   nfsd_file_close_inode_sync -> nfsd_file_close_inode
   nfsd_file_close_inode -> nfsd_file_close_inode_sync
as well, but there the content of the functions also change
so one concludes that you just moved functions, and diff sees the '{'
and '}' and blank lines are common and aligns on them...

Why did you just swap the order of those last two ??

You also moved a tracepoint from nfsd_file_put_final to nfsd_file_free,
but didn't mention it in the commit comment (is that being too picky?).

But allowing for all that - the patch looks ok.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 135 ++++++++++++++++++++++----------------------
>  fs/nfsd/trace.h     |   4 +-
>  2 files changed, 70 insertions(+), 69 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 90e62042d6d6..0bf3727455e2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -311,16 +311,59 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, uns=
igned int may)
>  	return nf;
>  }
> =20
> +static void
> +nfsd_file_fsync(struct nfsd_file *nf)
> +{
> +	struct file *file =3D nf->nf_file;
> +
> +	if (!file || !(file->f_mode & FMODE_WRITE))
> +		return;
> +	if (vfs_fsync(file, 1) !=3D 0)
> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> +}
> +
> +static int
> +nfsd_file_check_write_error(struct nfsd_file *nf)
> +{
> +	struct file *file =3D nf->nf_file;
> +
> +	if (!file || !(file->f_mode & FMODE_WRITE))
> +		return 0;
> +	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
> +}
> +
> +static void
> +nfsd_file_hash_remove(struct nfsd_file *nf)
> +{
> +	trace_nfsd_file_unhash(nf);
> +
> +	if (nfsd_file_check_write_error(nf))
> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> +	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
> +			       nfsd_file_rhash_params);
> +}
> +
> +static bool
> +nfsd_file_unhash(struct nfsd_file *nf)
> +{
> +	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> +		nfsd_file_hash_remove(nf);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static bool
>  nfsd_file_free(struct nfsd_file *nf)
>  {
>  	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
>  	bool flush =3D false;
> =20
> +	trace_nfsd_file_free(nf);
> +
>  	this_cpu_inc(nfsd_file_releases);
>  	this_cpu_add(nfsd_file_total_age, age);
> =20
> -	trace_nfsd_file_put_final(nf);
>  	if (nf->nf_mark)
>  		nfsd_file_mark_put(nf->nf_mark);
>  	if (nf->nf_file) {
> @@ -354,27 +397,6 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>  }
> =20
> -static int
> -nfsd_file_check_write_error(struct nfsd_file *nf)
> -{
> -	struct file *file =3D nf->nf_file;
> -
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return 0;
> -	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
> -}
> -
> -static void
> -nfsd_file_flush(struct nfsd_file *nf)
> -{
> -	struct file *file =3D nf->nf_file;
> -
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return;
> -	if (vfs_fsync(file, 1) !=3D 0)
> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> -}
> -
>  static void nfsd_file_lru_add(struct nfsd_file *nf)
>  {
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> @@ -388,31 +410,18 @@ static void nfsd_file_lru_remove(struct nfsd_file *nf)
>  		trace_nfsd_file_lru_del(nf);
>  }
> =20
> -static void
> -nfsd_file_hash_remove(struct nfsd_file *nf)
> -{
> -	trace_nfsd_file_unhash(nf);
> -
> -	if (nfsd_file_check_write_error(nf))
> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> -	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
> -			       nfsd_file_rhash_params);
> -}
> -
> -static bool
> -nfsd_file_unhash(struct nfsd_file *nf)
> +struct nfsd_file *
> +nfsd_file_get(struct nfsd_file *nf)
>  {
> -	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_hash_remove(nf);
> -		return true;
> -	}
> -	return false;
> +	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
> +		return nf;
> +	return NULL;
>  }
> =20
>  static void
> -nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dispo=
se)
> +nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
>  {
> -	trace_nfsd_file_unhash_and_dispose(nf);
> +	trace_nfsd_file_unhash_and_queue(nf);
>  	if (nfsd_file_unhash(nf)) {
>  		/* caller must call nfsd_file_dispose_list() later */
>  		nfsd_file_lru_remove(nf);
> @@ -450,7 +459,7 @@ nfsd_file_put(struct nfsd_file *nf)
>  		nfsd_file_unhash_and_put(nf);
> =20
>  	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -		nfsd_file_flush(nf);
> +		nfsd_file_fsync(nf);
>  		nfsd_file_put_noref(nf);
>  	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>  		nfsd_file_put_noref(nf);
> @@ -459,14 +468,6 @@ nfsd_file_put(struct nfsd_file *nf)
>  		nfsd_file_put_noref(nf);
>  }
> =20
> -struct nfsd_file *
> -nfsd_file_get(struct nfsd_file *nf)
> -{
> -	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
> -		return nf;
> -	return NULL;
> -}
> -
>  static void
>  nfsd_file_dispose_list(struct list_head *dispose)
>  {
> @@ -475,7 +476,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
>  	while(!list_empty(dispose)) {
>  		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del_init(&nf->nf_lru);
> -		nfsd_file_flush(nf);
> +		nfsd_file_fsync(nf);
>  		nfsd_file_put_noref(nf);
>  	}
>  }
> @@ -489,7 +490,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
>  	while(!list_empty(dispose)) {
>  		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>  		list_del_init(&nf->nf_lru);
> -		nfsd_file_flush(nf);
> +		nfsd_file_fsync(nf);
>  		if (!refcount_dec_and_test(&nf->nf_ref))
>  			continue;
>  		if (nfsd_file_free(nf))
> @@ -689,7 +690,7 @@ __nfsd_file_close_inode(struct inode *inode, struct lis=
t_head *dispose)
>  				       nfsd_file_rhash_params);
>  		if (!nf)
>  			break;
> -		nfsd_file_unhash_and_dispose(nf, dispose);
> +		nfsd_file_unhash_and_queue(nf, dispose);
>  		count++;
>  	} while (1);
>  	rcu_read_unlock();
> @@ -697,37 +698,37 @@ __nfsd_file_close_inode(struct inode *inode, struct l=
ist_head *dispose)
>  }
> =20
>  /**
> - * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
> + * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
>   * @inode: inode of the file to attempt to remove
>   *
> - * Unhash and put, then flush and fput all cache items associated with @in=
ode.
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
> + * Unhash and put, then flush and fput all cache items associated with @in=
ode.
>   */
> -static void
> -nfsd_file_close_inode(struct inode *inode)
> +void
> +nfsd_file_close_inode_sync(struct inode *inode)
>  {
>  	LIST_HEAD(dispose);
>  	unsigned int count;
> =20
>  	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode(inode, count);
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	trace_nfsd_file_close_inode_sync(inode, count);
> +	nfsd_file_dispose_list_sync(&dispose);
>  }
> =20
>  /**
> @@ -891,7 +892,7 @@ __nfsd_file_cache_purge(struct net *net)
>  		nf =3D rhashtable_walk_next(&iter);
>  		while (!IS_ERR_OR_NULL(nf)) {
>  			if (!net || nf->nf_net =3D=3D net)
> -				nfsd_file_unhash_and_dispose(nf, &dispose);
> +				nfsd_file_unhash_and_queue(nf, &dispose);
>  			nf =3D rhashtable_walk_next(&iter);
>  		}
> =20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index b09ab4f92d43..940252482fd4 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -903,10 +903,10 @@ DEFINE_EVENT(nfsd_file_class, name, \
>  	TP_PROTO(struct nfsd_file *nf), \
>  	TP_ARGS(nf))
> =20
> -DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
>  DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
> -DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_dispose);
> +DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
> =20
>  TRACE_EVENT(nfsd_file_alloc,
>  	TP_PROTO(
> --=20
> 2.38.1
>=20
>=20
