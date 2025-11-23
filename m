Return-Path: <linux-nfs+bounces-16684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC64C7E308
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027414E32B8
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DCF2D593D;
	Sun, 23 Nov 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/94jBut"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C22D7393
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913389; cv=none; b=n8wZ1Yz4OEuzpMdoxEIM7Njz58r0P4QLV9S/oewdpYIHr99c5F45faWAF6U7Tu1Fae2cyK2rfzTyWV21JRe6FEbK/wTosMcRG+bYkKmx+e2g4NIZuwwT7JIhFKUTOqoZ0LwKUDpH0gkcynisZrku/PwxVl4UZd9l/j70VkLLUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913389; c=relaxed/simple;
	bh=sQyer9/m1QdbLcyAIWbpYMvOWdMjsj9KmbLJCBmnTqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzbufYNwlWqtUF+Q6ibar2IK85K49VtcBFRkk1ndA6ctALI8h6bo3qRRoHfa7EkxB3B0tq43OR9jcG5HXWEhxiLRS15aeym8Q8cv4vWdGPLlUNyEQiLxQAHBzT65+n/4JbEJZHquda6648Gm+ccUwWcoNtYkz/vJgJfyLLzl4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/94jBut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE580C116D0;
	Sun, 23 Nov 2025 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913389;
	bh=sQyer9/m1QdbLcyAIWbpYMvOWdMjsj9KmbLJCBmnTqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/94jButhy9TfQA1hHaIKcSofLS6XWzd7aYnezCc0pcLOhQUBxU/wcbsTjAWpccZD
	 FFEx4i8AzcEDvIj7pGY2/7/naNPq0fJ+xAmJk9oFZ4nsjYLkfkvqO8oIE83nsyX7AY
	 ASr9en8eOTeu6O+J3/GSLf2cJzsUawn0gr9AmdFB98CBDore4Sk++I0Q7Fn9BdR8Cf
	 qncAdmMp0HoND3+0qGkpIo6fOXH74fBEMny35C7HKoCES0xYcijCizYr/5SBQL9xvU
	 BqdFblWac1N+vDv2NGyEZO8RFu1kvtv0wDVWxa3kzc4e1V/8infeaQrMsAaPfmkRbD
	 zdNpYEr6r/5YQ==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 04/10] Add a helper to compute POSIX mode bits from NFSv4 ACLs
Date: Sun, 23 Nov 2025 10:56:12 -0500
Message-ID: <20251123155623.514129-5-cel@kernel.org>
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

NFSv4 servers are permitted to adjust a file's mode bits when
the file's ACL is set. RFC 8881 Section 6.3.2 describes what is
expected.

I'm about to add new tests that set an ACL and then retrieve
the file's mode to verify that the server is following that
section of RFC 8881. Mode bit verification is common, so it
is added as a utility function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 69e0d0bcfbe1..ceb9ea6a198e 100644
--- a/nfs4.0/nfs4acl.py
+++ b/nfs4.0/nfs4acl.py
@@ -208,6 +208,66 @@ def chk_groups(acl, flags, not_mask):
             chk_triple(mask, allow, acl[0], flags | GROUP, not_mask)
         del acl[:1]
 
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
+            if ace.type not in (ALLOWED, DENIED):
+                continue
+            # Skip inherit-only ACEs (they don't affect current permissions)
+            if ace.flag & ACE4_INHERIT_ONLY_ACE:
+                continue
+
+            if ace.type == ALLOWED:
+                # Add allowed permissions not already denied
+                allowed_mask |= (ace.access_mask & ~denied_mask)
+            elif ace.type == DENIED:
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
 def printableacl(acl):
     type_str = ["ACCESS", "DENY"]
     out = ""
-- 
2.51.1


