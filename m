Return-Path: <linux-nfs+bounces-11903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A5AC3866
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 06:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34038170651
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 04:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FA17A2E2;
	Mon, 26 May 2025 04:08:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576A136E
	for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748232510; cv=none; b=JK3vD+eUIpYCRs8y0e/YwKMjinUeCYydioFDemLGj5GT0sm+sB2TYt5yW5XD/gzPcrsN7BU3W7OIjtQtfAAAVHGMfj8GBT7/oN5jmpz9SdcsQXBGpc1G70uDvH/Quo76Yo7VYHiSx10Am7IXrNcCS6yB00WaGt7mAAN4G6JheCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748232510; c=relaxed/simple;
	bh=Xl4SQEVJbEODj5sGE/Y07ZTQO8W1pkZQ+c7YucOVwEw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=W3XOIoLaL2qXLA0Aju4KCu915z+X371Idy9hXA1AetnkSHYOSeHkSgUPpVnPQOCEW/uUzEv4YPXEP0xuE3LBdQmQ0fcxk7D3sPuC84DuKeUOlJRSWYIyglm0yJ8NN9uUcZVLs+tJpaau8xaA8OAs4qKuFdhXtkK/AMDL99laICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uJP8T-00B4Yh-RK;
	Mon, 26 May 2025 04:08:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix incorrect handling of large-number NFS errors in
 nfs4_do_mkdir()
Date: Mon, 26 May 2025 14:08:25 +1000
Message-id: <174823250556.608730.11560543414622955231@noble.neil.brown.name>


A recent commit introduced nfs4_do_mkdir() which reports an error from
nfs4_call_sync() by returning it with ERR_PTR().

This is a problem as nfs4_call_sync() can return negative NFS-specific
errors with values larger than MAX_ERRNO (4095).  One example is
NFS4ERR_DELAY which has value 10008.

This "pointer" gets to PTR_ERR_OR_ZERO() in nfs4_proc_mkdir() which
chooses ZERO because it isn't in the range of value errors.  Ultimately
the pointer is dereferenced.

This patch changes nfs4_do_mkdir() to report the dentry pointer and
status separately - pointer as a return value, status in an "int *"
parameter.

The same separation is used for _nfs4_proc_mkdir() and the two are
combined only in nfs4_proc_mkdir() after the status has passed through
nfs4_handle_exception(), which ensures the error code does not exceed
MAX_ERRNO.

It also fixes a problem in the even when nfs4_handle_exception() updated
the error value, the original 'alias' was still returned.

Reported-by: Anna Schumaker <anna@kernel.org>
Fixes: 8376583b84a1 ("nfs: change mkdir inode_operation to return alternate d=
entry if needed.")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/nfs4proc.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b1d2122bd5a7..4b123bca65e1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5164,13 +5164,15 @@ static int nfs4_do_create(struct inode *dir, struct d=
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
@@ -5179,7 +5181,11 @@ static struct dentry *nfs4_do_mkdir(struct inode *dir,=
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
@@ -5240,17 +5246,18 @@ static int nfs4_proc_symlink(struct inode *dir, struc=
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
@@ -5273,11 +5280,12 @@ static struct dentry *nfs4_proc_mkdir(struct inode *d=
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
--=20
2.49.0


