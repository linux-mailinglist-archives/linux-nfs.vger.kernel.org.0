Return-Path: <linux-nfs+bounces-22719-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avAmJ0mXNWrR0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22719-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A96A780F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UdAFoRGN;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22719-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22719-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE83530ABB31
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8A83451A6;
	Fri, 19 Jun 2026 19:23:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61996345CCA
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896990; cv=none; b=YOCwwZqEZ2vI/NVWE4Bvt9SSGgvB1uRbwc9cVt0q8NbGoovw5X6GH8drIBNCnIg/5Oh3f5iKWZyXpShyX/CwgLbElTFno2xq2IUb9DyNqol/6uYCJZPM8m1R9kYcE/N3GY/KWVYGQWSnx2WnqqnwdnOLDHkgg6kcbn+FCV4sFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896990; c=relaxed/simple;
	bh=QxVcOnqNBG0kA34Up6SyrAi1MkZLPpd3OrTv7ghHGw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZeNqS8xFAOQ7lJ3cOE/WbG/P6HGPBggvhuzbwrjxeZ1/WKCOdCdnx9ctXkjiWWA3sjkheVvoXN+w9MNa+sfWjo5e++bMsg5++WVxzkLfnGpj7Jzt+1NGbhHmBdv0PVCiYgWNy5VuixEKqTm/k3YnMSUy7uotqEZT1mAev9/eFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdAFoRGN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542531F00A3A;
	Fri, 19 Jun 2026 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896988;
	bh=LGgudBmyulwnWJQDOV0u3nFa0A/rb9xsmtdkqXhektE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UdAFoRGN/H0B3b28l24G2t1TwkQ1HSgKY3zqKjEWcvxYfCfDkL5m26uzOVxXMSrpP
	 y+NY6qWvbvPsA0k65Bh9mvA3Pr5R3poHAc40oSdn2LXUDtWS6JlcQwX4E2PQnqGPWo
	 PjmVFsz5HkJcPWkqBpDX4xdQoA3ITD+ReayVtW2/Pzh59Qchef0c4pp+8Qm9+Yqx0U
	 gaC4+p/mKbbEZH8pKhd47gZbZVvxbgUgcr1mEdSRyNE0/1ti7J91Pi0MAUi3psZANK
	 7LDlJVyBJ9dc9DPjCSNpb5+OJE2siMVg8SVhh/B0x6Nikot1Jn6rx/GyGdrJ1dnNSj
	 oMFKBMfPx2Hew==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:43 -0400
Subject: [PATCH pynfs v3 24/26] server41tests: test cross-directory
 rename-over nad_old_entry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-24-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6015; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QxVcOnqNBG0kA34Up6SyrAi1MkZLPpd3OrTv7ghHGw4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb9s/vOkwgmEqUS+Gi0yN1eIIPGU+lgDWHI7
 gqhSj464GWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/QAKCRAADmhBGVaC
 FSjuD/9PDOMByH16CvHtPtgfiz1eS5n+QRRJvZKOwP6YXGZ4cHrNfElb6qMKakHW8e5ySLI/e4A
 SuI7UZC4xFPZghezvHkBiV76WNOMgb1r9U4zdV90FxyLwUqSouoHhTCncuVxP5xXRyxpZyeQX1C
 kxR/WrZMkvHS/MUYoK8+gBCKClxF0qcQxnvJ7NYo0QKj+sYcXii+07E0uvorSebOyBBcqMcHQ+b
 Nl4xkhfTSfQYdeKr/ZbLXEXxJ2BYsVAKrbIJiU9wZTxAfuq/K+HjHvrHk2ychXZy4w684Bn7aX2
 ApGaes3LDfF809JomLmoqwI4t14iUoqsy+ellijsbTx5mPR1NW9IFs9EAKdXBPQ/uz/alnv1TV/
 NmFYxMyxCs/nG8eoKK4a+ANHxMa5kW1ypd2+tnwmttZpw4IQAqsPE3i6jYnOY+Fy29UDoaQvy2a
 NhNBzvVSFUVtNyRXQImsmNCZHfNv/cUGbdaZ7JYfy3T/s7thCRhh0K6ESSr7diD7MYGsT6L7y8r
 ezwSgW/ZAIAdYkT6jEvSAe/j6ZiZWRaULbSayH+JIEheqIBNNk1GWfeYU0I7QOVP196cbRzUFax
 JgGC1LKGwP/1q9+pbzpJMnajGMeOWUXMVg0ZBCDsoH3DVm9y3qirwCkpW14037EpFhxbQSOSFzq
 l+1tg6fPJI67POQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22719-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 121A96A780F

