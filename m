Return-Path: <linux-nfs+bounces-11857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC96AC00A9
	for <lists+linux-nfs@lfdr.de>; Thu, 22 May 2025 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B0218822A4
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31D23D2B1;
	Wed, 21 May 2025 23:21:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227921D3C7
	for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869662; cv=none; b=fS13v4DjbUXDJTUmQIWaoDu5qCPcjM7wjUC6m9hM9a/NSQHWXG6Hy3q9p+aYfxKiEcd7CgrQsvNWxRgU2Y2aBU/u1eq7JEdcWIHmSiaIG3Z5haxlRDEHm3vXrqNcB+4hX4z1in5sZTByw+bBgCMfsYT8RcLEsGwm9s65jK93ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869662; c=relaxed/simple;
	bh=Ih0XwK5pjQQxkw/U/3xiRAsPcYWeN041WyA6R+Jfet4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IwiIlaK3ap+qvi8RrjVwYvXGWLmYkqWtrS21wrwVXCDJPwZvO3yakS/Qvi0IUqmVpYO31NtqwcHubXNPrWYK+6fFWWMYg8GDJhAxb/qWZ8eQSYsF71j88SH1km6teHl4QA4xuxCaleuEqXXvQW7qlAwWE+4lk1YCCtCKt51vkA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uHsjy-007kTU-Tg;
	Wed, 21 May 2025 23:20:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Anna Schumaker" <anna@kernel.org>
Cc:
 linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org
Subject: Re: [PATCH] NFS: Fixes for nfs4_proc_mkdir() error handling
In-reply-to: <20250516150010.61641-1-anna@kernel.org>
References: <20250516150010.61641-1-anna@kernel.org>
Date: Thu, 22 May 2025 09:20:50 +1000
Message-id: <174786965058.62796.752773445709137169@noble.neil.brown.name>

On Sat, 17 May 2025, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
>=20
> The PTR_ERR_OR_ZERO() macro uses IS_ERR(), which checks if an error
> value is a valid Linux error code. It does not take into account NFS
> error codes, which are well out of the range of MAX_ERRNO. So if
> _nfs4_proc_mkdir() returns -NFS4ERR_DELAY (which xfstests generic/477 was
> able to consistently hit while running against a Hammerspace server),
> PTR_ERR_OR_ZERO() will happily say "no, that's not an error", so we
> propagate it up to the VFS who then tries to dput() it.
>=20
> Naturally, the kernel doesn't like this:
>=20
> [  247.669307] BUG: unable to handle page fault for address: ffffffffffffd9=
68
> [  247.690824] RIP: 0010:lockref_put_return+0x67/0x130
> [  247.719037] Call Trace:
> [  247.719446]  <TASK>
> [  247.719806]  ? __pfx_lockref_put_return+0x10/0x10
> [  247.720538]  ? _raw_spin_unlock+0x15/0x30
> [  247.721173]  ? dput+0x179/0x490
> [  247.721682]  ? vfs_mkdir+0x475/0x780
> [  247.722259]  dput+0x30/0x490
> [  247.722730]  do_mkdirat+0x158/0x310
> [  247.723292]  ? __pfx_do_mkdirat+0x10/0x10
> [  247.723928]  __x64_sys_mkdir+0xd3/0x160
> [  247.724531]  do_syscall_64+0x4b/0x120
> [  247.725131]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  247.725914] RIP: 0033:0x7fe0e22f3ddb
>=20
> While I was in the area, I noticed that we're discarding any errors left
> unhandled by nfs4_handle_exception(). This patch fixes both of these
> issues.
>=20
> Fixes: 8376583b84a1 ("nfs: change mkdir inode_operation to return alternate=
 dentry if needed.")
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---
>  fs/nfs/nfs4proc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index c7e068b563ff..306dade146e6 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5274,13 +5274,17 @@ static struct dentry *nfs4_proc_mkdir(struct inode =
*dir, struct dentry *dentry,
>  		sattr->ia_mode &=3D ~current_umask();
>  	do {
>  		alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label);
> -		err =3D PTR_ERR_OR_ZERO(alias);
> +		err =3D PTR_ERR(alias);
> +		if (err > 0)
> +			err =3D 0;

This would be problematic on a 32 bit machine with more than 2GB of
memory ... or maybe on any 32bit machine as I think kernel addresses are
always negative.

The largest nfs error code is a little over 12000.  We could maybe
change MAX_ERRNO to 13000, but as that is more than one page it might
not work.
The best solution would be to separate the error from the pointer while
the error might exceed MAX_ERRNO.

Something like this?

NeilBrown


diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..feebca84b980 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5155,13 +5155,15 @@ static int nfs4_do_create(struct inode *dir, struct d=
entry *dentry, struct nfs4_
 }
=20
 static struct dentry *nfs4_do_mkdir(struct inode *dir, struct dentry *dentry,
-				    struct nfs4_createdata *data)
+				    struct nfs4_createdata *data, int *statusp)
 {
-	int status =3D nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &da=
ta->msg,
+	struct dentry *ret;
+
+	*statusp =3D nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &data=
->msg,
 				    &data->arg.seq_args, &data->res.seq_res, 1);
=20
-	if (status)
-		return ERR_PTR(status);
+	if (*statusp)
+		return NULL;
=20
 	spin_lock(&dir->i_lock);
 	/* Creating a directory bumps nlink in the parent */
@@ -5170,7 +5172,11 @@ static struct dentry *nfs4_do_mkdir(struct inode *dir,=
 struct dentry *dentry,
 				      data->res.fattr->time_start,
 				      NFS_INO_INVALID_DATA);
 	spin_unlock(&dir->i_lock);
-	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
+	ret =3D nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
+	if (!IS_ERR(ret))
+		return ret;
+	*statusp =3D PTR_ERR(ret);
+	return NULL;
 }
=20
 static void nfs4_free_createdata(struct nfs4_createdata *data)
@@ -5231,17 +5237,18 @@ static int nfs4_proc_symlink(struct inode *dir, struc=
t dentry *dentry,
=20
 static struct dentry *_nfs4_proc_mkdir(struct inode *dir, struct dentry *den=
try,
 				       struct iattr *sattr,
-				       struct nfs4_label *label)
+				       struct nfs4_label *label, int *statusp)
 {
 	struct nfs4_createdata *data;
-	struct dentry *ret =3D ERR_PTR(-ENOMEM);
+	struct dentry *ret =3D NULL;
=20
+	*statusp =3D -ENOMEM;
 	data =3D nfs4_alloc_createdata(dir, &dentry->d_name, sattr, NF4DIR);
 	if (data =3D=3D NULL)
 		goto out;
=20
 	data->arg.label =3D label;
-	ret =3D nfs4_do_mkdir(dir, dentry, data);
+	ret =3D nfs4_do_mkdir(dir, dentry, data, statusp);
=20
 	nfs4_free_createdata(data);
 out:
@@ -5264,11 +5271,12 @@ static struct dentry *nfs4_proc_mkdir(struct inode *d=
ir, struct dentry *dentry,
 	if (!(server->attr_bitmask[2] & FATTR4_WORD2_MODE_UMASK))
 		sattr->ia_mode &=3D ~current_umask();
 	do {
-		alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label);
-		err =3D PTR_ERR_OR_ZERO(alias);
+		alias =3D _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
 		trace_nfs4_mkdir(dir, &dentry->d_name, err);
-		err =3D nfs4_handle_exception(NFS_SERVER(dir), err,
-				&exception);
+		if (err)
+			alias =3D ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
+							      err,
+							      &exception));
 	} while (exception.retry);
 	nfs4_label_release_security(label);
=20

