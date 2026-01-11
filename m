Return-Path: <linux-nfs+bounces-17732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B3D0E019
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 01:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 300253004855
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 00:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536912CDA5;
	Sun, 11 Jan 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ZRGBNj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70193BB44
	for <linux-nfs@vger.kernel.org>; Sun, 11 Jan 2026 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768091081; cv=none; b=adibFs++H8tbfUQA93rudt4r8IoFjBM7X8PDcPCZ2cH6/gOIGkjq3F6gpPlkQrC1enorLKwTlguFCU73/Q1VzXEnSKrLtUWozKm6f1u1dKTtm/fW7WyVO1BGETizNgV4NpHduWoaN5AZxAI7wqtJ7xogIIx6AExQSd5xqTN0apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768091081; c=relaxed/simple;
	bh=wmyGBP7sjZR+u4coFvApsiid1YRrInflqqnyzmHfLSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rv0J8vpngOHRLej4aG18LLDxb5X/C9wNEuXGSto5kaOnSn/4Ox379E0vWA2aw7qe5Gh3QeTLsDnFKqHIhbhjibASDj4RiK+fozuBZeAxIPJ1Y7pBNuOzDUzW5ng+znlTG4pQzM9zSO01KUsm4GkbKq+IDafq0mMgRaM2IB2b3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+ZRGBNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17952C4CEF1;
	Sun, 11 Jan 2026 00:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768091080;
	bh=wmyGBP7sjZR+u4coFvApsiid1YRrInflqqnyzmHfLSE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=l+ZRGBNjPVD36vZwekz88z4YUO0NlvIepHh9EXpmVK3jCCEQY6Voor4Iuu5pTlaGb
	 7Q3zAXAB/O6ZbJta8PO34ng/ktoexG4Zi+AJoQ3XmV0cegmacEYntMuckQidx6B781
	 TVvdHGgW5sOvGUaqUmh3OJWzxqY8xfkjn+ZCtbbMVLR4bGi8EYYyyr6ZysrdRNb0Ik
	 dLv0Bdru7fYcRC2QIxnsjSUwS17FMGAXpitw/IaS+wu1FeMej9jjYVJ/rYyLnapuEQ
	 VKNPEUwugJraM89FUVL4zT08GnWkzUUUnmfVhxeSpP9cCpchSq7JCZj+REdpwkkqwH
	 3+Aq8F88T7zPA==
Message-ID: <211e07b8129353fbec59b44f4859ce22947f222b.camel@kernel.org>
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
From: Trond Myklebust <trondmy@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>, 
	linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Date: Sat, 10 Jan 2026 19:24:38 -0500
In-Reply-To: <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
		 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
		 <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
	 <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mark,

On Mon, 2026-01-05 at 10:20 -0500, Trond Myklebust wrote:
>=20
> OK so if I'm understanding correctly, this is organised as ext4
> partitions that are stored in qcow2 images that are again stored on a
> NFSv4.2 partition.
>=20
> Do these qcow2 images have a file size that is fixed at creation
> time,
> or is the file size dynamic?
> Also, does changing the "discard" option from "unmap" to "ignore"
> make
> any difference to the outcome?

I've been staring at this for several days now, and the only candidate
for a bug in the NFS client that I can see is this one. Can you please
check if the following patch helps?

Thanks
  Trond

8<------------------------------------------------------------------
From 18acd9e2652d44bcb8a48bc4643ab006787b809a Mon Sep 17 00:00:00 2001
Message-ID: <18acd9e2652d44bcb8a48bc4643ab006787b809a.1768091015.git.trond.=
myklebust@hammerspace.com>
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Sat, 10 Jan 2026 18:53:34 -0500
Subject: [PATCH] NFSv4.2: Fix size read races in fallocate and copy offload

If the pre-operation file size is read before locking the inode and
quiescing O_DIRECT writes, then nfs_truncate_last_folio() might end up
overwriting valid file data.

Fixes: b1817b18ff20 ("NFS: Protect against 'eof page pollution'")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/io.c        |  2 ++
 fs/nfs/nfs42proc.c | 29 +++++++++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index d275b0a250bf..8337f0ae852d 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -84,6 +84,7 @@ nfs_start_io_write(struct inode *inode)
 		nfs_file_block_o_direct(NFS_I(inode));
 	return err;
 }
