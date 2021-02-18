Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB73A31F088
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 20:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhBRTyp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 14:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhBRTvb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 14:51:31 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB7C06178B;
        Thu, 18 Feb 2021 11:50:50 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y202so3289616iof.1;
        Thu, 18 Feb 2021 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w8UJ4sQYnldYSLPP1oOJXV2Y2PCrQBalzFE+Ud1Q69s=;
        b=H5NdCNpC7Mh60mh+N+Iyn88mkp6Ev4L2g9ZL/SCBw0Kzr9dZYsel8JMlI3B72dDcA6
         kqaWLN+9Uxf4MlKjNawz6BOrlGJdCRFArZ/IJyPKbh9Q0Hh4AIAJDngaOxJTGPZ/EbWn
         nbNaYfv6YLjqO4ZyHVBFMmqdchrOft5HQcBsIYBlDPAO3BmYw0DMkv+Ch0Wt3YDifMnM
         +9KBIo9iW5oEw0lWUXWVCNwhkAohbikmgOkkIvYl3bkSDHr4BgM8VffLOfiYQGokH8Bp
         BgR/qMjO8aKC1u8+DHdR2pujIXZLQ6xu9VTJDwu29YanNUleWfLo6sXnzLsYq9BrT8sx
         UPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w8UJ4sQYnldYSLPP1oOJXV2Y2PCrQBalzFE+Ud1Q69s=;
        b=auZKCk6TXwyx8q2BIK7gjr3Li/Jw/8IpSnN8I5tl7aTfsx6/nUkYH+QiQKlx+Um8Fi
         uctyiaCTVn1I5O4gpY3WhNlEanCgFsvomAEtOnwK+STX6+wigMoviqUi3tHRcYl5Bmhf
         bzu43sZXinr7sSPxsTepp0+LsZcHduS3S8UGtG+TCzMZS2AN7cr4mL4ezcZazputlZkO
         4pC1fcpnTEIV8aeqpW3ZjQwXpR5kCa2t4kZvidL1JATdybr7Df+XLoUdexT2aGaAs61g
         Srn/ujRPbNekrTZrplgSYN5mf7X1Ou1kcvbZzrTplcAdIoekMYEaWvOuMzRCug+DSAqY
         n/dw==
X-Gm-Message-State: AOAM533GcDtCyRp1/MMl8vQSrpAONTKqRiXLx9kdm5ztdWDqQifhCMSy
        l5FumKV8Qtsj9K4FOG3Z0cc=
X-Google-Smtp-Source: ABdhPJz68cKBjFEqnITSHmU9ujdPBectMwBqaHzjicdcAOArNG6rNXX2NnbjrQCKzgt4l3oqCR4c7w==
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr649442iof.57.1613677850115;
        Thu, 18 Feb 2021 11:50:50 -0800 (PST)
Received: from Olgas-MBP-470.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l7sm5264557ils.48.2021.02.18.11.50.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2021 11:50:49 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v2 1/2] [security] Add new hook to compare new mount to an existing mount
Date:   Thu, 18 Feb 2021 14:50:45 -0500
Message-Id: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a new hook that takes an existing super block and a new mount
with new options and determines if new options confict with an
existing mount or not.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
`
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  6 ++++
 include/linux/security.h      |  8 ++++++
 security/security.c           |  7 +++++
 security/selinux/hooks.c      | 54 +++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+)

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
index a19adef1f088..77c1e9cdeaca 100644
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
+ *	Return 0 if options are the same.
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
index 644b17ec9e63..f0b8ebc1e2c2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2656,6 +2656,59 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	return rc;
 }
 
+static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
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
+		return opts ? 1 : 0;
+
+	/* superblock initialized and no options specified - reject if
+	 * superblock has any options set, otherwise accept
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
@@ -6984,6 +7037,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
+	LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
 	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
 	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
 	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
-- 
2.27.0

