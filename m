Return-Path: <linux-nfs+bounces-20922-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIhNKRwo4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20922-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB8413AE8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965E13151922
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714CE32FA10;
	Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KonQY5V4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00E31B833
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363309; cv=none; b=REgHvvmtgQeIzPzBATDkq0TpPTlua7jvg0/knI2dEzDGuAvB307odb2OGQbs7VzhsdxopQ9iRJ1Gnce92HvJUJAoiXTg58BFxuEt7gP0BGUDEvFs4YopoaA3OcqhC5lKGNhuAnD5PHgTbUOTpOOpiWv2ZIKJf2DL9wWsx6mZRB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363309; c=relaxed/simple;
	bh=HrdRyedO+91TNywlBwVvIFYAhflWruAtOHj9uNVA+oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/HLRg3xCDKahh/93UyMJfdS/qx4MGqoHKo9+1yGZugp2UzWptZwe0hw1ad8rRvG7BLZ9wVFuxiUo48KPYbWSUrOmxYcN4f0JM1Bd8mxdVB8A/vpzADvMk6RDP0Ail5ripJCNrGdLfRJYWIQcMpzZHHGUqTQ8Qy+kw6tjkPEXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KonQY5V4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A470CC2BCB9;
	Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363308;
	bh=HrdRyedO+91TNywlBwVvIFYAhflWruAtOHj9uNVA+oU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KonQY5V4m1w7D4D+6GNccVljKO99+ZfKv661T+U2QQUuM9jK4TTG7EkkX/nCLflDU
	 vo93rkqQCK8sDHtji+TEPHstXnwp1ZW3fmCEsd6i641BEUkA0GU2zwtdBOTjWgZA2x
	 bNqBGOtCJr5aCQ0G50vW/b8ZJoPRIwyi3AeIt1zwzPOz+uR/nT2trKV2eKiZDopaFN
	 wcND/XAk5hiSl6KYpIjaNZMMN5hPgVqUkZVgGRVbC0ejcCeBP9m6GB/mZXOher3vmd
	 ZCvt23jKec21ErQeS2XWjm9bzh2IGwk8wRNZzkT+VC49u0akWtoE8KJ44WraaiHryI
	 SBl0d/p2jDsOA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:52 -0700
Subject: [PATCH pynfs v2 20/25] server41tests: test cross-directory rename
 REMOVE notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-20-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3252; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HrdRyedO+91TNywlBwVvIFYAhflWruAtOHj9uNVA+oU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScidcjfjLt6zi4nEUp4iHOx0tfL7rIiweIVB
 QPKLP1h8U2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIgAKCRAADmhBGVaC
 Fdc+EACfjQds7EZa87+Srlt9qExUv3SNSQlYChnW1alh10KGpHbN0ukaRGZkqKDk411YJnxpgHn
 cv/86u0cCFb5CFKnalTcE6qb9d3NAVnClL3kcJVb7KKXOYtB1cZA1Jk0VWwzgBmoBG8H0bduFMa
 5QwHaP5N7AlQ0QiBwQISkXTDgXF6BsBl7whVgJ9Y2FbHWeyeuI8lIWzfnq5fssjqYRKSBebei7k
 p5G0stsyXAe2v7jWM02aGDiMo4fX0FdsTRF7/1OweyjlXcIWqoZ0pjFIypdU0a0NsvCvE8zDrWi
 GRfo4gWF5+H+pmGYVMh+DrrI9yWfONeY0Hmltus+xN1L2pyeY7WaE5x2mLM2O2fjovz0eu6hnEf
 8CATmLn9VVfwSgboSbBIMKOQuFDURCcRd1xIHpz0lI/UnxnIP7YZBUDgpH28hsEyeEZar4+UKb+
 4nPPgUV00yJbuR6vWy//d4ImmUH2GXCzCdjxDjvtGnOCb65HPZLB8tyAc0xkRJi7SzCn/LsTwny
 q89Hcv36YwRmvspWlmaHiLOimwwZZYtE1kdsGYsVek4Z8SZz/XH88prNXWyN8zprTOnBWzlkJzY
 +SRXB44CU52x9gLFKkvI5hFkrrOLCzQi5PyE4ExvM0Dc0p8Z0MTrcx2KOgDHq89e5tmh3obvJeK
 y1y0WpMrWUY7Dag==
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
	TAGGED_FROM(0.00)[bounces-20922-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 4CAB8413AE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Verify that a cross-directory rename generates a NOTIFY4_REMOVE_ENTRY
notification on the source directory's delegation, rather than a
NOTIFY4_RENAME_ENTRY (which is only for within-directory renames).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 8ad34881e694..35b6fea6d904 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -691,3 +691,60 @@ def testDirDelegFilehandle(t, env):
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
2.53.0


