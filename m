Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEDA568956
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiGFNZD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiGFNY7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 09:24:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610BA1903B
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 06:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A2C2B81CE4
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 13:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAD7C3411C;
        Wed,  6 Jul 2022 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657113895;
        bh=JPe86btgxfJ6V9AaOyN7ada0BrpERSwwc9ifFgR0D60=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dYbBsDuA+zFunQYWgkDf4SQrBJ+FqKLYoqmQgLYdClU5S3WWbomBYEKNLze4THoB6
         TnLMnicpuKleXTv+Cz5W18CLfxldY26a3casCQj+qB1i15Jk0MQAVoZxA3UaY1+9pe
         ZZDaMQrPFcavgBYqtRXDrQo2zRgsMdhp0frMUjwLbBPxLP7qWsoVQIBL4phgo9MhDr
         l3c9vIH74hb9h4KdoEAyaELxHmSMWHoxV/D4Emrgb3xuQLezIpY1zMdHW+kOouIR53
         T3d9TUbyvabKu4izxNpT5eSrb0Yzx7Lok//6Clw24lzc5p7zaWNuR6OXzhER11uWo1
         +S6OLThlnqDGg==
Message-ID: <9219d609cd9921742b6c34b2ea7b00e1b6e340df.camel@kernel.org>
Subject: Re: [PATCH 2/8] NFSD: change nfsd_create() to unlock directory
 before returning.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 09:24:52 -0400
