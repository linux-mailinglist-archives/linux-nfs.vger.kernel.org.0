Return-Path: <linux-nfs+bounces-20909-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBYFEeYn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20909-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1508413A90
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4FD030F2A89
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9290335568;
	Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc9aDR5o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AA2F9D85
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363303; cv=none; b=avGunUnR7MdZz40oO5ff27AFthqGZs6gnaAJrba1/PTK7BrjyJeme0zft3RSSifNa5lXrG2q9B7rMhLTcIPWLi+ZzvoPw1AbPTQDM1dEdC03VtX9IlG/Nyf+8/MzmE6cVXJ8facrO7UMjAhbwP2itnYCx2gPvXqdIXDGPHJUGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363303; c=relaxed/simple;
	bh=Msc5hLVqprxTc8II9pe0+HkTn1rFtjNDo0Lk929ZtnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/KTCw+pa5rnZhRtp12QFNdRS4veNfVDmfbr6jRlIMopbLUSPyGSGPxw8N49b5LES9GeikwtMgEuIwejeU/1YNTwEMiY8z3ytZIr39khGhxvrBK5YFAaqelIrAf0Bln3K1tIcuufEmCKT6sNbZGfEyy6lqWTeb7AQmuhhDYa35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc9aDR5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4990BC2BCB9;
	Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363303;
	bh=Msc5hLVqprxTc8II9pe0+HkTn1rFtjNDo0Lk929ZtnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cc9aDR5oio1T8XHK+mCHyyc4cj0rbI2qR4aDajnQceMxv/l/Uuc8GckQmwu/VHBwY
	 Hd3L5HniKBVxI1Kq1G15eMAoPk8i12HgIxCV/mrwgkhdES/fzlj7ekU9yF+EVMIgvV
	 hlPnE5hqeyP0FnPr+kwVoc+/v3/D53K7ftrLtZNVP1sTECuS2Xxjj6BGMxQSisLL5C
	 5cbeOddWl4V8Pf4cT4b0RbwH/ztqWnw4JgNDEhm5vx6qsfdIR1A1gvgsrE3v15rMKC
	 JOAy504P3fw8Jn6dT46y2d89ivrhyHOm+tkgRfHHkEGw/qeXAIzxAmR+zPT2s0pjGW
	 svIeUT3DWXThA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:39 -0700
Subject: [PATCH pynfs v2 07/25] server41tests: test rename triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-7-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Msc5hLVqprxTc8II9pe0+HkTn1rFtjNDo0Lk929ZtnM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScfrUOMZOo/oCPFMMYHay+F96OC3TwJbpWHY
 olxMUxentKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnHwAKCRAADmhBGVaC
 FW0MD/4h+M0vWH3c0fpZL968L7IROYjiP2dCs3nLegs0LcMTR61v+qk1dBBQYAK7n7DR/8VkV/m
 U/d36s7uZ3BQZbVS0qXMS7PrYJ41sYvqJ/oq6LEZhbcUszmbZ2E5WZu1PlxX/5BJpFA5uJX2fJO
 s2aYhNSCrqubO0gDnEoZXWsDdjMNhLlKU82K7BseegYps7Mk290DVoTbUwj5P8LfXJoojTNm6Au
 Tu3XwhAkLCfMBij8mn1advqkNitUtrhYPPHUjHP+6FwfDH6ZKCqSlD1Q6/YP4PsgW0L3XTpzAFC
 IoKJyBSqcUWCbAzWxWUZfXBeuxHUrYKU4R1j/5p2H4jPw8JyzNdzjWSWYBdmNZXSQa/6Z2SPBmI
 077CrBC9JNp6wIZOba3cwj1apwOVzjNXZy/4wYpTYD9JP5/R/7FHyD2wHwePizUo97OZTUVxee8
 keSkqdZ9Na5x8ouvj9Z4Wa3o5OLsww+6EwKqwiISWU4GYOCJdLmG2/770sNKXICuXMI3AGD/+sI
 vNOtWykDx6RbKhOpuMx8jbMhxKcf2jgxnJfRV8dQt9Ub0Kmka8FWFuQKhjY+kcicVnmR5FXhNFG
 BMURqp63j5/9FJaIfgft6MQnGLCqcofT3YnDLDOJZuCVnMht6P5YIy+H+R5ThEHqzT9cIm8eFsM
 OwSD2BFTxN4gKZQ==
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
	TAGGED_FROM(0.00)[bounces-20909-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: A1508413A90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get a dir delegation with no notification mask, create a file, then
rename it from a second client. Verify that the server issues a
CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index f5265e8cf0ab..d8d09cd4bf7e 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -175,3 +175,36 @@ def testDirDelegRemoveRecall(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegRenameRecall(t, env):
+    """Verify rename triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG4
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # Create a file from sess1
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
+    res = sess1.compound(open_op)
+    check(res)
+
+    # Rename the file from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    rename_op = [ op.putfh(fh), op.savefh(),
+                  op.putfh(fh),
+                  op.rename(env.testname(t), b"%s_2" % env.testname(t)) ]
+    slot = sess2.compound_async(rename_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.53.0


