Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE931A6BD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhBLVUv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhBLVUl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 16:20:41 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19BC061574;
        Fri, 12 Feb 2021 13:20:01 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g9so500968ilc.3;
        Fri, 12 Feb 2021 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Y3RJK3vxi+QhNIpzjNBegnGJj+h/AGZkLMsaZUQL3o=;
        b=iig/5IGXEtufIDVHhOxGQDevi3GZk8c1kwaI4Ysh/5rMsTUxqckm8zEm0DSTW6iBDd
         aM8irtmQsmQc4BSeupA2Q0MjCb+xJfrhtG5HRpkacjt0swLzEEzXUGxIT+QaPvmVO6/0
         fzbCf4QSTw0siT6wjK2+A/k/Cq1BBUIkHk7hdNenz/Bz+wtIc63CkNKAx6AcH4CDE/d6
         UCYQJKdHFh582piBR01C+mhih8qIVhLx18kpiRMPHYvqhKjK9X78QfKXLUjdb0yNXsMG
         Z5Q3VMvFNKzJxXM11Hqf16Bb+Mpj8fnhHhOAHgBTQ7U+mI/7jffWq5HCA+ncCZkGOTUv
         hD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Y3RJK3vxi+QhNIpzjNBegnGJj+h/AGZkLMsaZUQL3o=;
        b=Yf6+TcbGYPQ+5G+MZlHbFFujApR5sbpFBAUcmeWKDxejqCLGTGyRCxKwBAdkzhGkts
         3V524YXZOOg8InEUoi85WQZt2+P4Sfeiy7xtZ338L1Ai2KWUp3l4EFCgfufCybjYmcW9
         iOsWeAyTocLhveUbhSfLelqnZm82x8qRtU6oePD78Zymia7h8BSDc1S1YnKBIOcZUnEP
         BXnaoi4vDCHTvb+ABUKbHu2oacBCDS2wEQlDGJ+FWTnyCpbZ/kiljIhmpE86MKjVFlOr
         7tNdrdd3koRJGPtLLtjClOVYtWspxbW9gzLI7A8+50d6rPVP2OhjtbOpuC1JA0bZnMA3
         w9Xg==
X-Gm-Message-State: AOAM5306aHAtuoP6XUOY1i6fBZ2B+qj4KeTf01AFa2cwCEA0uRXNR23N
        hhZ43xfr6rtnSLfBbqjgq2xgYjbQTaeh8w==
X-Google-Smtp-Source: ABdhPJx6/LwfGstOn9Ozmrb0FJGjAxVPAeNmwhx6imbh78LeKd7jSGl1RkQctVKo4ldRnX673XkG8Q==
X-Received: by 2002:a92:b011:: with SMTP id x17mr3844690ilh.179.1613164800672;
        Fri, 12 Feb 2021 13:20:00 -0800 (PST)
Received: from Olgas-MBP-444.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id k11sm4685570iop.45.2021.02.12.13.19.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2021 13:19:59 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH 1/2] [security] Add new hook to compare new mount to an existing mount
Date:   Fri, 12 Feb 2021 16:19:54 -0500
Message-Id: <20210212211955.11239-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a new hook that takes an existing super block and a new mount
with new options and determines if new options confict with an
existing mount or not.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  6 ++++
 include/linux/security.h      |  1 +
 security/security.c           |  7 +++++
 security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7aaa753b8608..fbfc07d0b3d5 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -62,6 +62,7 @@ LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
 LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
+LSM_HOOK(int, 0, sb_do_mnt_opts_match, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_kern_mount, struct super_block *sb)
 LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a19adef1f088..a11b062c1847 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -142,6 +142,12 @@
  *	@orig the original mount data copied from userspace.
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
+ * @sb_do_mnt_opts_match:
+ *	Determine if the existing mount options are compatible with the new
+ *	mount options being used.
+ *	@sb superblock being compared
+ *	@mnt_opts new mount options
+ *	Return 1 if options are the same.
  * @sb_remount:
  *	Extracts security system specific mount options and verifies no changes
  *	are being made to those options.
diff --git a/include/linux/security.h b/include/linux/security.h
index c35ea0ffccd9..07026db7304d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -291,6 +291,7 @@ int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 void security_free_mnt_opts(void **mnt_opts);
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts);
+int security_sb_do_mnt_opts_match(struct super_block *sb, void *mnt_opts);
 int security_sb_remount(struct super_block *sb, void *mnt_opts);
 int security_sb_kern_mount(struct super_block *sb);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
diff --git a/security/security.c b/security/security.c
index 7b09cfbae94f..dae380916c6a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -890,6 +890,13 @@ int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
 }
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 
+int security_sb_do_mnt_opts_match(struct super_block *sb,
+				 void *mnt_opts)
+{
+	return call_int_hook(sb_do_mnt_opts_match, 0, sb, mnt_opts);
+}
+EXPORT_SYMBOL(security_sb_do_mnt_opts_match);
+
 int security_sb_remount(struct super_block *sb,
 			void *mnt_opts)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 644b17ec9e63..aaa3a725da94 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	return rc;
 }
 
+static int selinux_sb_do_mnt_opts_match(struct super_block *sb, void *mnt_opts)
+{
+	struct selinux_mnt_opts *opts = mnt_opts;
+	struct superblock_security_struct *sbsec = sb->s_security;
+	u32 sid;
+	int rc;
+
+	/* superblock not initialized (i.e. no options) - reject if any
+	 * options specified, otherwise accept
+	 */
+	if (!(sbsec->flags & SE_SBINITIALIZED))
+		return opts ? 0 : 1;
+
+	/* superblock initialized and no options specified - reject if
+	 * superblock has any options set, otherwise accept
+	 */
+	if (!opts)
+		return (sbsec->flags & SE_MNTMASK) ? 0 : 1;
+
+	if (opts->fscontext) {
+		rc = parse_sid(sb, opts->fscontext, &sid);
+		if (rc)
+			return 0;
+		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+			return 0;
+	}
+	if (opts->context) {
+		rc = parse_sid(sb, opts->context, &sid);
+		if (rc)
+			return 0;
+		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+			return 0;
+	}
+	if (opts->rootcontext) {
+		struct inode_security_struct *root_isec;
+
+		root_isec = backing_inode_security(sb->s_root);
+		rc = parse_sid(sb, opts->rootcontext, &sid);
+		if (rc)
+			return 0;
+		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+			return 0;
+	}
+	if (opts->defcontext) {
+		rc = parse_sid(sb, opts->defcontext, &sid);
+		if (rc)
+			return 0;
+		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+			return 0;
+	}
+	return 1;
+}
+
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
@@ -6984,6 +7037,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
+	LSM_HOOK_INIT(sb_do_mnt_opts_match, selinux_sb_do_mnt_opts_match),
 	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
 	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
 	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
-- 
2.27.0

