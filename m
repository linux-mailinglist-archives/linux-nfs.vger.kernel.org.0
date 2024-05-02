Return-Path: <linux-nfs+bounces-3139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C128BA355
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60531C20AF9
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE31B27D;
	Thu,  2 May 2024 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/K2b98e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C008462;
	Thu,  2 May 2024 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689288; cv=none; b=hNmQhGKs2vgge+GO65xyv1Dj2f9h2lxd8tLSGn0dvj35yts3FLOLcRB7cS0yYxBvG4WSnAEuhthQ8vBfWzgzuLqzh6n04Bph91RLt+SsYH71DEr7DXZH4xGjGXCZCtIM8HxWqaXernSH2Xwi/OKUMwtCdDuCl1e537dQ6iEebcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689288; c=relaxed/simple;
	bh=YA45pVuZxp2RA0fd/vUvVfJbao2NkHscxPlRveTOCO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpsIk5GITcxDaq7TnW6vMRUmjDFSaXkyrhSEKTLuK1iKYQHHMQexhk87exgPkGcw4h907/fEHuS/+Yb3fjcv2N6vtQNv6M53XBwU/C6jMfOC0ZskOmqnbvSpMFQHxscPn9ya8bOgAq7vyBRvVH6HE94HUKNIhbTw00L1Ud+lMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/K2b98e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A41EC113CC;
	Thu,  2 May 2024 22:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714689288;
	bh=YA45pVuZxp2RA0fd/vUvVfJbao2NkHscxPlRveTOCO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z/K2b98e04YHxRv6PuSeIxmvQ/RZZLkw9tcffrKVIaT9Uaz+zlCtJ/5M9CpIL1pqe
	 xAh1X5pNCca+uNUaKt2OD8PAvstKmh88cAnAq68Ns//iosWb+DGxjCDCw51HL6mCk8
	 U5jy3Vn1KNIcydNOWdd2zgN3KuJODEeREwq4K+RbSEedxfa6NjJ4sBvj8j5v0py4Pn
	 m1JtWKTQesHRqcpcdGfWJiXL685aWTi+oTg5MmCP+jsA9K6+Y5iW2Z7t09y+xONb/g
	 x/gXROVB5oMMQDWiPwKCfM5F9O0WbuMFEKrpXDebUrMLPOppU6lb0X0iNbHWcM40TJ
	 F4Sxom2G1f9GA==
Message-ID: <70273db57aa4b6df43ae1f73e6bf3b80abf0c599.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: set security label during create operations
From: Jeffrey Layton <jlayton@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 selinux@vger.kernel.org,  linux-nfs@vger.kernel.org,
 chuck.lever@oracle.com, neilb@suse.de
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Date: Thu, 02 May 2024 18:34:46 -0400
In-Reply-To: <20240502195800.3252-1-stephen.smalley.work@gmail.com>
References: <20240502195800.3252-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (3.52.0-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 15:58 -0400, Stephen Smalley wrote:
> When security labeling is enabled, the client can pass a file security
> label as part of a create operation for the new file, similar to mode
> and other attributes. At present, the security label is received by nfsd
> and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> called and therefore the label is never set on the new file. I couldn't
> tell if this has always been broken or broke at some point in time. Looki=
ng
> at nfsd_setattr() I am uncertain as to whether the same issue presents fo=
r
> file ACLs and therefore requires a similar fix for those. I am not overly
> confident that this is the right solution.
>=20
> An alternative approach would be to introduce a new LSM hook to set the
> "create SID" of the current task prior to the actual file creation, which
> would atomically label the new inode at creation time. This would be bett=
er
> for SELinux and a similar approach has been used previously
> (see security_dentry_create_files_as) but perhaps not usable by other LSM=
s.
>=20
> Reproducer:
> 1. Install a Linux distro with SELinux - Fedora is easiest
> 2. git clone https://github.com/SELinuxProject/selinux-testsuite
> 3. Install the requisite dependencies per selinux-testsuite/README.md
> 4. Run something like the following script:
> MOUNT=3D$HOME/selinux-testsuite
> sudo systemctl start nfs-server
> sudo exportfs -o rw,no_root_squash,security_label localhost:$MOUNT
> sudo mkdir -p /mnt/selinux-testsuite
> sudo mount -t nfs -o vers=3D4.2 localhost:$MOUNT /mnt/selinux-testsuite
> pushd /mnt/selinux-testsuite/
> sudo make -C policy load
> pushd tests/filesystem
> sudo runcon -t test_filesystem_t ./create_file -f trans_test_file \
> 	-e test_filesystem_filetranscon_t -v
> sudo rm -f trans_test_file
> popd
> sudo make -C policy unload
> popd
> sudo umount /mnt/selinux-testsuite
> sudo exportfs -u localhost:$MOUNT
> sudo rmdir /mnt/selinux-testsuite
> sudo systemctl stop nfs-server
>=20
> Expected output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: unconfined_u:object_r:test_filesystem_filetranscon_t:s0
> File context is correct
>=20
> Actual output:
> <eliding noise from commands run prior to or after the test itself>
> Process context:
> 	unconfined_u:unconfined_r:test_filesystem_t:s0-s0:c0.c1023
> Created file: trans_test_file
> File context: system_u:object_r:test_file_t:s0
> File context error, expected:
> 	test_filesystem_filetranscon_t
> got:
> 	test_file_t
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 introduces a nfsd_attrs_valid() helper and uses it as suggested by
> Jeffrey Layton <jlayton@kernel.org>.
>=20
>  fs/nfsd/nfsproc.c | 2 +-
>  fs/nfsd/vfs.c     | 2 +-
>  fs/nfsd/vfs.h     | 8 ++++++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 36370b957b63..3e438159f561 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -389,7 +389,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		 * open(..., O_CREAT|O_TRUNC|O_WRONLY).
>  		 */
>  		attr->ia_valid &=3D ATTR_SIZE;
> -		if (attr->ia_valid)
> +		if (nfsd_attrs_valid(attr))
>  			resp->status =3D nfsd_setattr(rqstp, newfhp, &attrs,
>  						    NULL);
>  	}

This function is for NFSv2, which doesn't support any inode attributes
that aren't represented in ia_valid. We could leave this as-is, but
this is fine too.

> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2e41eb4c3cec..29b1f3613800 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1422,7 +1422,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	 * Callers expect new file metadata to be committed even
>  	 * if the attributes have not changed.
>  	 */
> -	if (iap->ia_valid)
> +	if (nfsd_attrs_valid(attrs))
>  		status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status =3D nfserrno(commit_metadata(resfhp));
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c60fdb6200fd..57cd70062048 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -60,6 +60,14 @@ static inline void nfsd_attrs_free(struct nfsd_attrs *=
attrs)
>  	posix_acl_release(attrs->na_dpacl);
>  }
> =20
> +static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
> +{
> +	struct iattr *iap =3D attrs->na_iattr;
> +
> +	return (iap->ia_valid || (attrs->na_seclabel &&
> +		attrs->na_seclabel->len));
> +}
> +
>  __be32		nfserrno (int errno);
>  int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
>  		                struct svc_export **expp);

Reviewed-by: Jeffrey Layton <jlayton@kernel.org>

