Return-Path: <linux-nfs+bounces-16721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B5C86DB6
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4723B4D83
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C35133AD8F;
	Tue, 25 Nov 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb+b7Bia"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F033AD95
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100184; cv=none; b=RkhZ2QyqineS22yWOzFcHeH2/y8tcOBrZXcuowknGGTMAyVx3tcYFtZ1Bo1hqqDY4Lcv9xoneMj3x82Ri/j3ZFQxQ3JMJ0xYmLbbNHIocGR1v+3tbk9dGnUC3h+PjALQmIrUrRLuCMUnXwsJZU+4YsbsibdiTrfGbEIvQc08Dmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100184; c=relaxed/simple;
	bh=E/TQ7W7SsAe1K6fkLyTcraHZFlE/Xzfq9XCVNAnPeXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZD32Qo24hfGfyYqhywNJLZatR6hWUDVvhD2u3/kkry0CpOumk4vv/qRifldFu8hVRNzUgEvLMli2h0hApsz5liJFDpxYWDzTkTJhqJ/Ax7UwK0LZYF5zwcB+tkpL9jtv/RIn6/K1JQpGt/1FCYz747vA+tU3g5mr4Oe3burI688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb+b7Bia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C4AC4CEF1;
	Tue, 25 Nov 2025 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100183;
	bh=E/TQ7W7SsAe1K6fkLyTcraHZFlE/Xzfq9XCVNAnPeXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fb+b7Bia4vFTp+SstrwTn00jNKEen50Kc55feLKa6OfeqV0aAuzZFe30S72lh+VZU
	 ygxx8Y3zBgDqQ3lmeI48UDjurt7H6ghmam95SY+i/BJ/5jH5dhfZqzyljUA5TmSi46
	 bZ7g5rYxZV1knm+KWs8gxMCoeRXu21R/O+vUk1R92QdwtFcniTN6ETWWF6YzalF6FS
	 875tC48fe1PrgLL7BuxKX9SOljJ5HZN8dQgNq/JtG66F7lkVnvsw9Qw6QDL9KYNLin
	 cPJj29myso4BkptAqbHjm7ojNvlbXSqduFk00+hczmUN8AMWO7osyW2g1vH2Rjj3Kr
	 eENad7t84RA6Q==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 6/9] Add verify_acl() helper to nfs4acl modules
Date: Tue, 25 Nov 2025 14:49:31 -0500
Message-ID: <20251125194936.770792-7-cel@kernel.org>
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

I'm about to add several new tests that verify a test ACL. This is
common code for all these tests, so introduce a utility function
to verify the test ACL.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index e1dfcf0ae371..5197b1238ea8 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -310,6 +310,45 @@ def access_mask_to_str(mask):
     ]
     return " | ".join(name for bit, name in perms if mask & bit) or "(none)"
 
+def verify_acl(returned_acl, expected_acl):
+    """Verify that returned ACL contains expected ACEs
+
+    Server may add additional ACEs, but the requested ones must be present
+    with at least the requested permissions.
+
+    Raises AssertionError if verification fails.
+    """
+    if len(returned_acl) < len(expected_acl):
+        raise AssertionError(
+            "Returned ACL has fewer entries than requested: "
+            "expected at least %d, got %d" % (len(expected_acl), len(returned_acl)))
+
+    # Verify the ACEs we set are present (server may add additional ACEs)
+    for i, expected_ace in enumerate(expected_acl):
+        if i >= len(returned_acl):
+            raise AssertionError("Missing ACE %d in returned ACL" % i)
+        returned_ace = returned_acl[i]
+        if returned_ace.type != expected_ace.type:
+            raise AssertionError(
+                "ACE %d type mismatch: expected %d, got %d" %
+                (i, expected_ace.type, returned_ace.type))
+        if returned_ace.who != expected_ace.who:
+            raise AssertionError(
+                "ACE %d who mismatch: expected %s, got %s" %
+                (i, expected_ace.who, returned_ace.who))
+        # Check that requested permissions are present (server may add more)
+        if (returned_ace.access_mask & expected_ace.access_mask) != expected_ace.access_mask:
+            missing = expected_ace.access_mask & ~returned_ace.access_mask
+            raise AssertionError(
+                "ACE %d access_mask mismatch:\n"
+                "  Expected: %s\n"
+                "  Got:      %s\n"
+                "  Missing:  %s" %
+                (i,
+                 access_mask_to_str(expected_ace.access_mask),
+                 access_mask_to_str(returned_ace.access_mask),
+                 access_mask_to_str(missing)))
+
 def printableacl(acl):
     type_str = ["ACCESS", "DENY"]
     out = ""
-- 
2.51.1


