Return-Path: <linux-nfs+bounces-20919-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLlIIBIo4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20919-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F3413ADA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65AB331425D1
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12333554B;
	Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGUDAfvp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8279335566
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363307; cv=none; b=dSsiRE5uCY9mfmmjsjfdGNGoRPCCRC6p+Yq3jhuKuiEGP6O76e8pVISt+8j0KC4lNKOR8LYHJ360rGkI+fWeZ79oZseI4LsQB+OJx2d2yz9TUhtsgrx8uHH2YfWmEu/nNw9wbYszXxbF5+RcEx/JDwtvtjXNdIkmGNTSWw9uWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363307; c=relaxed/simple;
	bh=r8rUcz4BiinAxNamBxrDZuJpMaEcD4AyNCDi0WQIp9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LyUW1+PKPAVzNeCbC6PWdxfOR0hGKg7/RDwmK6Mg3GacCeCTL3clTG3TQ8JaiwK0yzgNOMkBHQBTnNApx60OomLKWktS86GnHTbiL/dCwN3RY7SIjZOaO9Pmp7V6D4HsBZNoufK4d4ee0q7OFmtHwRRx/Tdqp/S6F5/yn28GXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGUDAfvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AACBC2BCAF;
	Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363307;
	bh=r8rUcz4BiinAxNamBxrDZuJpMaEcD4AyNCDi0WQIp9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QGUDAfvp+r7VaSnc3+yOVUJoV7bU91aBr5kIOURVKWau8D1LaiPTgbmLceBeYDck4
	 VAc3grM1fXNVY1t2D2gOiYt7G5iQOCjZAihGZAO8UR8lZ7FfflEbUXcVffXOi3u34h
	 NjZRmeuNtt5gLhRps1ffhzLANM1AZA524+DMS75IgGYdDyI7Z8+6Y7PhsCi6kw6KIY
	 bXJQt+2PclO7emN0q+ZzBVNHnPFSTtH3JbAABdHHXk2IXYFL/Pwxrfj9weSg08OtYM
	 RXHDwfdRslBUsO1kUUjluBc14q8TY5ANtLKLQYQr5nTyjN7NQwu31Z4DM4vp4titkw
	 86NwDMBj5YlqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:49 -0700
Subject: [PATCH pynfs v2 17/25] server41tests: test mkdir triggers ADD
 notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-17-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=r8rUcz4BiinAxNamBxrDZuJpMaEcD4AyNCDi0WQIp9w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScihuODaGdJ0ZwJ5Ou2c4jtFxP0wv9gjrKeS
 Vt59sflO0KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIgAKCRAADmhBGVaC
 FS4TD/4jJMtq/pQ78kVjwlAi+Rz6mwLSPZjOlbXuXStqMKOWvAjwD+p02xdH1W5RzMshgRY0aU6
 uYM8wlhx/1gHkzbbAzG1qEbnGjoBIxd6Gw/RXNaOsoeIDiKmIpVPMlAE6skrs2qv1QHJBYl2mk8
 /F+WlUzm1P0jyPgrIMJ5D7uhgnvivMXjE0PGP6al8l62VPIZ4VQ77heyTPBN7z2ZoibF24VOsZ7
 I6ztdpkXox1ftRRTP98yutvKBuzi59JNyWl7rwe+HKgDOCNfaaxlaFe+pVMFQEvdwpL3gam+Ktd
 j1v83ubgYVU/9Lvco7VLnNSp4O1KaqAn0ozsBo8n6oi1QpV3fJj3Iw3h7PZDQw8TLSulI5w2Snb
 W7qFsVA7+qDOKNxVF8juZc+F38uWg8PsDMwy410lVjClpcTH9VSOeGntNclVD1jIDLUlERV1E+Z
 wfnUYTC6vpSGSHbgVcWESiPdmGNtzPra/17x2VvudGG7t/buX2QgFcPYwdoKn2OMOZl9NBZMrzw
 VM/WRONFfXqM79hLrMlml7eTbQuJtRlricxLg+zHPVOOdjal3mJ8Ks54UYxIeJeiULK3dVwzy7g
 fzkus0uLJGgEUgrFAiwpkezW7ZKng6dlRFRdT8cGJ080Nu686depA+6g0vUBF+2vadKfBKmEXzb
 HNj3/rm2ROm5hTg==
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
	TAGGED_FROM(0.00)[bounces-20919-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 032F3413ADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with ADD_ENTRY notifications. Create a
subdirectory from a second client. Verify the server sends a
CB_NOTIFY with the correct ADD event.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index e4d922be9d2c..282fbbb9e09c 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -572,3 +572,36 @@ def testDirDelegDirAttrs(t, env):
 
     if not found_dir_attrs:
         fail("No CHANGE_DIR_ATTRS notification found")
+
+def testDirDelegMkdir(t, env):
+    """Verify mkdir triggers ADD notification
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG14
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    topdir = c.homedir + [t.code.encode('utf8')]
+    subdir = topdir + [env.testname(t)]
+    res = create_obj(sess2, subdir)
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
+    if evt_type != NOTIFY4_ADD_ENTRY:
+        fail("Expected ADD notification, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != env.testname(t):
+        fail("Wrong directory name in ADD notification")

-- 
2.53.0


