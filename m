Return-Path: <linux-nfs+bounces-22721-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ExZFISqXNWrA0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22721-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91B6A77F3
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fWZV+Qbn;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22721-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22721-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3FC8301911D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B233F5B1;
	Fri, 19 Jun 2026 19:23:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93F3438B7
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896991; cv=none; b=W0Z7MCbkKJIBfcl11le6XGvmlvwgo5k50lo2D+sV1v6Daf6J/BKbanr2qb6jgI5br8SQlySXxC3yavGJFNYfzE0s/EYkDlubdiWzv921h6/RUAbk80GHzGQFxXzCOXQ3HnxvESn35efwALCFz9dnojwlKf/yqvW+SRY/3jmtr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896991; c=relaxed/simple;
	bh=HqMeZnqev5zWtXYA0qXMUjdzK8K8QYFHuQ0HBEKRqEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGhPrZO859wUoEIzN1JSh5W6MPkVgUZc+RI2Hhf8e2z/CcEP/N8lMQP7rtHWvynJ/zFAPyDe32jAj51T+qWcOOnymD+Ae2KMhsp9y6IszMtUYFQeXWNikxFVp6lUv9wSr37EteDj3Elz7srsWKWRRttQVAPc59k+ReMa1EbPTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWZV+Qbn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834521F00ACF;
	Fri, 19 Jun 2026 19:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896989;
	bh=GQbIJgmMdsqChu4THrDvYV9CxLfD3+xhBFzljFsqmT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fWZV+Qbn3wTKIQf3puthuxCDP8GzrmKXUTxo/QzQSKaIuEdz/+VvNl8KVtJK7xnzL
	 SWwsZPoZ++ZwftAAGIdXZYWmVXMOkr4oO6jMSN4b7Sl31GiYJ2zLNJnyPwFuqRxIU/
	 xQtvo90RzlDZT4TlQyPGac380lfmUYC+w69401+JAS0wjR8p8YYnHHph6G3ML7wxUz
	 rY7oEzVtvxM7tBfZyuIzapDl4NM+JyLRyoWQ+1gmHOyblQhRuIBC2K9TXK1wrkkch2
	 GfOAUTioDnquhtFX0oEY6NZij7mZGYAA3+KZhHU0y1DZIlQdrPGy4jxS043pQ6d4cH
	 VemxICz/p4ZAQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:44 -0400
Subject: [PATCH pynfs v3 25/26] server41tests: test within-directory
 rename-over nad_old_entry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-25-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HqMeZnqev5zWtXYA0qXMUjdzK8K8QYFHuQ0HBEKRqEE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb+bxjwgAihoWl9/088WrvjQkb0JhAc1tEkU
 ZP8QMsSD96JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/gAKCRAADmhBGVaC
 Fb8VEADVin30Tiq2Kf2/VhL8kU2LbtzOFig9KCDntzSxo47wvHI4uDuZnyC4a/dkjO1D3hV/th/
 VLWUie4wp3vMCT+XCctbBS4WmSyGBjVVqT/uVSCGAi/SAeL0KIw2YEZcA1RqQOPfEozOC58ZID2
 LFP4CKJl+V9w2DVtVjT5aAbLwS3RDIanKiD6+kOEnlbiAlZ2VoirIzA2N2UhOkjcI9Yx1rIeMEj
 8zZeEVSK3AB/gxGwR39h0r0NbX+4j/P+IpK7mGphDLiM3LT31lSS6h/vA4hQ0NAUn6x8qIDM75v
 B/eNmK6FtQK4VYNw/lHZo5/X+OEULgWbUPcRQEEY++97JrRAobiGwmYC/pwboSitTAC4gnjcvNI
 Q1+5Tx+FWmB7HOJS9q7FMfPe2aJ8w7AJnN2y0+rIuqKGKshatvBMvBzMV2Yy0l4E6Tb81t70kcO
 CsyDFWVBBxr1HkCDEtpDJO5sAfPznuGJ/KntcEA/Hw+XGPQZBOLsXZYXZ9mS3y8PLVxlq/m8MTT
 SIwRiNcbBHIaZs+1vLXkJKmMcaOHQcIDJxYp+Iwf/llpKrcvk+gFHK5J1c3zngaQT+sOIG0wY3o
 9axmbPnUjw7D0aqdcrbq39JALzAvcXq62UNPEqaQP0GbqJe0kGjqp446KRsVe3Wh4nt/BUGXE6y
 tug7z1SQ1OYBdPw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22721-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F91B6A77F3

Test that when a within-directory rename overwrites an existing entry,
the server populates nrn_new_entry.nad_old_entry in the
NOTIFY4_RENAME_ENTRY notification with the overwritten entry's info.
---
 nfs4.1/server41tests/st_dir_deleg.py | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 36873675cedd..7561d57cbdf3 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -1050,3 +1050,68 @@ def testDirDelegCrossRenameOver(t, env):
 
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
2.54.0


