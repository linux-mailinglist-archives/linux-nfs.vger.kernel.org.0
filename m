Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78F580A84
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 06:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiGZEkq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 00:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiGZEkq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 00:40:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F3D616F
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 21:40:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 622E01F38A;
        Tue, 26 Jul 2022 04:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658810443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDoGNC3YfjQTXdE2wT3l87S9RuIiQ9wL9ybfRoZiz7A=;
        b=MgQBiTHe4N9lYMDUgqiIllh00yP2nqBJHYTlqGIHCflNf8bVPYs57xrk0W9Fsb1ySamNE+
        cp01kV0Ovap0LJBN71pWvr4vJLjeJzsLgdzSJHlz9gab8ONFwIldz2cEOtYdGHiSoq7gEB
        8UXuS7UffJpIyTPph2l9jVfrqs+B8IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658810443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDoGNC3YfjQTXdE2wT3l87S9RuIiQ9wL9ybfRoZiz7A=;
        b=QFE+dwOgti/ZEnm8v2GMFJ1fqv3IfQB5WI2EPxKWiwnykeylpA5xxJYeho52MoOSQjJeaA
        GVaaILnC9eG5kxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53EE613A7C;
        Tue, 26 Jul 2022 04:40:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pBwWBUpw32LmLgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 04:40:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>
Cc:     "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: don't unhash dentry during unlink.
In-reply-to: <165708423191.17141.6465885406851939941@noble.neil.brown.name>
References: <165708423191.17141.6465885406851939941@noble.neil.brown.name>
Date:   Tue, 26 Jul 2022 14:40:39 +1000
Message-id: <165881043914.4359.13549022003264375515@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi Trond,
 did you have a change to look at this patch?

Thanks,
NeilBrown

