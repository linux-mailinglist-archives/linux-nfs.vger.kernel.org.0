Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748E568AEF
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiGFOLC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiGFOLB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 10:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0345018E0C
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 07:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DB7A61E6F
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 14:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1149C341C6;
        Wed,  6 Jul 2022 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657116660;
        bh=BuWBkWGYLUmoWtGXjwXGQAEv/ttK8FXoTEy2FvyVasM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n0EeFgNpnc+027H8rhVQIUj1G7bSsZs2NUdqzC2dnSRVNijBRcw3Y+QdtvRZMwCge
         +hcjkfFIIiygHngD3n7WefI4oa2E7WTOn79iGsfr42Uee9g5vgECr53ClAnDyVASI/
         UYt9/DB6I1lFEcLPydL6b4/poT5cy/N4PrFsPv08jrMIJAcM6Z1alw6heHlfbY2Mfn
         SXfeGqRy68otw4VhfMqXBGwne95V4pcWQJwZiKP6FmeHBYGKt8siej8nG6m7ZXiuZ3
         s7S1I+lONH1GqMKOC3EGGhvOskmA0hWBPVVRDF9Pnqi4i6Y5a+4haQhoaSoERGlg71
         /9b9cKSbli6ow==
Message-ID: <44e634b9118ee87af8e2831078e8d894155678b0.camel@kernel.org>
Subject: Re: [PATCH 7/8] NFSD: use (un)lock_inode instead of fh_(un)lock for
 file operations
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 10:10:56 -0400
In-Reply-To: <165708109260.1940.6599746560136720935.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <165708109260.1940.6599746560136720935.stgit@noble.brown>
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
> When locking a file to access ACLs and xattrs etc, use explicit locking
> with inode_lock() instead of fh_lock().  This means that the calls to
> fh_fill_pre/post_attr() are also explicit which improves readability and
> allows us to place them only where they are needed.  Only the xattr
> calls need pre/post information.
>=20
> When locking a file we don't need I_MUTEX_PARENT as the file is not a
> parent of anything, so we can use inode_lock() directly rather than the
> inode_lock_nested() call that fh_lock() uses.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs2acl.c   |    6 +++---
>  fs/nfsd/nfs3acl.c   |    4 ++--
>  fs/nfsd/nfs4acl.c   |    7 +++----
>  fs/nfsd/nfs4state.c |    8 ++++----
>  fs/nfsd/vfs.c       |   25 ++++++++++++-------------
>  5 files changed, 24 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index b5760801d377..9edd3c1a30fb 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -111,7 +111,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
>  	if (error)
>  		goto out_errno;
> =20
> -	fh_lock(fh);
> +	inode_lock(inode);
> =20
>  	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
>  			      argp->acl_access);
> @@ -122,7 +122,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
>  	if (error)
>  		goto out_drop_lock;
> =20
> -	fh_unlock(fh);
> +	inode_unlock(inode);
> =20
>  	fh_drop_write(fh);
> =20
> @@ -136,7 +136,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rq=
stp)
>  	return rpc_success;
> =20
>  out_drop_lock:
> -	fh_unlock(fh);
> +	inode_unlock(inode);
>  	fh_drop_write(fh);
>  out_errno:
>  	resp->status =3D nfserrno(error);
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 35b2ebda14da..9446c6743664 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -101,7 +101,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
>  	if (error)
>  		goto out_errno;
> =20
> -	fh_lock(fh);
> +	inode_lock(inode);
> =20
>  	error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
>  			      argp->acl_access);
> @@ -111,7 +111,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqst=
p)
>  			      argp->acl_default);
> =20
>  out_drop_lock:
> -	fh_unlock(fh);
> +	inode_unlock(inode);
>  	fh_drop_write(fh);
>  out_errno:
>  	resp->status =3D nfserrno(error);
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index 5c9b7e01e8ca..a33cacf62ea0 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -781,19 +781,18 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	if (host_error < 0)
>  		goto out_nfserr;
> =20
> -	fh_lock(fhp);
> +	inode_lock(inode);
> =20
>  	host_error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pac=
l);
>  	if (host_error < 0)
>  		goto out_drop_lock;
> =20
> -	if (S_ISDIR(inode->i_mode)) {
> +	if (S_ISDIR(inode->i_mode))
>  		host_error =3D set_posix_acl(&init_user_ns, inode,
>  					   ACL_TYPE_DEFAULT, dpacl);
> -	}
> =20
>  out_drop_lock:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
> =20
>  	posix_acl_release(pacl);
>  	posix_acl_release(dpacl);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9d1a3e131c49..307317ba9aff 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7322,21 +7322,21 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 struct file_lock *lock)
>  {
>  	struct nfsd_file *nf;
> +	struct inode *inode =3D fhp->fh_dentry->d_inode;
>  	__be32 err;
> =20
>  	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
>  	if (err)
>  		return err;
> -	fh_lock(fhp); /* to block new leases till after test_lock: */
> -	err =3D nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
> -							NFSD_MAY_READ));
> +	inode_lock(inode); /* to block new leases till after test_lock: */
> +	err =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>  	if (err)
>  		goto out;
>  	lock->fl_file =3D nf->nf_file;
>  	err =3D nfserrno(vfs_test_lock(nf->nf_file, lock));
>  	lock->fl_file =3D NULL;
>  out:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
>  	nfsd_file_put(nf);
>  	return err;
>  }
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2ca748aa83bb..2526615285ca 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -444,7 +444,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
>  			return err;
>  	}
> =20
> -	fh_lock(fhp);
> +	inode_lock(inode);
>  	if (size_change) {
>  		/*
>  		 * RFC5661, Section 18.30.4:
> @@ -480,7 +480,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp, struct iattr *iap,
>  	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> =20
>  out_unlock:
> -	fh_unlock(fhp);
> +	inode_unlock(inode);
>  	if (size_change)
>  		put_write_access(inode);
>  out:
> @@ -2196,12 +2196,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char **bufp,
>  }
> =20
>  /*
> - * Removexattr and setxattr need to call fh_lock to both lock the inode
> - * and set the change attribute. Since the top-level vfs_removexattr
> - * and vfs_setxattr calls already do their own inode_lock calls, call
> - * the _locked variant. Pass in a NULL pointer for delegated_inode,
> - * and let the client deal with NFS4ERR_DELAY (same as with e.g.
> - * setattr and remove).
> + * Pass in a NULL pointer for delegated_inode, and let the client deal
> + * with NFS4ERR_DELAY (same as with e.g.  setattr and remove).
>   */
>  __be32
>  nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
> @@ -2217,12 +2213,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, char *name)
>  	if (ret)
>  		return nfserrno(ret);
> =20
> -	fh_lock(fhp);
> +	inode_lock(fhp->fh_dentry->d_inode);
> +	fh_fill_pre_attrs(fhp);
> =20
>  	ret =3D __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
>  				       name, NULL);
> =20
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(fhp->fh_dentry->d_inode);
>  	fh_drop_write(fhp);
> =20
>  	return nfsd_xattr_errno(ret);
> @@ -2242,12 +2240,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char *name,
>  	ret =3D fh_want_write(fhp);
>  	if (ret)
>  		return nfserrno(ret);
> -	fh_lock(fhp);
> +	inode_lock(fhp->fh_dentry->d_inode);
> +	fh_fill_pre_attrs(fhp);
> =20
>  	ret =3D __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
>  				    len, flags, NULL);
> -
> -	fh_unlock(fhp);
> +	fh_fill_post_attrs(fhp);
> +	inode_unlock(fhp->fh_dentry->d_inode);
>  	fh_drop_write(fhp);
> =20
>  	return nfsd_xattr_errno(ret);
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
