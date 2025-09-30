Return-Path: <linux-nfs+bounces-14805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2396ABACB66
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3D354E2676
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E52609D0;
	Tue, 30 Sep 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF5Ow7D/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90751264623
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232267; cv=none; b=tt1EGpPB99LdomOR0AOrVLENlnrKqA0bD56kbKlEJPJNGpVCmMt5N+Aap4koShLQH0vuPWWhLNIZmrXmrTTqgZhwIJyuqO6Q81B1grRm/Nz0mj/5V6OvQaJQPhhGVxT2scxF/78qMlwbVY1s1VH30uGEEALG8SIP9ERQl0+wbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232267; c=relaxed/simple;
	bh=L5l4WoYVwSE3CVWlqFBz64mx3pAaC0es4//oLQdAMuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAKctreo7oCsy3Xp12QQ6O4vfrG7YVm8JHWSRU6bQ4YM1xBiX4STI/hXxhw7V7C/KplULfRl8lSeaiOjkClIbIkRnLa65mRMxgR0Rc2P/+g+zStF8NZQAb1UdfOoXxA9KUhkFxD62IH2j2g0pGSANhUu2IeWk/zYV/t4nfYryOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF5Ow7D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C9FC113CF;
	Tue, 30 Sep 2025 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232267;
	bh=L5l4WoYVwSE3CVWlqFBz64mx3pAaC0es4//oLQdAMuA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sF5Ow7D/agfEXbcDlTb249lIMjkEUhMQOBB0S8iGsuHXkv45CPit8K/eYzJTvoJIp
	 rgwdmGUHWBplRzzi/qOhCdD/DmnBTJvS3eXPuIh+4uH6AuF9N9g52y+apTowScx6D3
	 Tdd9CJ7y37KamoFv8cPI8q7XPfE2c+aBFXvTuWLNLe4PwzJks5OjQAImZ23j5AYAd+
	 MgLgY4O+nZSJKyU4G3zKwt0GT8JzOPuufEJeLe9NALi00SwHXzLFhMYh8+9WYW4lA7
	 WefNBD09srt75OhN+rk4k5MIlXjzTCB8GzTo4V8mHCFOrAa0CK1XQBUJ7FA1sFqf8h
	 zLOypw4Me5UIQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 30 Sep 2025 07:37:40 -0400
Subject: [PATCH pynfs 6/7] server41tests: add a test for diretory add
 notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-dir-deleg-v1-6-7057260cd0c6@kernel.org>
References: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
In-Reply-To: <20250930-dir-deleg-v1-0-7057260cd0c6@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=L5l4WoYVwSE3CVWlqFBz64mx3pAaC0es4//oLQdAMuA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo28EHa0sGSXvbgTZCd0Nbc06q21Kg1s8TKVJQn
 fbG1gtDdMKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNvBBwAKCRAADmhBGVaC
 FYxPEADMZ0qgtBOKLizNhdqVXiOFHpxxpm0cQUQX5Xo+oAe3+wo6JfV7+oYwhw8tG+xTbu0SRp0
 lFyHYzyERSYaDB6fhMgYjNxFiUGlFPk+qturvmsdhhIWMmuNoxeSFxioxWr06mpSEUm6zYIwm8A
 CpYgp4/11+8TNuxWXPT9bDWiS0uYwqfLQ2IDditOwLmq1WyOhkPQJhibYamhIb2+n0EXcTYnOCR
 JoOlf5Iz8JwLJU3BadrFTBe2YO3NVmNLGpSuSOv8I2AXL1LYHUUtWzS2AaIcfgBzf9b6ee7afs0
 rgwTcTlb1s48IdQqTrR7+a5qa9B7Zu4qHTYJj2LVMXKQ0c5hXL80Zm6Tyj6xSnG8SimfVyH83Wd
 iKjjYN4svoFpkqDUh1RAK1T/vm9Te67/2aduHAlXToOMMDw2xwFNOXYkBdsN6nNVPhOYmOQNLr3
 EVXAXQJqQnlDugmLIhNl+GTR96ZXtL7Taif7SmV6BoZDGFb2s0nhPtUPJ0CMptxtNjzhK6SvLkf
 W9n5YVmTxiWPHOGup7x8OTjd+Qxb/6ZPUvAHSbDcuWKnwekDZ7xt7nqhVtpTzXzf7ahABE/E93q
 f9RMPWkfwW6ZgiSKOoysi+zKOQBaPVttjaCfiNr3KsU2V/Y+eGMu7IkcYDy6ugsxzTztNxbTPNa
 6JlK6y5V2syFfkA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index f44a8f10738b1e6d5868f4496ba4bda1c5be810d..7073c590cb537f83552d7d8afa0ab02da1fe07c9 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -150,3 +150,36 @@ def testDirDelegRemove(t, env):
 
     if (not completed or not cb.got_notify):
         fail("Didn't receive a CB_NOTIFY from the server!")
+
+def testDirDelegAdd(t, env):
+    """Create a dir_deleg that accepts notification of ADD events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG4
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [NOTIFY4_ADD_ENTRY], cb)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess2.compound(open_op)
+    check(res)
+
+    completed = cb.wait(2)
+
+    delegreturn_op = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(delegreturn_op)
+    check(res)
+
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")

-- 
2.51.0


