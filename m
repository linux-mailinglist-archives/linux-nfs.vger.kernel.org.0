Return-Path: <linux-nfs+bounces-20924-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO0HGSQo4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20924-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 058F5413AF6
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45BF9315969C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18966332616;
	Thu, 16 Apr 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpPfGr15"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0D30FF1D
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363310; cv=none; b=M2pxoWfguXhAgC/1PiNdKwKrSTCkjMSOu8HEpNR1kyuQ0dkJnkyWSJsM+xxoz4XJ3xNMurNgHUEylC0TZRxw3UkYxWHRItqlcJos1G4iQL4Icf/bYDRqRGc940Z7FjZ85sdw6ja+WRtYMK6l8ueSzkkzvqdNqUCKhQqWLvtWMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363310; c=relaxed/simple;
	bh=ecn0+GFfdoF0q8PaR1bpwYlQvn14hGvml3qFTLt7y44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbjWh159jpCR0mMxWa5jW4RzedlORFFRFRtqGT9EFHxUFgdLVNZthQGS+VKT10lu4d3HbQ16QKq09hjNqxGoYLB9SeI/5EMvXHhwASQRrvTkXIp5r5rDqS97dmBMcaSMC/WSk6HjHFmjbXha9U4pXGiiEejn0pRJ7baGxXyAT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpPfGr15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E46C2BCB7;
	Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363309;
	bh=ecn0+GFfdoF0q8PaR1bpwYlQvn14hGvml3qFTLt7y44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gpPfGr151Lj7TqFCsmJ5A8aEIzx8qKiR4mpfgbPwmYupCpMsr4H9dP2cpjEgdJqol
	 fGnmUkPjcptyvdv4D+wdWyCi7YqSivDg2hygxre6hoL6LDlE/KbsFVIlztgH23g8Xo
	 pWD/3waAT0erbGfX6zYZHbiv5JLp9qgLi4eBEJ0Ro91VErvjiFB6xeF4/JsnOwWKSe
	 nHuaIOxypPKYt0sxX/NsMif1jDKDWaf2L93IrSaGIcJDqodfexiTC7OyPYvbm2dSIj
	 Qwiybdz3VdQNy3hn7/L5C22/k+OQnH8pod5L4MiSxQ0KFx53SjEeyTB+AH6bQn9xby
	 BGuiC2bulBwwg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:54 -0700
Subject: [PATCH pynfs v2 22/25] server41tests: test link triggers ADD
 notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-22-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ecn0+GFfdoF0q8PaR1bpwYlQvn14hGvml3qFTLt7y44=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScjClVZIQnHQoU28yypXTs4a3o/CHoRsyJka
 oQkloSEjp+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIwAKCRAADmhBGVaC
 FTGrD/9Jxh1x3HyetPwfrtd1Tnv8XrlZ4D7dWPK2HAMpikgblGFaqAgHjU5NctmTaxvPalzeca8
 knTBJbIMUzVuMvErjYB2S9e4gVanYDyv24UeJCzlvwmboqVGrptMjHJFR9xmxDN4AeT10dSuCop
 rMX3ehP5WrQBEX9SOo5ntud86f9D/NC6oc1RLvDrmrhzTsciSIpp43JanfOEfKggQdPpCjEWRjy
 8XDW3+bVFKdSe+F2Rk58/uuQBn6yyNWA+hMV4ZqIzupwJquNsZ3o8pBwqqeF/Na6QZjtCUtajOY
 t4CyN8k7CyecYgt9n+DfWF1e2nJOgbWuLOc+6dyAWL9VnNoxpGdfyRTAWXnQGs3MgzDlPsr+OlQ
 +meiXG91D9WWCv2rMbAp0iQyUIkWst83ZoCOLvZPPXqXV/QQIMQOznpnH+kEL8gh9q3xkR/eGCU
 736ok8xQ7rd4D4q9B7ZuWGNspTX7fv0s+wnBYghYXHioFh7SfONCsb0SmgbFlIm45/p3A0sVfXA
 dL1A9QqibPtTsWzBuYZTKn47nrvNj+7TkNvIy+HsZZ8YWFy9+Km0hOhrVOwcT7ijUawPogOL3BB
 S6Aj9ZxF2Nrn5fuJsWEb8iNf7WkSKJXWknjgE/Yc70QZBbcXT50uU7p0WtNkeqjlwq3ZfnEEqhQ
 xZVr9wlvaDRUY8g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20924-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 058F5413AF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Verify that creating a hard link triggers a NOTIFY4_ADD_ENTRY
notification on the directory's delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index fab4d64eed42..7c230d40e808 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -808,3 +808,59 @@ def testDirDelegCrossRenameTarget(t, env):
         fail("Expected ADD notification for cross-dir rename target, got %d" % evt_type)
     if evt.nad_new_entry.ne_file != env.testname(t):
         fail("Wrong entry name in ADD notification")
+
+def testDirDelegLinkNotify(t, env):
+    """Verify hard link triggers ADD notification
+
+    Per RFC 8881bis Section 27.4.4, the server sends an ADD notification
+    when a hard link is being created to an existing file.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG19
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Create a file in the delegated directory from sess1
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
+    # Clear the notification state from the create
+    cb.clear()
+    cb.got_notify = False
+
+    # Link the file to a new name from sess2
+    link_name = b"%s_link" % env.testname(t)
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    link_op = [ op.putfh(file_fh), op.savefh(),
+                op.putfh(fh),
+                op.link(link_name) ]
+    res = sess2.compound(link_op)
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
+        fail("Expected ADD notification for link, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != link_name:
+        fail("Wrong entry name in ADD notification")

-- 
2.53.0


