Return-Path: <linux-nfs+bounces-14386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B3B5538A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8D91D681E0
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDEC306490;
	Fri, 12 Sep 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irljk7+v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE73074B2
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690897; cv=none; b=gqQG9qblcC1M8C5eqGMLUCWiEyKgKSn3x4z3YQyHy+gvUgpH23UoSMEd7FJ2lqsrcRpPpZkjW4kdPcUidudFVGAnxQy4A/4YkrCvFJ+zwk//Dy5NdBicrM0GB9rn1O1a0+e+Wa31jY0wmLCL1aStA+rpLF5amNCHbPyISu/cVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690897; c=relaxed/simple;
	bh=CgyNEahm5gOOpEEykICG0JY6xqFEbeq32tKyTBTcXas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY8Dwg1ak63I08akWpLRv5Py72cAaWTKKM8F175ls/5FzkXeTMBr7WhnK993s5F69oSuvtkXWZ3fHgoQ0w8ST8+zj7C3qJemCdipsHgcOYOgRsC6eYQu+tlY3OS/26iiu2Xl6px4dNiMdaVBvKk7UU04C3bOXLub52iF5ewBxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irljk7+v; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso532840b3a.1
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690894; x=1758295694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qddzG88P0MDINuI3ttRfHIuZNQHYMA6MDyCfUKvDRo8=;
        b=Irljk7+vDXy/JeNOFoyMtzEjf1+GXyhS/GhnvZCuT5RQkU0ZPM9f05VzEknXVh8DqL
         Xp72IENBjSht0uXzdssiS6yXGy3wsQf6i0ygA5J5yp+5A3fByuP3pVpN4VTpAK8SplV3
         47I5Q2WVZXwLqCu3Svc8zzlrMRHsdjJiaFRz8z88QFCayW1+b2Z9YKremvvnTda3BB/b
         Nq3xuBaKwofmLvounCEzFFYS+frnVVe1uCbIFoIdTw+Y0amBqReYmNoqgYrRnJhZ2fsS
         h3X9L2C7PEVGOaZeP8X71y4/KCZCpcm6XRoWafb8onZW0F8lXZSu7F3WkfZsM+hFAup3
         PtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690894; x=1758295694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qddzG88P0MDINuI3ttRfHIuZNQHYMA6MDyCfUKvDRo8=;
        b=UetSnfnyORZUeijDbuv/y3/SOAhpEFq+dHmGR/i8rw4dbts1080mvE78YWqHHClDV+
         CEd9VuqoMSWWoftevNTUeiBYYsOxqhMZj6HZcturlkJLOZlGegHdIVA6FQF4wwVWXu4B
         GX2sLljbplCyAPkleEpIuYLf7W4bYjW/To3pGlMEIu9DTQPZldPBJ1STPjw//pIRPh70
         oVqdMBStaSpLKVl+InkWik8xg7Kp5GcnrWrweZ3+mu/PDenFtzjmnFakyX/ifGcuJXAf
         dbFj3wldrde45yrtibYgZtqylp6Qixgp9yjUliZz6E16war/dj9IhoQL/mYSUa9gpCN+
         75nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFQE2QggO5jigFlbpA00DouT0ZigANiQVZegBuwRtSS97ucWPRCy4aDNhP9Q4DmzQKF6x65WNxP5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkG9wtD5BRRGniCrv3TAUwAn5nk8Um/2xYe0QAc9EVLtZQxldh
	98iZyUxH5WeJvNUMGfIBxtwl75xHUL2iqz6lzdzpdY1Yp1sCYoaEc3DM
X-Gm-Gg: ASbGnctHpf/Rp6eYsE7N4RHzeDlm2lxYqoHt8Je5mWMCeP0ZqQh/4vlLncyYq1gQntw
	m717s97PuE4E+e400I7T4ZIS8s/c0T4ye2+eAz+tga1AxAANWpusmFqW2k2Ehs3aD3zIZgKfgqH
	4sHatfzFHEen5YdoesMy+6Lf42p9+laeN/SEsycV4d5yV3J7YRy85ALO7ciM66fEbqOrI/713A9
	rOVyaukPsegUcTw6toBQ648ZR+Kj3MrBX5RtbIe6J5Ida5mU772sjXzLys9i/AMzCs9lDd5WJ7R
	ckQs85FqDsnjjNbNwmKUscEznyme1kiT9XREmRkJzcKgzxEhLtnYrx1nOC3esMxNBkYCp0zb8w+
	zhjPv+NgEfbYNULrXeOh9wG410A==
X-Google-Smtp-Source: AGHT+IHSzv32UvYk1/EENIG2Gkyl/RiUekw8QXYbvFQu5Nyt93BDAZEn7q5Lm/tAAdYqDnZf6JgTdA==
X-Received: by 2002:a05:6a20:3c8e:b0:24c:2fa1:fddb with SMTP id adf61e73a8af0-2602cd2779cmr4539525637.53.1757690893744;
        Fri, 12 Sep 2025 08:28:13 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:28:13 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 10/10] xfs: add support for non-blocking fh_to_dentry()
Date: Fri, 12 Sep 2025 09:28:55 -0600
Message-ID: <20250912152855.689917-11-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to support using open_by_handle_at(2) via io_uring. It is useful
for io_uring to request that opening a file via handle be completed
using only cached data, or fail with -EAGAIN if that is not possible.

The signature of xfs_nfs_get_inode() is extended with a new flags
argument that allows callers to specify XFS_IGET_INCORE.

