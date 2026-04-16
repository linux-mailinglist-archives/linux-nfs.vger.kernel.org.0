Return-Path: <linux-nfs+bounces-20923-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKjYHB4o4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20923-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45C413AEF
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0670315304C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F13324B1E;
	Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tcoi7TJU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CF330324
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363309; cv=none; b=cmp6nrdUs9D/cQ43HUxG42kuJqZhHr6B02zWgL31jkXYOWLk+Ymd7RiBALUQGDypAZtjCNEYJnv2bRwd2jp9n3vZo8hk8gH8n//lbeIMlWrFwP066UUf6grLjXgq1IpttB/OWw+eT86oH0baCkonFhYAAQHiWiP+aDwjU3KzZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363309; c=relaxed/simple;
	bh=0+MTLnvJP8e95ITXaNH9fmSDcGyktQY5R1Ujk5vYyTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7/U34zT+BGZQkcScZ3l/g9FkkJ995aoPrxavs0mphrK2iaHn9IEpB+jKlIyrNF+ocUd5OTvsF8ycbvulCgCczcbWLQINGITKfgFJXkTPWP7nfpAu8hNVZM/htpb3q2oP/A3ZmK+Q/oUclkPV9nIMBB1juVKe51oFWrEaKuxMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tcoi7TJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A42C2BCAF;
	Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363309;
	bh=0+MTLnvJP8e95ITXaNH9fmSDcGyktQY5R1Ujk5vYyTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tcoi7TJUMcpKOtCannBzB/rPrLXCzZzBqGpwHy7XaPt+z92nk6ftJIWCs5tkZnjoe
	 fBEHwNcXg/VPtKYE5o9bviKUSP1awQSqZCQqxWCNTNb3nOfKq8KX/gPmirWJ4Cf5sT
	 4+W3I2jp6h36yClRqLL6ZOc3HHcj6oeNoAyj/sWbtjZKAGezmnMBuZ+t78aQiDbwRm
	 6aXnz+Df6h70buBFZ7uOuNe6h8/iuYybKXQNGUcUPMTYZFRFe9+VfYKqECQ/+kW4iM
	 w9Zoj4UMlvj9DVVrzFoxRIU6rQ2K6fGRJs0J71rrVm17yRtCG8/FfoSwUFV37b50Bo
	 ay7pUAzicp+pg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:53 -0700
Subject: [PATCH pynfs v2 21/25] server41tests: test cross-directory rename
 ADD notification on target
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-21-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0+MTLnvJP8e95ITXaNH9fmSDcGyktQY5R1Ujk5vYyTw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4Scj7Z7+qmzY7XXqPAt7/OTKueI9sJtrr3LrS
 E45JG5pDNOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIwAKCRAADmhBGVaC
 FX13D/9sc5tcQqSykkjIZkhdAB0D4LdLCyr743Yy6PBpggadpkMNamN4q3yrJi28Xior1lFG7MI
 RqryJJQDBPD373V8Asef1QLPq9/GlLCEsSIMTyu6g7cBgi2YituXHa6rDws1/0XoXSTDV5S97r8
 ut2RukUlzEl/kgYabJhMYjLgJZYg+icnqVyAPFGpjy88RpsbZt/pUCI/SCyDST/tSQGpSHmChcP
 uS9YrITpEDV21NDfp+XaMRV+xGUARz31GZhNMtpIPd8gEuTv8qJlsV4TtTSDJvQlDNxS5l04lBH
 dGhLbyW2rBKTIUM/CROhu9PZjGFc8DR3UW7LHtIyoPqQmkhzSKI6FnFi07Ds40zQylaSSGRigWd
 ArcbotDFFmokbLiofQNDDwYLs64C59JRWePmSiLdGHMAVB4Z4rAlpc93gfX1yUKqxJE2D9ek53A
 +aq1YEcqsdc4HjT6s5XWKsHgg9i15jWcLiQlRmvr7LGd3w+QugjOH06bHT2Ii6S6t1V67V6V/Vw
 6AZFP8hQhIEvb4oE5szXcEixf9nUh50zm08L/lMWgwJyi4kyBD94dG3oNvSxpI0oxT7nihCE3E6
 ARhbbpPrnO66pJP0oHNYrJBbHmKCTWL6+xhhHUj0NTvrC9Xs9jTj7iJGo7vXfKFbbFNeoGK1G2N
 FroL0xmZbXfQvAw==
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
	TAGGED_FROM(0.00)[bounces-20923-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: DD45C413AEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Verify that a cross-directory rename generates a NOTIFY4_ADD_ENTRY
notification on the target directory's delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 35b6fea6d904..fab4d64eed42 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -748,3 +748,63 @@ def testDirDelegCrossRename(t, env):
         fail("Expected REMOVE notification for cross-dir rename, got %d" % evt_type)
     if evt.nrm_old_entry.ne_file != env.testname(t):
         fail("Wrong entry name in REMOVE notification")
+
+def testDirDelegCrossRenameTarget(t, env):
+    """Verify cross-directory rename generates ADD notification on target
+
+    Per RFC 8881bis Section 27.4.6, a rename across directories sends
+    a REMOVE notification to the source directory and an ADD notification
+    to the target directory.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG18
+    """
+    c = env.c1
+    cb = threading.Event()
+
+    # Create a source directory (not delegated) and a file in it
+    srcdir = c.homedir + [b"%s_src" % t.code.encode('utf8')]
+    sess1 = c.new_client_session(b"%s_1" % env.testname(t))
+    res = create_obj(sess1, srcdir)
+    check(res)
+
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    src_fh = res.resarray[-1].object
+    open_op = [ op.putfh(src_fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess1.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+    close_file(sess1, file_fh, stateid=open_stateid)
+
+    # Get a dir delegation on the target directory
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Rename the file into the delegated target directory from sess2
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    topdir = c.homedir + [t.code.encode('utf8')]
+    oldpath = srcdir + [env.testname(t)]
+    newpath = topdir + [env.testname(t)]
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
+    if evt_type != NOTIFY4_ADD_ENTRY:
+        fail("Expected ADD notification for cross-dir rename target, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != env.testname(t):
+        fail("Wrong entry name in ADD notification")

-- 
2.53.0