On Wed, 06 Jul 2022, NeilBrown wrote:
> NFS unlink() must determine if the file is open, and must perform a
> "silly rename" instead of an unlink if it is.  Otherwise the client
> might hold a file open which has been removed on the server.
>=20
> Consequently if it determines that the file isn't open, it must block
> any subsequent opens until the unlink has been completed on the server.
>=20
> This is currently achieved by unhashing the dentry.  This forces any
> open attempt to the slow-path for lookup which will block on i_sem on
> the directory until the unlink completes.  A proposed patch will change
> the VFS to only get a shared lock on i_sem for unlink, so this will no
> longer work.
>=20
> Instead we introduce an explicit interlock.  A flag is set on the dentry
> while the unlink is running and ->d_revalidate blocks while that flag is
> set.  This closes the race without requiring exclusion on i_sem.
> unlink will still have exclusion on the dentry being unlinked, so it
> will be safe to set and then clear the flag without any risk of another
> thread touching the flag.
>=20
> There is little room for adding new dentry flags, so instead of adding a
> new flag, we overload an existing flag which is not used by NFS.
>=20
> DCACHE_DONTCACHE is only set for filesystems which call
> d_mark_dontcache() and NFS never calls this, so it is currently unused
> in NFS.
> DCACHE_DONTCACHE is only tested when the last reference on a dentry has
> been dropped, so it is safe for NFS to set and then clear the flag while
> holding a reference - the setting of the flag cannot cause a
> misunderstanding.
>=20
> So we define DCACHE_NFS_PENDING_UNLINK as an alias for DCACHE_DONTCACHE
> and add a definition to nfs_fs.h so that if NFS ever does find a need to
> call d_mark_dontcache() the build will fail with a suitable error.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>=20
> Hi Trond/Anna,
>  this patch is a precursor for my parallel-directory-updates patch set.
>  I would be particularly helpful if this (and the nfsd patches I
>  recently sent) could land for the next merge window.  Then I could post
>  a substantially reduced series to implement parallel directory
>  updates, which would then be easier for other to review.
>=20
> Thanks,
> NeilBrown
>=20
>=20
>  fs/nfs/dir.c           | 23 ++++++++++++++++-------
>  include/linux/nfs_fs.h | 14 ++++++++++++++
>  2 files changed, 30 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 0c4e8dd6aa96..695bb057cbd2 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1778,6 +1778,8 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsign=
ed int flags,
>  	int ret;
> =20
>  	if (flags & LOOKUP_RCU) {
> +		if (dentry->d_flags & DCACHE_NFS_PENDING_UNLINK)
> +			return -ECHILD;
>  		parent =3D READ_ONCE(dentry->d_parent);
>  		dir =3D d_inode_rcu(parent);
>  		if (!dir)
> @@ -1786,6 +1788,9 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsign=
ed int flags,
>  		if (parent !=3D READ_ONCE(dentry->d_parent))
>  			return -ECHILD;
>  	} else {
> +		/* Wait for unlink to complete */
> +		wait_var_event(&dentry->d_flags,
> +			       !(dentry->d_flags & DCACHE_NFS_PENDING_UNLINK));
>  		parent =3D dget_parent(dentry);
>  		ret =3D reval(d_inode(parent), dentry, flags);
>  		dput(parent);
> @@ -2454,7 +2459,6 @@ static int nfs_safe_remove(struct dentry *dentry)
>  int nfs_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	int error;
> -	int need_rehash =3D 0;
> =20
>  	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", dir->i_sb->s_id,
>  		dir->i_ino, dentry);
> @@ -2469,15 +2473,20 @@ int nfs_unlink(struct inode *dir, struct dentry *de=
ntry)
>  		error =3D nfs_sillyrename(dir, dentry);
>  		goto out;
>  	}
> -	if (!d_unhashed(dentry)) {
> -		__d_drop(dentry);
> -		need_rehash =3D 1;
> -	}
> +	/* We must prevent any concurrent open until the unlink
> +	 * completes.  ->d_revalidate will wait for DCACHE_NFS_PENDING_UNLINK
> +	 * to clear.  We set it here to ensure no lookup succeeds until
> +	 * the unlink is complete on the server.
> +	 */
> +	dentry->d_flags |=3D DCACHE_NFS_PENDING_UNLINK;
> +
>  	spin_unlock(&dentry->d_lock);
>  	error =3D nfs_safe_remove(dentry);
>  	nfs_dentry_remove_handle_error(dir, dentry, error);
> -	if (need_rehash)
> -		d_rehash(dentry);
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags &=3D ~DCACHE_NFS_PENDING_UNLINK;
> +	spin_unlock(&dentry->d_lock);
> +	wake_up_var(&dentry->d_flags);
>  out:
>  	trace_nfs_unlink_exit(dir, dentry, error);
>  	return error;
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index a17c337dbdf1..041a6076e045 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -617,6 +617,20 @@ nfs_fileid_to_ino_t(u64 fileid)
> =20
>  #define NFS_JUKEBOX_RETRY_TIME (5 * HZ)
> =20
> +/* We need to block new opens while a file is being unlinked.
> + * If it is opened *before* we decide to unlink, we will silly-rename
> + * instead. If it is opened *after*, then we the open to fail unless it cr=
eates
> + * a new file.
> + * If we allow the open and unlink to race, we could end up with a file th=
at is
> + * open but deleted on the server resulting in ESTALE.
> + * So overload DCACHE_DONTCACHE to record when the unlink is happening
> + * and block dentry revalidation while it is set.
> + * DCACHE_DONTCACHE is only used by filesystems which call d_mark_dontcach=
e()
> + * which NFS never calls.  It is only tested on a dentry on which all refe=
rences
> + * have been dropped, so it is safe for NFS to set it while holding a refe=
rence.
> + */
> +#define DCACHE_NFS_PENDING_UNLINK DCACHE_DONTCACHE
> +#define d_mark_dontcache(i) BUILD_BUG_ON_MSG(1, "NFS cannot use d_mark_don=
tcache()")
> =20
>  # undef ifdebug
>  # ifdef NFS_DEBUG
> --=20
> 2.36.1
>=20
>=20
