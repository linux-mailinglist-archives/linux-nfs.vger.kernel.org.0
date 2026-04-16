Return-Path: <linux-nfs+bounces-20916-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIMQKQco4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20916-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D1413AD3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DF2C3129C00
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3585311C2F;
	Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhJQvmvQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AA30FF1D
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363306; cv=none; b=S+gtZXnOz7zJT/tM1PnkULtyFwpyg1x3cB02wTTr8LoD/rK2m1YYuOVDabNR0vMASG/ktYPbRE6GT3aOS+BLMwCv7p7ZXCsxsbzOjCinEIdbnU+ZXHVLiUbnOryueSKIwBq9HibpZ/93OgfLpKNqW50+hbtseBFUbak1B8csiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363306; c=relaxed/simple;
	bh=UQgGQ8wu44wnQQDIWAcmEVs1OKT855cewl+l+CvQqC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjz7sKz7U6EVfI5n8xMuyh+lCyipyA3Ni6Pvv9aJhY+1X2EBnRpe8McrIV0Xa+hHk2sqsLNTPNcMhiGuVBImXRdgGTOc2wMvNX+ybo/HLr7IFLAw+Gy1sOh/4Oa1FB+KhdmRgnCHQn2BQw3VhB7WWzE20Fvam7MDf7vAjduUTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhJQvmvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A76C2BCB9;
	Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363306;
	bh=UQgGQ8wu44wnQQDIWAcmEVs1OKT855cewl+l+CvQqC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hhJQvmvQZTboFRAoWRljjlAioAzBkiEk6bUzNdpNZMEeqETC8lIcb4Y5S6WZrbYI9
	 FbxpLSyls0o2Wc86nQF5utQxT4Ot0kHLLaL+MJVUXScjOwyiRuV2Cc5lN4/KuKs1ru
	 iq3SQSIAvQ3Kxppxcn161+nKwAIVQUiHN1bq+WW2NY+9fEh4C9qrk6PoL9CGwDLglJ
	 oM6rJdW3toLoiw0JsgfQ6a3Q/A8a0L7dYTCyVQq+aQoW1Tm9qfDoutBbyG5NG06rxi
	 x2Xo/tS5rkXeJe9qlMoOOJq3iov3fVRZslBUpbfSO3iDnSB/zGv7xohuaNe9lLrwua
	 2MhFLO9DqV1TQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:46 -0700
Subject: [PATCH pynfs v2 14/25] server41tests: add test for RENAME event
 notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-14-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UQgGQ8wu44wnQQDIWAcmEVs1OKT855cewl+l+CvQqC4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4SchloIlNEp0eGzD1A1p5bR60VVKa2TnZkymF
 LRfDhhi2P2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIQAKCRAADmhBGVaC
 FXFXEACZHit5RXhTFOA/r1WhgejaanhUYg6W7Oop9n/qt0RFYMezgVaIcR8JNQR9J4bgdHxDQwR
 hcdj/BqMdLCAB4g47nsvj4aNALS3nKpbAeL0NyyqnvsV1WyyBXRwaRV0dUTTBCsdoM2JCs0DZFP
 ZCK9tEbiXm+QLmSeGO0Z4siJOZLD/vwhb5hgeJag1YhkjElYQWxdDnOtml1jFLGDaQ1jsTavrxu
 j/8ESBGKgO/8OF+UJAmB1+BBdNePUGkXBkDdKMO5RwYAajOhRluLtRBGwok2k0T7mPdh4X69QjW
 wf2t3p/A8Q/VcVERA+WbdCn3uw4heFAbhZio7VObvMRc8K35SiVpJzva0JjM8yBEVThrQ/HKL78
 Gw+heAk37xGr4Y5AdEsgIerI3m3eizde1gSU7hcDRMqyKXzt/0S8mcDd7kQdE2Ou8Uh5bDFYgR7
 JweePPSHB6asmQ7EvFo1b/Ahl0YjiV5fh9X7suSGRPfk6Qcb46dlfIFsGZE9p13VUsISs8Y/LXB
 kCLUfOkaiabx6eRNIsjeJmJGCfbtO+hkCn+XwiXFtzv4uvd+shFefWPQPrGbABwl32/fHWqGF2S
 1Q3QfIBgYHCSI2r/yKdT0zF+/kOfN9If7gRynYXUUAOQO3SIuYGo8Rl2OSs71v8AoI6LH504n1y
 TMy2zw8SSuxzeQA==
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
	TAGGED_FROM(0.00)[bounces-20916-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 492D1413AD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with RENAME_ENTRY notifications. Create a
file, then rename it from a second client. Verify the server sends
a CB_NOTIFY with the correct RENAME event.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index b26ed1f6e333..2c1cb846cb4b 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -431,3 +431,47 @@ def testDirDelegAdd(t, env):
         fail("Expected ADD notification, got %d" % evt_type)
     if evt.nad_new_entry.ne_file != env.testname(t):
         fail("Wrong entry name in ADD notification")
+
+def testDirDelegRename(t, env):
+    """Create a dir_deleg that accepts notification of RENAME events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG11
+    """
+    c = env.c1
+    cb = threading.Event()
+
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_RENAME_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
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
+
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_RENAME_ENTRY:
+        fail("Expected RENAME notification, got %d" % evt_type)
+    if evt.nrn_old_entry.nrm_old_entry.ne_file != env.testname(t):
+        fail("Wrong old entry name in RENAME notification")

-- 
2.53.0


