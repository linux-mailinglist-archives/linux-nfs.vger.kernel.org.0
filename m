Return-Path: <linux-nfs+bounces-20914-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D2AI/0n4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20914-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE5413ABC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 785B8311A28A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DD33554B;
	Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOCfoUed"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBB332EBC
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363305; cv=none; b=mIUFNgg0im/sJCZiLOi9rpBZiHgOLaIAnpvrBd1ToNR6fUn/s4Jc0KNffBdAhDbCRFi6CVwVUuV64gKcUopVaAfg3E3gT+qIx9XJFtwtZAsV68TDC2UZmIawrjKjl6xOHXAwnEdUdsuNsXnoRL/mcj2wofnSV3fgGkQ/jRNOP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363305; c=relaxed/simple;
	bh=o1cJjPqL75JE/HlQDRQKC20khfKReyjI6fe/dNvBAOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9UYYtzMZvBjdmYkP/NyXnmVPeEitYQH9pDZeDLlqf0uS7qqVeYDcTWY/kEqLhAMXRmo1PYuIrZaImxbon8FjV/eDvvT8nsdWTGZbGhriwPfK3Q58NeRuR7WSnOpw1cKWDEKBP5n6Uiw6T+W9t+A9JfdmcNAHzVw1+zd1uICEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOCfoUed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C50DC2BCB4;
	Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363305;
	bh=o1cJjPqL75JE/HlQDRQKC20khfKReyjI6fe/dNvBAOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dOCfoUedeC4aEjFwpLdd8tjuUs739+js8qPu8Kqv87UlJBc7dYgMZgklXfy3+4QfV
	 PENLjvTx+I8WzCzw+it4K46YoKhFHSS5OtZNb15w1iWGEwVvddKksdc9tO3DWdSJAO
	 nQbryrwodwSJDVcdvv0hYYjteCxxD5h+Wlpfnjn4imybQGHzJl4QGcQS8BgwQ/WTcO
	 AjOKOVp37XMHnsHqPsSE18Wr6ImE11aYevOHykanqYrR5idPGqvnmuVrK88OD8HCba
	 eg+zha3Ll2CdzZkue8+UstpPf24yy3khE62h4fSQ+n9lGwySEwv7xbsUV6f1A8i8jo
	 ckIi1ZVE+ENNw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:44 -0700
Subject: [PATCH pynfs v2 12/25] server41tests: add a test for removal from
 dir with dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-12-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4948; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=o1cJjPqL75JE/HlQDRQKC20khfKReyjI6fe/dNvBAOY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4SchkiKUwN7KOSBtv+aRIWmSkHLn4Go68PvUz
 Sg3wRLk68qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIQAKCRAADmhBGVaC
 FYscD/4tuV4Vu3N6x7lh9GBn1KFvKw+Zlsci9SECaA/LJJivvWTDPCCVa/jxVkG7jfKUC20itNL
 j79oMn6wTB6h9jccJRrowso7jtBCzg59dKUo9uDEmEW4Cs33fvZfnbWMIXd806iyQuTle2SjigL
 hwFOn/TKV35nmHOT4IleghQBLQUeSi+9xGCoL3qTBn0WLpXetF3yFA7KXBaxlE6esZLS1pGDPK1
 aKlSsyL+XCoJ9b9SUJlQ4lqwLIhxdJyDq4Ek0v5ZoOV8WZhaG0rTmWr+1El3iqD6e6gP2dDR8bb
 F+4WKYUh+HCiqXmR1/KwdXwyd2la/4SzZqfXZGV0XXiqcB9iureDps4iNqwpnZHMbDQAaLOFRi3
 udct7wRIXSq2LCfNpG40XXL1/6gmluJobERhDMy2hxpKGNk3wfBhv7mvS/DpV4mZn5XQXOJt/dM
 vs4c3gUGNszbi4HtZLqmWaXukzJwG0T8VH94LHuwXj14gVGkMaSGkS9tOkzon4SUwy2D6Zl1s2h
 QfCvkXzZzLfh6B2RFnZMxr518qzkuZX71SLtTdjUp+3/RXspxZIfJWQY15T1ryM46NNCkonCZfm
 4+VHA2qE2JoWVTnH9QsEvoNGIV9tdcXzMMEc92mF9VMi8CrQz31XuG48b22qZrKueJuB7dAr1vM
 GLl+2j5Vk6JtgOA==
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
	TAGGED_FROM(0.00)[bounces-20914-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15BE5413ABC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with REMOVE_ENTRY notifications. Create a
file, then remove it from a second client. Verify the server sends
a CB_NOTIFY with the correct REMOVE event.

Also add full child and directory attribute bitmaps to the
GET_DIR_DELEGATION request for all CB_NOTIFY tests.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 65 ++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index d62ccb634056..9c348e9e80f6 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -68,8 +68,26 @@ def _getDirDeleg(t, env, notify_mask, cb):
     mask_bm = nfs4lib.list2bitmap(notify_mask)
     ops = [ op.putfh(fh), op.get_dir_delegation(False, nfs4lib.list2bitmap(notify_mask),
                                                 zerotime, zerotime,
-                                                nfs4lib.list2bitmap([]),
-                                                nfs4lib.list2bitmap([]))]
+                                                nfs4lib.list2bitmap([FATTR4_TYPE,
+                                                                     FATTR4_CHANGE,
+                                                                     FATTR4_SIZE,
+                                                                     FATTR4_FILEID,
+                                                                     FATTR4_FILEHANDLE,
+                                                                     FATTR4_MODE,
+                                                                     FATTR4_NUMLINKS,
+                                                                     FATTR4_RAWDEV,
+                                                                     FATTR4_SPACE_USED,
+                                                                     FATTR4_TIME_ACCESS,
+                                                                     FATTR4_TIME_METADATA,
+                                                                     FATTR4_TIME_MODIFY,
+                                                                     FATTR4_TIME_CREATE]),
+                                                nfs4lib.list2bitmap([FATTR4_CHANGE,
+                                                                     FATTR4_SIZE,
+                                                                     FATTR4_NUMLINKS,
+                                                                     FATTR4_SPACE_USED,
+                                                                     FATTR4_TIME_ACCESS,
+                                                                     FATTR4_TIME_METADATA,
+                                                                     FATTR4_TIME_MODIFY]))]
     res = sess1.compound(ops)
     check(res, [NFS4_OK, NFS4ERR_NOTSUPP])
     if (res.status == NFS4ERR_NOTSUPP):
@@ -329,3 +347,46 @@ def testDirDelegFiltering(t, env):
 
     if not cb.got_recall:
         fail("Expected CB_RECALL for unrequested notification type")
+
+def testDirDelegRemove(t, env):
+    """Create a dir_deleg that accepts notification of REMOVE events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG9
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_CHANGE_DIR_ATTRS,
+                                      NOTIFY4_REMOVE_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
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
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    completed = cb.wait(5)
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")
+
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_REMOVE_ENTRY:
+        fail("Expected REMOVE notification, got %d" % evt_type)
+    if evt.nrm_old_entry.ne_file != env.testname(t):
+        fail("Wrong entry name in REMOVE notification")

-- 
2.53.0


