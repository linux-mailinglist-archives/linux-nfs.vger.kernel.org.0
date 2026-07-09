Return-Path: <linux-nfs+bounces-23218-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mmJ8EHHyT2rTqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23218-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADF734CA5
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b42s2DfU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23218-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23218-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEF343045B3A
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2C393DDD;
	Thu,  9 Jul 2026 19:02:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73F3CB8F1
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623772; cv=none; b=EW/HdnxfSFlKgVbjg3UNOrmh8mMRFG4dxaOerYuvmQ+HgKw3hOBwFlLS5b7zH/22Knd/S1xOndvy3n7Qcl+hJ5SKPrjsQ5Emk4KGl6npipCQh9fCtkMzXLWMQ5Q9+le4JBbWhkqPAIxcnJ/bSOo5HHO48pMcEDmdOpZLwOPtSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623772; c=relaxed/simple;
	bh=oNFvsMK/3Ge0EV62UT/dTWNi7LP1+nxg52/6QFn9FFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVUzyAiNNXQucMOAEi+aR8SI87MwxpadTUwiuHO8FDWegHQX6EZuxu8XqSDlDGUO3v500phEGZJcGiMDy4w/l128XrA/3QiJezpiNtsH5Mf4eVIZNH/NpE1TBf3X2RKZvq+l2zILhlN9mU8D7r8VWWfrweCREQv+dr5CNr6dsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b42s2DfU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D2D1F00ADE;
	Thu,  9 Jul 2026 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623770;
	bh=OYkNYTYH0msnHsy8cPO41AFGAIbOy63PYfkUyvkMWvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b42s2DfUCOI0yfq0WF/d6dNr/2IshfQBqLPYr9phBXK/XnoeHipBxzxkcNHKMAvXH
	 +kSds0rfYrekEan126ii4+SgfmzYDeajdabAIEOy/2M9DDINXZM7uTHV9jZiJyjklm
	 AcjyZUvd72bSf7oAe7mtjqvEAi8qk8HCOb53Twfx+GvuTDAkCJqRni65hcmsPeF7Rr
	 YSkQTL7hB7I8MosrqZaEV/rzpu0I75Z+yd7448T5+gqBWvX1U1WoeMkcxwRD3ICjOu
	 hh4SnvfSTyCjBiEml6q46B3LxAcAaNN8+RCKQedarrEvpRHdGoaddSTtQ4SNQhjRfq
	 +qT28r+YdECZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:33 -0400
Subject: [PATCH pynfs 05/13] server41tests: test OFFLOAD_CANCEL on async
 copy
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-5-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oNFvsMK/3Ge0EV62UT/dTWNi7LP1+nxg52/6QFn9FFI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BS8uC5O9bW6vbvkierxWOMGuVcr1jPVVZuw
 OaN8zsM4CyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wUgAKCRAADmhBGVaC
 FbxGEACgMo9MnNb/UCDEkhuFcCJgjpsCT2DwN0CY1W/rpRuVfjN/Pki+vg7KBJKa20tR4WKlkzA
 j71F/DDXi46BskIS0dyk58xhRb8DAj2y0bT7tStBknMgNH+YF7GZy6JP8UsUIrV2Apw+P0MHEJ6
 BG7lCWiy2V+fgevpDF1Puy+BHnuQwr85kTj2VtUKs1MGDPqwy07MeEafktjfvh3+dVu1rropMCY
 j7pl59l6btzm3RY2oBQxCGCvIG4kTbwNusQIxjXsN9D7ltxFbwvHoATuqHZo3TUg4XMhtV74dBS
 jMQgNGxdnSt3gGrV92nNlEWre7yYXASaXX4XmzO0d5MlPP1PD8mFKmohvjDAt6vo7rbf9ui+uGh
 lRsTewF5/FBGNAxsp51gll4BjtaHKVEIOud9vrCszGhQM54pNjl2srwXgfVaQKdbozNCKrEpuit
 /gBBBmWhqszCvycIIy8iPSGuNQc0W/dyiC/Yugx4Y9hu81LMtkQoqEVh00dZeviRIry2yQkk7/6
 fMmr4h5XyWBXnUTF5G6TrXwuBVRN/dXqZ1XqOI5TFPHmmCMLZHmIkZQ0ZuJ8/vDFfVSyKi1/ll9
 tq6UcW9LwNSiaOX9eFoTs+GPi5dTCIdx+AlAp39XQyAlryTjY7AOunnozkOM1+PgyovuA1+Mc3H
 /fSwNKyBCeFFHBA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23218-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17ADF734CA5

Add testOffloadCancel (COPY7) which starts an async copy and
immediately issues OFFLOAD_CANCEL.  Accepts NFS4_OK, NFS4ERR_NOTSUPP,
or NFS4ERR_COMPLETE_ALREADY as valid responses since the copy may
finish before the cancel arrives.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index 4b207d35049d..897c8c7d3a6c 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -225,3 +225,31 @@ def testAsyncCopyOffloadStatusAfterComplete(t, env):
     if recheck.osr_complete[0] != NFS4_OK:
         fail("OFFLOAD_STATUS completion changed to error: %d" %
              recheck.osr_complete[0])
+
+def testOffloadCancel(t, env):
+    """start an async copy and cancel it with OFFLOAD_CANCEL
+
+    FLAGS: copy
+    CODE: COPY7
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, src_stateid = _create_and_open(sess, env.testname(t))
+    data = b"E" * (1024 * 1024)
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
+        return
+
+    copy_stateid = cr.cr_response.wr_callback_id[0]
+
+    ops = [op.putfh(dst_fh), op.offload_cancel(copy_stateid)]
+    res = sess.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_NOTSUPP, NFS4ERR_COMPLETE_ALREADY],
+          msg="OFFLOAD_CANCEL")

-- 
2.55.0