That flag is set when the VFS passes the FILEID_CACHED flag via the
fileid_type argument.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/xfs/xfs_export.c | 34 ++++++++++++++++++++++++++--------
 fs/xfs/xfs_export.h |  3 ++-
 fs/xfs/xfs_handle.c |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 201489d3de08..6a57ed8fd9b7 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -106,7 +106,8 @@ struct inode *
 xfs_nfs_get_inode(
 	struct super_block	*sb,
 	u64			ino,
-	u32			generation)
+	u32			generation,
+	uint			flags)
 {
  	xfs_mount_t		*mp = XFS_M(sb);
 	xfs_inode_t		*ip;
@@ -123,7 +124,9 @@ xfs_nfs_get_inode(
 	 * fine and not an indication of a corrupted filesystem as clients can
 	 * send invalid file handles and we have to handle it gracefully..
 	 */
-	error = xfs_iget(mp, NULL, ino, XFS_IGET_UNTRUSTED, 0, &ip);
+	flags |= XFS_IGET_UNTRUSTED;
+
+	error = xfs_iget(mp, NULL, ino, flags, 0, &ip);
 	if (error) {
 
 		/*
@@ -140,6 +143,10 @@ xfs_nfs_get_inode(
 		case -EFSCORRUPTED:
 			error = -ESTALE;
 			break;
+		case -ENODATA:
+			if (flags & XFS_IGET_INCORE)
+				error = -EAGAIN;
+			break;
 		default:
 			break;
 		}
@@ -170,10 +177,15 @@ xfs_nfs_get_inode(
 
 STATIC struct dentry *
 xfs_fs_fh_to_dentry(struct super_block *sb, struct fid *fid,
-		 int fh_len, int fileid_type)
+		 int fh_len, int fileid_type_flags)
 {
+	int			fileid_type = FILEID_TYPE(fileid_type_flags);
 	struct xfs_fid64	*fid64 = (struct xfs_fid64 *)fid;
 	struct inode		*inode = NULL;
+	uint			flags = 0;
+
+	if (fileid_type_flags & FILEID_CACHED)
+		flags = XFS_IGET_INCORE;
 
 	if (fh_len < xfs_fileid_length(fileid_type))
 		return NULL;
@@ -181,11 +193,11 @@ xfs_fs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	switch (fileid_type) {
 	case FILEID_INO32_GEN_PARENT:
 	case FILEID_INO32_GEN:
-		inode = xfs_nfs_get_inode(sb, fid->i32.ino, fid->i32.gen);
+		inode = xfs_nfs_get_inode(sb, fid->i32.ino, fid->i32.gen, flags);
 		break;
 	case FILEID_INO32_GEN_PARENT | XFS_FILEID_TYPE_64FLAG:
 	case FILEID_INO32_GEN | XFS_FILEID_TYPE_64FLAG:
-		inode = xfs_nfs_get_inode(sb, fid64->ino, fid64->gen);
+		inode = xfs_nfs_get_inode(sb, fid64->ino, fid64->gen, flags);
 		break;
 	}
 
@@ -194,10 +206,15 @@ xfs_fs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 
 STATIC struct dentry *
 xfs_fs_fh_to_parent(struct super_block *sb, struct fid *fid,
-		 int fh_len, int fileid_type)
+		 int fh_len, int fileid_type_flags)
 {
+	int			fileid_type = FILEID_TYPE(fileid_type_flags);
 	struct xfs_fid64	*fid64 = (struct xfs_fid64 *)fid;
 	struct inode		*inode = NULL;
+	uint			flags = 0;
+
+	if (fileid_type_flags & FILEID_CACHED)
+		flags = XFS_IGET_INCORE;
 
 	if (fh_len < xfs_fileid_length(fileid_type))
 		return NULL;
@@ -205,11 +222,11 @@ xfs_fs_fh_to_parent(struct super_block *sb, struct fid *fid,
 	switch (fileid_type) {
 	case FILEID_INO32_GEN_PARENT:
 		inode = xfs_nfs_get_inode(sb, fid->i32.parent_ino,
-					      fid->i32.parent_gen);
+					      fid->i32.parent_gen, flags);
 		break;
 	case FILEID_INO32_GEN_PARENT | XFS_FILEID_TYPE_64FLAG:
 		inode = xfs_nfs_get_inode(sb, fid64->parent_ino,
-					      fid64->parent_gen);
+					      fid64->parent_gen, flags);
 		break;
 	}
 
@@ -248,4 +265,5 @@ const struct export_operations xfs_export_operations = {
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
 #endif
+	.flags			= EXPORT_OP_NONBLOCK,
 };
diff --git a/fs/xfs/xfs_export.h b/fs/xfs/xfs_export.h
index 3cd85e8901a5..9addfcd5b1e1 100644
--- a/fs/xfs/xfs_export.h
+++ b/fs/xfs/xfs_export.h
@@ -57,6 +57,7 @@ struct xfs_fid64 {
 /* This flag goes on the wire.  Don't play with it. */
 #define XFS_FILEID_TYPE_64FLAG	0x80	/* NFS fileid has 64bit inodes */
 
-struct inode *xfs_nfs_get_inode(struct super_block *sb, u64 ino, u32 gen);
+struct inode *xfs_nfs_get_inode(struct super_block *sb, u64 ino, u32 gen,
+				uint flags);
 
 #endif	/* __XFS_EXPORT_H__ */
diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index f19fce557354..7d877ff504d6 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -193,7 +193,7 @@ xfs_khandle_to_inode(
 		return ERR_PTR(-EINVAL);
 
 	inode = xfs_nfs_get_inode(mp->m_super, handle->ha_fid.fid_ino,
-			handle->ha_fid.fid_gen);
+			handle->ha_fid.fid_gen, 0);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-- 
2.51.0


