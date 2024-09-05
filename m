Return-Path: <linux-nfs+bounces-6258-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7996E1BF
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03D41C210E4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E7158D66;
	Thu,  5 Sep 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbjx/KmZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642B17ADF7
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560224; cv=none; b=MMxDZ1sTCmu0cwSH6Ms1VKbaEUSuKdctWGK1zivHEiaRWFnx/fo5jTftOW07bBApyLwW8PRKLo6+chvAmM4goa5/SIqkYcDvQNpKDvvq0rlnfKhtoRvWotkFtwrws36tWwsRs1kG0UgD/ohrBh1nkNygQX6i4UlhwANWbnAPDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560224; c=relaxed/simple;
	bh=4YuuyJO6Ks9XTbe/WWpmwyebyxsD7gWUehfkyYQWk4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ot/We34ssYkkp01ERg1/Dy4fYXOgx5SJf7QLOaiXfFNBBcZt6ETRUhpp3/8Ibp0v2Y/mmyaG8Gp8ct+bpzWD/LnyoEc54OS/SIFhpmwiv2nRMV0ULNWD6R+0Y9VHJZlJUsgWXn+6Di54JM/W7t5VQsQSQJ64ARYtt2RjdxqLpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbjx/KmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BC8C4CECA;
	Thu,  5 Sep 2024 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725560224;
	bh=4YuuyJO6Ks9XTbe/WWpmwyebyxsD7gWUehfkyYQWk4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mbjx/KmZPhtLsOjWcGETDrjVXTaAMT626Xvs8gM5+qcY8MNlROXxX2syVVAghkJ22
	 sNIHOLRArqz9r5uTV1fzuCg9FhichlWou4FApzRWiup5/dxn9EOftU2LmUGKbCtOPm
	 7lMSHYb2bWiyK+Wnez/TSRUYCHuAnUYH4HEef8Qj24ViEdS2+Our4AzDfWV9IsKtre
	 Y2LaBoE4boZ1W7biDvqMbriKgvrcR3dmbeBuhUtPfWuoBtMN2eXBukBKZWc0jumcXb
	 +t6ywLWVRr9+frubI4p+98Dsa7GdwRtc75JUnl8FMMixTqPiGkML0qrZUJSeOb3i3m
	 Mwz4u7y9BHL9g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 14:16:58 -0400
Subject: [PATCH pynfs 2/2] nfs4.1: add two CB_GETATTR tests
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-cb_getattr-v1-2-0af05c68234f@kernel.org>
References: <20240905-cb_getattr-v1-0-0af05c68234f@kernel.org>
In-Reply-To: <20240905-cb_getattr-v1-0-0af05c68234f@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4914; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4YuuyJO6Ks9XTbe/WWpmwyebyxsD7gWUehfkyYQWk4c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2fWeagXKaJ9YaF2zHTfHJro2SGH51I9z30CzO
 VTf3wodI9yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtn1ngAKCRAADmhBGVaC
 FVpFD/9Snl8dwgoASwv1nmAMH0FbkHRY60tH0Y7vWjN4DrX3Wh9hDtAcDFihPpRHG9u4oF+1U/0
 ZyQWBdr3g9bQHtJUaXoRgOe++RP3WsT0/fRsHsYT/C8jV+uZbJPPirCUYdVbmIHOMh9lzM7Nm9e
 n6XTOqDjnl1sII7OzJvPi5EP6CtyhDmMRsMG1KGFSq+yBRojI+imjSJn0cXVlhdrjRzJbt8CMti
 1oDkh5a7DtVp22jBovpcwhC74ijem/Grm42zdca/QjhOWbr7o5Vr8WZyIB/apaB2ewCCGO2J9Tj
 avQKKb/Ag/dB9/Q6T+utmynPR/fyjiqQNTftHSUUm+5ikkWdKPOkZ1D1aabAJaWqto1rGfOHCCz
 Fz7OO9YkTtud0k/i2SxIkuJcXHeeYF0rBaVHr7JQqpbMyiQRJ3IKyCWm2zS28I8qE/inyURTbiE
 j74BUBISlyBriOzh7KIi5tEXD/aGVpxygvESmJD6/KRfD1jTXX7c8MT4OYhVASAyEwpoAI+pY4A
 eGW1W89HBhnTAFxE81JwH88+NN7SoYBvX4bbXhVyu1pP2rCOIHIpJkIdi4PvbRVHO20UDWBGWfe
 TAITobynYhEnu2E2WoE6+znJzr9ZimZsF2kggIhhgpkFOlvOio6krUfbkNarBkabttGlo3vU7uC
 ddzo9uhjiM7GslA==
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
index 8ce64dd639c7..941cf4000a5f 100644
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
index 80b0da28fbad..2aa73ba7acd0 100644
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
2.46.0


