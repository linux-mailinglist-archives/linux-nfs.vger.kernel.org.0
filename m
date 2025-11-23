Return-Path: <linux-nfs+bounces-16682-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEAEC7E302
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE40F4E30E7
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D274729E10B;
	Sun, 23 Nov 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9wMKSQ+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7272D5937
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913388; cv=none; b=mVWV1oNlGKQ7bBYwTxypP2E7QwcQK3PZCXDljRxhy4sJSoBRA930RO1diqUFCGPIJbQJnxjyOhAUFhi7RpSqoIMadrZEqnqH8RqCsxthhkhlDW/vtCNSWWcx4zzvAd4wxYBZlFJeZref8OEZKt8ku8oJ44wvk5KZWMBvxb/WgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913388; c=relaxed/simple;
	bh=NzEcD944RiOklcegaw6nya4Zmwx0ECXTettfyG7q5SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSPUeTSOczCsuq/zzlNWOy4kZunmT0obWytlJsyQmBrIGEufpDPOUH5ttyHzKt/Oi0F2WnQvvB0gVZH7Ui85Wv1f0yldBqqqVgxkoAIuhZ/3cs8HSQ13I4NKuWda0nyh9oL5ngpA5x79T5krDpCAUwJ7KrxMTnK7w7LavzaQt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9wMKSQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF338C116D0;
	Sun, 23 Nov 2025 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913388;
	bh=NzEcD944RiOklcegaw6nya4Zmwx0ECXTettfyG7q5SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9wMKSQ+qk68hvXQuBHeFhcqHXFe9iZPmFVR17Lqn+u5fOevQF0E6KggfNEw6B2Z8
	 flhDmM509DCAD4VbZskSHehBF6vyx68Nsld8bUZXnI6WUMrj/1E96ip+w8UQh5lsAR
	 paCAREpucoBUMqbaIA0872+I7Q2Jxgt6Y3uxId6yxpuYCq2PFFeM4uXeqoXdxiZvhu
	 Hsx7FU2BtboOQd6Mky8q1AWvDR75NMtH/kZmHuFA1oGwcmimf+y/pY99XX+xaKOsGQ
	 dRJyMpvyTRrKiDknAHSLYF8LCkul9PiMbBM4kP9gXrCpozEOuGf9Um6DYe84Z1loku
	 MlFBJx+vCaQqQ==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 02/10] Add helper to format ACE access masks
Date: Sun, 23 Nov 2025 10:56:10 -0500
Message-ID: <20251123155623.514129-3-cel@kernel.org>
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

I'm about to add new ACL-related tests. Introduce
access_mask_to_str() to convert ACE access_mask values to human-
readable symbolic strings for the display output in these new
tests.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.1/nfs4acl.py | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 nfs4.1/nfs4acl.py

diff --git a/nfs4.1/nfs4acl.py b/nfs4.1/nfs4acl.py
new file mode 100644
index 000000000000..44f01de0d513
--- /dev/null
+++ b/nfs4.1/nfs4acl.py
@@ -0,0 +1,85 @@
+#
+# nfs4acl.py - ACL utility functions for NFSv4.1
+#
+
+from xdrdef.nfs4_const import *
+
+def acl2mode_rfc8881(acl):
+    """
+    Compute mode from ACL according to RFC 8881 Section 6.3.2.
+
+    For each special identifier (OWNER@, GROUP@, EVERYONE@), evaluate the
+    ACL in order considering only ALLOW and DENY ACEs for EVERYONE@ and
+    the identifier under consideration. Then translate to mode bits:
+    - Read bit: Set if ACE4_READ_DATA is permitted
+    - Write bit: Set if BOTH ACE4_WRITE_DATA AND ACE4_APPEND_DATA are permitted
+    - Execute bit: Set if ACE4_EXECUTE is permitted
+
+    Returns the low-order 9 bits of the mode (user/group/other permissions).
+    """
+    identifiers = [
+        (b"OWNER@", MODE4_RUSR, MODE4_WUSR, MODE4_XUSR),
+        (b"GROUP@", MODE4_RGRP, MODE4_WGRP, MODE4_XGRP),
+        (b"EVERYONE@", MODE4_ROTH, MODE4_WOTH, MODE4_XOTH)
+    ]
+
+    mode = 0
+
+    for who, read_bit, write_bit, exec_bit in identifiers:
+        # Start with no permissions
+        allowed_mask = 0
+        denied_mask = 0
+
+        # Evaluate ACL in order, considering only ALLOW/DENY for this
+        # identifier and EVERYONE@
+        for ace in acl:
+            # Skip non-relevant ACEs
+            if ace.who not in (who, b"EVERYONE@"):
+                continue
+            if ace.type not in (ACE4_ACCESS_ALLOWED_ACE_TYPE, ACE4_ACCESS_DENIED_ACE_TYPE):
+                continue
+            # Skip inherit-only ACEs (they don't affect current permissions)
+            if ace.flag & ACE4_INHERIT_ONLY_ACE:
+                continue
+
+            if ace.type == ACE4_ACCESS_ALLOWED_ACE_TYPE:
+                # Add allowed permissions not already denied
+                allowed_mask |= (ace.access_mask & ~denied_mask)
+            elif ace.type == ACE4_ACCESS_DENIED_ACE_TYPE:
+                # Add denied permissions not already allowed
+                denied_mask |= (ace.access_mask & ~allowed_mask)
+
+        # Translate permitted mask to mode bits per RFC 8881 §6.3.2
+        # Read bit: ACE4_READ_DATA must be set
+        if allowed_mask & ACE4_READ_DATA:
+            mode |= read_bit
+
+        # Write bit: BOTH ACE4_WRITE_DATA and ACE4_APPEND_DATA must be set
+        if (allowed_mask & ACE4_WRITE_DATA) and (allowed_mask & ACE4_APPEND_DATA):
+            mode |= write_bit
+
+        # Execute bit: ACE4_EXECUTE must be set
+        if allowed_mask & ACE4_EXECUTE:
+            mode |= exec_bit
+
+    return mode
+
+def access_mask_to_str(mask):
+    """Convert an ACE access_mask to a symbolic string representation"""
+    perms = [
+        (ACE4_READ_DATA, "READ_DATA"),
+        (ACE4_WRITE_DATA, "WRITE_DATA"),
+        (ACE4_APPEND_DATA, "APPEND_DATA"),
+        (ACE4_READ_NAMED_ATTRS, "READ_NAMED_ATTRS"),
+        (ACE4_WRITE_NAMED_ATTRS, "WRITE_NAMED_ATTRS"),
+        (ACE4_EXECUTE, "EXECUTE"),
+        (ACE4_DELETE_CHILD, "DELETE_CHILD"),
+        (ACE4_READ_ATTRIBUTES, "READ_ATTRIBUTES"),
+        (ACE4_WRITE_ATTRIBUTES, "WRITE_ATTRIBUTES"),
+        (ACE4_DELETE, "DELETE"),
+        (ACE4_READ_ACL, "READ_ACL"),
+        (ACE4_WRITE_ACL, "WRITE_ACL"),
+        (ACE4_WRITE_OWNER, "WRITE_OWNER"),
+        (ACE4_SYNCHRONIZE, "SYNCHRONIZE"),
+    ]
+    return " | ".join(name for bit, name in perms if mask & bit) or "(none)"
-- 
2.51.1


