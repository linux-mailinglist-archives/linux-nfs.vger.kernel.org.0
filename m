Return-Path: <linux-nfs+bounces-7174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5E99D880
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949461F21949
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B541D12E6;
	Mon, 14 Oct 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1HEQULa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE41D1318
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939040; cv=none; b=EBlnDzELSkKPnzbSivAJ7RGTVh2O52Y6Yw2TKybv7ZlHZxJgGOW0scdws2Ok348qa01RvhCsootZWQlirvyDOssG3w0SbAZ7olF3Kf2Wc9gHZoHWGAb6XElxDJ5i8IyVToLa6lkUIbaBsSsAcZplgMHAaZG9vLHc/i9pBjnijX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939040; c=relaxed/simple;
	bh=HlqGssIt3+GgeWSoa7cHHow5dp3EnztPYYyzAk8xGn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGr3HzE6X7FIzPGGjmuS/MeNIg9sPw9TqC+MWEQIPOjZfBwYYKRzBr2J80m2ul2aoWe+6YB+PkET+IGej5tddpa4d6itYzBhzIUHEbyIUYmTrgYUFZKZVY9L6agD8CGsaqWId0At0cgLuSooO3AynylvD13JEyj0fUopsg1TsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1HEQULa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2642C4CEC6;
	Mon, 14 Oct 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939040;
	bh=HlqGssIt3+GgeWSoa7cHHow5dp3EnztPYYyzAk8xGn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i1HEQULald2ITG7AgFlS84W98rCobBp7W92B4CX7aGhKxn8cjxcdgLVpullrASHrK
	 8n3aFPK5I6YC4a7zluh5bgPHSoA3mNqlY3l8dIqu3zZllHyuZUHUcHbgchY2Whf1gB
	 vQtrsLbUvJg1RtCZYPcOywWHNdxgkvUcpP2O0TjpFYZl5iEHK3kdBXwK/1uJk8F5I/
	 MPqhIueOy6Vyj+UdPGRj1LhJ/Dr5AHqkmO0pfYNd4lX8R2tibeyG61jhFVzzB8alKZ
	 Cnov8RaRKEW//5tvaaUGV7zCT1wcEzf03iJp4mzzaCxuXA7dzidfvjI7a/aN/jMwN6
	 sx3oerthUGv8A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 16:50:26 -0400
Subject: [PATCH pynfs v2 6/7] nfs4.1: add support for the "delstid" draft
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-cb_getattr-v2-6-3782e0d7c598@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5797; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HlqGssIt3+GgeWSoa7cHHow5dp3EnztPYYyzAk8xGn8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDYQcmtS2LOmczu4cDPr2Eik+vMqEhswMFHpGy
 /vX+nyaQ1mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw2EHAAKCRAADmhBGVaC
 FX+gEACg0v2ntGPhF0CXxhn11bs5dniHJyURKe9a+YyErwD2gj44hlpSMPhfxKT4WKfqWQQ8Ac5
 6dV2Ic0lyCrveO7OC01i4+k+32ygeWrK7ee15wUBknbgUOMbLdqiI3bqIZwvmhCwGcKiZPnnWY9
 gM3rQgEjjIOX1EkfAA3nNRxEuGTt9AcrKOcubZtrkaktKuat9AWpjprTJFU2BiKFtM01PNLER7v
 yOhspimgN2asgP1SKUoj9kdv4lYcYC2OX2ZsicvzOnF6aQtRhZPvT5uCOOHcoVv3MUoKduKroO6
 jRuT0XtIl69sHHAkOjRwp//HMChxncDpK454SC43v9hEdVr2vIXl9o7C2GW510PkU5Z/0ylToZX
 F/OQ0rVDStSvO1aL6l2SgVDLuZN9QFqCoDOnz+YqXmxu7SSM7BYzwXY2WJgxg0qwpFqDik4YY3d
 7YB1qTAJRV2X3dUNjhC1lWRj5Uypq1Wr5QVxuPZgpH80Yvbtg+6PKXzTDCNdq2tkuYO5+aFK6Ec
 l5lF01uhDlqHRBgO7yh8fHzMK5zYK1Xv0ijCBYF5rRIJXTrl3GEX0yLcBoHqf0DoFXGYUXIiqcz
 A0jt3n1pyF551p+E+Q6Ve8uhqBu3ds9OpfT8InlI7PKJPSQFBou2LPeJNBa45biYHU1lDCsJOoC
 mKgCMZzZfWzloGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the new .x snippet to nfs4.x, and the necessary info about the new
attributes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/nfs4lib.py                   |   3 +
 nfs4.1/server41tests/environment.py |   3 +
 nfs4.1/xdrdef/nfs4.x                | 111 ++++++++++++++++++++++++++++++++++--
 3 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/nfs4.1/nfs4lib.py b/nfs4.1/nfs4lib.py
index b1a247b02f66a529da7f2bd98ec436f168b30873..d3a1550f1ce1e135b124a59fa1518c9ff89fd502 100644
--- a/nfs4.1/nfs4lib.py
+++ b/nfs4.1/nfs4lib.py
@@ -731,5 +731,8 @@ attr_info = { FATTR4_SUPPORTED_ATTRS : A("r", "fs"),
               FATTR4_MODE_SET_MASKED : A("w", "obj"),
               FATTR4_FS_CHARSET_CAP : A("r", "fs"),
               FATTR4_XATTR_SUPPORT : A("r", "obj"),
+              FATTR4_TIME_DELEG_ACCESS : A("w", "obj"),
+              FATTR4_TIME_DELEG_MODIFY : A("w", "obj"),
+              FATTR4_OPEN_ARGUMENTS : A("r", "fs"),
               }
 del A
diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 0b7c976d8582a0e4ef5bd1d21ce34247f26899e4..48284e029634fff60b7690e058cd4131bfea9b08 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -108,6 +108,9 @@ class Environment(testmod.Environment):
         AttrInfo('time_modify_set', 'w', settime4(0)),
         AttrInfo('mounted_on_fileid', 'r', 0),
         AttrInfo('xattr_support', 'r', False),
+        AttrInfo('time_deleg_access', 'r', nfstime4(0, 0)),
+        AttrInfo('time_deleg_modify', 'r', nfstime4(0, 0)),
+        AttrInfo('open_arguments', 'r', open_arguments4()),
         ]
 
     home = property(lambda s: use_obj(s.opts.home))
diff --git a/nfs4.1/xdrdef/nfs4.x b/nfs4.1/xdrdef/nfs4.x
index 7b4e755369d749c2570a624895c234b1454df0cb..ee3da8aa7a342e4d3829f4b1b1f82543275199c5 100644
--- a/nfs4.1/xdrdef/nfs4.x
+++ b/nfs4.1/xdrdef/nfs4.x
@@ -1742,10 +1742,12 @@ const
  = 0x20000;
 
 enum open_delegation_type4 {
-        OPEN_DELEGATE_NONE      = 0,
-        OPEN_DELEGATE_READ      = 1,
-        OPEN_DELEGATE_WRITE     = 2,
-        OPEN_DELEGATE_NONE_EXT  = 3 /* new to v4.1 */
+        OPEN_DELEGATE_NONE              = 0,
+        OPEN_DELEGATE_READ              = 1,
+        OPEN_DELEGATE_WRITE             = 2,
+        OPEN_DELEGATE_NONE_EXT          = 3, /* new to v4.1 */
+        OPEN_DELEGATE_READ_ATTRS_DELEG  = 4,
+        OPEN_DELEGATE_WRITE_ATTRS_DELEG = 5
 };
 
 enum open_claim_type4 {
@@ -1921,8 +1923,10 @@ switch (open_delegation_type4 delegation_type) {
         case OPEN_DELEGATE_NONE:
                 void;
         case OPEN_DELEGATE_READ:
+        case OPEN_DELEGATE_READ_ATTRS_DELEG:
                 open_read_delegation4 read;
         case OPEN_DELEGATE_WRITE:
+        case OPEN_DELEGATE_WRITE_ATTRS_DELEG:
                 open_write_delegation4 write;
         case OPEN_DELEGATE_NONE_EXT: /* new to v4.1 */
                 open_none_delegation4 od_whynone;
@@ -3949,3 +3953,102 @@ program NFS4_CALLBACK {
                         CB_COMPOUND(CB_COMPOUND4args) = 1;
         } = 1;
 } = 0x40000000;
+
+/*
+ * The following content was extracted from draft-ietf-nfsv4-delstid
+ */
+
+typedef bool            fattr4_offline;
+
+
+const FATTR4_OFFLINE            = 83;
+
+
+struct open_arguments4 {
+  bitmap4  oa_share_access;
+  bitmap4  oa_share_deny;
+  bitmap4  oa_share_access_want;
+  bitmap4  oa_open_claim;
+  bitmap4  oa_create_mode;
+};
+
+
+enum open_args_share_access4 {
+   OPEN_ARGS_SHARE_ACCESS_READ  = 1,
+   OPEN_ARGS_SHARE_ACCESS_WRITE = 2,
+   OPEN_ARGS_SHARE_ACCESS_BOTH  = 3
+};
+
+
+enum open_args_share_deny4 {
+   OPEN_ARGS_SHARE_DENY_NONE  = 0,
+   OPEN_ARGS_SHARE_DENY_READ  = 1,
+   OPEN_ARGS_SHARE_DENY_WRITE = 2,
+   OPEN_ARGS_SHARE_DENY_BOTH  = 3
+};
+
+
+enum open_args_share_access_want4 {
+   OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG           = 3,
+   OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG            = 4,
+   OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL              = 5,
+   OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL
+                                                   = 17,
+   OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED
+                                                   = 18,
+   OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS    = 20,
+   OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 21
+};
+
+
+enum open_args_open_claim4 {
+   OPEN_ARGS_OPEN_CLAIM_NULL          = 0,
+   OPEN_ARGS_OPEN_CLAIM_PREVIOUS      = 1,
+   OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR  = 2,
+   OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV = 3,
+   OPEN_ARGS_OPEN_CLAIM_FH            = 4,
+   OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH  = 5,
+   OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH = 6
+};
+
+
+enum open_args_createmode4 {
+   OPEN_ARGS_CREATEMODE_UNCHECKED4     = 0,
+   OPEN_ARGS_CREATE_MODE_GUARDED       = 1,
+   OPEN_ARGS_CREATEMODE_EXCLUSIVE4     = 2,
+   OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1  = 3
+};
+
+
+typedef open_arguments4 fattr4_open_arguments;
+
+
+%/*
+% * Determine what OPEN supports.
+% */
+const FATTR4_OPEN_ARGUMENTS     = 86;
+
+
+const OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000;
+
+
+const OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010;
+
+
+/*
+ * attributes for the delegation times being
+ * cached and served by the "client"
+ */
+typedef nfstime4        fattr4_time_deleg_access;
+typedef nfstime4        fattr4_time_deleg_modify;
+
+
+%/*
+% * New RECOMMENDED Attribute for
+% * delegation caching of times
+% */
+const FATTR4_TIME_DELEG_ACCESS  = 84;
+const FATTR4_TIME_DELEG_MODIFY  = 85;
+
+
+const OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000;

-- 
2.47.0


