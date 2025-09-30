Return-Path: <linux-nfs+bounces-14806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0315ABACB69
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070777AB37D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076DF25CC69;
	Tue, 30 Sep 2025 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAqyx49h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7765264623
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232268; cv=none; b=SAWR3+sp1Ss2Bmj7flNJ6DGbThtVfgIbCKkGiZjYmIl3+6IzMNflxLlCPMTPJh0qEbWx2BAjGGGPmRJX3dCQFRgTYp3nzrGBMWqQE5y90hwF7yAIMqz265kgEs1cPGlOWYCveVRyUdeRtd6cPdrPu5M6tstKdyip+2m0c9lAek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232268; c=relaxed/simple;
	bh=kX0gU4IB97E67767XZ46jiEl4uavuptglTyJN6hwjws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxBRRnetSE1eWH1TX3caEgNbD9I3wzHoj2oB4ZhnlMo6dXScGOSt1p0Gyf8tEVeUH1yTgzRSb22EUb4eptAOaigTQmU52TWjY/TU5G+w9gGF55gORFR1UfUICdE3QN4DGFvvhOSAr6tpz6YpDE5rjvuuyGzn8PGu8NHDk7slJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAqyx49h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67421C4CEF0;
	Tue, 30 Sep 2025 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232267;
	bh=kX0gU4IB97E67767XZ46jiEl4uavuptglTyJN6hwjws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iAqyx49hIuM82XChPNUbUBNkQeQinduspIepXMMSWKquegopFVaSDVl2k32Gu97f3
	 Eqy9Piugtm/YCoTnNyRZyPAW+AxvWUCYLJ2z5m+J7AJY/vLoF3bDIPZd7l08zuKPXk
	 DGbTfxF4HvCYKDX6mR/nJvJVWJ7mJciRrGMUE5LonRagYiysoc/uzEtRjxJpHydbi3
	 Sjv06ZvHZ/GTjskBYl+1h0HazP/BajqFXMy0wN7XwJgG3r0/38OzypS9TeUMEZa4dA
	 okf30PRwLVrB8bGXBJfCMoijj8C5gQz0LUhO6nm3fMj2a7TElYH7PAi5K4FXpuDdtd
	 5STOcQT7cTnUQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 30 Sep 2025 07:37:41 -0400
Subject: [PATCH pynfs 7/7] server41tests: add test for rename event
 notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-dir-deleg-v1-7-7057260cd0c6@kernel.org>
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kX0gU4IB97E67767XZ46jiEl4uavuptglTyJN6hwjws=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EHj8ZYJ5TdIjIU2xnvMxfMFkADhrHwTAvSb
 803kEW+pLOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBwAKCRAADmhBGVaC
 FfJ4EAC0YlVf3Igil5Jj6EeTCslpEqItTlKMGb/8idzz8yjRQNlzk5gNj7inS8i0Xw2i0FxE7kh
 rFCHTq7ttC64uDbxTeLFixV+zVDNL14a+7Zk53c0yfsQngLPSByLCWblPspZYOgzzDMBmrEy2cy
 sy6Ahlv4zetISP7ids90tnCzSMI1l5dgGMS7/FFybcHTUbNyKqqPXoWALYFQhLqEpdadV2zB2gF
 7yYWG5ZLMAfkzKtj7x65n+nIiI+vfmpu9vFUrv4cvNTxmomtiKJct60E53DiTHO8SX/fYd0Jp42
 v7NqyNSl1exUuTaR3tKga4zQYA2Oc5+Swgs6QlvE8zI7/B5d4FGqSu2gJISiRICnZr777veztpl
 JcsKNemxuAzkSHiF0iUWwzcz8vLDgSrvSQh6+4q/nFLlLwUubaU5CUP6PWsux4yF2IO+U+Qpen4
 QHqsFAz+pudcirS0kCuTyL6ZP25lLXPRSVzDwgLogLUNHV+TUtk0VzcxVUaYa7GggBWQo9szpla
 R8w0PDLf93XHcWBZwKlN5xGA9/8q/ZOs9p6J62ZJCSY2GgOJ4TQBcbKfIO6rKC5Igygi5khwuyE
 F0u/qqhOkRqUNMSzInRAfK4dqge2ZVM7WdN7qkRNZF6809o2aD0kZQ0gkW72NTyoX7rp7sLpp1f
 OVIJsFOEMi8xrlg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a test of notifications for renames within the same dir.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 38 +++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 7073c590cb537f83552d7d8afa0ab02da1fe07c9..bd1cd1c2ad5342b3026e245f5eb0823c01b1f9ea 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -2,7 +2,7 @@ from .st_create_session import create_session
 from .st_open import open_claim4
 from xdrdef.nfs4_const import *
 
-from .environment import check, fail, create_obj, use_obj
+from .environment import check, fail, create_obj, use_obj, rename_obj
 from xdrdef.nfs4_type import *
 import nfs_ops
 op = nfs_ops.NFS4ops()
@@ -183,3 +183,39 @@ def testDirDelegAdd(t, env):
 
     if (not completed or not cb.got_notify):
         fail("Didn't receive a CB_NOTIFY from the server!")
+
+def testDirDelegRename(t, env):
+    """Create a dir_deleg that accepts notification of RENAME events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG5
+    """
+    c = env.c1
+    cb = threading.Event()
+
+    sess1, fh, deleg = _getDirDeleg(t, env, [NOTIFY4_RENAME_ENTRY], cb)
+
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
+    res = sess1.compound(open_op)
+    check(res)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    topdir = c.homedir + [t.code.encode('utf8')]
+    oldpath = topdir + [env.testname(t)]
+    newpath = topdir + [b"%s_2" % env.testname(t)]
+    res = rename_obj(sess2, oldpath, newpath)
+    check(res)
+
+    completed = cb.wait(2)
+
+    delegreturn_op = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(delegreturn_op)
+    check(res)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")

-- 
2.51.0


