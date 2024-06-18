Return-Path: <linux-nfs+bounces-3992-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445A190D75F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E579F1F23953
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B3612E6D;
	Tue, 18 Jun 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="KWtQF1rk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CF31758
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724800; cv=none; b=Crs3avyd8h7LwMlL9jkKKQ5CKZbbX8KgRtXg6noajvQZTtqH6IV/1l6JDi95BiG6BAlso68ZJ4CtD4DkXcPf0mKuO/ccH+Z+L6AeW+uJTe1XRoYNzIi4KJ6LkZ2GF25JcKb8A9G57CmtdUFuql7bJTZjChm5iLD6whZWuYqrOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724800; c=relaxed/simple;
	bh=RNjlrFFVPSujGH09kqombRGvi+AKKB7KPqq/tcrH/WA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=R6vggl/VfGolaEeKoEJRpyED9PZI2oB7Q7jlDCP0MEibatqeI+0paToAMAq2935TgCFhHMiX2VVB46GdEwgG8vfcf4z0fynOQct0MJFAOGUmwJbuUsG5ZZiwZvN9ifL3oC7xcRnlIb1UnRU+W33DbuefDswj6zOVxxuoyk7cUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=KWtQF1rk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4217d451f69so45388995e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1718724795; x=1719329595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDSZpjPNtUBNzabvFMhFZvD2BWHNGMDzGJ7x5V+7yZg=;
        b=KWtQF1rknSwLa8f78ZyKl9Fm5iLA3FZG1f3E0ZVqcZBgCNY8BveaVaIFg1GAZtOpGF
         bsxhgfFyGZPVMiFdVs7m04vI7b4jhY939i1aUZsQqB0Q9MeFNdb1J6CclJ/6oP0Q1miY
         V1sIMVXxBdEgVXl3/PANS4u3Tj2hKWQTzT2bjTXd5jXbpRPkq5jYtA3Nhax3lyrP1DIk
         DdJEIRyMz6RJ8hAD4YUB4H+F4cVVFGYLNZgxtCmC2PM346dv8vC2vGrKI39lDlQLShNf
         jKQot1ysrYXcrjN3aLYkXjsepo/uhjabie5l0L5cNYXQLN6bpPTmni1Azgh5UePsWN1E
         FwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724795; x=1719329595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDSZpjPNtUBNzabvFMhFZvD2BWHNGMDzGJ7x5V+7yZg=;
        b=kNmp2neCMbw4iave9GV41mP/JO7uu7Uy5SXkgdlraHJ+ce19Y7tBV7Fnw9mysIgxd8
         HTg3aTExrycLgLtZMWei4nQPwesVi47gba+3Hv3I6yrwfJUui0SxpKvuKZbD3M5pg8bA
         l51B315X0pAY4yWITME1yiJ7W1zuqjGfB+VQnMyRLZcw0ijcZSpuA12BPQaEOdTLFjW9
         KPqXM0icI1fhGH1HI3cHxen2SeFYp3Zz0IgaglXdPmYjufs2C7jbf8/5epWQS4C1vXA6
         tc+IVfcoGDQM9YLDMKrMOqIUs7sNnCfuorGHS934NzA9/c5mrPjPOeVEmJGCHYvcd6I+
         tUxA==
X-Gm-Message-State: AOJu0YxTNQWnJaYLUL1GLr2kLSeCFsTucZLvxmd9OiYdl6P0umOaDZMI
	2Zyyf2EAj+ExzVJz0wySIrLfjBNSXNDEr+WB1ceaPCkEV4M++F3Vf+7B8mIMstzJBh2AvVFLzGM
	g
X-Google-Smtp-Source: AGHT+IEkKljHyLkzWI7iXX3SG1e4bbddBm4Yx0zkXiUSLmSwLkOZUs9B/a7LKKrOsyrw+T5d+8w0bw==
X-Received: by 2002:a05:600c:243:b0:424:7490:23f0 with SMTP id 5b1f17b1804b1-424749024b9mr4520125e9.38.1718724795208;
        Tue, 18 Jun 2024 08:33:15 -0700 (PDT)
Received: from jupiter.vstd.int ([176.230.79.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de653sm236666925e9.32.2024.06.18.08.33.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:33:14 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes' prevention
Date: Tue, 18 Jun 2024 18:33:13 +0300
Message-Id: <20240618153313.3167460-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some applications that write to predefined non-overlapping
file offsets from multiple clients and therefore don't need to rely on
file locking. However, NFS file system behavior of extending writes to
to deal with write fragmentation, causes those clients to corrupt each
other's data.

To help these applications, this change adds the `noextend` parameter to
the mount options, and handles this case in `nfs_can_extend_write`.

Clients can additionally add the 'noac' option to ensure page cache
flush on read for modified files.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfs/fs_context.c       | 8 ++++++++
 fs/nfs/super.c            | 3 +++
 fs/nfs/write.c            | 3 +++
 include/linux/nfs_fs_sb.h | 1 +
 4 files changed, 15 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 6c9f3f6645dd..509718bc5b24 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -49,6 +49,7 @@ enum nfs_param {
 	Opt_bsize,
 	Opt_clientaddr,
 	Opt_cto,
+	Opt_extend,
 	Opt_fg,
 	Opt_fscache,
 	Opt_fscache_flag,
@@ -149,6 +150,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_u32   ("bsize",		Opt_bsize),
 	fsparam_string("clientaddr",	Opt_clientaddr),
 	fsparam_flag_no("cto",		Opt_cto),
+	fsparam_flag_no("extend",	Opt_extend),
 	fsparam_flag  ("fg",		Opt_fg),
 	fsparam_flag_no("fsc",		Opt_fscache_flag),
 	fsparam_string("fsc",		Opt_fscache),
@@ -592,6 +594,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		else
 			ctx->flags |= NFS_MOUNT_TRUNK_DISCOVERY;
 		break;
+	case Opt_extend:
+		if (result.negated)
+			ctx->flags |= NFS_MOUNT_NO_EXTEND;
+		else
+			ctx->flags &= ~NFS_MOUNT_NO_EXTEND;
+		break;
 	case Opt_ac:
 		if (result.negated)
 			ctx->flags |= NFS_MOUNT_NOAC;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index cbbd4866b0b7..f27fd3858913 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -549,6 +549,9 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	else
 		seq_puts(m, ",local_lock=posix");
 
+	if (nfss->flags & NFS_MOUNT_NO_EXTEND)
+		seq_puts(m, ",noextend");
+
 	if (nfss->flags & NFS_MOUNT_WRITE_EAGER) {
 		if (nfss->flags & NFS_MOUNT_WRITE_WAIT)
 			seq_puts(m, ",write=wait");
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..ed76c317b349 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1315,7 +1315,10 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct file_lock *fl;
 	int ret;
+	unsigned int mntflags = NFS_SERVER(inode)->flags;
 
+	if (mntflags & NFS_MOUNT_NO_EXTEND)
+		return 0;
 	if (file->f_flags & O_DSYNC)
 		return 0;
 	if (!nfs_folio_write_uptodate(folio, pagelen))
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..f6d8a4f63e50 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -157,6 +157,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
 #define NFS_MOUNT_SHUTDOWN			0x08000000
+#define NFS_MOUNT_NO_EXTEND		0x10000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.39.3


