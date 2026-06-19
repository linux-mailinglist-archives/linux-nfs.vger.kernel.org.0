Return-Path: <linux-nfs+bounces-22715-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5QoROzyXNWrK0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22715-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2EC6A7807
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=irI0hFpN;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22715-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22715-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1263309C1C0
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A793348445;
	Fri, 19 Jun 2026 19:23:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F431F99E
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896987; cv=none; b=kcBb8kZ+FtaDGlbiPrD1VbgdXVolmqieaYtjwQVQwR096Nj9kRmKoMxhyz0WXmu1jHr7wGVoV3PTSy8nLyk0oGf8xsx4GDXloYhhnpX4LUKBDSXkxyxOtwy/malm9Y9WeMj9MXO1ELN2XxT742+czW3Zlp6PoHmdYK+NMfoOChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896987; c=relaxed/simple;
	bh=yX8J69V/PwO6i5O52YmNvev3Gq3CAgmU3lavLkEPfNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuUwAvJUOZCOvXxxa3097ka5RjFAzfAyTVGiVQ2SrkHdJj/d0l8CD3/3eqcXk2/Ob+Q40gA7tbqPnU8OXdE9qUoZE3/7Nxwj0cVGG8MdQiZQ81Berf+VwqMGe6HgyiphHORvY3HiqBGAy8AlPY1svBF0NEo+Qz82WnZ+EF73kHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irI0hFpN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0AF1F00ACF;
	Fri, 19 Jun 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896983;
	bh=buhVi5yqKs/7oVUGOw407bkJj8lphTTyb/Lrd3cvLH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=irI0hFpNaCjHGntkXDpD9/Lu1L28PZsiCJQz2EE4XLJd5hJsOyTpU/mzSOrCwoz5r
	 mNMBmUnDZ0CNJmarfzZnxYxjMGw5jqqQL60ugxwNSIlExYA2WPAfXF1nl2p8JsAUGL
	 mwr8Jhjsl0V8O92WWxFCtHFXYHBPqKotgOzS592QBEVQiPK7wSKsgyR6316mGgQp/w
	 FVAaC1uqS/jQKIcYL/+h/nJgK5BgvTeuc2bSXT2CtS+xcbk9jfJSqy9hIe0xAMJalK
	 NT84ZB77Ce5byyuLtlLeIGPb40adp7076f7hEw5Sz7C4lVlQecW50kN6QB0l5zVJF3
	 PHWq8j1ST+aFA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:39 -0400
Subject: [PATCH pynfs v3 20/26] server41tests: test cross-directory rename
 REMOVE notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-20-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3252; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yX8J69V/PwO6i5O52YmNvev3Gq3CAgmU3lavLkEPfNc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb9fHcivqliEC8RbX0RBB5lheMrAUXh9WCXZ
 KfvmLlDC2CJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/QAKCRAADmhBGVaC
 FXvRD/9GP5ogpfqWCyyY17458E65OVJgLYKhIdYo4LbG7N7d+zCQTQw7X1IDwwXYLX5iIs75h0p
 U+4CwZwrMsN6LSU8ngjHpyjAQUdYndXC2X9eEyIGPM62AvrnDHqOh1m+R0a8KH/DPHEbdb+Jk3+
 5ENWN+H8oXJ9nMS9JjY0HFPWyG5AjwodV9qV9txjn+q5IGKFaRhfY0LyFt6TdOWk3/MKx23U4gg
 sHmnQvGUVBC6umcBF8PpzWRFTVUAeOv+vHvRRIJTHbO6m5P3lk56iDUrVSJi2oBsC4dmRKdy4x+
 l0oUazbQai4ImRYIdBvMfICiOxynCrYf6QETPiFSi16VGFdQJTYiD0b2cTJpbcradUqpDpy3PLs
 z0Uhd5SFMJE/cExZpIqQGJ88TvtI7DJLMIWKmoyXQxt5lLiR6yun96am5X3vFLgbeEnC74jqxlG
 Fxm3mg0R0e7z2axDRnsRdrsvBQB1tE19I2JGJVLkk5Pr+VGfh5wvIwm08feq7ANx8THWrIitYWA
 YzLvFjnjbURPPX6dCNv8/+k8uE6da0JnIM/kds2EzrpF9KgX5raghRequrDf41H6XJ7Kn0jWl/h
 G0sq8NxN+tuyuL22wKffn2fiZI4mk/PHEbNNmgqpOyX0KecThLFR6L8MR9pK0bPMud8ayRHsrPI
 OM7oF20dMwZWIVA==
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
	TAGGED_FROM(0.00)[bounces-22715-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 8E2EC6A7807

Verify that a cross-directory rename generates a NOTIFY4_REMOVE_ENTRY
notification on the source directory's delegation, rather than a
NOTIFY4_RENAME_ENTRY (which is only for within-directory renames).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 5d7c1a8fbaca..0751cf1ec47e 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -738,3 +738,60 @@ def testDirDelegFilehandle(t, env):
         fail("No filehandle in ADD notification attributes")
     if attr_dict[FATTR4_FILEHANDLE] != file_fh:
         fail("Filehandle in notification doesn't match GETFH result")
+
+def testDirDelegCrossRename(t, env):
+    """Verify cross-directory rename generates REMOVE notification on source
+
+    Per RFC 8881bis Section 27.4.6, a rename across directories sends
+    a REMOVE notification to the source directory and an ADD notification
+    to the target directory, rather than a RENAME notification.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG17
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_REMOVE_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Create a file in the delegated directory
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
+    # Create a target directory (sibling of the delegated directory)
+    topdir = c.homedir + [t.code.encode('utf8')]
+    targetdir = c.homedir + [b"%s_target" % t.code.encode('utf8')]
+    res = create_obj(sess1, targetdir)
+    check(res)
+
+    # Rename the file from the delegated dir to the target dir from sess2
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    oldpath = topdir + [env.testname(t)]
+    newpath = targetdir + [env.testname(t)]
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
+    if evt_type != NOTIFY4_REMOVE_ENTRY:
+        fail("Expected REMOVE notification for cross-dir rename, got %d" % evt_type)
+    if evt.nrm_old_entry.ne_file != env.testname(t):
+        fail("Wrong entry name in REMOVE notification")

-- 
2.54.0


