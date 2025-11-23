Return-Path: <linux-nfs+bounces-16687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD25C7E30E
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBE53ABC82
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B31A2D838C;
	Sun, 23 Nov 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFaEFkBt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0A2D7DE2
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913391; cv=none; b=rwOzAnnAeAyjTyQbtIN13HsBPy+xW5cFdTv585mTA13iDr9gU72DGaPwlByidat42AEeEJs7bfYHHB+E9qBJrGRWTPU00PC1R5vtKS+cp0yovVyF1ceIJtcsX/R0m7FgT9X4LPOUHO8I4fhT3VD/I5pdnR4QYecm2w+Ekhb5EL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913391; c=relaxed/simple;
	bh=ga6qHKraw7DiW327XwtIt0eZ7NFG5d34xJY6dOhzbs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCAoo1kJ1x9BWGnBkY75XDPh00hRlXQo0lXWwL56CxUx2/4sj5JyEwE+5kkSUmSPoi38CPTZLUdw3ok9A9F0oOVzk/EGer5EU3f6UBMCGeV/e4oMZL6H1Mv3cvz5x12aBIgt1WfeSU9VV+bDncUVQwhnyIpJnR1Lp7VL4LOvHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFaEFkBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043EC116D0;
	Sun, 23 Nov 2025 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913390;
	bh=ga6qHKraw7DiW327XwtIt0eZ7NFG5d34xJY6dOhzbs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFaEFkBtT7iVaufWB6k1ELr7jjyoz+SBJFGldCs3u+rrYqo1iMXVH/4UAI3nzcrEn
	 pQ8lEpKWsNxIRA3Oj1g0KN7X3qZeCnJT702G7mNbQjSSNVrDDk86iV8Ajyj/b83oy4
	 U/rY8FIyrt03d9RbStg76Kcb7zYcu77W4u0FLlt54cHQMEw85jesNVntbS56A/a1UH
	 r18jWgLLASO2grPtTL7MSByXl89q+3LIvfYreq2Ozs2YtNVQ/nQlTaSGcckZnPD1rs
	 MO4FQQ5PLKOeCdzyvw5wvEgL63YrHsR2CVqX4Pqwn3dHnB8qwAluBCkyy2eGrGdZ7b
	 xTG47b5cqzgiw==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 07/10] Add verify_acl() helper to nfs4acl modules
Date: Sun, 23 Nov 2025 10:56:15 -0500
Message-ID: <20251123155623.514129-8-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 39 +++++++++++++++++++++++++++++++++++++++
 nfs4.1/nfs4acl.py | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 41b69c049410..2a03012aa6ff 100644
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
diff --git a/nfs4.1/nfs4acl.py b/nfs4.1/nfs4acl.py
index f4d4993b143b..0b2940f04098 100644
--- a/nfs4.1/nfs4acl.py
+++ b/nfs4.1/nfs4acl.py
@@ -106,3 +106,42 @@ def access_mask_to_str(mask):
         (ACE4_SYNCHRONIZE, "SYNCHRONIZE"),
     ]
     return " | ".join(name for bit, name in perms if mask & bit) or "(none)"
+
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
-- 
2.51.1


