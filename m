Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006AD31FD75
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 17:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBSQ54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 11:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBSQ5z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 11:57:55 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F675C061574;
        Fri, 19 Feb 2021 08:57:15 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id f6so6310443ioz.5;
        Fri, 19 Feb 2021 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D3F3taZlJUSn5V/f9dCAzLIlaPHlCOcZIBWnJiBY/YA=;
        b=k6u2Y04j64Os602s5w7KcztshZ1k5mWJJHLRw1TbAJasWL9ehqJ5E1VSeJR613aj/O
         J30WJxgb1gI37bZNBH2Xrl5dkylGjuIYBpB8X7Qm9WfnX5O9823QUfLQe9MWGTGzGdJS
         LJes25J142CC4yMD21KxLgYT4PVc152LEfppOiiV6Chsi+kxKbE+6w1BPmFqUqUr20bU
         1cgxgZpaPh2aoc3pVdCHRdDfYOV3EKkhxOcVhs2nLy6hnYPQ7Uqdv2NYuvjhHuh6bUBv
         TRUIeW2kP1QBR9zzaZ1UVUOCTfz3s4qUA+pj5SBnQ4oEbEnbr0SxSYHI++2oiTp+qvCy
         QahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D3F3taZlJUSn5V/f9dCAzLIlaPHlCOcZIBWnJiBY/YA=;
        b=SQbpZcjy1KcySNEiDcxNMWD1ZytCe7rlCXPB0ZUvO1fJMB6h5DTALaObY8yaChTVHP
         8m0FQYHuCM6Ma6OfqHKCZt3R8fiPq+1VvfwW1oSGuxNLBnbJmlIsRaHrBskzIG6FkbX2
         gfr4ASObKELy/qsXViNhftzoQqerkcqr26N16LIgGrIxVPTLzOEpsL84g5KbKMgPl0az
         rKDUvcZfdMDiL1r07bz8C16Bypd0WgUJezC2075enjxGM1Nfgu1pL0Ng3IFTZD3xOb+f
         xMczuVG4JN5hVY56ZY429vQInkQp2/AIPAOfgjXo3scS7+7AiDGS1v0Rv5ekcy89/t/1
         1Lhw==
X-Gm-Message-State: AOAM533i9bRd55xaZjX/SJPeVQHHcbTywWLCqJ1sKdmgmewIbAZH9vrm
        rkc+bCh+0lSxyIq6iikoQNlEbkBTiKVQ2Q==
X-Google-Smtp-Source: ABdhPJzkO8KUsqTRUeQEbP6A/0dUNPOdoRhyoetZOdADp1F4DWdMY/wtGjh3SNudMdvGKhumCorKtQ==
X-Received: by 2002:a02:449:: with SMTP id 70mr10432185jab.137.1613753834588;
        Fri, 19 Feb 2021 08:57:14 -0800 (PST)
Received: from Olgas-MBP-470.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i6sm6749814ilu.70.2021.02.19.08.57.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2021 08:57:13 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v3 1/2] [security] Add new hook to compare new mount to an existing mount
Date:   Fri, 19 Feb 2021 11:57:14 -0500
Message-Id: <20210219165715.20324-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a new hook that takes an existing super block and a new mount
with new options and determines if new options confict with an
existing mount or not.

A filesystem can use this new hook to determine if it can share
the an existing superblock with a new superblock for the new mount.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  6 ++++
 include/linux/security.h      |  8 +++++
 security/security.c           |  7 +++++
 security/selinux/hooks.c      | 56 +++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7aaa753b8608..1b12a5266a51 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
 LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
+LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
 LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a19adef1f088..e2519adccb74 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -142,6 +142,12 @@
  *	@orig the original mount data copied from userspace.
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
+ * @sb_mnt_opts_compat:
+ *	Determine if the existing mount options are compatible with the new
+ *	mount options being used.
+ *	@sb superblock being compared
+ *	@mnt_opts new mount options
+ *	Return 0 if options are the compatible.
  * @sb_remount:
  *	Extracts security system specific mount options and verifies no changes
  *	are being made to those options.
diff --git a/include/linux/security.h b/include/linux/security.h
index c35ea0ffccd9..50db3d5d1608 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 void security_free_mnt_opts(void **mnt_opts);
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
+int security_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts);
 int security_sb_remount(struct super_block *sb, void *mnt_opts);
 int security_sb_kern_mount(struct super_block *sb);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
@@ -635,6 +636,13 @@ static inline int security_sb_remount(struct super_block *sb,
 	return 0;
 }
 
+static inline int security_sb_mnt_opts_compat(struct super_block *sb,
+					      void *mnt_opts)
+{
+	return 0;
+}
+
+
 static inline int security_sb_kern_mount(struct super_block *sb)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 7b09cfbae94f..56cf5563efde 100644
--- a/security/security.c
+++ b/security/security.c
@@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
 }
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 
+int security_sb_mnt_opts_compat(struct super_block *sb,
+				void *mnt_opts)
+{
+	return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
+}
+EXPORT_SYMBOL(security_sb_mnt_opts_compat);
+
 int security_sb_remount(struct super_block *sb,
 			void *mnt_opts)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 644b17ec9e63..afee3a222a0e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2656,6 +2656,61 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	return rc;
 }
 
+static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
+{
+	struct selinux_mnt_opts *opts = mnt_opts;
+	struct superblock_security_struct *sbsec = sb->s_security;
+	u32 sid;
+	int rc;
+
+	/*
+	 * Superblock not initialized (i.e. no options) - reject if any
+	 * options specified, otherwise accept.
+	 */
+	if (!(sbsec->flags & SE_SBINITIALIZED))
+		return opts ? 1 : 0;
+
+	/*
+	 * Superblock initialized and no options specified - reject if
+	 * superblock has any options set, otherwise accept.
+	 */
+	if (!opts)
+		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
+
+	if (opts->fscontext) {
+		rc = parse_sid(sb, opts->fscontext, &sid);
+		if (rc)
+			return 1;
+		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+			return 1;
+	}
+	if (opts->context) {
+		rc = parse_sid(sb, opts->context, &sid);
+		if (rc)
+			return 1;
+		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+			return 1;
+	}
+	if (opts->rootcontext) {
+		struct inode_security_struct *root_isec;
+
+		root_isec = backing_inode_security(sb->s_root);
+		rc = parse_sid(sb, opts->rootcontext, &sid);
+		if (rc)
+			return 1;
+		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+			return 1;
+	}
+	if (opts->defcontext) {
+		rc = parse_sid(sb, opts->defcontext, &sid);
+		if (rc)
+			return 1;
+		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+			return 1;
+	}
+	return 0;
+}
+
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
@@ -6984,6 +7039,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
+	LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
 	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
 	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
 	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
-- 
2.27.0

