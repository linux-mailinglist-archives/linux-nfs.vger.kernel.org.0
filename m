Return-Path: <linux-nfs+bounces-22717-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JnKXDSaXNWq40gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22717-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA756A77E8
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cHFbYo99;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22717-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22717-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25CCB301DD86
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81332AACB;
	Fri, 19 Jun 2026 19:23:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22183451A9
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896989; cv=none; b=GXONMqG+kSJresRPHmJmwR9D1KCC69vqQ2YfpU7xhUrx2No3uZuXfVvROSk4rQTyn5Hu/GatbOvMxkX3ZovPAKldVgSla+51FT0uCdA1oF00WqH4gn2ZOesSW9kri01BN+3mzJYzORQvcqesrkqFL9bCzoRabMLtoBDsh0u01rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896989; c=relaxed/simple;
	bh=dGeV5HgVYQiDrL14Qn1/PyB919ejZZOdyAsXLfwgbU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtS9f6/h58IJb7q7ChwyS82dSLBu2cvc2nA8GOmrlSQmIb1E70C1l2hBL2n3Y7v8d5Jd+lY4bKnnDgBox4NYDjUGzk0ZSy0XBIUgzB9REWUDu2cH9ZMk1YuE68lvArJ4b8ibpGyCngfERikb5omn71XsYaX9+gF3vcHT3PpJE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHFbYo99; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54671F000E9;
	Fri, 19 Jun 2026 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896978;
	bh=4pGhQSukMmDvU6lCXPKu9ckhhdmqwmRHCYdKfqHvVcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cHFbYo99yok7MdGrjcleRzN6+IwRsWKqfDG/xZfhSXmzNXQinuZJWXqFzw9x0bwAw
	 mTSfbFOdcFcOjKs0sUwLhCCIS9K3/l/bl0AwEXOVfsJ4+GjTdQHCNekLme5FKKernH
	 HYRbxrRrVF/t/0LEWUCdVUve9wag6fPsvnrROFqtr4ZK0FdH95Qgxln2VuljSjnvjR
	 fwnciFwRBTzy3IDqppKzB5mgTzcgZqBDfC2XodxpBBC/qdReLf6YtN1zu6CUcG+wF0
	 Y+sAmQrNQoc/mqqVyz+5AUPxsnB5FRxQkKyof3p9TjrgtahFtL2dCe6FTuO8kVtnRH
	 Nv9hRAg/rlv2w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:35 -0400
Subject: [PATCH pynfs v3 16/26] server41tests: test CHANGE_DIR_ATTRS
 notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-16-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2923; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dGeV5HgVYQiDrL14Qn1/PyB919ejZZOdyAsXLfwgbU0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb8iwXHqnT/BTt0gaiMlfFeErCOAtTaOFB2e
 /rxRJBJC6OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/AAKCRAADmhBGVaC
 FZ7iD/4+IxiABJ2Zqtn6c18Wv3hmzGw177YdvtCoxXqMksjiM2wZVfeAGGEzIDhm3qu9xYkMlsJ
 Z1zWzajxqQtiCwgNTcSEFKeBDEh/95azR9YytqxVttiZlVoDfrut3eksOr07B81J8JA6qKgQKA3
 XbzdmKvbahyKg0jrYmedhDU5u5v3Ct5i3GFI2uHusudN9UxwHnScWk2FJWiuIScLAW+yepqNFxA
 9MceepjAAPZJuxk1vwXecGs8ZhJ3azwsuhMJplf2gTftP4OeDXZE4RH0/ZsVttnPQ9O9B6iObEi
 Cb65QbpuDIQwWK5txd5kUsDN/rcbF6nxYQkQXMMrqSpHEjg2Xm/KU10IKo2TH0ezr2sNFuyXZrM
 y0v5bY3jEr9t5M81F0i5gW63LGC4aDRVYZ9rX7YBci66UDUnawrU+nH7RDZ7evRPStL3XkQkBYg
 7LpuVETluzNT5shO6MAbTSAH7JjSxdhOM8FyGHbdehobgOEqnzqGjgRByctCoyeE5F8N73jHKS5
 ES7kAMguViHKmcVnqcKszeDf/aii8EEmVRImdYt9RQOqBPFqDGcKCBCg+Ma3YERqKykJ3cxBXD1
 BivhdaMbnitR2JmKriDCq1L9fezfg3Iy/Q8+KDEcM7ib/kVKN949l0H5WSCtAOFoIhOmqPV9and
 ZHqy3SI3PZXHCuw==
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
	TAGGED_FROM(0.00)[bounces-22717-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: DCA756A77E8

Request a dir delegation with CHANGE_DIR_ATTRS and ADD_ENTRY
notifications. Create a file from a second client. Verify the
server sends a CHANGE_DIR_ATTRS notification with directory
attributes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index a12fa13878e4..752fec3df185 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -558,3 +558,57 @@ def testDirDelegChildAttrs(t, env):
     attr_dict = nfs4lib.fattr2dict(attrs)
     if FATTR4_SIZE in attr_dict and attr_dict[FATTR4_SIZE] != 0:
         fail("Expected size 0 for new file, got %d" % attr_dict[FATTR4_SIZE])
+
+def testDirDelegDirAttrs(t, env):
+    """Verify CHANGE_DIR_ATTRS notification on directory change
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG13
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_CHANGE_DIR_ATTRS,
+                                      NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess2.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+
+    completed = cb.wait(2)
+
+    delegreturn_op = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(delegreturn_op)
+    check(res)
+
+    close_file(sess2, file_fh, stateid=open_stateid)
+
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")
+
+    # Look for a CHANGE_DIR_ATTRS event among the changes
+    found_dir_attrs = False
+    for change in cb.changes:
+        evt_type, evt = decode_notify_event(change)
+        if evt_type == NOTIFY4_CHANGE_DIR_ATTRS:
+            found_dir_attrs = True
+            attrs = evt.na_changed_entry.ne_attrs
+            if not any(attrs.attrmask):
+                fail("No directory attributes in CHANGE_DIR_ATTRS notification")
+            break
+
+    if not found_dir_attrs:
+        fail("No CHANGE_DIR_ATTRS notification found")

-- 
2.54.0


