Return-Path: <linux-nfs+bounces-16718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2FC86DA7
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 20:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E5D2352246
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206A332ED3;
	Tue, 25 Nov 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeuXWlGv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6D33AD82
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100182; cv=none; b=dpnRN8kmIe1waBoCcCXriEIRvkaoZxa6hlmdy2RqDXBbs/EMvBd4KevLVQnvNt7RDasK+jm3jrexA0QHLii2hl+eUvaKZTxYI/B7f0J57Ew9QBY0/K+3mffHZ+qRDaSUHyDVmpB0pj+sMwRnHL1FF9eKW77iY8ujWR6JoVxISY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100182; c=relaxed/simple;
	bh=0aYSDYzvOLPfKJOqoMAjFBWvmQ1gBVCVU7h4FaI9S2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLINvNu8rHGjcKJpW1ptBOLcxDnqanFzDx6Qo2VL/Dd5lJyVq1EsRVMpn345psfLJuwUak2nkBT6tQ7C/Byo/kre2YvB5vLfkNsJwbmcpvWWOg6EX1PpDtvUGFdA8+ROQY6lqnPDDHpzJaV2HT2BP3yGqQ1hdk42uk9KhRwlNu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeuXWlGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D856C116B1;
	Tue, 25 Nov 2025 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100181;
	bh=0aYSDYzvOLPfKJOqoMAjFBWvmQ1gBVCVU7h4FaI9S2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NeuXWlGvsC3oTa08cE2JU9EnYDu61H7PPPVseJ1ZvuM9BjZUYRWHdmMrKWwErllto
	 IxL3FYjXmY/PHPwpyHrPAMwfC/zEJ4QPdd99dEYUvEm1W0kVwmei2OIUpZ6rlzrvzz
	 2vwqGdyDZEmrhrM1GU2Z8sm2e4l7Ljf50aZLZEeZ85J7RGJ9T8cCkJSbBQKbsjG8C1
	 ty4YYBeg83JyTS04EaDoCV1TkxBqhTtXL9oipyhB1FAJyTIpeZFjAtO+fTgMQaV9V5
	 h8Edt1iLiMOI3cremiScfwkwmeKQP/zxZVONJdFCCB9QpWIwfTfqL22VKkuyPGx939
	 7sUtkR94UYufw==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	aurelien.couderc2002@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/9] Add a helper to compute POSIX mode bits from NFSv4 ACLs
Date: Tue, 25 Nov 2025 14:49:28 -0500
Message-ID: <20251125194936.770792-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125194936.770792-1-cel@kernel.org>
References: <20251125194936.770792-1-cel@kernel.org>
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

To avoid duplicating this code for both NFSv4.0 and NFSv4.1
ACL-related tests (I'm expecting to see a common NFSv4 ACL
document published soon), a symlink is added to make ACL
utility functions visible to tests for both minor versions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 nfs4.0/nfs4acl.py | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 nfs4.1/nfs4acl.py |  1 +
 2 files changed, 61 insertions(+)
 create mode 120000 nfs4.1/nfs4acl.py

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index 69e0d0bcfbe1..62193123ef7c 100644
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
+        ("OWNER@", MODE4_RUSR, MODE4_WUSR, MODE4_XUSR),
+        ("GROUP@", MODE4_RGRP, MODE4_WGRP, MODE4_XGRP),
+        ("EVERYONE@", MODE4_ROTH, MODE4_WOTH, MODE4_XOTH)
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
+            if ace.who not in (who, "EVERYONE@"):
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
diff --git a/nfs4.1/nfs4acl.py b/nfs4.1/nfs4acl.py
new file mode 120000
index 000000000000..f05cb4015424
--- /dev/null
+++ b/nfs4.1/nfs4acl.py
@@ -0,0 +1 @@
+../nfs4.0/nfs4acl.py
\ No newline at end of file
-- 
2.51.1


