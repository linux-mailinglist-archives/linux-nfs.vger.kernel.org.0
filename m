Return-Path: <linux-nfs+bounces-7172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297F899D87F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3778282539
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614741D0F5D;
	Mon, 14 Oct 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq1z3xJC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5E1D0E3E
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939039; cv=none; b=iglg9xn6XzWm7iWJA0i7x9iikfBzWrJID+1LhCHupQ6IvGcOgbSVZ1QScyxyyeTEiOz8EsDkqcuy7mPonbBA4ug4o4kbw+/7eAciZk7pjMWqG2wmBpiJT6wA1DewFGziyvFUBWAVy7ep8Czvm8UcW7N8hXe9HEEPmhjIvIS9Jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939039; c=relaxed/simple;
	bh=1Dt5Lx5cdimQzqLxTgptUSgjFvMCdQ6TBYDG+Mc32V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8/zuS6fFlSelipx31691W7zYsNb9JJFsQtRrYWF1BEb8yaeFvT9IO7NoPKKr6CsoN2tMv31w1ou/RBadxypQlSaEb09voRYa++qJA/7xSbh7ia9Vjcyn0QMb0mApbc5N9WVh/p7CPzZK9km7OEJt2vdSLpFNjzm5uSUJtCsnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq1z3xJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A22C4CEC3;
	Mon, 14 Oct 2024 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939039;
	bh=1Dt5Lx5cdimQzqLxTgptUSgjFvMCdQ6TBYDG+Mc32V0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dq1z3xJCzIbvovOCgajsUNaEKGpgv+aVS8xqZkOB4uEB8Gr/OHhEO2DddJhO+kzua
	 tqcBIVJ3lSLJzNX2JMzHogcCmSZ7AklV15NB5hsHUIqNHyUtkGj5++zP0Sl41LnqN4
	 Ons1MP2rhF52JQ/4WBANOuneiPBut9AYkoeJvhP7d4e+MxYj0JGebYZP64JCMqSYxD
	 /M4PovlTMSWVtpm5K4+rzPLti/MT+fq+PCaFSZE+G5/MX0OIIsIJ89ndIBAeyzlOu0
	 Fo0WtK+VgsNDUNXolJ8qao+f9Rp09/Za/9c6zBNbX4daa9BaiqNKlW1nbYCsTXJ0gA
	 NJ6q0zNTyQWog==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 16:50:24 -0400
Subject: [PATCH pynfs v2 4/7] nfs4.1: add two CB_GETATTR tests
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-cb_getattr-v2-4-3782e0d7c598@kernel.org>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5026; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1Dt5Lx5cdimQzqLxTgptUSgjFvMCdQ6TBYDG+Mc32V0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDYQchHVgugcLwDEaBdKWwu+6CDwDN835UsSbp
 t5dNZv9TGqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw2EHAAKCRAADmhBGVaC
 Feg2D/0emcfctwfYu9d49iaZwg09QlUFy4zsjpOjtsdyyCI9zp1vamJdRrGXvqegviFC2rPew2e
 C5YsWLNzfA5SJDQW66jDesLhwW0jYrjI7DBZpgWXwyKJy5eohk6dvXPMYqyDtCMFEdOaseCfUTe
 GDinG6DZxTHHE/fLWuBaZR58DcSWltdH+MshPs2/dy6giM0yOqp6kOYrJEc97y8nRM0SGQvKrt2
 yr90WRKncZRgXpXj7Ct/ermppB7RZB3n6wUM2fUrjtw+x1A0DY5w3RjnXyWOYRIYqBk96hPOyd+
 VLbKsNg+IDDpDmDCGUmHE75qefwMZCByDuisCAeq45m4Q9hcLx+erqcLekZAeOEp6aFrqgPYz2D
 HGpIorIsR+7ooz9xxrzPVO0fyRLoHiGnlkRGli01L+V6nBseaT88F2JxD2XnBAQIOrn1wg0TaUf
 M77vSB0cHOU47abIRsE75qunIVE2AockjefNjHwZismOFtiuWOdXscvEScy6N5t0PSBrSd9eaZ+
 REGPX97w8uYyeZfMTu5wHI0nX/TQ6lpTGKXskmmK2absKHHgyLzbVGqcaTiybI3Wfua1Ooolanw
 mfGTzpCeE7NnyY8fhLpCpj9oYavOt2fexIQA7wBCfsSyCh9LVGDByB5EqkLT6iPqUtUB28n9cQR
 q++UPpSMCbdPP1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add tests for CB_GETATTR support.

Open a file r/w and request a write delegation. Do a getattr against it
to get the current size and change attr. From a second client, issue a
GETATTR against the file.

