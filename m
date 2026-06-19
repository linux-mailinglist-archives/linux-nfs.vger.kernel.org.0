Return-Path: <linux-nfs+bounces-22704-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0uZULByXNWqv0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22704-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0D6A77D1
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Djq+J5Fi;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22704-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22704-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F57306B377
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D469348C4A;
	Fri, 19 Jun 2026 19:22:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A934107F
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896973; cv=none; b=rrlk5j3Nj0GDDzU37RoBeLhl0f52C0iGMxNicHvZeyO3yQkhxKEfQchqp2uMu7SV4rF0Mm8PwEeKtatqbJZd0Dpfyw6IX460J34t7dsipDFmOvMPPPNeZIyLtYsq4Q5bIOLBS0kKHwEOF7f0k8/kAp8IfwBFDFz+OtpZBcSEd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896973; c=relaxed/simple;
	bh=9Y5wyPNM9nHmW0uxevgrqDPhGyreqSTj1VA0oF6muDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuK4zcczfpgG3xgmAmlt14jwG2lUr2zc9TyXUSxGGaIh2pIhJi7kuEeahVTAiWv0/PTItazMrkTzqAhY7K7VWyfRaXX4Cd6mQ2A2kl1NKZqZ1T7br9ZAMqclc89tZJEjrsfozXNs7oJRH/jqaakB8JrEY1HZDp2VvoGJKcT5Lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djq+J5Fi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72171F00A3F;
	Fri, 19 Jun 2026 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896966;
	bh=6dIcBSYYEPfBNbKWL/c+x/Su5RKHbkO08JW/G3SiRYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Djq+J5Fi9FxhC+2/IGrDBT8HlKKkpaYuyiRLssWkfUA/TNdh1K9VM/N+0LACZMD9m
	 hoATKNvAH0PFyBuSJl90NRNDcNLJYGceCybaUTn4SAjWZ6BvFEmFX+GQWhUCvgzzRW
	 mnJqqP2Q69d5qnsnxZ4Ne1sz4Wi0GaKOTBjoZf1XaA7QC4DNpfXKjV1r2DjuIC7ZA0
	 zjli+LI3XWRzLkLYjMqD4jEp7FvqEkQKLfTfd5+pE4NJw9q0Ng8VPK6yfCl5s+5LCt
	 IoPx+f5AwwoZOIQHBqKyORo61W5WcCGkfu6yo0bM/OizbhpE1z2BvthhJBbqFLebNe
	 gUk1wCwuPTg8w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:25 -0400
Subject: [PATCH pynfs v3 06/26] server41tests: test remove triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-6-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9Y5wyPNM9nHmW0uxevgrqDPhGyreqSTj1VA0oF6muDs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb5NepOl9FgPorWJuBDJGum52aj9y8FHP3na
 7Xxyu6WheWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+QAKCRAADmhBGVaC
 FTg5D/9VypdPsPtSbtw5VFbOjj3yYtAdZGbgViecbh2XG3H2sDem4iMrjNNaSs0FNRo681WddTK
 2/JGHNZjA23/yhnxSO1SKF42HQrjQy2lgOE7MR7gXEBUPWlQH+3k7SjuiDDJKU4fNKIbJc1vc1v
 qWPdvGSmcY9w8MgHFuVIK129XPBWd0So0Sv2N27OwfnSDkRM0RB+rgI38EsnULdqG4vODIqdMKV
 /eDgGd7hsEoOXy7lnY1sMHxz0x0Mwlhykbc+u9HwpU/SmSKiMtrBflaNdqPW7OQTRNVYJU8R+bG
 QVZ9rbugXK88AXTnDymkoQJkv6+i80eEQlQwIFFKTeaOhvNW8sytzU8OFtGo/XsmcIC6sf1mHZb
 NWOZXuZJ5wAT23yZRhhTcc9KPFYuwQbwVRZQyw+MXHt0ydW4QJupGZgQt5723rS1GYdhU0bb6dW
 yMmFNjS0/OJYL2pzVnzfRB0AJVZnkOqGSYz7uFhaeZ1za3vnihwHFEEgICfSkvu3r2lun85TYm3
 T000kA6Rz7WLNge2/SdOhBGZAnhubEysphqjecNN35yQLLlusLv/0OR//wM9Nic3s9klcB8flqX
 pSFhdxpV3cy+r2ExSeFX6loOMKNElgFevcXV9Mij4sWH/lSCnZN9WyMwNWeem8A9GWmrwdiX3kb
 2RzAjVpnslr3Xaw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22704-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BB0D6A77D1

Get a dir delegation with no notification mask, create a file, then
remove it from a second client. Verify that the server issues a
CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 5f46c08316e3..b2afc7cccb01 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -3,7 +3,7 @@ from .st_open import open_claim4
 from xdrdef.nfs4_const import *
 from xdrdef.nfs4_pack import NFS4Unpacker
 
-from .environment import check, fail, create_obj, use_obj
+from .environment import check, fail, create_obj, use_obj, close_file, rename_obj
 from xdrdef.nfs4_type import *
 import nfs_ops
 op = nfs_ops.NFS4ops()
@@ -148,3 +148,37 @@ def testDirDelegDuplicate(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegRemoveRecall(t, env):
+    """Verify remove triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG3
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
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess1.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+    close_file(sess1, file_fh, stateid=open_stateid)
+
+    # Remove the file from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    slot = sess2.compound_async(remove_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.54.0


