Return-Path: <linux-nfs+bounces-20926-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF/aESoo4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20926-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244E413AFD
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70CF3315ED65
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C71F8691;
	Thu, 16 Apr 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp+K0jB0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6DC335554
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363310; cv=none; b=F7b2TQVC/it3B2z/oudXoztpt4ZVq6EJN5zStUkvJZNINX5A53NK5P3pdU+rUvaLx/vmzJm5IG+c+UcMLuzKIpNdptQ/vsXXoynKepWNl0ky2SVVvXs3QIzH0gY1ff6rsECHoZp9tSAUesMGAs7qoOhQd2lWCb9JBEwSLg/MC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363310; c=relaxed/simple;
	bh=NVgi0m5eowIrCZCoyn8VRQFgX4CjFFbyebT8EA+rgrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=liqtiwIB/Yiav7gp59uO93ukyz6vs1OgKXq+dvaYUGTSgD8EPedj/mzACYj4JqMBBiZKjiK04HtWQv01kzmWzm3qgA/LbatzAOYievDstjpN+m2rVq6e8AT2W3NSRQWMqoKKrzlDDAlnO7JipWZh5qtum+GZ4jub1KZYH1GspXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp+K0jB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E565C2BCB4;
	Thu, 16 Apr 2026 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363310;
	bh=NVgi0m5eowIrCZCoyn8VRQFgX4CjFFbyebT8EA+rgrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jp+K0jB0yaQiFQg6DP8htCqnn41LOSBaHZ4kjLa2vqxNWgDIUMtJDrOwOdGZnmEkz
	 uWfhwmbv9IMoYVRp4byy5pl4UH6K7W0ceKIb6bKCKXz8YTL0EALW4oHdVwdzaCdMp8
	 EQlyPXkyVY557hCG2pvTgk+sqXYsX4sUCUUPdKGMaOFyVYDrczLhHI+qk/UVPQMX+p
	 4b4rvDTQB1pD2T0rCXEh4BiNbCxUWMBgAWCgLyMNYJMNHaQ6Y8Lrfva88B5Olg6tg9
	 V0V3ueIU+JsLzora+V7gA3FeKCZgiHfsKMtxX9UUdomk0SG6xu6P9+rrJQgF6by72a
	 P9ODgPAca3oxg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:56 -0700
Subject: [PATCH pynfs v2 24/25] server41tests: test cross-directory
 rename-over nad_old_entry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-24-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6015; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NVgi0m5eowIrCZCoyn8VRQFgX4CjFFbyebT8EA+rgrs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4Scj40ShuUPOYuj4uWdPLhsP7+jrX2mPczYNs
 sAF6PDhZSmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIwAKCRAADmhBGVaC
 FQj9D/9WwdP2LFbGVi3kPDRnvM4PSfJUdKwnsvHsxkS1IOkGcyCLdThrWAngls9SQ1cjF+fRw7E
 DMMaAwDPzvstkLf09S5RB7q2pJJ2jVO+P2TwyeuLDyvxKvUQyVmjFdcCJJy9Nz4WtT1GikBvM21
 hZzvTEKGQkLH6SugjDR87SXMKSKnV1uLjrkuIP2+GqZf9j0JtVXF8gDRo8SES+TFJINqIHn0bOV
 AMHyoTY87T+DMw4Z+f+RRPWyUqQrz8u0yR4iivfppxVjwD1cGm/psTMPuAzKGesi0fclGkaAtaW
 iE7gULAVSHetP8MVHZfv+x0+e8YjfGw9dUG3z9KZAz+9RAqH2pkc9nhSvFhK1MTRv5G5rIU0baC
 ERz5PtgSzGPwWEshpOZPPrzJc8EJkY9HlUqyDCcVT24ORgJXV+Tloi3uZmRbQZa7z1oM55DvIbI
 LyIgT8w38BIO463ZOgZ6JJUsaaZ6VibliF9R7tkAjop3eo+pKPhdyhiS7dtitHNVj07/b91fXd+
 /tGyibe5sJo1LrziOYeumpUV9yhAjwuxkvxMp712oBYUzwlEadScu4IvMlUj6WSMwWd7SCfZtJA
 bdSWBEloIBuLaXMK18AHIcJJEx9804Sb1d36FldPIQpr5FAtaDataEAJWBZ3dG4nDFD2aCvv7bC
 LtXRkAWFDRAoVWw==
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
	TAGGED_FROM(0.00)[bounces-20926-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 9244E413AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 63072bd8b81a..a2465efbcdbe 100644
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
@@ -901,3 +902,100 @@ def testDirDelegSameClientNoNotify(t, env):
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
2.53.0


