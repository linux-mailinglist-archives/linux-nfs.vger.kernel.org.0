Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEC49561B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jan 2022 22:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377998AbiATVt6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jan 2022 16:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378012AbiATVt5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jan 2022 16:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642715396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rty4gjVzENPNVoxsZdxNcd5C7M5E9kOrqI2SunpngqI=;
        b=CEYqoU2JDu7zz65AEOgdxljvxpOR/n1f9PfS4jLCKC3LA/FXLZDHFBPZn3C78dHhUR+eve
        xGp2TzcL+t+OyIb/h61rf/5T/CrcpyCSWbPv2KQhvgnLe2jLp+QALDxzI4aNy0bus9o2U1
        dowEc4W90ovtDP5kW4Y42Tv5UEWSUSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-M-ApFgvZNMygeKnqcN2JFA-1; Thu, 20 Jan 2022 16:49:50 -0500
X-MC-Unique: M-ApFgvZNMygeKnqcN2JFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D530A1006AA4;
        Thu, 20 Jan 2022 21:49:49 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.8.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5928E710;
        Thu, 20 Jan 2022 21:49:49 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id DFFBF1A0021; Thu, 20 Jan 2022 16:49:48 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/2] selinux: try to use preparsed sid before calling parse_sid()
Date:   Thu, 20 Jan 2022 16:49:48 -0500
Message-Id: <20220120214948.3637895-3-smayhew@redhat.com>
In-Reply-To: <20220120214948.3637895-1-smayhew@redhat.com>
References: <20220120214948.3637895-1-smayhew@redhat.com>
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
 security/selinux/hooks.c | 85 ++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f27ca9e870c0..28ba5c8529fa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -677,36 +677,52 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	if (opts) {
 		if (opts->fscontext) {
-			rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
-			if (rc)
-				goto out;
+			if (opts->preparsed & FSCONTEXT_MNT)
+				fscontext_sid = opts->fscontext_sid;
+			else {
+				rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
 					fscontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= FSCONTEXT_MNT;
 		}
 		if (opts->context) {
-			rc = parse_sid(sb, opts->context, &context_sid);
-			if (rc)
-				goto out;
+			if (opts->preparsed & CONTEXT_MNT)
+				context_sid = opts->context_sid;
+			else {
+				rc = parse_sid(sb, opts->context, &context_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
 					context_sid))
 				goto out_double_mount;
 			sbsec->flags |= CONTEXT_MNT;
 		}
 		if (opts->rootcontext) {
-			rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->preparsed & ROOTCONTEXT_MNT)
+				rootcontext_sid = opts->rootcontext_sid;
+			else {
+				rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
 					rootcontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= ROOTCONTEXT_MNT;
 		}
 		if (opts->defcontext) {
-			rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
-			if (rc)
-				goto out;
+			if (opts->preparsed & DEFCONTEXT_MNT)
+				defcontext_sid = opts->defcontext_sid;
+			else {
+				rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
+				if (rc)
+					goto out;
+			}
 			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
 					defcontext_sid))
 				goto out_double_mount;
@@ -2753,32 +2769,48 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 		return 0;
 
 	if (opts->fscontext) {
-		rc = parse_sid(sb, opts->fscontext, &sid);
-		if (rc)
-			return rc;
+		if (opts->preparsed & FSCONTEXT_MNT)
+			sid = opts->fscontext_sid;
+		else {
+			rc = parse_sid(sb, opts->fscontext, &sid);
+			if (rc)
+				return rc;
+		}
 		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
 			goto out_bad_option;
 	}
 	if (opts->context) {
-		rc = parse_sid(sb, opts->context, &sid);
-		if (rc)
-			return rc;
+		if (opts->preparsed & CONTEXT_MNT)
+			sid = opts->context_sid;
+		else {
+			rc = parse_sid(sb, opts->context, &sid);
+			if (rc)
+				return rc;
+		}
 		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
 			goto out_bad_option;
 	}
 	if (opts->rootcontext) {
 		struct inode_security_struct *root_isec;
 		root_isec = backing_inode_security(sb->s_root);
-		rc = parse_sid(sb, opts->rootcontext, &sid);
-		if (rc)
-			return rc;
+		if (opts->preparsed & ROOTCONTEXT_MNT)
+			sid = opts->rootcontext_sid;
+		else {
+			rc = parse_sid(sb, opts->rootcontext, &sid);
+			if (rc)
+				return rc;
+		}
 		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
 			goto out_bad_option;
 	}
 	if (opts->defcontext) {
-		rc = parse_sid(sb, opts->defcontext, &sid);
-		if (rc)
-			return rc;
+		if (opts->preparsed & DEFCONTEXT_MNT)
+			sid = opts->defcontext_sid;
+		else {
+			rc = parse_sid(sb, opts->defcontext, &sid);
+			if (rc)
+				return rc;
+		}
 		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
 			goto out_bad_option;
 	}
@@ -2877,6 +2909,11 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 		if (!opts->defcontext)
 			return -ENOMEM;
 	}
+	opts->fscontext_sid = src->fscontext_sid;
+	opts->context_sid = src->context_sid;
+	opts->rootcontext_sid = src->rootcontext_sid;
+	opts->defcontext_sid = src->defcontext_sid;
+	opts->preparsed = src->preparsed;
 	return 0;
 }
 
-- 
2.31.1