In-Reply-To: <165708109257.1940.11051756818329976731.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <165708109257.1940.11051756818329976731.stgit@noble.brown>
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
> nfsd_create() usually exits with the directory still locked.  This
> relies on other code to unlock the directory.  Planned future patches
> will change how directory locking works so the unlock step may be less
> trivial.  It is cleaner to have lock and unlock in the same function.
>=20
> nfsd4_create() performs some extra changes after the creation and before
> the unlock - setting security label and an ACL.  To allow for these to
> still be done while locked, we create a function nfsd4_post_create() and
> pass it to nfsd_create() when needed.
>=20
> nfsd_symlink() DOES usually unlock the directory, but nfsd4_create() may
> add a label or ACL - with the directory unlocked.  I don't think symlinks
> have ACLs and don't know if they can have labels, so I don't know if
> this is of any practical consequence.  For consistency nfsd_symlink() is
> changed to accept the same callback and call it if given.
>=20
> nfsd_symlink() didn't unlock the directory if lookup_one_len() gave an
> error.  This is untidy and potentially confusing, and has now been
> fixed.  It isn't a practical problem as an eventual fh_put() will unlock
> if needed.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs3proc.c |   11 ++++++-----
>  fs/nfsd/nfs4proc.c |   38 ++++++++++++++++++++++++--------------
>  fs/nfsd/nfsproc.c  |    5 +++--
>  fs/nfsd/vfs.c      |   40 +++++++++++++++++++++++++++-------------
>  fs/nfsd/vfs.h      |   11 ++++++++---
>  5 files changed, 68 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 981a3a7a6e16..38255365ef71 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -378,8 +378,8 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
>  	fh_copy(&resp->dirfh, &argp->fh);
>  	fh_init(&resp->fh, NFS3_FHSIZE);
>  	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len=
,
> -				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> -	fh_unlock(&resp->dirfh);
> +				   &argp->attrs, S_IFDIR, 0, &resp->fh,
> +				   NULL, NULL);
>  	return rpc_success;
>  }
> =20
> @@ -414,7 +414,8 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
>  	fh_copy(&resp->dirfh, &argp->ffh);
>  	fh_init(&resp->fh, NFS3_FHSIZE);
>  	resp->status =3D nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
> -				    argp->flen, argp->tname, &resp->fh);
> +				    argp->flen, argp->tname, &resp->fh,
> +				    NULL, NULL);
>  	kfree(argp->tname);
>  out:
>  	return rpc_success;
> @@ -453,8 +454,8 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
> =20
>  	type =3D nfs3_ftypes[argp->ftype];
>  	resp->status =3D nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len=
,
> -				   &argp->attrs, type, rdev, &resp->fh);
> -	fh_unlock(&resp->dirfh);
> +				   &argp->attrs, type, rdev, &resp->fh,
> +				   NULL, NULL);
>  out:
>  	return rpc_success;
>  }
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 60591ceb4985..3279daab909d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -780,6 +780,18 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  			     (__be32 *)commit->co_verf.data);
>  }
> =20
> +static void nfsd4_post_create(struct svc_fh *fh, void *vcreate)
> +{
> +	struct nfsd4_create *create =3D vcreate;
> +
> +	if (create->cr_label.len)
> +		nfsd4_security_inode_setsecctx(fh, &create->cr_label,
> +					       create->cr_bmval);
> +
> +	if (create->cr_acl !=3D NULL)
> +		do_set_nfs4_acl(fh, create->cr_acl, create->cr_bmval);
> +}
> +
>  static __be32
>  nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate=
,
>  	     union nfsd4_op_u *u)
> @@ -805,7 +817,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	case NF4LNK:
>  		status =3D nfsd_symlink(rqstp, &cstate->current_fh,
>  				      create->cr_name, create->cr_namelen,
> -				      create->cr_data, &resfh);
> +				      create->cr_data, &resfh,
> +				      nfsd4_post_create, create);
>  		break;
> =20
>  	case NF4BLK:
> @@ -816,7 +829,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  			goto out_umask;
>  		status =3D nfsd_create(rqstp, &cstate->current_fh,
>  				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFBLK, rdev, &resfh);
> +				     &create->cr_iattr, S_IFBLK, rdev, &resfh,
> +				     nfsd4_post_create, create);
>  		break;
> =20
>  	case NF4CHR:
> @@ -827,26 +841,30 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  			goto out_umask;
>  		status =3D nfsd_create(rqstp, &cstate->current_fh,
>  				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFCHR, rdev, &resfh);
> +				     &create->cr_iattr, S_IFCHR, rdev, &resfh,
> +				     nfsd4_post_create, create);
>  		break;
> =20
>  	case NF4SOCK:
>  		status =3D nfsd_create(rqstp, &cstate->current_fh,
>  				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFSOCK, 0, &resfh);
> +				     &create->cr_iattr, S_IFSOCK, 0, &resfh,
> +				     nfsd4_post_create, create);
>  		break;
> =20
>  	case NF4FIFO:
>  		status =3D nfsd_create(rqstp, &cstate->current_fh,
>  				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFIFO, 0, &resfh);
> +				     &create->cr_iattr, S_IFIFO, 0, &resfh,
> +				     nfsd4_post_create, create);
>  		break;
> =20
>  	case NF4DIR:
>  		create->cr_iattr.ia_valid &=3D ~ATTR_SIZE;
>  		status =3D nfsd_create(rqstp, &cstate->current_fh,
>  				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr, S_IFDIR, 0, &resfh);
> +				     &create->cr_iattr, S_IFDIR, 0, &resfh,
> +				     nfsd4_post_create, create);
>  		break;
> =20
>  	default:
> @@ -856,14 +874,6 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	if (status)
>  		goto out;
> =20
> -	if (create->cr_label.len)
> -		nfsd4_security_inode_setsecctx(&resfh, &create->cr_label, create->cr_b=
mval);
> -
> -	if (create->cr_acl !=3D NULL)
> -		do_set_nfs4_acl(&resfh, create->cr_acl,
> -				create->cr_bmval);
> -
> -	fh_unlock(&cstate->current_fh);
>  	set_change_info(&create->cr_cinfo, &cstate->current_fh);
>  	fh_dup2(&cstate->current_fh, &resfh);
>  out:
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index fcdab8a8a41f..a25b8e321662 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -493,7 +493,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
> =20
>  	fh_init(&newfh, NFS_FHSIZE);
>  	resp->status =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->fle=
n,
> -				    argp->tname, &newfh);
> +				    argp->tname, &newfh, NULL, NULL);
> =20
>  	kfree(argp->tname);
>  	fh_put(&argp->ffh);
> @@ -522,7 +522,8 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
>  	argp->attrs.ia_valid &=3D ~ATTR_SIZE;
>  	fh_init(&resp->fh, NFS_FHSIZE);
>  	resp->status =3D nfsd_create(rqstp, &argp->fh, argp->name, argp->len,
> -				   &argp->attrs, S_IFDIR, 0, &resp->fh);
> +				   &argp->attrs, S_IFDIR, 0, &resp->fh,
> +				   NULL, NULL);
>  	fh_put(&argp->fh);
>  	if (resp->status !=3D nfs_ok)
>  		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d79db56475d4..1e7ca39e8a49 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1366,8 +1366,10 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>   */
>  __be32
>  nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		char *fname, int flen, struct iattr *iap,
> -		int type, dev_t rdev, struct svc_fh *resfhp)
> +	    char *fname, int flen, struct iattr *iap,
> +	    int type, dev_t rdev, struct svc_fh *resfhp,
> +	    void (*post_create)(struct svc_fh *fh, void *data),
> +	    void *data)
>  {
>  	struct dentry	*dentry, *dchild =3D NULL;
>  	__be32		err;
> @@ -1389,8 +1391,10 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	fh_lock_nested(fhp, I_MUTEX_PARENT);
>  	dchild =3D lookup_one_len(fname, dentry, flen);
>  	host_err =3D PTR_ERR(dchild);
> -	if (IS_ERR(dchild))
> -		return nfserrno(host_err);
> +	if (IS_ERR(dchild)) {
> +		err =3D nfserrno(host_err);
> +		goto out_unlock;
> +	}
>  	err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
>  	/*
>  	 * We unconditionally drop our ref to dchild as fh_compose will have
> @@ -1398,9 +1402,14 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	 */
>  	dput(dchild);
>  	if (err)
> -		return err;
> -	return nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> -					rdev, resfhp);
> +		goto out_unlock;
> +	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
> +				 rdev, resfhp);
> +	if (!err && post_create)
> +		post_create(resfhp, data);
> +out_unlock:
> +	fh_unlock(fhp);
> +	return err;
>  }
> =20
>  /*
> @@ -1447,9 +1456,11 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp, char *buf, int *lenp)
>   */
>  __be32
>  nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				char *fname, int flen,
> -				char *path,
> -				struct svc_fh *resfhp)
> +	     char *fname, int flen,
> +	     char *path,
> +	     struct svc_fh *resfhp,
> +	     void (*post_create)(struct svc_fh *fh, void *data),
> +	     void *data)
>  {
>  	struct dentry	*dentry, *dnew;
>  	__be32		err, cerr;
> @@ -1474,12 +1485,12 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	dentry =3D fhp->fh_dentry;
>  	dnew =3D lookup_one_len(fname, dentry, flen);
>  	host_err =3D PTR_ERR(dnew);
> -	if (IS_ERR(dnew))
> +	if (IS_ERR(dnew)) {
> +		fh_unlock(fhp);
>  		goto out_nfserr;
> -
> +	}
>  	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
>  	err =3D nfserrno(host_err);
> -	fh_unlock(fhp);
>  	if (!err)
>  		err =3D nfserrno(commit_metadata(fhp));
> =20
> @@ -1488,6 +1499,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
>  	dput(dnew);
>  	if (err=3D=3D0) err =3D cerr;
> +	if (!err && post_create)
> +		post_create(resfhp, data);
> +	fh_unlock(fhp);
>  out:
>  	return err;
> =20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 26347d76f44a..9f4fd3060200 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -66,8 +66,10 @@ __be32		nfsd_create_locked(struct svc_rqst *, struct s=
vc_fh *,
>  				char *name, int len, struct iattr *attrs,
>  				int type, dev_t rdev, struct svc_fh *res);
>  __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, struct iattr *attrs,
> -				int type, dev_t rdev, struct svc_fh *res);
> +			    char *name, int len, struct iattr *attrs,
> +			    int type, dev_t rdev, struct svc_fh *res,
> +			    void (*post_create)(struct svc_fh *fh, void *data),
> +			    void *data);
>  __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
>  __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct svc_fh *resfhp, struct iattr *iap);
> @@ -111,7 +113,10 @@ __be32		nfsd_readlink(struct svc_rqst *, struct svc_=
fh *,
>  				char *, int *);
>  __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
>  				char *name, int len, char *path,
> -				struct svc_fh *res);
> +				struct svc_fh *res,
> +				void (*post_create)(struct svc_fh *fh,
> +						    void *data),
> +				void *data);
>  __be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
>  				char *, int, struct svc_fh *);
>  ssize_t		nfsd_copy_file_range(struct file *, u64,
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
