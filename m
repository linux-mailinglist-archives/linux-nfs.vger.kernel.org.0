Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58077576525
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiGOQMC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGOQMB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 12:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C0753B8
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 09:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF1B26216E
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 16:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B8DC34115;
        Fri, 15 Jul 2022 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657901516;
        bh=uSdSKXPGBk0HYWp670Hmsmcx01keSMpy1AidcjuKTZk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H2RYo+sJLyQlw/k/+K7jBmV1uHr05Rjq351bc9G5Fsz8i1t3zeRA+PasW68A47KTA
         hcbaOthy5cdB/3muqkNrhkh3fynd46WKwTUd5dfe1BHmgw43VJtLOzFtOXQ4lN1fL6
         jGcqFj6H1DaRijcAb2X7u+1/USUOGx/UfBRE+XiFTzfqpeLJCPclGA04leSt+yJ7Te
         QCcvNiu+xfz82houBz2Gm4LHBOswgrAwIG61KH0IEBu9AXyn2i7suVNbs/VU6NdsoA
         9evL6LCytFTAwvQfwEygIyWX78U/uRLF6oIk7b0IsSpo7D7UtRrxQv6j81c/7w30rE
         +SGDxPYdh3mzA==
Message-ID: <ccc3c78c5a6b4b72f6160aeb38ffa36cec94595f.camel@kernel.org>
Subject: Re: [PATCH 6/8] NFSD: use explicit lock/unlock for directory ops
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 15 Jul 2022 12:11:54 -0400
In-Reply-To: <165708109259.1940.685583862810495747.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <165708109259.1940.685583862810495747.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-07-06 at 14:18 +1000, NeilBrown wrote:
> When creating or unlinking a name in a directory use explicit
> inode_lock_nested() instead of fh_lock(), and explicit calls to
> fh_fill_pre_attrs() and fh_fill_post_attrs().  This is already done for
> renames.
>=20
> Also move the 'fill' calls closer to the operation that might change the
> attributes.  This way they are avoided on some error paths.
>=20
> Having the locking explicit will simplify proposed future changes to
> locking for directories.  It also makes it easily visible exactly where
> pre/post attributes are used - not all callers of fh_lock() actually
> need the pre/post attributes.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs3proc.c |    6 ++++--
>  fs/nfsd/nfs4proc.c |    6 ++++--
>  fs/nfsd/nfsproc.c  |    7 ++++---
>  fs/nfsd/vfs.c      |   30 +++++++++++++++++++-----------
>  4 files changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 3a67d0afb885..9629517344ff 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -254,7 +254,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	if (host_err)
>  		return nfserrno(host_err);
> =20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(inode, I_MUTEX_PARENT);
> =20
>  	child =3D lookup_one_len(argp->name, parent, argp->len);
>  	if (IS_ERR(child)) {
> @@ -312,11 +312,13 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	if (!IS_POSIXACL(inode))
>  		iap->ia_mode &=3D ~current_umask();
> =20
> +	fh_fill_pre_attrs(fhp);
>  	host_err =3D vfs_create(&init_user_ns, inode, child, iap->ia_mode, true=
);
>  	if (host_err < 0) {
>  		status =3D nfserrno(host_err);
>  		goto out;
>  	}
> +	fh_fill_post_attrs(fhp);
> =20
>  	/* A newly created file already has a file size of zero. */
>  	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> @@ -334,7 +336,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> =20
>  out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
>  	if (child && !IS_ERR(child))
>  		dput(child);
>  	fh_drop_write(fhp);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 6ec22c69cbec..242f059e6788 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -306,7 +306,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	if (host_err)
>  		return nfserrno(host_err);
> =20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(inode, I_MUTEX_PARENT);
> =20
>  	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
>  	if (IS_ERR(child)) {
> @@ -385,10 +385,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	if (!IS_POSIXACL(inode))
>  		iap->ia_mode &=3D ~current_umask();
> =20
> +	fh_fill_pre_attrs(fhp);
>  	status =3D nfsd4_vfs_create(fhp, child, open);
>  	if (status !=3D nfs_ok)
>  		goto out;
>  	open->op_created =3D true;
> +	fh_fill_post_attrs(fhp);
> =20
>  	/* A newly created file already has a file size of zero. */
>  	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))

Should the fh_fill_post_attrs call be done after nfsd_create_setattr
instead in this function? It seems like we're filling out the post-op
attr here before we're actually done changing things...

