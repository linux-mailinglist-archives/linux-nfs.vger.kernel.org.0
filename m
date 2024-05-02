Return-Path: <linux-nfs+bounces-3134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CAB8BA049
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D941F220B6
	for <lists+linux-nfs@lfdr.de>; Thu,  2 May 2024 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB616FF58;
	Thu,  2 May 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtqjsePK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E07171E71;
	Thu,  2 May 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674526; cv=none; b=nW7aMf/BOnXbobzOp+kwHWzy6O8Plm7f2WAHTy/PkHvwQl7gWJXoXoqd8IE5IeuO/l0vkHlxpqDhXCLTJJQqiMvgAJkqXKUM5OKHFXucRn9Vmm3U/jTEscxQUtJtJPljLqbfJHSpYcGYgrbZI1Ly4JYF7caCtJX7tZTK1bIw4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674526; c=relaxed/simple;
	bh=zvfNEW688eZzDoKlk1nclcnOhbVaDpSdqpExSUFNPak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCnihNlc8qmHpFqlt2rNrSnEtHoghSFa+rxNudnCeorUvHnCEYel4nyIR+7FZQKN6cEjp74PaaQSoYOaDnoCaJKwDBVX7twF4lf1rPjiwr6Vz0Q5GP7lpBsKNGYwHeW8u1RShGFcrLJcOV4qXMo7bzQNr2DB6R/X+A/x3N0AEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtqjsePK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECEFC113CC;
	Thu,  2 May 2024 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714674526;
	bh=zvfNEW688eZzDoKlk1nclcnOhbVaDpSdqpExSUFNPak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KtqjsePKJ1PFvwEkhaJPOyYLsBVjFUGCd8NAZ/+zU4hqtGUB6gsAcMEIM6Mcv+dgV
	 hfFBPRIwrcy73w2tJxF4CU/zZ4oFlFKs+ASBc1mRFxxVl3xTp1U2ZIxOmjr9j7UQRh
	 xiBpNwguhD97cTBMj35nmFxLQMe202xxyI2eK3TEqALt37g21YyQPkHHKLcAXcRY14
	 PtDKe+aCk6hnH0Ny6qkuvV6kIbUXwRh+Dm9rK70BYEGmljXksThVICGRlanSR1wrJZ
	 7FsnWsLZt6eiROaBGgQ8jmVE07VVtlCTQGH5weLnOnjgmbfZys9WqLk4IMgsQB3KQX
	 gb8ea3hSeN8fw==
Message-ID: <732fab0f79c5e0f1e521a3a5dfa652f80d83eac5.camel@kernel.org>
Subject: Re: [RFC][PATCH] nfsd: set security label during create operations
From: Jeffrey Layton <jlayton@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 selinux@vger.kernel.org,  linux-nfs@vger.kernel.org,
 chuck.lever@oracle.com, neilb@suse.de
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org
Date: Thu, 02 May 2024 14:28:44 -0400
In-Reply-To: <20240502175818.21890-1-stephen.smalley.work@gmail.com>
References: <20240502175818.21890-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (3.52.0-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 13:58 -0400, Stephen Smalley wrote:
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

Nice catch. I think you're correct on file ACLs too.

We're probably saved in many cases by the fact that clients usually
send ACLs and seclabels alongside other attributes during a create.
Obviously, that's not _always_ the case though.

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
>  fs/nfsd/vfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 2e41eb4c3cec..9b777ea7ef26 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1422,7 +1422,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	 * Callers expect new file metadata to be committed even
>  	 * if the attributes have not changed.
>  	 */
> -	if (iap->ia_valid)
> +	if (iap->ia_valid || (attrs->na_seclabel && attrs->na_seclabel->len))
>  		status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status =3D nfserrno(commit_metadata(resfhp));

This looks like the right approach to me, but can we instead add a
nfsd_attrs_valid() helper function that checks ia_valid and does the
test above?

Then we can add similar tests for ACLs to it later, once we do a bit
more investigation.

Thanks,
--=20
Jeffrey Layton <jlayton@kernel.org>

