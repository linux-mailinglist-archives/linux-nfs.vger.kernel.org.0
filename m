Return-Path: <linux-nfs+bounces-20927-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEzzHS0o4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20927-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 225CE413B05
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5852316230B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E83368A7;
	Thu, 16 Apr 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9xUz/Hy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A263368A3
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363311; cv=none; b=FgJbGLfhinxsqETT2bKNU9pInU+nZloXsYnn1Zt8+tO1skCD1PxlZHfUZDoFvyfqF5a4A4TimXRDjsxgxCMLs1pCCgCxk15tJ50d7wpVligcsLFpEXJWZ7kArwVjgeUEhfxPpH4WeTvL5zd65f7Lnx3UghTjdG8nZsfAHY4ppgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363311; c=relaxed/simple;
	bh=6fXkfy/Fe3rFql01Mi1ZTgpjRYa4qqO8MQtbZowsYU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXfRxSrDWsSDBp2PxrbLPz7RRXnO/sNJacFtoT+vn4tHk3X6uCq0ahnjpyPWtLD3IZ4Q9HQYMBy7T1gdRnDblanzXYNVJDXeT04JCl51FfW1JeahOQx3MIedXiZGJTCUkbeYRqccRYi+UgUw3/tbEBwmnIEy+98TRRK8rPflknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9xUz/Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3140C2BCB0;
	Thu, 16 Apr 2026 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363311;
	bh=6fXkfy/Fe3rFql01Mi1ZTgpjRYa4qqO8MQtbZowsYU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F9xUz/HytP2Gn11AVgAU29DprAfwy8ORd2c9yQ8zSmJ1619OUuUUWdI1dvcFpkjIZ
	 julZtsEASPM4a2ckEwxesJTY9fB7BtZ5qHIAC2ww7K3yEPq1KKFTlQbJh/GKTZzmvZ
	 FjUdJu1bXBcSoEfhk29eBK15tjekdQTQeJbmJpTXaJg9LAs4sdB6vc7B6wFWV3CwDx
	 oYq74HDsr3Ugk+OEnO/+2LydPGwUZE0A1Zh8QB6E62smcR5s5lg/uqVsZ6YNUu0BC6
	 mE8AzI005MofU/y4uqUfwodWF/SvKChOCwqPWrA66AaSS01ohzid8uBjPengwFMHpA
	 pqRdkRMDIXCJA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:57 -0700
Subject: [PATCH pynfs v2 25/25] server41tests: test within-directory
 rename-over nad_old_entry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-25-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6fXkfy/Fe3rFql01Mi1ZTgpjRYa4qqO8MQtbZowsYU0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4Scjk7tuEo0AMPHBAnYYzhxZKk6RAnxTBtqKw
 6CpM6duN1GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIwAKCRAADmhBGVaC
 FWpVD/0a0Lbt7CT3qiSC/GrTGgj4h8v+7Vv54akzPRvq5HiMuHqzdxaBwuY3PTYvK2rbLyhBjgD
 gnj2ww38qhfx27m7pfdAlbfiEEXP7rTdHo1/rbztrwUW4xT/JEJ0r+0YrVX6XJYRJfobLGv/0VG
 WKzb3IdyttEI6Q0XPfi0lpdBr3v7PmmFpl9CFtFGPDkAqRkRyK9PVEU9hTEzW2EfJBsKx9q7IXp
 qEaxv/QvyKSqj+d0WOFBjPG+qJE+GYvXVusRudalUy/B/XlLyegY9IX7MCVcFTYqH2f53uyirdI
 ISG7CHdsJTaGcIczn/Hn9d8fSQpVTZ8LIqakv24rCw/d9YlpHHjSe9uVHxsTmw4oDzQqqNHqoP2
 e9UfS441EDvwGYKPhES64KqZzna/aPDFMl2hSNh7QUvFFoEqgmoBqnxWPQ1bLyZcdc8PzolRjt5
 hbsLoBe3t2vwI7GKCCwYwvRTchdmk49HvD5c5/cCdzjXTgySd5lkwhJJGWB37/u3/YueLbO8IVD
 kaLYxFjXix/1JCEN/3BO+dT8uyfYS5FBx/qF4RFtfIE9MXy0a/Q+vXtI7mez6nwZBPw3I6hxSak
 /c5U2P519sumIyXd1WXvtN/W7nKSwjY0qLwvjjpCddXG0BnaadCGlFWbqdjo7DeKWKEAY2IJnos
 2cpSzFHKDqQbPkA==
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
	TAGGED_FROM(0.00)[bounces-20927-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 225CE413B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Test that when a within-directory rename overwrites an existing entry,
the server populates nrn_new_entry.nad_old_entry in the
NOTIFY4_RENAME_ENTRY notification with the overwritten entry's info.
---
 nfs4.1/server41tests/st_dir_deleg.py | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index a2465efbcdbe..3a1d7ff2b659 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -999,3 +999,68 @@ def testDirDelegCrossRenameOver(t, env):
 
     if not got_add:
         fail("Missing ADD notification for cross-dir rename-over")
+
+def testDirDelegRenameOver(t, env):
+    """Verify within-directory rename-over populates nad_old_entry
+
+    Per RFC 8881bis Section 27.4.6, when a within-directory rename
+    overwrites an existing entry, the overwritten entry's info is
+    reported in nrn_new_entry.nad_old_entry.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG22
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_RENAME_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Create two files in the delegated directory from sess1
+    src_name = env.testname(t)
+    victim_name = b"%s_victim" % env.testname(t)
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+
+    for name in [src_name, victim_name]:
+        claim = open_claim4(CLAIM_NULL, name)
+        open_op = [ op.putfh(fh), op.open(0,
+                                          OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                          OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+        res = sess1.compound(open_op)
+        check(res)
+        open_stateid = res.resarray[-2].stateid
+        file_fh = res.resarray[-1].object
+        close_file(sess1, file_fh, stateid=open_stateid)
+
+    # Rename src over victim from sess2
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    rename_op = [ op.putfh(fh), op.savefh(),
+                  op.putfh(fh),
+                  op.rename(src_name, victim_name) ]
+    res = sess2.compound(rename_op)
+    check(res)
+
+    completed = cb.wait(2)
+    if completed:
+        cb.clear()
+        cb.wait(1)
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
+    if evt.nrn_old_entry.nrm_old_entry.ne_file != src_name:
+        fail("Wrong old entry name in RENAME notification")
+    if evt.nrn_new_entry.nad_new_entry.ne_file != victim_name:
+        fail("Wrong new entry name in RENAME notification")
+    if len(evt.nrn_new_entry.nad_old_entry) != 1:
+        fail("Expected nad_old_entry to contain the overwritten entry")
+    if evt.nrn_new_entry.nad_old_entry[0].nrm_old_entry.ne_file != victim_name:
+        fail("Wrong overwritten entry name in nad_old_entry")

-- 
2.53.0