> @@ -406,7 +408,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> =20
>  out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
>  	if (child && !IS_ERR(child))
>  		dput(child);
>  	fh_drop_write(fhp);
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index ed24fae09517..427c404bc52b 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -285,7 +285,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		goto done;
>  	}
> =20
> -	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
> +	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
>  	dchild =3D lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
>  	if (IS_ERR(dchild)) {
>  		resp->status =3D nfserrno(PTR_ERR(dchild));
> @@ -382,6 +382,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	}
> =20
>  	resp->status =3D nfs_ok;
> +	fh_fill_pre_attrs(dirfhp);
>  	if (!inode) {
>  		/* File doesn't exist. Create it and set attrs */
>  		resp->status =3D nfsd_create_locked(rqstp, dirfhp, argp->name,
> @@ -399,10 +400,10 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  			resp->status =3D nfsd_setattr(rqstp, newfhp, attr, 0,
>  						    (time64_t)0);
>  	}
> +	fh_fill_post_attrs(dirfhp);
> =20
>  out_unlock:
> -	/* We don't really need to unlock, as fh_put does it. */
> -	fh_unlock(dirfhp);
> +	inode_unlock(dirfhp->fh_dentry->d_inode);
>  	fh_drop_write(dirfhp);
>  done:
>  	fh_put(dirfhp);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8e050c6d112a..2ca748aa83bb 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1412,7 +1412,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  	if (host_err)
>  		return nfserrno(host_err);
> =20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
> +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
>  	dchild =3D lookup_one_len(fname, dentry, flen);
>  	host_err =3D PTR_ERR(dchild);
>  	if (IS_ERR(dchild)) {
> @@ -1427,12 +1427,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	dput(dchild);
>  	if (err)
>  		goto out_unlock;
> +	fh_fill_pre_attrs(fhp);
>  	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
>  				 rdev, resfhp);
>  	if (!err && post_create)
>  		post_create(resfhp, data);
> +	fh_fill_post_attrs(fhp);
>  out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(dentry->d_inode);
>  	return err;
>  }
> =20
> @@ -1505,14 +1507,15 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	if (host_err)
>  		goto out_nfserr;
> =20
> -	fh_lock(fhp);
>  	dentry =3D fhp->fh_dentry;
> +	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
>  	dnew =3D lookup_one_len(fname, dentry, flen);
>  	host_err =3D PTR_ERR(dnew);
>  	if (IS_ERR(dnew)) {
> -		fh_unlock(fhp);
> +		inode_unlock(dentry->d_inode);
>  		goto out_nfserr;
>  	}
> +	fh_fill_pre_attrs(fhp);
>  	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
>  	err =3D nfserrno(host_err);
>  	if (!err)
> @@ -1525,7 +1528,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	if (err=3D=3D0) err =3D cerr;
>  	if (!err && post_create)
>  		post_create(resfhp, data);
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(dentry->d_inode);
>  out:
>  	return err;
> =20
> @@ -1569,9 +1573,9 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
>  		goto out;
>  	}
> =20
> -	fh_lock_nested(ffhp, I_MUTEX_PARENT);
>  	ddir =3D ffhp->fh_dentry;
>  	dirp =3D d_inode(ddir);
> +	inode_lock_nested(dirp, I_MUTEX_PARENT);
> =20
>  	dnew =3D lookup_one_len(name, ddir, len);
>  	host_err =3D PTR_ERR(dnew);
> @@ -1585,8 +1589,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
>  	err =3D nfserr_noent;
>  	if (d_really_is_negative(dold))
>  		goto out_dput;
> +	fh_fill_pre_attrs(ffhp);
>  	host_err =3D vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
> -	fh_unlock(ffhp);
> +	fh_fill_post_attrs(ffhp);
> +	inode_unlock(dirp);
>  	if (!host_err) {
>  		err =3D nfserrno(commit_metadata(ffhp));
>  		if (!err)
> @@ -1606,7 +1612,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
>  out_dput:
>  	dput(dnew);
>  out_unlock:
> -	fh_unlock(ffhp);
> +	inode_unlock(dirp);
>  	goto out_drop_write;
>  }
> =20
> @@ -1781,9 +1787,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  	if (host_err)
>  		goto out_nfserr;
> =20
> -	fh_lock_nested(fhp, I_MUTEX_PARENT);
>  	dentry =3D fhp->fh_dentry;
>  	dirp =3D d_inode(dentry);
> +	inode_lock_nested(dirp, I_MUTEX_PARENT);
> =20
>  	rdentry =3D lookup_one_len(fname, dentry, flen);
>  	host_err =3D PTR_ERR(rdentry);
> @@ -1801,6 +1807,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  	if (!type)
>  		type =3D d_inode(rdentry)->i_mode & S_IFMT;
> =20
> +	fh_fill_pre_attrs(fhp);
>  	if (type !=3D S_IFDIR) {
>  		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
>  			nfsd_close_cached_files(rdentry);
> @@ -1808,8 +1815,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  	} else {
>  		host_err =3D vfs_rmdir(&init_user_ns, dirp, rdentry);
>  	}
> +	fh_fill_post_attrs(fhp);
> =20
> -	fh_unlock(fhp);
> +	inode_unlock(dirp);
>  	if (!host_err)
>  		host_err =3D commit_metadata(fhp);
>  	dput(rdentry);
> @@ -1832,7 +1840,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  out:
>  	return err;
>  out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(dirp);
>  	goto out_drop_write;
>  }
> =20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