One test does this and has the delegation holder send back the same
attrs, another has it send back updated ones.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/nfs4client.py                  |  6 +++
 nfs4.1/server41tests/st_delegation.py | 72 ++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index 8ce64dd639c75ea14b24bd5b732ddbe0fcb0fa71..941cf4000a5f0da254cd826a1d41e37f652e7714 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -271,6 +271,12 @@ class NFS4Client(rpc.Client, rpc.Server):
         res = self.posthook(arg, env, res)
         return encode_status(NFS4_OK, res)
 
+    def op_cb_getattr(self, arg, env):
+        log_cb.info("In CB_GETATTR")
+        self.prehook(arg, env)
+        res = self.posthook(arg, env, res=CB_GETATTR4resok())
+        return encode_status(NFS4_OK, res)
+
     def op_cb_recall(self, arg, env):
         log_cb.info("In CB_RECALL")
         self.prehook(arg, env)
diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 80b0da28fbad85429fc1f4c0e759be82b0cc5c08..2aa73ba7acd0bd857a4fd5206b8857f980176d73 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -2,7 +2,7 @@ from .st_create_session import create_session
 from .st_open import open_claim4
 from xdrdef.nfs4_const import *
 
-from .environment import check, fail, create_file, open_file, close_file
+from .environment import check, fail, create_file, open_file, close_file, do_getattrdict
 from xdrdef.nfs4_type import *
 import nfs_ops
 op = nfs_ops.NFS4ops()
@@ -289,3 +289,73 @@ def testServerSelfConflict3(t, env):
     check(res, [NFS4_OK, NFS4ERR_DELAY])
     if not completed:
         fail("delegation break not received")
+
+def _testCbGetattr(t, env, change=0, size=0):
+    cb = threading.Event()
+    cbattrs = {}
+    def getattr_post_hook(arg, env, res):
+        res.obj_attributes = cbattrs
+        env.notify = cb.set
+        return res
+
+    sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
+    sess1.client.cb_post_hook(OP_CB_GETATTR, getattr_post_hook)
+
+    fh, deleg = __create_file_with_deleg(sess1, env.testname(t),
+                                                OPEN4_SHARE_ACCESS_READ  |
+                                                OPEN4_SHARE_ACCESS_WRITE |
+                                                OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG)
+    print("__create_file_with_deleg: ", fh, deleg)
+    attrs1 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE])
+    cbattrs = dict(attrs1)
+
+    if change != 0:
+        cbattrs[FATTR4_CHANGE] += 1
+        if size > 0:
+            cbattrs[FATTR4_SIZE] = size
+
+    # create a new client session and do a GETATTR
+    sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
+    slot = sess2.compound_async([op.putfh(fh), op.getattr(1<<FATTR4_CHANGE | 1<<FATTR4_SIZE)])
+
+    # wait for the CB_GETATTR
+    completed = cb.wait(2)
+    res = sess2.listen(slot)
+    attrs2 = res.resarray[-1].obj_attributes
+    sess1.compound([op.putfh(fh), op.delegreturn(deleg.write.stateid)])
+    check(res, [NFS4_OK, NFS4ERR_DELAY])
+    if not completed:
+        fail("CB_GETATTR not received")
+    return attrs1, attrs2
+
+def testCbGetattrNoChange(t, env):
+    """Test CB_GETATTR with no changes
+
+    Get a write delegation, then do a getattr from a second client. Have the
+    client regurgitate back the same attrs (indicating no changes). Then test
+    that the attrs that the second client gets back match the first.
+
+    FLAGS: deleg
+    CODE: DELEG24
+    """
+    attrs1, attrs2 = _testCbGetattr(t, env)
+    if attrs1[FATTR4_SIZE] != attrs2[FATTR4_SIZE]:
+        fail("Bad size: %u != %u" % (attrs1[FATTR4_SIZE], attrs2[FATTR4_SIZE]))
+    if attrs1[FATTR4_CHANGE] != attrs2[FATTR4_CHANGE]:
+        fail("Bad change attribute: %u != %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))
+
+def testCbGetattrWithChange(t, env):
+    """Test CB_GETATTR with simulated changes to file
+
+    Get a write delegation, then do a getattr from a second client. Modify the
+    attrs before sending them back to the server. Test that the second client
+    sees different attrs than the original one.
+
+    FLAGS: deleg
+    CODE: DELEG25
+    """
+    attrs1, attrs2 = _testCbGetattr(t, env, change=1, size=5)
+    if attrs2[FATTR4_SIZE] != 5:
+        fail("Bad size: %u != 5" % attrs2[FATTR4_SIZE])
+    if attrs1[FATTR4_CHANGE] == attrs2[FATTR4_CHANGE]:
+        fail("Bad change attribute: %u == %u" % (attrs1[FATTR4_CHANGE], attrs2[FATTR4_CHANGE]))

-- 
2.47.0


