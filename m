Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BA4A4F0C
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 19:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358697AbiAaS5o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 13:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350769AbiAaS5o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 13:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643655463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BmqQTpP7Ti7sWEQodfvEZZ7tU/bhgco+sYObBtILqY=;
        b=QkBANHKj5hV41cNeOzR1Jgidr6e6YOalxHQP096QoRg/rfDCeXsT0hgPhAbwRJ3fGSlPgH
        R2O1quO3pJ1SzBP1ga6UgurB6/V1oPgGREAn1PhQICTB/2Vm5NDOe+ZpFY2wOwy6fxYS5F
        2NGqhoqgsHHA3Q+Ks1OIuEB2gL+NdW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-HA6uXdRFNOSZ3IZgvoSnJw-1; Mon, 31 Jan 2022 13:57:39 -0500
X-MC-Unique: HA6uXdRFNOSZ3IZgvoSnJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3362161282;
        Mon, 31 Jan 2022 18:57:38 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D7984A24;
        Mon, 31 Jan 2022 18:57:38 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 430211A001E; Mon, 31 Jan 2022 13:57:37 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
Date:   Mon, 31 Jan 2022 13:57:36 -0500
Message-Id: <20220131185737.1640824-2-smayhew@redhat.com>
In-Reply-To: <20220131185737.1640824-1-smayhew@redhat.com>
References: <20220131185737.1640824-1-smayhew@redhat.com>
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
 security/selinux/hooks.c | 75 ++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4fc29..9645ff982ca5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -342,6 +342,10 @@ static void inode_free_security(struct inode *inode)
 
 struct selinux_mnt_opts {
 	const char *fscontext, *context, *rootcontext, *defcontext;
+	u32 fscontext_sid;
+	u32 context_sid;
+	u32 rootcontext_sid;
+	u32 defcontext_sid;
 };
 
 static void selinux_free_mnt_opts(void *mnt_opts)
@@ -598,15 +602,14 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
 	return 0;
 }
 
-static int parse_sid(struct super_block *sb, const char *s, u32 *sid,
-		     gfp_t gfp)
+static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
 {
 	int rc = security_context_str_to_sid(&selinux_state, s,
-					     sid, gfp);
+					     sid, GFP_KERNEL);
 	if (rc)
 		pr_warn("SELinux: security_context_str_to_sid"
 		       "(%s) failed for (dev %s, type %s) errno=%d\n",
-		       s, sb->s_id, sb->s_type->name, rc);
+		       s, sb ? sb->s_id : "?", sb ? sb->s_type->name : "?", rc);
 	return rc;
 }
 
@@ -673,8 +676,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	if (opts) {
 		if (opts->fscontext) {
-			rc = parse_sid(sb, opts->fscontext, &fscontext_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
@@ -683,8 +685,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			sbsec->flags |= FSCONTEXT_MNT;
 		}
 		if (opts->context) {
-			rc = parse_sid(sb, opts->context, &context_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->context, &context_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
@@ -693,8 +694,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			sbsec->flags |= CONTEXT_MNT;
 		}
 		if (opts->rootcontext) {
-			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
@@ -703,8 +703,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			sbsec->flags |= ROOTCONTEXT_MNT;
 		}
 		if (opts->defcontext) {
-			rc = parse_sid(sb, opts->defcontext, &defcontext_sid,
-					GFP_KERNEL);
+			rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
 			if (rc)
 				goto out;
 			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
@@ -996,21 +995,29 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		if (opts->context || opts->defcontext)
 			goto err;
 		opts->context = s;
+		if (selinux_initialized(&selinux_state))
+			parse_sid(NULL, s, &opts->context_sid);
 		break;
 	case Opt_fscontext:
 		if (opts->fscontext)
 			goto err;
 		opts->fscontext = s;
+		if (selinux_initialized(&selinux_state))
+			parse_sid(NULL, s, &opts->fscontext_sid);
 		break;
 	case Opt_rootcontext:
 		if (opts->rootcontext)
 			goto err;
 		opts->rootcontext = s;
+		if (selinux_initialized(&selinux_state))
+			parse_sid(NULL, s, &opts->rootcontext_sid);
 		break;
 	case Opt_defcontext:
 		if (opts->context || opts->defcontext)
 			goto err;
 		opts->defcontext = s;
+		if (selinux_initialized(&selinux_state))
+			parse_sid(NULL, s, &opts->defcontext_sid);
 		break;
 	}
 
@@ -2648,8 +2655,6 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct superblock_security_struct *sbsec = sb->s_security;
-	u32 sid;
-	int rc;
 
 	/*
 	 * Superblock not initialized (i.e. no options) - reject if any
@@ -2666,34 +2671,36 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
 
 	if (opts->fscontext) {
-		rc = parse_sid(sb, opts->fscontext, &sid, GFP_NOWAIT);
-		if (rc)
+		if (opts->fscontext_sid == SECSID_NULL)
 			return 1;
-		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+		else if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
+				       opts->fscontext_sid))
 			return 1;
 	}
 	if (opts->context) {
-		rc = parse_sid(sb, opts->context, &sid, GFP_NOWAIT);
-		if (rc)
+		if (opts->context_sid == SECSID_NULL)
 			return 1;
-		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+		else if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
+				       opts->context_sid))
 			return 1;
 	}
 	if (opts->rootcontext) {
-		struct inode_security_struct *root_isec;
-
-		root_isec = backing_inode_security(sb->s_root);
-		rc = parse_sid(sb, opts->rootcontext, &sid, GFP_NOWAIT);
-		if (rc)
-			return 1;
-		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+		if (opts->rootcontext_sid == SECSID_NULL)
 			return 1;
+		else {
+			struct inode_security_struct *root_isec;
+
+			root_isec = backing_inode_security(sb->s_root);
+			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
+				       opts->rootcontext_sid))
+				return 1;
+		}
 	}
 	if (opts->defcontext) {
-		rc = parse_sid(sb, opts->defcontext, &sid, GFP_NOWAIT);
-		if (rc)
+		if (opts->defcontext_sid == SECSID_NULL)
 			return 1;
-		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+		else if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
+				       opts->defcontext_sid))
 			return 1;
 	}
 	return 0;
@@ -2713,14 +2720,14 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
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
@@ -2729,14 +2736,14 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
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

