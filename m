Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3979CEA7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjILKp2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 06:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjILKo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 06:44:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1C10F4
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 03:44:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0858EC433C7;
        Tue, 12 Sep 2023 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515482;
        bh=O/a59D5k0hqT+5kyuEbIhBuLQFteeZHXtQ1qFvzFlhQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hVSWIou+Tr7WWWlYWJfSGnRx6sJSUHGs9eN7NLyyXInrGoU/5382LRSfGPKIeLzgW
         GPfmCpk5yFS76YYq8Ro/+EHHe9zsQciu40cEqyUgEmMiA3FCcTceuVch2s5Glfext1
         fAjtfojPedXVuuOC7uQz6DJHVq4SytuRrwIO5KlO9CD1rceSgpyTxV/BSLmqvT9zXZ
         JgdXxLI2oljRzQFbIltvz6CujdRimwC/4+Na6MkSaoIqmWgWvZWc+1JyxiFZRtmx4i
         uqvGUg/jmnPau8BK+5hkUFJXtxwe486YA663U2q7v85gyu0hkdqe2BpZ+THuc8OTJC
         BVO6NjoqjS2uA==
Message-ID: <eefec1ba89a5b70de5a0964e3d321a22ac86ab2d.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Handle EOPENSTALE correctly in the filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     trondmy@gmail.com, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 Sep 2023 06:44:40 -0400
In-Reply-To: <20230911183027.11372-1-trond.myklebust@hammerspace.com>
References: <20230911183027.11372-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-11 at 14:30 -0400, trondmy@gmail.com wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The nfsd_open code handles EOPENSTALE correctly, by retrying the call to
> fh_verify() and __nfsd_open(). However the filecache just drops the
> error on the floor, and immediately returns nfserr_stale to the caller.
>=20
> This patch ensures that we propagate the EOPENSTALE code back to
> nfsd_file_do_acquire, and that we handle it correctly.
>=20
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfs=
d")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/filecache.c | 27 +++++++++++++++++++--------
>  fs/nfsd/vfs.c       | 28 +++++++++++++---------------
>  fs/nfsd/vfs.h       |  2 +-
>  3 files changed, 33 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ee9c923192e0..07bf219f9ae4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -989,22 +989,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	unsigned char need =3D may_flags & NFSD_FILE_MAY_MASK;
>  	struct net *net =3D SVC_NET(rqstp);
>  	struct nfsd_file *new, *nf;
> -	const struct cred *cred;
> +	bool stale_retry =3D true;
>  	bool open_retry =3D true;
>  	struct inode *inode;
>  	__be32 status;
>  	int ret;
> =20
> +retry:
>  	status =3D fh_verify(rqstp, fhp, S_IFREG,
>  				may_flags|NFSD_MAY_OWNER_OVERRIDE);
>  	if (status !=3D nfs_ok)
>  		return status;
>  	inode =3D d_inode(fhp->fh_dentry);
> -	cred =3D get_current_cred();
> =20
> -retry:
>  	rcu_read_lock();
> -	nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> +	nf =3D nfsd_file_lookup_locked(net, current_cred(), inode, need, want_g=
c);
>  	rcu_read_unlock();
> =20
>  	if (nf) {
> @@ -1026,7 +1025,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> =20
>  	rcu_read_lock();
>  	spin_lock(&inode->i_lock);
> -	nf =3D nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
> +	nf =3D nfsd_file_lookup_locked(net, current_cred(), inode, need, want_g=
c);
>  	if (unlikely(nf)) {
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
> @@ -1058,6 +1057,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  			goto construction_err;
>  		}
>  		open_retry =3D false;
> +		fh_put(fhp);
>  		goto retry;
>  	}
>  	this_cpu_inc(nfsd_file_cache_hits);
> @@ -1074,7 +1074,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  		nfsd_file_check_write_error(nf);
>  		*pnf =3D nf;
>  	}
> -	put_cred(cred);
>  	trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
>  	return status;
> =20
> @@ -1088,8 +1087,20 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>  			status =3D nfs_ok;
>  			trace_nfsd_file_opened(nf, status);
>  		} else {
> -			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
> -						    &nf->nf_file);
> +			ret =3D nfsd_open_verified(rqstp, fhp, may_flags,
> +						 &nf->nf_file);
> +			if (ret =3D=3D -EOPENSTALE && stale_retry) {
> +				stale_retry =3D false;
> +				nfsd_file_unhash(nf);
> +				clear_and_wake_up_bit(NFSD_FILE_PENDING,
> +						      &nf->nf_flags);
> +				if (refcount_dec_and_test(&nf->nf_ref))
> +					nfsd_file_free(nf);
> +				nf =3D NULL;
> +				fh_put(fhp);
> +				goto retry;
> +			}
> +			status =3D nfserrno(ret);
>  			trace_nfsd_file_open(nf, status);
>  		}
>  	} else
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2c9074ab2315..98fa4fd0556d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -823,7 +823,7 @@ int nfsd_open_break_lease(struct inode *inode, int ac=
cess)
>   * and additional flags.
>   * N.B. After this call fhp needs an fh_put
>   */
> -static __be32
> +static int
>  __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  			int may_flags, struct file **filp)
>  {
> @@ -831,14 +831,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *=
fhp, umode_t type,
>  	struct inode	*inode;
>  	struct file	*file;
>  	int		flags =3D O_RDONLY|O_LARGEFILE;
> -	__be32		err;
> -	int		host_err =3D 0;
> +	int		host_err =3D -EPERM;
> =20
>  	path.mnt =3D fhp->fh_export->ex_path.mnt;
>  	path.dentry =3D fhp->fh_dentry;
>  	inode =3D d_inode(path.dentry);
> =20
> -	err =3D nfserr_perm;
>  	if (IS_APPEND(inode) && (may_flags & NFSD_MAY_WRITE))
>  		goto out;
> =20
> @@ -847,7 +845,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fh=
p, umode_t type,
> =20
>  	host_err =3D nfsd_open_break_lease(inode, may_flags);
>  	if (host_err) /* NOMEM or WOULDBLOCK */
> -		goto out_nfserr;
> +		goto out;
> =20
>  	if (may_flags & NFSD_MAY_WRITE) {
>  		if (may_flags & NFSD_MAY_READ)
> @@ -859,13 +857,13 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *=
fhp, umode_t type,
>  	file =3D dentry_open(&path, flags, current_cred());
>  	if (IS_ERR(file)) {
>  		host_err =3D PTR_ERR(file);
> -		goto out_nfserr;
> +		goto out;
>  	}
> =20
>  	host_err =3D ima_file_check(file, may_flags);
>  	if (host_err) {
>  		fput(file);
> -		goto out_nfserr;
> +		goto out;
>  	}
> =20
>  	if (may_flags & NFSD_MAY_64BIT_COOKIE)
> @@ -874,10 +872,8 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *f=
hp, umode_t type,
>  		file->f_mode |=3D FMODE_32BITHASH;
> =20
>  	*filp =3D file;
> -out_nfserr:
> -	err =3D nfserrno(host_err);
>  out:
> -	return err;
> +	return host_err;
>  }
> =20
>  __be32
> @@ -885,6 +881,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 umode_t type,
>  		int may_flags, struct file **filp)
>  {
>  	__be32 err;
> +	int host_err;
>  	bool retried =3D false;
> =20
>  	validate_process_creds();
> @@ -904,12 +901,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fh=
p, umode_t type,
>  retry:
>  	err =3D fh_verify(rqstp, fhp, type, may_flags);
>  	if (!err) {
> -		err =3D __nfsd_open(rqstp, fhp, type, may_flags, filp);
> -		if (err =3D=3D nfserr_stale && !retried) {
> +		host_err =3D __nfsd_open(rqstp, fhp, type, may_flags, filp);
> +		if (host_err =3D=3D -EOPENSTALE && !retried) {
>  			retried =3D true;
>  			fh_put(fhp);
>  			goto retry;
>  		}
> +		err =3D nfserrno(host_err);
>  	}
>  	validate_process_creds();
>  	return err;
> @@ -922,13 +920,13 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fh=
p, umode_t type,
>   * @may_flags: internal permission flags
>   * @filp: OUT: open "struct file *"
>   *
> - * Returns an nfsstat value in network byte order.
> + * Returns a posix error.
>   */
> -__be32
> +int
>  nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_f=
lags,
>  		   struct file **filp)
>  {
> -	__be32 err;
> +	int err;
> =20
>  	validate_process_creds();
>  	err =3D __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index a6890ea7b765..e4b7207ef2e0 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -104,7 +104,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  int 		nfsd_open_break_lease(struct inode *, int);
>  __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
>  				int, struct file **);
> -__be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
> +int		nfsd_open_verified(struct svc_rqst *, struct svc_fh *,
>  				int, struct file **);
>  __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct file *file, loff_t offset,

Looks reasonable.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
