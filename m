Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A54A4F0E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 19:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359548AbiAaS6A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 13:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358771AbiAaS5p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 13:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643655464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ed3hVQ48RMb2MFp4ZsSa5NSDyBIXulmD20K/MbtpUpk=;
        b=ZMf+D2WzSI3XksjuJfW+rIAS+Kv23z4EwJ4xmSVRnoGuylyKdPLLfk/MrjCzVrsfdOl5jg
        T2SSfVNgWh4rFAmDvftcI65rIxPNd0Jv7nTdG4e3Uadvln5FL2iMDzs9pgmhONcGsB+5ey
        ofWXZICKERHXGWKVTaUH6fnysmwoIWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-1llfo-CJMBG_0whZZL0v8w-1; Mon, 31 Jan 2022 13:57:39 -0500
X-MC-Unique: 1llfo-CJMBG_0whZZL0v8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BEA81091DA9;
        Mon, 31 Jan 2022 18:57:38 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04CF038E05;
        Mon, 31 Jan 2022 18:57:38 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 460891A0021; Mon, 31 Jan 2022 13:57:37 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] selinux: try to use preparsed sid before calling parse_sid()
Date:   Mon, 31 Jan 2022 13:57:37 -0500
Message-Id: <20220131185737.1640824-3-smayhew@redhat.com>
In-Reply-To: <20220131185737.1640824-1-smayhew@redhat.com>
References: <20220131185737.1640824-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Avoid unnecessary parsing of sids that have already been parsed via
selinux_sb_eat_lsm_opts().

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 security/selinux/hooks.c | 88 +++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 29 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9645ff982ca5..05d24b7a68cf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -676,36 +676,48 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	if (opts) {
 		if (opts->fscontext) {
-			rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
-			if (rc)
-				goto out;
+			if (opts->fscontext_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
+				if (rc)
+					goto out;
+			} else
+				fscontext_sid = opts->fscontext_sid;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
 					fscontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= FSCONTEXT_MNT;
 		}
 		if (opts->context) {
-			rc = parse_sid(sb, opts->context, &context_sid);
-			if (rc)
-				goto out;
+			if (opts->context_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->context, &context_sid);
+				if (rc)
+					goto out;
+			} else
+				context_sid = opts->context_sid;
 			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
 					context_sid))
 				goto out_double_mount;
 			sbsec->flags |= CONTEXT_MNT;
 		}
 		if (opts->rootcontext) {
-			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->rootcontext_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
+				if (rc)
+					goto out;
+			} else
+				rootcontext_sid = opts->rootcontext_sid;
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
 					rootcontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= ROOTCONTEXT_MNT;
 		}
 		if (opts->defcontext) {
-			rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->defcontext_sid == SECSID_NULL) {
+				rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
+				if (rc)
+					goto out;
+			} else
+				defcontext_sid = opts->defcontext_sid;
 			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
 					defcontext_sid))
 				goto out_double_mount;
@@ -2710,7 +2722,6 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
-	u32 sid;
 	int rc;
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
@@ -2720,33 +2731,48 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 		return 0;
 
 	if (opts->fscontext) {
-		rc = parse_sid(sb, opts->fscontext, &sid);
-		if (rc)
-			return rc;
-		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+		if (opts->fscontext_sid == SECSID_NULL) {
+			rc = parse_sid(sb, opts->fscontext,
+				       &opts->fscontext_sid);
+			if (rc)
+				return rc;
+		}
+		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
+			       opts->fscontext_sid))
 			goto out_bad_option;
 	}
 	if (opts->context) {
-		rc = parse_sid(sb, opts->context, &sid);
-		if (rc)
-			return rc;
-		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+		if (opts->context_sid == SECSID_NULL) {
+			rc = parse_sid(sb, opts->context, &opts->context_sid);
+			if (rc)
+				return rc;
+		}
+		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
+			       opts->context_sid))
 			goto out_bad_option;
 	}
 	if (opts->rootcontext) {
 		struct inode_security_struct *root_isec;
 		root_isec = backing_inode_security(sb->s_root);
-		rc = parse_sid(sb, opts->rootcontext, &sid);
-		if (rc)
-			return rc;
-		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+		if (opts->rootcontext_sid == SECSID_NULL) {
+			rc = parse_sid(sb, opts->rootcontext,
+				       &opts->rootcontext_sid);
+			if (rc)
+				return rc;
+		}
+		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
+			       opts->rootcontext_sid))
 			goto out_bad_option;
 	}
 	if (opts->defcontext) {
-		rc = parse_sid(sb, opts->defcontext, &sid);
-		if (rc)
-			return rc;
-		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+		if (opts->defcontext_sid == SECSID_NULL) {
+			rc = parse_sid(sb, opts->defcontext,
+				       &opts->defcontext_sid);
+			if (rc)
+				return rc;
+		}
+		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
+			       opts->defcontext_sid))
 			goto out_bad_option;
 	}
 	return 0;
@@ -2844,6 +2870,10 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 		if (!opts->defcontext)
 			return -ENOMEM;
 	}
+	opts->fscontext_sid = src->fscontext_sid;
+	opts->context_sid = src->context_sid;
+	opts->rootcontext_sid = src->rootcontext_sid;
+	opts->defcontext_sid = src->defcontext_sid;
 	return 0;
 }
 
-- 
2.31.1

