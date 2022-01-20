Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20604495617
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jan 2022 22:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378001AbiATVtx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jan 2022 16:49:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377994AbiATVtx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jan 2022 16:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642715392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfgKaodlN9Lyf93BRAbcq71NjLq5mLWN//fkUxBkn4U=;
        b=VrtaRkVjIqUmSeJ0yoZwFDI768pr8ok/yPJP2KBkl6SvKYILuj0yIZzkNH2B42tYPsHqj9
        BUYgecd+vPo+nrQ9+cv/7fOgk7B06nMvXNXBrZNg/5tCXwp/8OEsfnis6ti3INCyh4N4Fr
        b7sUk0N2/h9MOpP8EN/MVNVr2CsH4iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-Le2TFKmPMzKWLU4fsGgoaQ-1; Thu, 20 Jan 2022 16:49:50 -0500
X-MC-Unique: Le2TFKmPMzKWLU4fsGgoaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5952343C9;
        Thu, 20 Jan 2022 21:49:49 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.8.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A20F94D732;
        Thu, 20 Jan 2022 21:49:49 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id DD0FC1A001E; Thu, 20 Jan 2022 16:49:48 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
Date:   Thu, 20 Jan 2022 16:49:47 -0500
Message-Id: <20220120214948.3637895-2-smayhew@redhat.com>
In-Reply-To: <20220120214948.3637895-1-smayhew@redhat.com>
References: <20220120214948.3637895-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
shouldn't be performing any memory allocations.  Fix this by parsing the
sids at the same time we're chopping up the security mount options
string and then using the pre-parsed sids when doing the comparison.

Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 36 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4fc29..f27ca9e870c0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -342,6 +342,11 @@ static void inode_free_security(struct inode *inode)
 
 struct selinux_mnt_opts {
 	const char *fscontext, *context, *rootcontext, *defcontext;
+	u32 fscontext_sid;
+	u32 context_sid;
+	u32 rootcontext_sid;
+	u32 defcontext_sid;
+	unsigned short preparsed;
 };
 
 static void selinux_free_mnt_opts(void *mnt_opts)
@@ -598,12 +603,11 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
 	return 0;
 }
 
-static int parse_sid(struct super_block *sb, const char *s, u32 *sid,
-		     gfp_t gfp)
+static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
 {
 	int rc = security_context_str_to_sid(&selinux_state, s,
-					     sid, gfp);
-	if (rc)
+					     sid, GFP_KERNEL);
+	if (rc && sb != NULL)
 		pr_warn("SELinux: security_context_str_to_sid"
 		       "(%s) failed for (dev %s, type %s) errno=%d\n",
 		       s, sb->s_id, sb->s_type->name, rc);
