Return-Path: <linux-nfs+bounces-22722-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5AGnDFKXNWrU0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22722-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:24:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9056A7813
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:24:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K8oyGyuk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22722-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22722-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1232830B1471
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01904348C42;
	Fri, 19 Jun 2026 19:23:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64C347BD7
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896991; cv=none; b=HlAE3Fy4d4xLiAyjGGBotmXpy9yul1Eb+UCQtP5y2gQdVh0nhNPRO4w9EyQcFHH5MzY1zVHci6zJqjj1+OYu25Zv9qEP2FXmIMUR5uSuBqstfACKsm10zSkZmOttTny+46F2YwtqUErUN7iyhsovffvH25XP3rvw1NOZQcjkwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896991; c=relaxed/simple;
	bh=SD/paz/GKUwlliQzkiqKaP8cxZ/W2e50jVzTM1p43Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxDWKteocrkk7AQu7rWwm3nwa14Jz03LFOHbAyQmIf3/K/jjOkjf/jSEDaQAfGZ2lf7nlwbpwzKR0g9V60sZEPzQA7ywaxWxHTytxtdIGXNxkfOVmzqcCkpSikm/WWoDX0qcYfwg/LR4P5I7F1SZBS0+CPpOEBN5lrJ4qzpXwWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8oyGyuk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BEB1F00AC4;
	Fri, 19 Jun 2026 19:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896987;
	bh=CXsNY2c1PKZN8fEm/BrTnovE0vZb97p3hYCKUauRncU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K8oyGyukfa6ZpyM3gkExojxpjARecTp85Sl33nqmyyN1fIeC/pIAXXUOUDXZ0cDKr
	 IIqWsuHTn0FfYTuIqxM3NBd2Xnaf/XMRqX4o2Ibagf9FA7EeLcYo6NgzUMaFLkPikC
	 4aUbEB5ThxC0qdRozUW68MfbkQRZ9YtgPNhRnH3ru7feJy9ZvZUKhJtpX1KOWEoz8+
	 W80oKDKi3MQP5GpnKWVQumwKSxR7dGEWu+0Ih6HGYN1cVkKqFyy3e/FTusuNfMSmAk
	 ylRaN9Cx2iJWBNt1maNcp5tdpe2cKomy3q7d6EvbjK5QTXIy+JxYydIPodR0qfESwY
	 w/SV55DuzOIJg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:42 -0400
Subject: [PATCH pynfs v3 23/26] server41tests: test same-client changes
 don't trigger notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-23-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SD/paz/GKUwlliQzkiqKaP8cxZ/W2e50jVzTM1p43Sc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb9QYDxy4yEHWtEzT7bn7zore67Ds8LNo3za
 WJBR3e0dSqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/QAKCRAADmhBGVaC
 FWQ+EADExj4XW/BUAlbB6fri7cXfbEuhFS0KVgpMz5PP5Hz5VEwnsa+GdbNIan1ngll0BblVc3Z
 s3BBNR4cHJNl9WYdKmG/W8d7iT4ohH1xa9N2UMgeSrY4Q7+kAN1n0jnLsCnjnMbGs+n6LEGxKZq
 reTv5CEBDgp7Bs4GpuPyntoerGGPOJR4Y3hsifrlcO0b/tSt4LHjkUdn4AiqH20sA8l1TJH2Bcw
 t8a3EOJKa7n11ewBpohAuql3t0w4YdfO73nrtQMJNaJp2WVYvv6ZKMarcXNDh3Es5IwE4nKJAI5
 zDyo+MMYxtmZbx9dBg746Rn3CNAWMHh2n7zSF2LwSq0ernr/wgvyIjLbJlxeiKZyRxZ79MUG6m1
 ZP3cjjSRHEUglVqOoGnoEmHjfSPxpluz+cGUXig8iccF4jtqVJCm+rIr+g/4OOd/PlECFCpTo63
 60OYuiWIb/n2uglbaEhdX6CtXZR1Yy5XCoHsaAB9wAdhDB9vTJVD+9SWPe/Gr8GwfdwiSPc2BOf
 ztKCFfzTAGPsyzwfHObtMzDkuTtt5VVovbmGB+Z0rHlcJ+SVwhcG9SrIx8JaGyg61cwre1TEziv
 3oAxeJLkep9D+1XLy2TKxh31Hq8tFAF2ki3Xe/xONzVutR76rxTbP6Obq3W4TzqCRnhqCDLxMrV
 iFpvB2QLG1oQzZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22722-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A9056A7813

Verify that changes made by the delegation-holding session itself
do not trigger CB_NOTIFY or CB_RECALL callbacks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 973ac5b8f934..8da51bb53cd6 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -911,3 +911,44 @@ def testDirDelegLinkNotify(t, env):
         fail("Expected ADD notification for link, got %d" % evt_type)
     if evt.nad_new_entry.ne_file != link_name:
         fail("Wrong entry name in ADD notification")
+
+def testDirDelegSameClientNoNotify(t, env):
+    """Verify delegation holder's own changes don't trigger notifications
+
+    Per RFC 8881bis Section 16.2.11.2, order-unaware clients should not
+    receive notifications for changes they made themselves.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG20
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Create a file from the delegation-holding session itself
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
+
+    # Wait briefly -- should NOT get any callback
+    completed = cb.wait(2)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)
+
+    close_file(sess1, file_fh, stateid=open_stateid)
+
+    if cb.got_notify:
+        fail("Got CB_NOTIFY for delegation holder's own change")
+    if cb.got_recall:
+        fail("Got CB_RECALL for delegation holder's own change")

-- 
2.54.0


