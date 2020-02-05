Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A77153266
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBEOCC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 09:02:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726748AbgBEOCC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 09:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580911321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8hnRB/54ocr4XYqnIxMCt/VDo0InYWo8HeIlSXK7Uo=;
        b=XYgLZuz9QfwKtOmNa/hVehd1QRhpV221IerltuwZIskPVdxyXeSdBbsYssjMKtgi8xohFF
        tEatyWodXkdc056NmPDq7NPFriPucoeVgWzXNjGhCbS8Zol+g+S/9WGki+lS45+o8AOh1j
        6YiUQGxokx23vNOXe2GKqX6LV/DFBd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-ZmhBepeZPbOpSFsZ16aiyw-1; Wed, 05 Feb 2020 09:01:57 -0500
X-MC-Unique: ZmhBepeZPbOpSFsZ16aiyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC22B108838B;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6424D5D9E2;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id E7EB010C1FC8; Wed,  5 Feb 2020 09:01:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix up directory verifier races
Date:   Wed,  5 Feb 2020 09:01:52 -0500
Message-Id: <1fb737c85fdfc56abe19cac56c04b6b9bf4287d8.1580910601.git.bcodding@redhat.com>
In-Reply-To: <cover.1580910601.git.bcodding@redhat.com>
References: <cover.1580910601.git.bcodding@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

In order to avoid having our dentry revalidation race with an update
of the directory on the server, we need to store the verifier before
the RPC calls to LOOKUP and READDIR.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@gmail.com>
Tested-by: Benjamin Coddington <bcodding@gmail.com>
---
 fs/nfs/dir.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1320288ff9ec..b4e7558e42ab 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -155,6 +155,7 @@ typedef struct {
 	loff_t		current_index;
 	decode_dirent_t	decode;
=20
+	unsigned long	dir_verifier;
 	unsigned long	timestamp;
 	unsigned long	gencount;
 	unsigned int	cache_entry_index;
@@ -353,6 +354,7 @@ int nfs_readdir_xdr_filler(struct page **pages, nfs_r=
eaddir_descriptor_t *desc,
  again:
 	timestamp =3D jiffies;
 	gencount =3D nfs_inc_attr_generation_counter();
+	desc->dir_verifier =3D nfs_save_change_attribute(inode);
 	error =3D NFS_PROTO(inode)->readdir(file_dentry(file), cred, entry->coo=
kie, pages,
 					  NFS_SERVER(inode)->dtsize, desc->plus);
 	if (error < 0) {
@@ -455,13 +457,13 @@ void nfs_force_use_readdirplus(struct inode *dir)
 }
=20
 static
-void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry)
+void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
+		unsigned long dir_verifier)
 {
 	struct qstr filename =3D QSTR_INIT(entry->name, entry->len);
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
-	struct inode *dir =3D d_inode(parent);
 	struct inode *inode;
 	int status;
=20
@@ -500,7 +502,7 @@ void nfs_prime_dcache(struct dentry *parent, struct n=
fs_entry *entry)
 		if (nfs_same_file(dentry, entry)) {
 			if (!entry->fh->size)
 				goto out;
-			nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+			nfs_set_verifier(dentry, dir_verifier);
 			status =3D nfs_refresh_inode(d_inode(dentry), entry->fattr);
 			if (!status)
 				nfs_setsecurity(d_inode(dentry), entry->fattr, entry->label);
@@ -526,7 +528,7 @@ void nfs_prime_dcache(struct dentry *parent, struct n=
fs_entry *entry)
 		dput(dentry);
 		dentry =3D alias;
 	}
-	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+	nfs_set_verifier(dentry, dir_verifier);
 out:
 	dput(dentry);
 }
@@ -564,7 +566,8 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t =
*desc, struct nfs_entry *en
 		count++;
=20
 		if (desc->plus)
-			nfs_prime_dcache(file_dentry(desc->file), entry);
+			nfs_prime_dcache(file_dentry(desc->file), entry,
+					desc->dir_verifier);
=20
 		status =3D nfs_readdir_add_to_array(entry, page);
 		if (status !=3D 0)
@@ -1159,6 +1162,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, str=
uct dentry *dentry,
 	struct nfs_fh *fhandle;
 	struct nfs_fattr *fattr;
 	struct nfs4_label *label;
+	unsigned long dir_verifier;
 	int ret;
=20
 	ret =3D -ENOMEM;
@@ -1168,6 +1172,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, str=
uct dentry *dentry,
 	if (fhandle =3D=3D NULL || fattr =3D=3D NULL || IS_ERR(label))
 		goto out;
=20
+	dir_verifier =3D nfs_save_change_attribute(dir);
 	ret =3D NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, label);
 	if (ret < 0) {
 		switch (ret) {
@@ -1188,7 +1193,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, str=
uct dentry *dentry,
 		goto out;
=20
 	nfs_setsecurity(inode, fattr, label);
-	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+	nfs_set_verifier(dentry, dir_verifier);
=20
 	/* set a readdirplus hint that we had a cache miss */
 	nfs_force_use_readdirplus(dir);
@@ -1415,6 +1420,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct=
 dentry * dentry, unsigned in
 	struct nfs_fh *fhandle =3D NULL;
 	struct nfs_fattr *fattr =3D NULL;
 	struct nfs4_label *label =3D NULL;
+	unsigned long dir_verifier;
 	int error;
=20
 	dfprintk(VFS, "NFS: lookup(%pd2)\n", dentry);
@@ -1440,6 +1446,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct=
 dentry * dentry, unsigned in
 	if (IS_ERR(label))
 		goto out;
=20
+	dir_verifier =3D nfs_save_change_attribute(dir);
 	trace_nfs_lookup_enter(dir, dentry, flags);
 	error =3D NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, label);
 	if (error =3D=3D -ENOENT)
@@ -1463,7 +1470,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct=
 dentry * dentry, unsigned in
 			goto out_label;
 		dentry =3D res;
 	}
-	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+	nfs_set_verifier(dentry, dir_verifier);
 out_label:
 	trace_nfs_lookup_exit(dir, dentry, flags, error);
 	nfs4_label_free(label);
--=20
2.20.1

