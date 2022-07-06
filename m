Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF21E568B1E
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 16:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiGFOXS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGFOXR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 10:23:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD016586
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 07:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37922B81CD2
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 14:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78BCC3411C;
        Wed,  6 Jul 2022 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657117393;
        bh=ZsqJS4D+f8L/38diC14ckYjcuOb0LkeJUtqv18MCne8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HlcZ5DqnPP8yOortsPm8ZlTbyZlrPbtbEq+bt7x4NnD15QSfX7lxY5BZGGLbf8NhV
         w/JlY4sd0Ktoq7sLJuEYJ5dqgOUSBO1laJzipA1Xxv+rORYoUrDYgr0AXOraisaOIv
         ySvHjwazqyYK7/7EHyOIzfyHkNF+yf/O2XUuS4vB8b8ZhtFI6v/jZ0wRGoPQpswpyd
         1eTAGVG0H8wpauKz+TeeSqd2iuUSEo1DHQsDGq/1J/21pQkRNmbzVbQt+9TXlbjHWd
         QWJJ3tttgPdUgASiwSwY/N4gkZt+1gwr1EcgLmGGZoD32MSSzmlrrceLPo6+uO0MNW
         qARclPkpZk2/A==
Message-ID: <b327b4752784a9c3d854671d31c5b4738f45f599.camel@kernel.org>
Subject: Re: [PATCH] NFS: don't unhash dentry during unlink.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Date:   Wed, 06 Jul 2022 10:23:10 -0400
In-Reply-To: <165708423191.17141.6465885406851939941@noble.neil.brown.name>
References: <165708423191.17141.6465885406851939941@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-07-06 at 15:10 +1000, NeilBrown wrote:
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
> @@ -1778,6 +1778,8 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsi=
gned int flags,
>  	int ret;
> =20
>  	if (flags & LOOKUP_RCU) {
> +		if (dentry->d_flags & DCACHE_NFS_PENDING_UNLINK)
> +			return -ECHILD;
>  		parent =3D READ_ONCE(dentry->d_parent);
>  		dir =3D d_inode_rcu(parent);
>  		if (!dir)
> @@ -1786,6 +1788,9 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsi=
gned int flags,
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
> @@ -2469,15 +2473,20 @@ int nfs_unlink(struct inode *dir, struct dentry *=
dentry)
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
> + * instead. If it is opened *after*, then we the open to fail unless it =
creates

"then we allow the open to fail"

> + * a new file.
> + * If we allow the open and unlink to race, we could end up with a file =
that is
> + * open but deleted on the server resulting in ESTALE.
> + * So overload DCACHE_DONTCACHE to record when the unlink is happening
> + * and block dentry revalidation while it is set.
> + * DCACHE_DONTCACHE is only used by filesystems which call d_mark_dontca=
che()
> + * which NFS never calls.  It is only tested on a dentry on which all re=
ferences
> + * have been dropped, so it is safe for NFS to set it while holding a re=
ference.
> + */
> +#define DCACHE_NFS_PENDING_UNLINK DCACHE_DONTCACHE
> +#define d_mark_dontcache(i) BUILD_BUG_ON_MSG(1, "NFS cannot use d_mark_d=
ontcache()")
> =20
>  # undef ifdebug
>  # ifdef NFS_DEBUG

Wow, we really are out of dentry flags. I wonder if some of them are no
longer needed?

This overloading is a bit klunky but it's probably OK. AFAICT,
0x80000000 is still available though if this turns out to be too nasty.
It looks like 0x08000000 may also be free


Reviewed-by: Jeff Layton <jlayton@kernel.org>