Test that when a cross-directory rename overwrites an existing file in
a delegated directory, the server reports the overwritten entry via
nad_old_entry in the NOTIFY4_ADD_ENTRY notification rather than
generating a separate NOTIFY4_REMOVE_ENTRY notification.

Per RFC 8881 Section 18.26.4, when the removal is done atomically with
the rename, a separate NOTIFY4_REMOVE_ENTRY notification will not be
generated. Instead, the deletion of the file will be reported as part
of the NOTIFY4_ADD_ENTRY notification via nad_old_entry.

Also fix _getDirDeleg to initialize cb.changes as a list and use
extend() to accumulate notifications, so tests that receive multiple
CB_NOTIFY callbacks can see all notifications.
---
 nfs4.1/server41tests/st_dir_deleg.py | 100 ++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 8da51bb53cd6..36873675cedd 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -44,7 +44,7 @@ def _getDirDeleg(t, env, notify_mask, cb):
     def notify_pre_hook(arg, env):
         cb.stateid = arg.cna_stateid
         cb.fh = arg.cna_fh
-        cb.changes = arg.cna_changes
+        cb.changes.extend(arg.cna_changes)
         cb.got_notify = True
         env.notify = cb.set # This is called after compound sent to queue
     def notify_post_hook(arg, env, res):
@@ -52,6 +52,7 @@ def _getDirDeleg(t, env, notify_mask, cb):
 
     cb.got_recall = False
     cb.got_notify = False
+    cb.changes = []
 
     c = env.c1
     sess1 = c.new_client_session(b"%s_1" % env.testname(t))
@@ -952,3 +953,100 @@ def testDirDelegSameClientNoNotify(t, env):
         fail("Got CB_NOTIFY for delegation holder's own change")
     if cb.got_recall:
         fail("Got CB_RECALL for delegation holder's own change")
+
+def testDirDelegCrossRenameOver(t, env):
+    """Verify cross-directory rename-over reports overwritten entry in nad_old_entry
+
+    Per RFC 8881 Section 18.26.4, when a cross-directory rename
+    overwrites an existing file in the target directory, a
+    NOTIFY4_ADD_ENTRY is generated.  When the removal is done
+    atomically with the rename, a separate NOTIFY4_REMOVE_ENTRY
+    notification will not be generated.  Instead, the deletion of the
+    file will be reported as part of the NOTIFY4_ADD_ENTRY notification
+    via nad_old_entry.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG21
+    """
+    c = env.c1
+    cb = threading.Event()
+
+    # Get a dir delegation on the target directory
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_REMOVE_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    topdir = c.homedir + [t.code.encode('utf8')]
+
+    # Create a file in the delegated directory (will be renamed over)
+    victim_name = b"%s_victim" % env.testname(t)
+    claim = open_claim4(CLAIM_NULL, victim_name)
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
+    # Create a source directory and a file in it
+    srcdir = c.homedir + [b"%s_src" % t.code.encode('utf8')]
+    res = create_obj(sess1, srcdir)
+    check(res)
+    src_fh = res.resarray[-1].object
+
+    src_name = env.testname(t)
+    claim2 = open_claim4(CLAIM_NULL, src_name)
+    owner2 = open_owner4(0, b"owner2")
+    how2 = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(src_fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner2, how2, claim2), op.getfh() ]
+    res = sess1.compound(open_op)
+    check(res)
+    open_stateid2 = res.resarray[-2].stateid
+    file_fh2 = res.resarray[-1].object
+    close_file(sess1, file_fh2, stateid=open_stateid2)
+
+    # Clear notification state from creates above
+    cb.clear()
+    cb.got_notify = False
+
+    # Rename the source file over the victim in the delegated dir from sess2
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    oldpath = srcdir + [src_name]
+    newpath = topdir + [victim_name]
+    res = rename_obj(sess2, oldpath, newpath)
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
+    # Look for ADD notification with nad_old_entry for the overwritten file
+    got_add = False
+    for change in cb.changes:
+        evt_type, evt = decode_notify_event(change)
+        if evt_type == NOTIFY4_ADD_ENTRY:
+            got_add = True
+            if evt.nad_new_entry.ne_file != victim_name:
+                fail("Wrong entry name in ADD notification")
+            if len(evt.nad_old_entry) != 1:
+                fail("Expected nad_old_entry to contain the overwritten entry")
+            if evt.nad_old_entry[0].nrm_old_entry.ne_file != victim_name:
+                fail("Wrong overwritten entry name in nad_old_entry")
+
+    if not got_add:
+        fail("Missing ADD notification for cross-dir rename-over")

-- 
2.54.0


