Return-Path: <linux-nfs+bounces-3150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9868BB1D4
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 19:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C9C1F2100A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8E157E6B;
	Fri,  3 May 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymaer843"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08013B593;
	Fri,  3 May 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757511; cv=none; b=PWu6CAzctSvX32glWmxRdywHcZI8m2Pofa59a90N5MbkjH6XmxfhL9/Ah3iJBVg6Eqwq7U8EDepbFNfx+4XAQT0jJKOwHHW1SBGHk9Oj0hy99ArdUFIXNLKiuZZw21YqFKvd54FzOnkKlR68PwdO+ZRxQ4/ZZmGGP6lPG3Ll9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757511; c=relaxed/simple;
	bh=NA8Lb6bNRP/z+eXkOqMJbaWB5ZBHyOdDEvk7/px99vE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Txh4cZtuM+F9KYoUA8zevIK3v+IBrb9Ygbniyvs05WsPqvayOrJN8l5zzfRNbzNMU8v7Peylb0hw+u0A3wZM5R5t3nF/7/1qFYbRVzqpBDma6kDlwN/AhrB8pp7w2rCYGYYAZXc64vEZEVzDEm6zIRcyopFtY6QpVe38ltO47Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymaer843; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE06C116B1;
	Fri,  3 May 2024 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714757511;
	bh=NA8Lb6bNRP/z+eXkOqMJbaWB5ZBHyOdDEvk7/px99vE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ymaer8435Ebdaect7lbFLXNBCiCR7vefJwiSLtATML7X7AB9Y42zxiCxjCi8i0uhl
	 x4Ofqfee+0612S+XyoA8TMbb6bHWc5IKCWo8mboFDL//wPCgSBay1iONOqgvEIaD2/
	 kWwkzsOmrVo4QvTGrx+3u4sZqDjVvbggmV2fgWIFt2sSGc6R9pnT5UKI50WAvfD4ss
	 lUxVGlbu5FVlZPX7HHPCA+YNZksr5qOAk+2SSbllflaBk2Pt+510BOOAF9VnvjufuH
	 0AODC+0ZUQCZIZbi+xockPgylcSkKIhBloGpqLn9CC5sxrQSD+NlOIXiWrmYnSxYCm
	 ClyFqNcJKehaw==
Message-ID: <53810d77218a7a67fc35f5977584664d54d0e575.camel@kernel.org>
Subject: Re: [PATCH v3] nfsd: set security label during create operations
From: Jeffrey Layton <jlayton@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 selinux@vger.kernel.org,  linux-nfs@vger.kernel.org,
 chuck.lever@oracle.com, neilb@suse.de
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Date: Fri, 03 May 2024 13:31:49 -0400
In-Reply-To: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
References: <20240503130905.16823-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (3.52.0-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 09:09 -0400, Stephen Smalley wrote:
> When security labeling is enabled, the client can pass a file security
> label as part of a create operation for the new file, similar to mode
> and other attributes. At present, the security label is received by nfsd
> and passed down to nfsd_create_setattr(), but nfsd_setattr() is never
> called and therefore the label is never set on the new file. This bug
> may have been introduced on or around commit d6a97d3f589a ("NFSD:
> add security label to struct nfsd_attrs"). Looking at nfsd_setattr()
> I am uncertain as to whether the same issue presents for
> file ACLs and therefore requires a similar fix for those.
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
> v3 removes the erroneous and unnecessary change to NFSv2 and updates the
> description to note the possible origin of the bug. I did not add a=20
> Fixes tag however as I have not yet tried confirming that.
>=20
>  fs/nfsd/vfs.c | 2 +-
>  fs/nfsd/vfs.h | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>

