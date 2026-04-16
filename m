Return-Path: <linux-nfs+bounces-20925-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP6HBzUn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20925-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0EF413A2E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07205303740A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAFA336886;
	Thu, 16 Apr 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX4kyemm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0A3358B0
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363310; cv=none; b=GeV1MazZIRVyzck+wxzeSy824cSnCLZYeAZ9u0MyqNMvzfXUPS2vCAIWPaKentD9Vui0U4Z0jeVdK8bdlMQeLja08hP0TV0YleoTZrRlYv2zrtlxSOADGX7aHP0DYj3GD4IPlcm9a1o+wqO9n4aIRdeyX3ed2NXqYn0RS4Hx64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363310; c=relaxed/simple;
	bh=2GG7wS0y5DFj/e3rvlpGhVPJ+banrYZhi1hsZuOd79I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skP0flhSz7LtGecR9D5SWoO67LnYTgHLsK2T8J3HYQGzE1hf2RyHeboGaGsEeHuqN4hWaeBl6upxQonRDPFLDP3Hxb9uh5n8ZXrzmpWJp+9ZtBjlehT3vW0aTnWFzYrAw70ziIPnB1ciDRhruoejcdZaZsz+Iuau7twkkvHolcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX4kyemm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDD9C2BCB5;
	Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363310;
	bh=2GG7wS0y5DFj/e3rvlpGhVPJ+banrYZhi1hsZuOd79I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qX4kyemm6H+SFJfBhtTVkBrSRTa/LWXHRwowo7TVxPVFuonNFHLEg4K2fnWmySesJ
	 zH4Ywl4VlPOe7AXtHEUrTSw+NE+6oFJGIvaq453Pf6udIikW+IS2Ia2R2RA27zgj6F
	 +skLOokLkU+qGjzEREiIw9qX++TO2UT3I6CwXPfK5UR2BbAlwihzA0aWCjhOnMTEiz
	 YcIxvOWvcU6tZr7e8Qt8hvQvRUTRyr8M2FRiiKIfdCDpjLFFnO7JOJIVE/VuuwaAoU
	 Kb1syrsiZCtapsS18f1pnwHGs8qHRfa1Pq0c6HI8x4jQ5jZ6yTWUS0yP1Ck8oGjRHD
	 UuCzb6pOcH8cw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:55 -0700
Subject: [PATCH pynfs v2 23/25] server41tests: test same-client changes
 don't trigger notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-23-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2GG7wS0y5DFj/e3rvlpGhVPJ+banrYZhi1hsZuOd79I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScjE7aylm3P6VTL/dy0KKP0Dy5XLZxucV7Xk
 kD6P2pLLFWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIwAKCRAADmhBGVaC
 FWmnEACDsoPOdhITnpYq2XkkO4my3d8hbLae06f9qV56we4dZWlFAryP2DWTOk8HZlt5VVZd5gH
 S78TrntYTnaNP7AY7AbK4BNMyeaLoofcqwkIOPw/zXkhHTqqjWWKeZ4rv3sc8Zml7OKRVu+Y5KL
 RltG7gwqSl/Wjghqn8Wlk8CmRK9iJAsiDAZfycY751oVpyRnHjwXSh7/AnLgll0oAC9dcmwmEzV
 sdJiLjkpPxK9u+TSdr/U/+xpcCOLbaAEQzKxy3dyKWHEh9znZ/qKRZccD1PwyJSTIEanrDoSgEV
 66NVsJ+YmGUj97wR7Veu9wgvLY73V9W7VHGVq3qH3Px4ATAA/Kxknil/+vC1RVrq4ENttZsdLbR
 x58Vi052WuvIGybLjP1s7IvNv0H3x6YUk5fZxBaLZv6thmMKqvXEwZRlXdUqjtLwjdoVOC8HbM2
 MK9I2p92fgLA/AM9Fnfbc957+aAJISTs2GZ79cEAJOkd/ZbwBgMJGMw1hsqyN6whD9ogHOBmL1K
 Ljp3YrmUq+gxSE5KLK5uw5aAhNAc9/BlyxK8nUt0EyKxODgbMxgXigmgx7h1tVkXfULHPpzcNxm
 3sIN5IdDTzmXkca7TutwDq8lGZrV3bTrOAtf8rHDexGpsubHfA1wLwPjnzGZBXFHjHywkl6uXQA
 1mKtwiIyWxdvI+Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20925-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA0EF413A2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Verify that changes made by the delegation-holding session itself
do not trigger CB_NOTIFY or CB_RECALL callbacks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 7c230d40e808..63072bd8b81a 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -864,3 +864,40 @@ def testDirDelegLinkNotify(t, env):
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
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
+    res = sess1.compound(open_op)
+    check(res)
+
+    # Wait briefly -- should NOT get any callback
+    completed = cb.wait(2)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)
+
+    if cb.got_notify:
+        fail("Got CB_NOTIFY for delegation holder's own change")
+    if cb.got_recall:
+        fail("Got CB_RECALL for delegation holder's own change")

-- 
2.53.0


