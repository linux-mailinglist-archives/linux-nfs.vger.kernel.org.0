Return-Path: <linux-nfs+bounces-22712-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O+WfCiGXNWq00gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22712-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711E6A77D9
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qi+NdrWZ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22712-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22712-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58436300CF01
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F336346FAD;
	Fri, 19 Jun 2026 19:23:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD59346FB0
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896983; cv=none; b=t4ZzrdobPqt08llNR8jK01Y7aM1NcuOTRRQsvW/617o2+P6AlO5NomqtQGaQrH7rD/SdGQjNjUGbEaYBinvZZu0Ve+YoTI0Lyl5J37FAZk5tFWBAuj84mdBnms+BQixx8Soq46XwLnyQElYo7xcybQEolossoAWeV39P1PvZzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896983; c=relaxed/simple;
	bh=2pQKEYc1lb3SqhyV3uLNCd2AECVLcbbxNlugeLptFCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LPTqbbIYuR+vJhOa4oKAd4CHJsEdFhUIyjO9UDQyxdq0AEfCzP31cvtWbOR1lZ6tArxUcTqLny2CVNFoCxAh1P+6eWIpRLbUiPdfFVbl25xksr17ZETNotAgK/wFTmtd9y5ODKNx9N6acMBtujZtRL4yogCNFKvfyVVChRxKRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi+NdrWZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3891E1F00A3D;
	Fri, 19 Jun 2026 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896975;
	bh=ADL+FvBuVbyPesj4XcCHvTsPgOhNit0SwHGTW/2uG14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qi+NdrWZtvBh/3dDcNhzI+JXZNBzUFQxWnRUHcR59ue4GzHGKeZd2Gg5xLd1FZ3Uk
	 oaW6x/PC7cGFj9GLgSISXH9qTfZMYdHwREz4TfDFCY874S6o/zWO/FrKYiUyDYk7GW
	 JdXo79GBO49bLB18Z159+zFE7/UCRbt0uyCbTDBJpVz0fH8QMJ2XBb/aLqLYN1P+6n
	 QDBdlUmUH+f6rRTNPAIHYhXP2mHpQ9p/ym7UndxJCCdLPpKPXgnJ2PO5L+rLiQePf/
	 a0j8uFORdsov5IQAVGspVWNCM8pHvAFGg4YP29gsu4jF79SMzhyIwCD7QLxvE16VpJ
	 ngvDsBFMHq75g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:32 -0400
Subject: [PATCH pynfs v3 13/26] server41tests: add a test for directory add
 notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-13-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2pQKEYc1lb3SqhyV3uLNCd2AECVLcbbxNlugeLptFCU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb783bLeAJMlG20wl+D2U06oKnmW/GMYWaND
 3l5ErBReBeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+wAKCRAADmhBGVaC
 FX8AEAC2Im2BkCfSLwJubwMe28lU4XVRy9o/40TizDNE4ogwnA9sU5JLdsDWwqlBJ4pG5hqCKg1
 qnRnrRau3e9x1rOKG3/X7RgVUB0hotGVxN5zNSS6RA44R6X2hyLWwrDlfC+dqzVOVHre0bvSsIr
 Pdt2L+MgoR5Zb4b4G0rR7MVWZ1cMRvg1aP13bv2jNlaY5ilWmeCU10GOgf0xxWv8qnsGi7romy3
 59QUWPBntHwpzSlKRlxZYYd5mq1ser4U4lAvvTYuem2xRS4lAlHomSKNIgq2uH8oNAIUBIxhvMH
 oosc5Jk2bOV5UmD3BoglXdR/IVqVVn3SWPYq1sCAYpG/k3J/+zq765XITZwzAgkM9dQWBx2m/Lt
 wX5Jgw/7VnmP9mSF5W8nQ+vmt7dYL9AIONNIDG8uP8C1JhjD2bPJHbKT/Nu8JeE1x5z9Hw8FPw+
 fpMJ9/0DwGjRHZdlrl/pFfPN+2O5VXZJ0ZKG+ly5hU138GivpuBcMm5E0QFbnOj4CSwm4M8UnnN
 BN2O0BVHwROWj1eDJ90IM22jB2era9+gzQsioYxS+fOYSEKzhqnOf2VzHsi1gwnCkiVal01kqaf
 ykGyBDbdI7pkHhTmcpWw1CpkXkONVqNKT97SggE9e7f++SuU948k16Qy54jgx/sTHYgr4IZZtNX
 SJjCi4La7EgGnxg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22712-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4711E6A77D9

Request a dir delegation with ADD_ENTRY notifications. Create a file
from a second client. Verify the server sends a CB_NOTIFY with the
correct ADD event.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 5b39f38a478c..e906633a7972 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -415,3 +415,48 @@ def testDirDelegRemove(t, env):
         fail("Expected REMOVE notification, got %d" % evt_type)
     if evt.nrm_old_entry.ne_file != env.testname(t):
         fail("Wrong entry name in REMOVE notification")
+
+def testDirDelegAdd(t, env):
+    """Create a dir_deleg that accepts notification of ADD events
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG10
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
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
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_ADD_ENTRY:
+        fail("Expected ADD notification, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != env.testname(t):
+        fail("Wrong entry name in ADD notification")

-- 
2.54.0


