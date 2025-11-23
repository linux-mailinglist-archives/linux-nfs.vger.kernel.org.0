Return-Path: <linux-nfs+bounces-16685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7052C7E309
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADE33ABD9B
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A982D73A8;
	Sun, 23 Nov 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzEJIloJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5712D7393
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913390; cv=none; b=EniZtoNxDPRDaHQeKuQIxjxcGCcWcdy0drM2XGMs8f4LzSAbQcxrt4x25Z8UJWxqYFUxqVBKzUNv9KlvfzhDA+bBYyHGdG4IAzmV63xJUVLXstPXMUpXFfz9G3MntzBWDyv5OfCrQhCk7q5vrJsCR+Mcf2qAyUp8gE2dcaOZBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913390; c=relaxed/simple;
	bh=OaB2RcLK7Lfd8qSrURz9hjzsMFObUU8UGPZuSHCE1N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqLTgIXqWvErJULkhTtCQCIoyOWTVvJIfYdjeGUN62dMJkPa3vJJqoxfG6IsHtlRfoZ3RwdLF1+GYLBeHa0AcCrAaxDhkq7V+9Xbr22clkNuufRPVmvPoU/7YpB84kq7qn4/bZ0c11xfzpLVuF9KhRAR6DisVLmR19DjUSAe2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzEJIloJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7326EC19422;
	Sun, 23 Nov 2025 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913389;
	bh=OaB2RcLK7Lfd8qSrURz9hjzsMFObUU8UGPZuSHCE1N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzEJIloJmoNwRm0hTWLLQNjRwowJ22h116Wq9UzSGSD/sPkcciqcrGOJgrgIr43D4
	 g8Gfuh+jzfXHFbdXqX+6ZX7DL2KGV+gXkVQalbtuWi/A3ab2kElYGxxOibUyI80U5A
	 JDrlm+LjFZ3B1PUjT4AashoY8Rps8rPUSwGKJGH9p85HKZ58HWDx77rx9k5lp9pleX
	 +1YQkjhFZb7snGlePQmzqyd0Tj5VT/ukCuRU3Fltg3xxhM8ruRF9Yt9f4P4XqqebLk
	 n6nNinPN5xvzPSsX6wXzJDeZ6eBVJOkaFSzFgCZH6W+Bpezj/ArCKXYGTJFPQP7369
	 mjNlVMtcpTyHw==
From: Chuck Lever <cel@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 05/10] Add make_test_acl() helper to nfs4acl modules
Date: Sun, 23 Nov 2025 10:56:13 -0500
Message-ID: <20251123155623.514129-6-cel@kernel.org>
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
 nfs4.0/nfs4acl.py | 22 ++++++++++++++++++++++
 nfs4.1/nfs4acl.py | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/nfs4.0/nfs4acl.py b/nfs4.0/nfs4acl.py
index ceb9ea6a198e..329be01f9fd6 100644
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
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
+
 def acl2mode(acl):
     """Translate an acl into a 3-digit octal mode"""
     names = ["OWNER@", "GROUP@", "EVERYONE@"]
diff --git a/nfs4.1/nfs4acl.py b/nfs4.1/nfs4acl.py
index 44f01de0d513..f4d4993b143b 100644
--- a/nfs4.1/nfs4acl.py
+++ b/nfs4.1/nfs4acl.py
@@ -3,6 +3,29 @@
 #
 
 from xdrdef.nfs4_const import *
+from xdrdef.nfs4_type import nfsace4
+
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
+                b"OWNER@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"GROUP@"),
+        nfsace4(ACE4_ACCESS_ALLOWED_ACE_TYPE, 0,
+                ACE4_READ_DATA,
+                b"EVERYONE@")
+    ]
 
 def acl2mode_rfc8881(acl):
     """
-- 
2.51.1


