Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F119D320154
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 23:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBSWXQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 17:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhBSWXN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 17:23:13 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90497C061786;
        Fri, 19 Feb 2021 14:22:32 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id w1so5775738ilm.12;
        Fri, 19 Feb 2021 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q0+YHrjRMXzvo9iLbY6PGIPzvcsrQEDleY/dlymWrS4=;
        b=YFWc4yC60tG/hB7FPxDFuvX84iAywEhzR/Cj9+l6fqpTyGPa0769VBStMccU3Ex4PU
         t+LdxTgDJn2fjvQhx/jBj7kGJ3hBomlE5ReDTA66duaTttUdHL/Ocs7RkAPTXfD9qjoJ
         jm7AwcvD0ETNzITFS+F2FfxMwidF4y6/lW2NorzqnmvSU/SAc7k0hvNg72LoES5/lTFN
         H85V16B/3XegfPQaO5YTeEf2mdBle/tgKAcubaKx1+WG07gXpJWvKTx+k3xOKNqWnvlp
         lhjcJBuOe97vwdVrLBRG0DT4Nfq09q95MgaJKZydahG1ypa/kyrvg1N4j/RaoDh1ysoL
         6VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q0+YHrjRMXzvo9iLbY6PGIPzvcsrQEDleY/dlymWrS4=;
        b=nn1eM3NWXg4KNFju8cNSDZTIML6bbo62fclnOuj3oVDIWeuTRA6QPVXp+C4DwnKFay
         vjUDBclS9yBW3ap37d/EFueXRV+LLckTmvyfKgEoea32o4LmDEuD/Mmh/PD472vh6eCh
         YDWf6S+XWu5we2opgHtcBaSfhY5CdsHKuOQJpuO97khk7e+vknTPDYddhF3m8WxENYnq
         WNOKduUBVnkuP0alGpvPCryq6v7gaEc7gA2VRimKmKh9JVS2Bt7UKxUT2n6jxsA8jM7P
         JKFvPF1XOSNp6h/yXgc6KdDn0OUAOcPkowwtzUd8GpycmMOAKhET5dIJOltCwhvhTesX
         BIBg==
X-Gm-Message-State: AOAM533KO6u2YcRlLLQVf3dsgb2IRYyRHSQFP4QO4mbb06yV+0OBM8GB
        7uvh73DRNvsftb43ylC2xw4yGMQFHFSGfTo6
X-Google-Smtp-Source: ABdhPJwId1DPpjv7tYcWyMbbf9TN1n80isb3/NYN57vpJ46+HQBbP8UGFMU4hLvgY32ddCNZfeTcZA==
X-Received: by 2002:a05:6e02:16ca:: with SMTP id 10mr5887294ilx.28.1613773351935;
        Fri, 19 Feb 2021 14:22:31 -0800 (PST)
Received: from Olgas-MBP-470.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id b19sm8456290ioj.50.2021.02.19.14.22.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2021 14:22:31 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v3 1/3] [security] Add new hook to compare new mount to an existing mount
Date:   Fri, 19 Feb 2021 17:22:31 -0500
Message-Id: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
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
index a19adef1f088..d76aaecfdf0f 100644
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
+ *	Return 0 if options are compatible.
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