@@ -673,8 +677,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	if (opts) {
 		if (opts->fscontext) {
-			rc = parse_sid(sb, opts->fscontext, &fscontext_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
@@ -683,8 +686,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			sbsec->flags |= FSCONTEXT_MNT;
 		}
 		if (opts->context) {
-			rc = parse_sid(sb, opts->context, &context_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->context, &context_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
@@ -693,8 +695,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			sbsec->flags |= CONTEXT_MNT;
 		}
 		if (opts->rootcontext) {
-			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
@@ -703,8 +704,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			sbsec->flags |= ROOTCONTEXT_MNT;
 		}
 		if (opts->defcontext) {
-			rc = parse_sid(sb, opts->defcontext, &defcontext_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
@@ -976,6 +976,9 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct selinux_mnt_opts *opts = *mnt_opts;
 	bool is_alloc_opts = false;
+	bool preparse_sid = false;
+	u32 sid;
+	int rc;
 
 	if (token == Opt_seclabel)
 		/* eaten and completely ignored */
@@ -991,26 +994,57 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		is_alloc_opts = true;
 	}
 
+	if (selinux_initialized(&selinux_state))
+		preparse_sid = true;
+
 	switch (token) {
 	case Opt_context:
 		if (opts->context || opts->defcontext)
 			goto err;
 		opts->context = s;
+		if (preparse_sid) {
+			rc = parse_sid(NULL, s, &sid);
+			if (rc == 0) {
+				opts->context_sid = sid;
+				opts->preparsed |= CONTEXT_MNT;
+			}
+		}
 		break;
 	case Opt_fscontext:
 		if (opts->fscontext)
 			goto err;
 		opts->fscontext = s;
+		if (preparse_sid) {
+			rc = parse_sid(NULL, s, &sid);
+			if (rc == 0) {
+				opts->fscontext_sid = sid;
+				opts->preparsed |= FSCONTEXT_MNT;
+			}
+		}
 		break;
 	case Opt_rootcontext:
 		if (opts->rootcontext)
 			goto err;
 		opts->rootcontext = s;
+		if (preparse_sid) {
+			rc = parse_sid(NULL, s, &sid);
+			if (rc == 0) {
+				opts->rootcontext_sid = sid;
+				opts->preparsed |= ROOTCONTEXT_MNT;
+			}
+		}
 		break;
 	case Opt_defcontext:
 		if (opts->context || opts->defcontext)
 			goto err;
 		opts->defcontext = s;
+		if (preparse_sid) {
+			rc = parse_sid(NULL, s, &sid);
+			if (rc == 0) {
+				opts->defcontext_sid = sid;
+				opts->preparsed |= DEFCONTEXT_MNT;
+			}
+		}
 		break;
 	}
 
@@ -2648,8 +2682,6 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct superblock_security_struct *sbsec = sb->s_security;
-	u32 sid;
-	int rc;
 
 	/*
 	 * Superblock not initialized (i.e. no options) - reject if any
@@ -2666,35 +2698,43 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
 
 	if (opts->fscontext) {
-		rc = parse_sid(sb, opts->fscontext, &sid, GFP_NOWAIT);
-		if (rc)
-			return 1;
-		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+		if (opts->preparsed & FSCONTEXT_MNT) {
+			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
+				       opts->fscontext_sid))
+				return 1;
+		} else {
 			return 1;
+		}
 	}
 	if (opts->context) {
-		rc = parse_sid(sb, opts->context, &sid, GFP_NOWAIT);
-		if (rc)
-			return 1;
-		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+		if (opts->preparsed & CONTEXT_MNT) {
+			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
+				       opts->context_sid))
+				return 1;
+		} else {
 			return 1;
+		}
 	}
 	if (opts->rootcontext) {
-		struct inode_security_struct *root_isec;
+		if (opts->preparsed & ROOTCONTEXT_MNT) {
+			struct inode_security_struct *root_isec;
 
-		root_isec = backing_inode_security(sb->s_root);
-		rc = parse_sid(sb, opts->rootcontext, &sid, GFP_NOWAIT);
-		if (rc)
-			return 1;
-		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+			root_isec = backing_inode_security(sb->s_root);
+			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
+				       opts->rootcontext_sid))
+				return 1;
+		} else {
 			return 1;
+		}
 	}
 	if (opts->defcontext) {
-		rc = parse_sid(sb, opts->defcontext, &sid, GFP_NOWAIT);
-		if (rc)
-			return 1;
-		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+		if (opts->preparsed & DEFCONTEXT_MNT) {
+			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
+				       opts->defcontext_sid))
+				return 1;
+		} else {
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -2713,14 +2753,14 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 		return 0;
 
 	if (opts->fscontext) {
-		rc = parse_sid(sb, opts->fscontext, &sid, GFP_KERNEL);
+		rc = parse_sid(sb, opts->fscontext, &sid);
 		if (rc)
 			return rc;
 		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
 			goto out_bad_option;
 	}
 	if (opts->context) {
-		rc = parse_sid(sb, opts->context, &sid, GFP_KERNEL);
+		rc = parse_sid(sb, opts->context, &sid);
 		if (rc)
 			return rc;
 		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
@@ -2729,14 +2769,14 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 	if (opts->rootcontext) {
 		struct inode_security_struct *root_isec;
 		root_isec = backing_inode_security(sb->s_root);
-		rc = parse_sid(sb, opts->rootcontext, &sid, GFP_KERNEL);
+		rc = parse_sid(sb, opts->rootcontext, &sid);
 		if (rc)
 			return rc;
 		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
 			goto out_bad_option;
 	}
 	if (opts->defcontext) {
-		rc = parse_sid(sb, opts->defcontext, &sid, GFP_KERNEL);
+		rc = parse_sid(sb, opts->defcontext, &sid);
 		if (rc)
 			return rc;
 		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
-- 
2.31.1

