Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1D568B03
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiGFOMc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGFOMX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 10:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F045C1EADE
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 07:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F00461E73
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 14:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F8FC3411C;
        Wed,  6 Jul 2022 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657116742;
        bh=jtI9gRdifEFPjz0Cvlh2IKcXUMXrb8Ayks7ulX+VMy0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K4DiqPYw2MVm3RPm2PigKYHuNFFZ8Y9zVCBFZGCHQdkbh/7QVqieiwbUCR89V04U4
         KjpFKVuTo+HpWlKXZFyd1wHwcRfFyQEQFEzWTeAfsFDXMx39X2MOwcx8R41NoWC0DC
         AYoLS98Uf4j0T0C7hT4L6PIB9ROzAWfJ3wmo4KFwyyM0y91YTDpDobunRSKSVnpUYk
         dz3uy0Cm0pwLAdduib14AwqgmHkvd71l8lTIkQcsT+CAIi05nEc3HY5h+sPtcvt9Bv
         9kBAoyhST9AxQMTq9wScLISIKarYglwgFqhWd51X+zU7j9ILK356Auq7mkhiZZhGno
         TVvgTLQ2zL8iA==
Message-ID: <4a39dc37373241e1ec5cb7d47f5649bc693e11df.camel@kernel.org>
Subject: Re: [PATCH 8/8] NFSD: discard fh_locked flag and fh_lock/fh_unlock
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 10:12:19 -0400
In-Reply-To: <165708109261.1940.5366273190007170909.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <165708109261.1940.5366273190007170909.stgit@noble.brown>
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

