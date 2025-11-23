Return-Path: <linux-nfs+bounces-16688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67651C7E317
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99FD034A2B8
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23C2D839B;
	Sun, 23 Nov 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiMM4MmA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A495224AE0
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913391; cv=none; b=s/I9HFzlGqhJV4E012H5ff3w1Sy5refwIO7bzCb9gKfDfxUeCUZbGYSareUmGALYS2eb/ZXF2z8ZiOjCF+WDD+7pfPlergRtfy6Twvwww0/+T5HWlD5jfRVBxDkVqVR07RGbuyZisAI6FwOYpiVYIc+/whdvtumMDTvcKKY2JZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913391; c=relaxed/simple;
	bh=55GN4SQUxVxfmdus3T9VzB+UBJwg8KDC1odQbf+oTAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9G+FneyC+NECzZs5FbGTPV8sEXkBpqcNnJwHnusCSR7881fYOMBqtrio1G29mdTjV8zWWFV0rWSoA9wbHDHHXcUH7ZAm3m+omjBLbbjYHj6Vvr6jivnwpkkvsPlN8K/4COklCcd1yjzGlj457p9Uy0Fs+S7znNU9MBaHH6Y/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiMM4MmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA498C19421;
	Sun, 23 Nov 2025 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913391;
	bh=55GN4SQUxVxfmdus3T9VzB+UBJwg8KDC1odQbf+oTAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiMM4MmArsYcSEF7yjouONEyRh5HxMADAUp8obWrG3b4UnxZZBebbNaDoNAbopZCe
	 3pJQ1me4w90FEj+Tk+ZYTHIYPx5sruaV3SKRnKg1aNud4pOgJ0mrNlZxJdKxgxPrOe
	 Czq81k0xYLXF9PtzEfTp/No0xGnH7b+fzFky76p+RV4E7ETPG1YF2ZCikC49sXvHKi
	 grwSNz+JbpHQQAeQERVlMnC18vAM+19xa2vwfgYDg5J5QNlLrVdeDwJBVqOPMlcznp
	 Fk6Fx2lmS8sT1Mps+5kXxH5iOqupyyjVT8nYa6GJtSOlvYaRTYvyiZE+mylipl+uQH
	 BYg+6r0S8GrFQ==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 08/10] Add verify_mode_and_acl() helper to nfs4acl modules
Date: Sun, 23 Nov 2025 10:56:16 -0500
Message-ID: <20251123155623.514129-9-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251123155623.514129-1-cel@kernel.org>
References: <20251123155623.514129-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 39 +++++++++++++++++++++++++++++++++++++++
 nfs4.1/nfs4acl.py | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 2a03012aa6ff..64492dc7ff6e 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -349,6 +349,45 @@ def verify_acl(returned_acl, expected_acl):
                  access_mask_to_str(returned_ace.access_mask),
                  access_mask_to_str(missing)))
 
+def verify_mode_and_acl(attrs_dict, expected_acl, operation="operation"):
+    """Verify that MODE and ACL attributes match expectations
+
+    This helper encapsulates the common pattern of verifying both ACL
+    and mode derivation per RFC 8881 Section 6.3.2.
+
+    Args:
+        attrs_dict: Dictionary of attributes (must contain FATTR4_ACL and FATTR4_MODE)
+        expected_acl: The ACL that should be present
+        operation: Name of operation for error messages (default: "operation")
+
+    Returns:
+        tuple: (returned_mode, expected_mode) - both as integers with low 9 bits
+
+    Raises:
+        AssertionError: If verification fails
+    """
+    # Check that both attributes are present
+    if FATTR4_ACL not in attrs_dict:
+        raise AssertionError(
+            "ACL attribute not returned after %s" % operation)
+    if FATTR4_MODE not in attrs_dict:
+        raise AssertionError(
+            "MODE attribute not returned after %s" % operation)
+
+    # Verify ACL matches expected
+    verify_acl(attrs_dict[FATTR4_ACL], expected_acl)
+
+    # Verify mode matches RFC 8881 derivation from ACL
+    returned_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if returned_mode != expected_mode:
+        raise AssertionError(
+            "MODE (0%o) does not match RFC 8881 §6.3.2 derivation "
+            "from ACL (expected 0%o)" % (returned_mode, expected_mode))
+
+    return returned_mode, expected_mode
+
 def printableacl(acl):
     type_str = ["ACCESS", "DENY"]
     out = ""
diff --git a/nfs4.1/nfs4acl.py b/nfs4.1/nfs4acl.py
index 0b2940f04098..ab4b45d01d4a 100644
--- a/nfs4.1/nfs4acl.py
+++ b/nfs4.1/nfs4acl.py
@@ -145,3 +145,44 @@ def verify_acl(returned_acl, expected_acl):
                  access_mask_to_str(expected_ace.access_mask),
                  access_mask_to_str(returned_ace.access_mask),
                  access_mask_to_str(missing)))
+
+def verify_mode_and_acl(attrs_dict, expected_acl, operation="operation"):
+    """Verify that MODE and ACL attributes match expectations
+
+    This helper encapsulates the common pattern of verifying both ACL
+    and mode derivation per RFC 8881 Section 6.3.2.
+
+    Args:
+        attrs_dict: Dictionary of attributes (must contain FATTR4_ACL and FATTR4_MODE)
+        expected_acl: The ACL that should be present
+        operation: Name of operation for error messages (default: "operation")
+
+    Returns:
+        tuple: (returned_mode, expected_mode) - both as integers with low 9 bits
+
+    Raises:
+        AssertionError: If verification fails
+    """
+    from xdrdef.nfs4_const import FATTR4_ACL, FATTR4_MODE
+
+    # Check that both attributes are present
+    if FATTR4_ACL not in attrs_dict:
+        raise AssertionError(
+            "ACL attribute not returned after %s" % operation)
+    if FATTR4_MODE not in attrs_dict:
+        raise AssertionError(
+            "MODE attribute not returned after %s" % operation)
+
+    # Verify ACL matches expected
+    verify_acl(attrs_dict[FATTR4_ACL], expected_acl)
+
+    # Verify mode matches RFC 8881 derivation from ACL
+    returned_mode = attrs_dict[FATTR4_MODE] & 0o777
+    expected_mode = acl2mode_rfc8881(attrs_dict[FATTR4_ACL])
+
+    if returned_mode != expected_mode:
+        raise AssertionError(
+            "MODE (0%o) does not match RFC 8881 §6.3.2 derivation "
+            "from ACL (expected 0%o)" % (returned_mode, expected_mode))
+
+    return returned_mode, expected_mode
-- 
2.51.1


