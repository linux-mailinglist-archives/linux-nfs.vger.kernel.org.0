Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764AE14BCCB
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 16:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgA1P1I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 10:27:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20513 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgA1P1I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jan 2020 10:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580225227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h67eEMoUZ2cV0yZN6ojPzh8Y2Hh4TVTcgvwRAuSzaRc=;
        b=CuSTWYcieRDjq8QSWNf3jKFCsIAEgXRLOXwGb397J93Hi4TLGqM3WdsOFkwQo0Im/mmf1x
        SPWHKEB1ktA7X6YsNTzY2KmYHWR9ExAPYlBmDS2AGd4qAyTwrVA7nhnK/YOA/1MtaCT/h5
        GZOuUdAhDfrgxVMqubar0S+i8qUbzWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Qtr1M4XOM7OTCtSezBHAVQ-1; Tue, 28 Jan 2020 10:26:59 -0500
X-MC-Unique: Qtr1M4XOM7OTCtSezBHAVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EA70190D35A;
        Tue, 28 Jan 2020 15:26:58 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB785E241;
        Tue, 28 Jan 2020 15:26:57 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 91EC310C1FC7; Tue, 28 Jan 2020 10:26:57 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Revalidate once when holding a delegation
Date:   Tue, 28 Jan 2020 10:26:57 -0500
Message-Id: <bcb5ffd399c4434730e6d100a5b7cae5e207244e.1580225161.git.bcodding@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we skip lookup revalidataion while holding a delegation, we might miss
that the file has changed directories on the server.  This can happen if
the file is moved in between the client caching a dentry and obtaining a
delegation.  That can be reproduced on a single system with this bash:

mkdir -p /exports/dir{1,2}
exportfs -o rw localhost:/exports
mount -t nfs -ov4.1,noac localhost:/exports /mnt/localhost

touch /exports/dir1/fubar

cat /mnt/localhost/dir1/fubar
mv /mnt/localhost/dir{1,2}/fubar

mv /exports/dir{2,1}/fubar

cat /mnt/localhost/dir1/fubar
mv /mnt/localhost/dir{1,2}/fubar

In this example, the final `mv` will stat source and destination and find
they are the same dentry.

To fix this without giving up the increased lookup performance that holdi=
ng
a delegation provides, let's revalidate the dentry only once after
obtaining a delegation by placing a magic value in the dentry's verifier.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..e9d07dcd6d6f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -949,6 +949,7 @@ static int nfs_fsync_dir(struct file *filp, loff_t st=
art, loff_t end,
 	return 0;
 }
=20
+#define NFS_DELEGATION_VERF 0xfeeddeaf
 /**
  * nfs_force_lookup_revalidate - Mark the directory as having changed
  * @dir: pointer to directory inode
@@ -962,6 +963,8 @@ static int nfs_fsync_dir(struct file *filp, loff_t st=
art, loff_t end,
 void nfs_force_lookup_revalidate(struct inode *dir)
 {
 	NFS_I(dir)->cache_change_attribute++;
+	if (NFS_I(dir)->cache_change_attribute =3D=3D NFS_DELEGATION_VERF)
+		NFS_I(dir)->cache_change_attribute++;
 }
 EXPORT_SYMBOL_GPL(nfs_force_lookup_revalidate);
=20
@@ -1133,6 +1136,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, str=
uct dentry *dentry,
 	struct nfs_fh *fhandle;
 	struct nfs_fattr *fattr;
 	struct nfs4_label *label;
+	unsigned long verifier;
 	int ret;
=20
 	ret =3D -ENOMEM;
@@ -1154,6 +1158,11 @@ nfs_lookup_revalidate_dentry(struct inode *dir, st=
ruct dentry *dentry,
 	if (nfs_refresh_inode(inode, fattr) < 0)
 		goto out;
=20
+	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+		verifier =3D NFS_DELEGATION_VERF;
+	else
+		verifier =3D nfs_save_change_attribute(dir);
+
 	nfs_setsecurity(inode, fattr, label);
 	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
=20
@@ -1167,6 +1176,15 @@ nfs_lookup_revalidate_dentry(struct inode *dir, st=
ruct dentry *dentry,
 	return nfs_lookup_revalidate_done(dir, dentry, inode, ret);
 }
=20
+static int nfs_delegation_matches_dentry(struct inode *dir,
+			struct dentry *dentry, struct inode *inode)
+{
+	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ) &&
+		dentry->d_time =3D=3D NFS_DELEGATION_VERF)
+		return 1;
+	return 0;
+}
+
 /*
  * This is called every time the dcache has a lookup hit,
  * and we should check whether we can really trust that
@@ -1197,7 +1215,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct =
dentry *dentry,
 		goto out_bad;
 	}
=20
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+	if (nfs_delegation_matches_dentry(dir, dentry, inode))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
=20
 	/* Force a full look up iff the parent directory has changed */
@@ -1635,7 +1653,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct=
 dentry *dentry,
 	if (inode =3D=3D NULL)
 		goto full_reval;
=20
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+	if (nfs_delegation_matches_dentry(dir, dentry, inode))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
=20
 	/* NFS only supports OPEN on regular files */
--=20
2.20.1

