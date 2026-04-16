Return-Path: <linux-nfs+bounces-20915-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPkDEAMo4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20915-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C94413AC3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F097F3123FD7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA88248B;
	Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVZLuAhz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB9335BBB
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363306; cv=none; b=CkcMu2DLeZVf/+fLUSyI1EbUqdZUst2QOTvgr4IhN0REVnNtCbNPsQT2Yh1X21tl1p05pzeQkT61ZffGpwVKQlxeT9gEBYn15IiRB3Tj3azB9/gQRn26OMVkPh7BQhErIEJxnyccdZDW3FlwtOHTD0Iht2dFLA8rRtYj6YNLyrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363306; c=relaxed/simple;
	bh=2iYMDvI8HOpuP6aHcdusUlEFCRr8q9qcdL2B+NZrW7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hA3iUMNAtxRr7AjEHSZSq41CtmixIhqa/QtjXOjblliWbFgUedRKAqyj0pnF1rWKJmZBpOg+Pbr7dQtq7r6wU4Tvf3rA3PKL6rQinqtNaPII4SakUdxS+kvo+TXazNBtTpjw+SJYrRDLMej2h3NSTMYJLcdg4lJ8NpqsZCCd+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVZLuAhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10CDC2BCAF;
	Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363306;
	bh=2iYMDvI8HOpuP6aHcdusUlEFCRr8q9qcdL2B+NZrW7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HVZLuAhzcOXWQwDXJY0t4D/yaohwrOHsjTk10W7Wer880LWvdvVVsVdac2LmZexUV
	 umEC1f/scfEwFcRQNiZnBhQQIMogUWyHTb7BGDFOb5hKn6k8Jpy2jfhQs5wssQhVe3
	 1Q0YzpD3j8M03mqXe3RKGKQM1mCdQDwmRtHlpkWOGU+1JIK/wI/dgmnniC0VwmFlwQ
	 0Nlst1Xxv4mxXc+CzFk7fuqhQ7fNJv2lCq5G+HGkdpGmowiX6duHoyc7UMTnkpig4/
	 BRFARIqcEgXRl4sLbFBHvPUHGf1MlYiJ71a3QUMVcNCFx/h1DAoMXvX7F/Tb+MdIuz
	 5ha2zo/vqghdA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:45 -0700
Subject: [PATCH pynfs v2 13/25] server41tests: add a test for directory add
 notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-13-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2iYMDvI8HOpuP6aHcdusUlEFCRr8q9qcdL2B+NZrW7o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScheuSYiZHh6Pf+GE74y7HdQUXWzq/Pr7tLy
 wAEEHog39OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIQAKCRAADmhBGVaC
 FeVXD/9IrtVhRugNlONmwLx52xCEKkngmw4x8plQOTnfo7kvX3MXSF6SP2R3FLBBMl1vEQOEI8P
 qCmc5EGd8zuJEyQViEKgz1QmF2VTXNxNmLRPDNBzh8INbP8eY62szAtGPrhISW/fEX7zhOW66gV
 ddWAejOKCVtJNOPFp5LqcfnQglxG8DjmOwnTDyeEGSG2nTgTz+6KX5aQd3TT+MQC3L7K7VQZrYx
 OCMjbE8zCK1UGDs0Fu1REMnWEdm75lDE8g7HIqRvMR0Ze0lCjqM/K9uWeFnrYJTbUoXEB2hB55c
 oFA2cOiWmn6140MnLela2onlgqitj7Exwdre+wBLNdf8WFyxytSn9E9op+7LtHv9X98aWJwdySM
 8UcxmKPogREj1IX/ITLVbkZFmZrStke6MMjweMza3Fouj0v3tUb5fHxgXLweaV+BQ4HUiT5sDtY
 Hsod6kWBXmMpVGWleoE7ux15+h698OLsfyRci8v+D4S/WHhvfBdZX98s/AS+I9SPTUIBoWrU3+5
 sxfxxaNjz5TgrTQp3+tdLHmu1Qa6GqIMCAeYZZwLWX5GgwsiSd+ffxPKDr47HPPJuSbtipleyaY
 IhG98qShys3fdXKXtoomiW0JCd/HGaT7UyXxW32Uz/CKmPiN8FQUjUpCoOxK4OMhD7IFeiW/kc6
 XH9Pe2BZp13tnHA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20915-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3C94413AC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with ADD_ENTRY notifications. Create a file
from a second client. Verify the server sends a CB_NOTIFY with the
correct ADD event.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 9c348e9e80f6..b26ed1f6e333 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -390,3 +390,44 @@ def testDirDelegRemove(t, env):
         fail("Expected REMOVE notification, got %d" % evt_type)
     if evt.nrm_old_entry.ne_file != env.testname(t):
         fail("Wrong entry name in REMOVE notification")
+
+def testDirDelegAdd(t, env):
+    """Create a dir_deleg that accepts notification of ADD events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG10
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
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
+
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_ADD_ENTRY:
+        fail("Expected ADD notification, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != env.testname(t):
+        fail("Wrong entry name in ADD notification")

-- 
2.53.0