+EXPORT_SYMBOL_GPL(nfs_start_io_write);
=20
 /**
  * nfs_end_io_write - declare that the buffered write operation is done
@@ -97,6 +98,7 @@ nfs_end_io_write(struct inode *inode)
 {
 	up_write(&inode->i_rwsem);
 }
+EXPORT_SYMBOL_GPL(nfs_end_io_write);
=20
 /* Call with exclusively locked inode->i_rwsem */
 static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode=
)
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index d537fb0c230e..c08520828708 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -114,7 +114,6 @@ static int nfs42_proc_fallocate(struct rpc_message *msg=
, struct file *filep,
 	exception.inode =3D inode;
 	exception.state =3D lock->open_context->state;
=20
-	nfs_file_block_o_direct(NFS_I(inode));
 	err =3D nfs_sync_inode(inode);
 	if (err)
 		goto out;
@@ -138,13 +137,17 @@ int nfs42_proc_allocate(struct file *filep, loff_t of=
fset, loff_t len)
 		.rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE],
 	};
 	struct inode *inode =3D file_inode(filep);
-	loff_t oldsize =3D i_size_read(inode);
+	loff_t oldsize;
 	int err;
=20
 	if (!nfs_server_capable(inode, NFS_CAP_ALLOCATE))
 		return -EOPNOTSUPP;
=20
-	inode_lock(inode);
+	err =3D nfs_start_io_write(inode);
+	if (err)
+		return err;
+
+	oldsize =3D i_size_read(inode);
=20
 	err =3D nfs42_proc_fallocate(&msg, filep, offset, len);
=20
@@ -155,7 +158,7 @@ int nfs42_proc_allocate(struct file *filep, loff_t offs=
et, loff_t len)
 		NFS_SERVER(inode)->caps &=3D ~(NFS_CAP_ALLOCATE |
 					     NFS_CAP_ZERO_RANGE);
=20
-	inode_unlock(inode);
+	nfs_end_io_write(inode);
 	return err;
 }
=20
@@ -170,7 +173,9 @@ int nfs42_proc_deallocate(struct file *filep, loff_t of=
fset, loff_t len)
 	if (!nfs_server_capable(inode, NFS_CAP_DEALLOCATE))
 		return -EOPNOTSUPP;
=20
-	inode_lock(inode);
+	err =3D nfs_start_io_write(inode);
+	if (err)
+		return err;
=20
 	err =3D nfs42_proc_fallocate(&msg, filep, offset, len);
 	if (err =3D=3D 0)
@@ -179,7 +184,7 @@ int nfs42_proc_deallocate(struct file *filep, loff_t of=
fset, loff_t len)
 		NFS_SERVER(inode)->caps &=3D ~(NFS_CAP_DEALLOCATE |
 					     NFS_CAP_ZERO_RANGE);
=20
-	inode_unlock(inode);
+	nfs_end_io_write(inode);
 	return err;
 }
=20
@@ -189,14 +194,17 @@ int nfs42_proc_zero_range(struct file *filep, loff_t =
offset, loff_t len)
 		.rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_ZERO_RANGE],
 	};
 	struct inode *inode =3D file_inode(filep);
-	loff_t oldsize =3D i_size_read(inode);
+	loff_t oldsize;
 	int err;
=20
 	if (!nfs_server_capable(inode, NFS_CAP_ZERO_RANGE))
 		return -EOPNOTSUPP;
=20
-	inode_lock(inode);
+	err =3D nfs_start_io_write(inode);
+	if (err)
+		return err;
=20
+	oldsize =3D i_size_read(inode);
 	err =3D nfs42_proc_fallocate(&msg, filep, offset, len);
 	if (err =3D=3D 0) {
 		nfs_truncate_last_folio(inode->i_mapping, oldsize,
@@ -205,7 +213,7 @@ int nfs42_proc_zero_range(struct file *filep, loff_t of=
fset, loff_t len)
 	} else if (err =3D=3D -EOPNOTSUPP)
 		NFS_SERVER(inode)->caps &=3D ~NFS_CAP_ZERO_RANGE;
=20
-	inode_unlock(inode);
+	nfs_end_io_write(inode);
 	return err;
 }
=20
@@ -416,7 +424,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	struct nfs_server *src_server =3D NFS_SERVER(src_inode);
 	loff_t pos_src =3D args->src_pos;
 	loff_t pos_dst =3D args->dst_pos;
-	loff_t oldsize_dst =3D i_size_read(dst_inode);
+	loff_t oldsize_dst;
 	size_t count =3D args->count;
 	ssize_t status;
=20
@@ -461,6 +469,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 		&src_lock->open_context->state->flags);
 	set_bit(NFS_CLNT_DST_SSC_COPY_STATE,
 		&dst_lock->open_context->state->flags);
+	oldsize_dst =3D i_size_read(dst_inode);
=20
 	status =3D nfs4_call_sync(dst_server->client, dst_server, &msg,
 				&args->seq_args, &res->seq_res, 0);
--=20
2.52.0


