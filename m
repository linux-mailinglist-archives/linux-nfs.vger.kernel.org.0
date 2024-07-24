Return-Path: <linux-nfs+bounces-5029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3993B018
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 13:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3C81F24916
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D2152180;
	Wed, 24 Jul 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="TTj0+6Qx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DC2595
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819239; cv=none; b=bKSrGlrMePi1AcOjh1s8Fghg2sfBljlzfhcpp4T1J3L6MQknT0Q05k9wBucB9g7tugxU4KiWuDWVflHaZz03fne67q+AxIxb3mntkO3hzU98FzxwodLPKYH6f7CmQyeQWVQwarDwG5dm9hsKikn2Bex3N1e5A7f64uzc08kuamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819239; c=relaxed/simple;
	bh=ZTasRongqyqj3vRZoqH/qpy7XdSAHrqHYEOEbvBhPHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzsbqWbfMiWuJiGgb3fzUYNqLDvFyuN/UdDaPX5HE4H130uNYubqAME27H+Ji0K/jpiJv7K3ofsvXdPn/qNljlvMcpY3YGXC0PcvdNDCShQRq/uB143/rZg59XGFzgKw49oS6YsORqSduBrf59tWKDcP7Hg5oycuNsOHS4hVipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=TTj0+6Qx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368663d7f80so3669831f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1721819234; x=1722424034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jzvuavcpGZrWPbwj7dn22fGuNw5c0dOtsAh21vedzM=;
        b=TTj0+6QxwcnG5msE6TlN9IiuqUhjhfxp5UPV+i7EAcGU8S+Y6caxSgk7nKj0z8sjex
         q+JoNCqu+7fFz7fudVvU8qqe22aMNHUi6EqsJrnDmRR/HA+R3y8G3dXFN2Po7QrstwVP
         ort+Pp+qV7lF5TpoO8YzEOlLF3sekapo4L90lATmxXcOabmZd3A86YcnAcm9fRIo7DbW
         EywjL+0aievAIj9yDSjmchbhUlsgqbVCK58vMG32Z1eA9MWOeSPPZj4EGGoM7ACd99mU
         v1SH5Fb0Dpbn37VLxvS1ZLmqi2NvgLB9PMbgZx9oOHqkmcl1qf0G1VtL9pD5mv4cO+Jm
         D08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721819234; x=1722424034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jzvuavcpGZrWPbwj7dn22fGuNw5c0dOtsAh21vedzM=;
        b=Ae2zL1mIsUoqFkJmmrkoEX/bITdqAxlqWMWqkLshPwNDhGlG0yWXZOOydHMlEMW6Gk
         kryRMSjZtHo+Fwy0c7515d2EvaMdoZ2WxctfS2twG37kmv31Ie4FHgVK0KxZ/XhnNTfa
         0V7TTrM3prGVYyPn6sX7NMv6XxFzCNC6BikUav/v9MjMLKZnZR+Ra7RoOwmm5Yqx/wdQ
         gnrYjcNiiW82FqQWMcRDp6Tzi82fRqTF3997sORIZP7jH0+J26S1zBopthcHvtqZ1sdg
         bp9DEQ1nNQUxGOp1gck0j7HRZzzOrsGlp6R/+Sr6VE4Wz3GgzZYu+aPKcu4bJFq2oA2q
         BdCg==
X-Gm-Message-State: AOJu0YwUeMjAo23TO8XsOUpq72GE/zbKWix5MGSdxCaPPyJD1glVvUxa
	92E3eTl6apZUU5rC/CB/v6v5PUvxa0HyvsyRsgwXvFwKg5zwkvZPnsZGSPOg28OYtJSY0OsIB8p
	fsuo=
X-Google-Smtp-Source: AGHT+IFARlIxX8qgckf5MzPBxmEAa5z9Bn/OXQNud6pmsaeM6/U6Lu2G46pxm4Uw1bdqzoK+NhNFPA==
X-Received: by 2002:a5d:5f96:0:b0:367:9854:791d with SMTP id ffacd0b85a97d-369f5b8b7dcmr1376257f8f.43.1721819233933;
        Wed, 24 Jul 2024 04:07:13 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ed281sm13933659f8f.102.2024.07.24.04.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 04:07:13 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nfs: add 'noalignwrite' option for lock-less 'lost writes' prevention
Date: Wed, 24 Jul 2024 14:07:12 +0300
Message-ID: <20240724110712.2600130-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some applications that write to predefined non-overlapping
file offsets from multiple clients and therefore don't need to rely on
file locking. However, if these applications want non-aligned offsets
and sizes they need to either use locks or risk data corruption, as the
NFS client defaults to extending writes to whole pages.

This commit adds a new mount option `noalignwrite`, which allows to turn
that off and avoid the need of locking, as long as these applications
don't overlap on offsets.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfs/fs_context.c       | 8 ++++++++
 fs/nfs/super.c            | 3 +++
 fs/nfs/write.c            | 3 +++
 include/linux/nfs_fs_sb.h | 1 +
 4 files changed, 15 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 6c9f3f6645dd..7e000d782e28 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -49,6 +49,7 @@ enum nfs_param {
 	Opt_bsize,
 	Opt_clientaddr,
 	Opt_cto,
+	Opt_alignwrite,
 	Opt_fg,
 	Opt_fscache,
 	Opt_fscache_flag,
@@ -149,6 +150,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_u32   ("bsize",		Opt_bsize),
 	fsparam_string("clientaddr",	Opt_clientaddr),
 	fsparam_flag_no("cto",		Opt_cto),
+	fsparam_flag_no("alignwrite",	Opt_alignwrite),
 	fsparam_flag  ("fg",		Opt_fg),
 	fsparam_flag_no("fsc",		Opt_fscache_flag),
 	fsparam_string("fsc",		Opt_fscache),
@@ -592,6 +594,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		else
 			ctx->flags |= NFS_MOUNT_TRUNK_DISCOVERY;
 		break;
+	case Opt_alignwrite:
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NO_ALIGNWRITE;
+		else
+			ctx->flags &= ~NFS_MOUNT_NO_ALIGNWRITE;
+		break;
 	case Opt_ac:
 		if (result.negated)
 			ctx->flags |= NFS_MOUNT_NOAC;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index cbbd4866b0b7..1382ae19bba4 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -549,6 +549,9 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	else
 		seq_puts(m, ",local_lock=posix");
 
+	if (nfss->flags & NFS_MOUNT_NO_ALIGNWRITE)
+		seq_puts(m, ",noalignwrite");
+
 	if (nfss->flags & NFS_MOUNT_WRITE_EAGER) {
 		if (nfss->flags & NFS_MOUNT_WRITE_WAIT)
 			seq_puts(m, ",write=wait");
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..cfe8061bf005 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1315,7 +1315,10 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct file_lock *fl;
 	int ret;
+	unsigned int mntflags = NFS_SERVER(inode)->flags;
 
+	if (mntflags & NFS_MOUNT_NO_ALIGNWRITE)
+		return 0;
 	if (file->f_flags & O_DSYNC)
 		return 0;
 	if (!nfs_folio_write_uptodate(folio, pagelen))
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..4d28b4a328a7 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -157,6 +157,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
 #define NFS_MOUNT_SHUTDOWN			0x08000000
+#define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.43.5


