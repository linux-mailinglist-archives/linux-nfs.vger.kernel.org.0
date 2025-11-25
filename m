Return-Path: <linux-nfs+bounces-16720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4E4C86DB0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5D454E1FA0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7C33AD88;
	Tue, 25 Nov 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU7JjaqS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E833AD8F
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100183; cv=none; b=sCYL7tdi3uWiotTBij2wC8VP8fOsbGk6aayHCXkCaNaWIUSOrcMP0am6jKlxG/geYB13FnlGhOE4IIUCW775Nx48RNOSEpLRjDqon08IWQ2GPpZzyahL/b0RAbrXciFFFxYidAxG2ssvRe0UQoMIk2+h0ikyjx9xWs2xkTi/Fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100183; c=relaxed/simple;
	bh=0hqAvHAXa4vHsS59Xs+BmdG9G5NBcNrtt4ep5MPftd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnoX7IacADVAXMpBU4K2t2ODJddc9fUYs22USGm/uQWJKebcOV5tyJYXwTmIbopjlLyUFfQr5HfJmPGn63pRjdqQx9ITx2d/bJ3rmw2GnaO2gfUMKpASIveZWCfqkef5q78CGKonItHWBbkuZR9PTzowJDFbteIKUU5/2Nlk7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU7JjaqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993D6C116B1;
	Tue, 25 Nov 2025 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100183;
	bh=0hqAvHAXa4vHsS59Xs+BmdG9G5NBcNrtt4ep5MPftd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HU7JjaqS30XsBh0bXMRb+DzNb95NKzbXhwZipm91Im+x3Yh+GIHIpOpGvhnGJkS7W
	 s5WpPc1GPnlU5W0g/+s7tm1ggyWqmQ4RC6bZOeixvGDYizM1hF69SjgP7bRMcaYxVg
	 FnLCIEZH34CVO7b1QKE18OSgJ587cEislflQZJW4LmpYyPmMiMACSL45NEUeu3fnX5
	 CHRBxoS3uYdtbT8gOls5Kc4uj1Ewts+XxvmWICL3HpUnEg9VB12PyPySfePjudEniJ
	 iRKML44cy/vcs3of5xTms37j337ZXJ5YNNCsT3GHmhi03C5F2+SJSQ0vYnItW507Oh
	 rF5QDmFSfVCNQ==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 5/9] Add make_test_acl() helper to nfs4acl modules
Date: Tue, 25 Nov 2025 14:49:30 -0500
Message-ID: <20251125194936.770792-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125194936.770792-1-cel@kernel.org>
References: <20251125194936.770792-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to add several new tests that set a test ACL. This is
common code for all these tests, so introduce a utility function
to construct this ACL for each test.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 0fabd0860cff..e1dfcf0ae371 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -78,6 +78,28 @@ def mode2acl(mode, dir=False):
              nfsace4(DENIED, 0, negate(other), "EVERYONE@")
              ]
 
+def make_test_acl():
+    """Create a test ACL that maps cleanly to POSIX ACLs
+
+    Uses OWNER@, GROUP@, and EVERYONE@ to match POSIX user/group/other
+    structure, which helps servers that map NFSv4 ACLs to POSIX ACLs.
+
+    Includes both WRITE_DATA and APPEND_DATA for write permission, since
+    Linux NFS server's conservative NFSv4-to-POSIX mapping requires both
+    to grant POSIX write permission.
+    """
+    return [
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA | ACE4_WRITE_DATA | ACE4_APPEND_DATA | ACE4_READ_ACL,
+                "OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                "GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                "EVERYONE@")
+    ]
+
 def acl2mode(acl):
     """Translate an acl into a 3-digit octal mode"""
     names = ["OWNER@", "GROUP@", "EVERYONE@"]
-- 
2.51.1


