Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D799471D1A
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Dec 2021 22:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhLLVA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Dec 2021 16:00:59 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:35118 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLLVA6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Dec 2021 16:00:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AD89A614E2ED;
        Sun, 12 Dec 2021 22:00:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xBu7Mhxd4hUg; Sun, 12 Dec 2021 22:00:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 38727614E2F0;
        Sun, 12 Dec 2021 22:00:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hm8rnARabn_U; Sun, 12 Dec 2021 22:00:51 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id D0559614E2ED;
        Sun, 12 Dec 2021 22:00:50 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com, david@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH] NFS: Save 4 bytes when re-exporting
Date:   Sun, 12 Dec 2021 22:00:44 +0100
Message-Id: <20211212210044.16238-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When re-exporting, the whole struct nfs_fh is embedded in the new
fhandle.
But we need only nfs_fh->data[], nfs_fh->size is not needed.
So skip fs_fh->size and save a full word (4 bytes).
The downside is the extra memcpy() in nfs_fh_to_dentry().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
While investigating into improving NFS re-export I noticed that
we can already save 4 bytes of overhead.
I don't think we need to embedd the full struct nfs_fh and
can skip ->size.

Thanks,
//richard
---
 fs/nfs/export.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 5f6e1b715545..5579c87106a1 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -22,9 +22,9 @@ enum {
 };
=20
=20
-static struct nfs_fh *nfs_exp_embedfh(__u32 *p)
+static unsigned char *nfs_exp_embedfh(__u32 *p)
 {
-	return (struct nfs_fh *)(p + EMBED_FH_OFF);
+	return (unsigned char *)(p + EMBED_FH_OFF);
 }
=20
 /*
@@ -35,8 +35,8 @@ static int
 nfs_encode_fh(struct inode *inode, __u32 *p, int *max_len, struct inode =
*parent)
 {
 	struct nfs_fh *server_fh =3D NFS_FH(inode);
-	struct nfs_fh *clnt_fh =3D nfs_exp_embedfh(p);
-	size_t fh_size =3D offsetof(struct nfs_fh, data) + server_fh->size;
+	unsigned char *raw_fh =3D nfs_exp_embedfh(p);
+	size_t fh_size =3D server_fh->size;
 	int len =3D EMBED_FH_OFF + XDR_QUADLEN(fh_size);
=20
 	dprintk("%s: max fh len %d inode %p parent %p",
@@ -58,7 +58,9 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max_l=
en, struct inode *parent)
 	p[FILEID_LOW_OFF] =3D NFS_FILEID(inode);
 	p[FILE_I_TYPE_OFF] =3D inode->i_mode & S_IFMT;
 	p[len - 1] =3D 0; /* Padding */
-	nfs_copy_fh(clnt_fh, server_fh);
+
+	memcpy(raw_fh, server_fh->data, server_fh->size);
+
 	*max_len =3D len;
 	dprintk("%s: result fh fileid %llu mode %u size %d\n",
 		__func__, NFS_FILEID(inode), inode->i_mode, *max_len);
@@ -70,18 +72,22 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *=
fid,
 		 int fh_len, int fh_type)
 {
 	struct nfs_fattr *fattr =3D NULL;
-	struct nfs_fh *server_fh =3D nfs_exp_embedfh(fid->raw);
-	size_t fh_size =3D offsetof(struct nfs_fh, data) + server_fh->size;
+	unsigned char *raw_server_fh =3D nfs_exp_embedfh(fid->raw);
 	const struct nfs_rpc_ops *rpc_ops;
 	struct dentry *dentry;
 	struct inode *inode;
-	int len =3D EMBED_FH_OFF + XDR_QUADLEN(fh_size);
 	u32 *p =3D fid->raw;
+	struct nfs_fh server_fh =3D { 0 };
 	int ret;
=20
-	/* NULL translates to ESTALE */
-	if (fh_len < len || fh_type !=3D len)
+	server_fh.size =3D (fh_len * XDR_UNIT) - (EMBED_FH_OFF * XDR_UNIT);
+	if (server_fh.size < 1) {
+		WARN_ON_ONCE(1);
+		/* NULL translates to ESTALE */
 		return NULL;
+	}
+
+	memcpy(server_fh.data, raw_server_fh, server_fh.size);
=20
 	fattr =3D nfs_alloc_fattr_with_label(NFS_SB(sb));
 	if (fattr =3D=3D NULL) {
@@ -95,20 +101,20 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid =
*fid,
=20
 	dprintk("%s: fileid %llu mode %d\n", __func__, fattr->fileid, fattr->mo=
de);
=20
-	inode =3D nfs_ilookup(sb, fattr, server_fh);
+	inode =3D nfs_ilookup(sb, fattr, &server_fh);
 	if (inode)
 		goto out_found;
=20
 	rpc_ops =3D NFS_SB(sb)->nfs_client->rpc_ops;
-	ret =3D rpc_ops->getattr(NFS_SB(sb), server_fh, fattr, NULL);
+	ret =3D rpc_ops->getattr(NFS_SB(sb), &server_fh, fattr, NULL);
 	if (ret) {
 		dprintk("%s: getattr failed %d\n", __func__, ret);
-		trace_nfs_fh_to_dentry(sb, server_fh, fattr->fileid, ret);
+		trace_nfs_fh_to_dentry(sb, &server_fh, fattr->fileid, ret);
 		dentry =3D ERR_PTR(ret);
 		goto out_free_fattr;
 	}
=20
-	inode =3D nfs_fhget(sb, server_fh, fattr);
+	inode =3D nfs_fhget(sb, &server_fh, fattr);
=20
 out_found:
 	dentry =3D d_obtain_alias(inode);
--=20
2.26.2

