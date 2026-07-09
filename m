Return-Path: <linux-nfs+bounces-23216-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8X/oN2nyT2rRqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23216-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69F734C9D
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CccjQa8+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23216-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23216-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2DFF3054A0C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7427355F43;
	Thu,  9 Jul 2026 19:02:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399C44160A
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623771; cv=none; b=D/2jPS6YRS0PCB5G8yt2jnaoF8I02Jyvlg4NdnhexAtdwORrPpZi/yffhrI8M6vUkGL8HYm8we/AtysNlXv/060plyJ2jqwtrvhUEraG0HAZVSgvpgrOJ9rpmMyGps6++9xJ+86vIA2qXFBHRoachZd+ezB5GHeRlWtxzk3MHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623771; c=relaxed/simple;
	bh=GXNYm7uSz0giHj43Rp0tsCBNhC0jsHG1m1ICSzqNNaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvDaSjqXTwMIyLnny1pWb1Y9q/z7yfNSKlCRPGqNI9yIdCHQ5ULdF0NPEFNqzs94uBQ1MyuHmDWJGlCqL2vSIT2/SBR3NrHbmIXakx47JXNKszk2qWGZbt0Hj4YGPjtdZxf1o45eFKy9B14Fgpigw4aftEtulG3W6ariKnvOBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CccjQa8+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C0B1F00A3E;
	Thu,  9 Jul 2026 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623769;
	bh=/iCffZUhw0pjOsubncxmeSJG4aDbhA2pkUh1haf+8fw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CccjQa8+W/SPHP90S0a0rIHrJds7qypIqIZQKDeVvIcSzPHCi6+iDJcjhE1AT/cZz
	 7M/V0ht9xCZ6paZNMkROvuy4hDBn1ni0IwwSLOVhr5qpE8iVP0aGkwFJhDxJ+o0oxc
	 OqN2sVDh4gOgy6h8JFIKaXstalBg7epwTi8emt269y2oJ7W4r8htnENpElnitm4Vhu
	 lhxu8krcbm0CTHmfgoW5n402emOLtxO4BF7bwlp753QchcCn7rA0ptOzY+s14KGKEg
	 1usu8y1VVbFovLZsNrwNko4NYeJga2jib6hL0tj4QmyrFtipDcbotSpeRRyik/lx7Q
	 Vk+ab7V4iApsA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:32 -0400
Subject: [PATCH pynfs 04/13] server41tests: test OFFLOAD_STATUS persists
 after async copy completes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-4-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2986; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GXNYm7uSz0giHj43Rp0tsCBNhC0jsHG1m1ICSzqNNaQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BSSgCCbx19vfATxrrs9XN0qNdf/1Q1VOxnX
 FyymTmzPuuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wUgAKCRAADmhBGVaC
 FW3SEAC2nEsRDEuick2VD145SMbJwSX2Y3dfDiSpkKEywLb60jwEk1RpyztRCI85Vqeg7Mwrwyg
 E7vwWOy66J3n5p9nMxJzcdBsTzcDAarqU78X9cTU4T/CYH4ir2bMVnEBJ6dqe0eioGw7n4Gzczr
 pV3MLsnS4B3HIZyUx1hRiRZYXc283FKliRLwrYOmmWXu/iy2a68irVjnyA8fmXM7Fj/M8KNFv7H
 JTi1Dg5EZncZ+FLhFC6l7G2wIa2Japb5Lf0SYmcZ9Dt+z3CuXHrQ5+zBnfAlHh0XQTm7YrZ6e2p
 PY6OwseK/Th6V0xRrunH81mrbgIyaqBLfIru/PBI6MyxUEk0DWqYmwoybHoTNpu1SdZ3KZFfPWN
 3aa/ZYkG1u9+64s71WqlxFB5pSYdxRX59yGMEK3L3n5ax3r9vBlIAwlzLH9bWt3InTPIpVdNlan
 UcSE88FSLd8zhOxypR1UiJnwNimcuobdcxieIG4w+cTNnTNfAIuf9QBG+gEJMwf9xcXHi0Ub+a1
 n6NOe6fiJa/iFXNhDatxGgvWXGSx2h76y1o6RQ0r9qxRllQlbgMonWrbLdDNbFg0+xxDkj/zkDF
 QI6kRGtPtJxeHbosTe91dbOiXRKA9TfyQUg+j18kWOmB4Gqs9SDx3ibXBb7hILtsDDrAv6a/1Md
 Kc3NJP5Bn2+vFvg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23216-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C69F734C9D

Add testAsyncCopyOffloadStatusAfterComplete (COPY6) which performs an
async copy, waits for completion, then re-queries OFFLOAD_STATUS after
a delay to verify the server still returns valid copy state.

This catches a kernel bug where the async copy reaper has an inverted
TTL check (if (--cp_ttl) instead of if (!--cp_ttl)), causing the copy
state to be destroyed on the first laundromat tick after completion
rather than surviving for the full TTL window.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index 8c320173db1f..4b207d35049d 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -178,3 +178,50 @@ def testZeroLengthCopy(t, env):
     l = res.resarray[-1].cr_response.wr_count
     if l != len(data):
         fail("Copy to end of %d-byte file copied %d bytes" % (len(data), l))
+
+def testAsyncCopyOffloadStatusAfterComplete(t, env):
+    """verify OFFLOAD_STATUS works after async copy completes
+
+    The server should keep copy state around for a TTL window after
+    completion so clients can query final status.  This catches the
+    inverted TTL check bug where the reaper destroys the state on
+    the first tick instead of the last.
+
+    FLAGS: copy
+    CODE: COPY6
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, src_stateid = _create_and_open(sess, env.testname(t))
+    data = b"D" * (1024 * 1024)
+    _write_data(sess, src_fh, src_stateid, data)
+
+    dst_fh, dst_stateid = _create_and_open(sess, env.testname(t) + b"_dst")
+
+    res = _do_copy(sess, src_fh, src_stateid, dst_fh, dst_stateid,
+                   count=len(data), synchronous=0)
+    check(res)
+    cr = res.resarray[-1]
+
+    if cr.cr_resok4.cr_requirements.cr_synchronous:
+        if cr.cr_response.wr_count != len(data):
+            fail("Sync copy returned %d bytes, expected %d" %
+                 (cr.cr_response.wr_count, len(data)))
+        return
+
+    copy_stateid = cr.cr_response.wr_callback_id[0]
+    status = _poll_offload_status(sess, dst_fh, copy_stateid)
+    if status.osr_complete[0] != NFS4_OK:
+        fail("Async copy completed with error: %d" % status.osr_complete[0])
+
+    # Copy is done. Wait a bit then re-query -- state should still be valid.
+    time.sleep(5)
+
+    ops = [op.putfh(dst_fh), op.offload_status(copy_stateid)]
+    res = sess.compound(ops)
+    check(res, msg="OFFLOAD_STATUS after completion should still succeed")
+    recheck = res.resarray[-1]
+    if not recheck.osr_complete:
+        fail("OFFLOAD_STATUS lost completion status")
+    if recheck.osr_complete[0] != NFS4_OK:
+        fail("OFFLOAD_STATUS completion changed to error: %d" %
+             recheck.osr_complete[0])

-- 
2.55.0