On Wed, 2022-07-06 at 14:18 +1000, NeilBrown wrote:
> As all inode locking is now fully balanced, fh_put() does not need to
> call fh_unlock().
> fh_lock() and fh_unlock() are no longer used, so discard them.
> These are the only real users of ->fh_locked, so discard that too.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsfh.c |    3 +--
>  fs/nfsd/nfsfh.h |   56 ++++---------------------------------------------=
------
>  fs/nfsd/vfs.c   |   17 +----------------
>  3 files changed, 6 insertions(+), 70 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 5e2ed4b2a925..22a77a5e2327 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -549,7 +549,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp=
, struct dentry *dentry,
>  	if (ref_fh =3D=3D fhp)
>  		fh_put(ref_fh);
> =20
> -	if (fhp->fh_locked || fhp->fh_dentry) {
> +	if (fhp->fh_dentry) {
>  		printk(KERN_ERR "fh_compose: fh %pd2 not initialized!\n",
>  		       dentry);
>  	}
> @@ -681,7 +681,6 @@ fh_put(struct svc_fh *fhp)
>  	struct dentry * dentry =3D fhp->fh_dentry;
>  	struct svc_export * exp =3D fhp->fh_export;
>  	if (dentry) {
> -		fh_unlock(fhp);
>  		fhp->fh_dentry =3D NULL;
>  		dput(dentry);
>  		fh_clear_pre_post_attrs(fhp);
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index fb9d358a267e..09c654bdf9b0 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -81,7 +81,6 @@ typedef struct svc_fh {
>  	struct dentry *		fh_dentry;	/* validated dentry */
>  	struct svc_export *	fh_export;	/* export pointer */
> =20
> -	bool			fh_locked;	/* inode locked by us */
>  	bool			fh_want_write;	/* remount protection taken */
>  	bool			fh_no_wcc;	/* no wcc data needed */
>  	bool			fh_no_atomic_attr;
> @@ -93,7 +92,7 @@ typedef struct svc_fh {
>  	bool			fh_post_saved;	/* post-op attrs saved */
>  	bool			fh_pre_saved;	/* pre-op attrs saved */
> =20
> -	/* Pre-op attributes saved during fh_lock */
> +	/* Pre-op attributes saved when inode is locked */
>  	__u64			fh_pre_size;	/* size before operation */
>  	struct timespec64	fh_pre_mtime;	/* mtime before oper */
>  	struct timespec64	fh_pre_ctime;	/* ctime before oper */
> @@ -103,7 +102,7 @@ typedef struct svc_fh {
>  	 */
>  	u64			fh_pre_change;
> =20
> -	/* Post-op attributes saved in fh_unlock */
> +	/* Post-op attributes saved in fh_fill_post_attrs() */
>  	struct kstat		fh_post_attr;	/* full attrs after operation */
>  	u64			fh_post_change; /* nfsv4 change; see above */
>  } svc_fh;
> @@ -223,8 +222,8 @@ void	fh_put(struct svc_fh *);
>  static __inline__ struct svc_fh *
>  fh_copy(struct svc_fh *dst, struct svc_fh *src)
>  {
> -	WARN_ON(src->fh_dentry || src->fh_locked);
> -		=09
> +	WARN_ON(src->fh_dentry);
> +
>  	*dst =3D *src;
>  	return dst;
>  }
> @@ -323,51 +322,4 @@ static inline u64 nfsd4_change_attribute(struct ksta=
t *stat,
>  extern void fh_fill_pre_attrs(struct svc_fh *fhp);
>  extern void fh_fill_post_attrs(struct svc_fh *fhp);
> =20
> -
> -/*
> - * Lock a file handle/inode
> - * NOTE: both fh_lock and fh_unlock are done "by hand" in
> - * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
> - * so, any changes here should be reflected there.
> - */
> -
> -static inline void
> -fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
> -{
> -	struct dentry	*dentry =3D fhp->fh_dentry;
> -	struct inode	*inode;
> -
> -	BUG_ON(!dentry);
> -
> -	if (fhp->fh_locked) {
> -		printk(KERN_WARNING "fh_lock: %pd2 already locked!\n",
> -			dentry);
> -		return;
> -	}
> -
> -	inode =3D d_inode(dentry);
> -	inode_lock_nested(inode, subclass);
> -	fh_fill_pre_attrs(fhp);
> -	fhp->fh_locked =3D true;
> -}
> -
> -static inline void
> -fh_lock(struct svc_fh *fhp)
> -{
> -	fh_lock_nested(fhp, I_MUTEX_NORMAL);
> -}
> -
> -/*
> - * Unlock a file handle/inode
> - */
> -static inline void
> -fh_unlock(struct svc_fh *fhp)
> -{
> -	if (fhp->fh_locked) {
> -		fh_fill_post_attrs(fhp);
> -		inode_unlock(d_inode(fhp->fh_dentry));
> -		fhp->fh_locked =3D false;
> -	}
> -}
> -
>  #endif /* _LINUX_NFSD_NFSFH_H */
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2526615285ca..fe4cdf8ab428 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1305,13 +1305,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	dirp =3D d_inode(dentry);
> =20
>  	dchild =3D dget(resfhp->fh_dentry);
> -	if (!fhp->fh_locked) {
> -		WARN_ONCE(1, "nfsd_create: parent %pd2 not locked!\n",
> -				dentry);
> -		err =3D nfserr_io;
> -		goto out;
> -	}
> -
>  	err =3D nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE)=
;
>  	if (err)
>  		goto out;
> @@ -1674,10 +1667,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>  		goto out;
>  	}
> =20
> -	/* cannot use fh_lock as we need deadlock protective ordering
> -	 * so do it by hand */
>  	trap =3D lock_rename(tdentry, fdentry);
> -	ffhp->fh_locked =3D tfhp->fh_locked =3D true;
>  	fh_fill_pre_attrs(ffhp);
>  	fh_fill_pre_attrs(tfhp);
> =20
> @@ -1733,17 +1723,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
>  	dput(odentry);
>   out_nfserr:
>  	err =3D nfserrno(host_err);
> -	/*
> -	 * We cannot rely on fh_unlock on the two filehandles,
> -	 * as that would do the wrong thing if the two directories
> -	 * were the same, so again we do it by hand.
> -	 */
> +
>  	if (!close_cached) {
>  		fh_fill_post_attrs(ffhp);
>  		fh_fill_post_attrs(tfhp);
>  	}
>  	unlock_rename(tdentry, fdentry);
> -	ffhp->fh_locked =3D tfhp->fh_locked =3D false;
>  	fh_drop_write(ffhp);
> =20
>  	/*
>=20
>=20

Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
