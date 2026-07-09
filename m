Return-Path: <linux-nfs+bounces-23222-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y7u5NHvyT2rXqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23222-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3211734CB5
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZmWOkayh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23222-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23222-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA49230BB7EE
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D13B995B;
	Thu,  9 Jul 2026 19:02:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925239A057
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623775; cv=none; b=bcuTPQTHE/QP55bCWj5ySfVS+7U6hnQX49jwgNP5ZvCYEhm+5tYXf0EhWPP2O4McFKM+dnz9HFUJpK0l0nbnMWPxoRzlY89jnkdO5ZSewj+sQSaIKHXzhneMn5QKfO4Oq1S+ag1FFWHeUx4Fin1Br7NfsbtgpZHZq2Xan77HuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623775; c=relaxed/simple;
	bh=toxHJ63hhagMhL7C8ZmP85dkt+FCp5SfoQHHHLl5nEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elqvFXMPJCcEGwlEf/ra/SYupxDghwhIXoTfXwHcYC6Hpgdcg174Nnqnbwv42egQYyKv4I0BXzE79n3SzanrF8jllEvoFrDRI/hfg070Up1cNDrg1tgYYKqeIEmAr6GvE8BiXeZJ2ZC5KbmTPDAI5fGxrVZEKWMSm4HaXzGSEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmWOkayh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C941F00A3E;
	Thu,  9 Jul 2026 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623773;
	bh=kDGyuDf1lC5ZJCUhO6kO/poPIXtDXw8pn9LLFTWw+Po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZmWOkayhVFc6ecfg0znn50C/SfjBNKvtp81MqJEwDZnRM4fHJ+iWdpUu5jbsD0+8T
	 jrfw1CZW6Zs6yAiHsHkTCxylA0iffwVL+wrtSTosXNr1KaTxAVjn/q7/znrHe6rsUi
	 arVcuaPQKsnvjbEa0xARZGa/KX8uqXRz1okk08/287j7Oa8DaYmcoTrXY4BdYvEte9
	 QkzOV6LeydBKxKh8FKAX6/3AxshWOA+Bl6XSMas9mbW8w0XBp1N9T7W69rxxkXf6MY
	 V6T4cI+0vK6+huZjrTfW0qeNKX6WQ/rMGBPJx+D0MxkfpM7bNB/hlnBMlo3JMF/CMX
	 PEZx8lZyXEiaQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:37 -0400
Subject: [PATCH pynfs 09/13] server41tests: test COPY within same file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-9-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=toxHJ63hhagMhL7C8ZmP85dkt+FCp5SfoQHHHLl5nEQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BUszX+0EmUcxWfjqRLQIIx6MdTw/iIaCSfE
 l6zvlVfCJiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wVAAKCRAADmhBGVaC
 FRMiD/9LGS4sKQJfYio6IGRUBLJEpqiXcIeHzHLAHVPQRucXzB/n7ldKQ7m6yLYOP/jSjnJW8su
 ybTxwWAPnjrImnrCMAuzDTM1oTdBzjotZHp+vjpmmu7JSc+kmgqSV31C+BRiWWnZP7d6/BVXpi0
 dRfMZG+WOrsWzdAvb6LfXyXd81qR6PdG52ZrHLkwej13Z7yUipYcvCHF0nnB1X58lOmYAVkDix5
 oRHV6zEozq/N6W6KvLg/ixqxMsmEVB+XcdX6Pzh/ls4w4cd/TQBFIDKhlHLi0OFQnmO4vRrYhL/
 g6v8kqPeFCRXEDtUCC1U0+Iam1xgdB2636OEiYkn5jKikQBiGTmDvLg6UheEW17NdrMFskQefKq
 MSqNYRWYJ0InbB7QMm7NwZIzzsAD1Q8bSrrnevLGh7eBinUu4nxmlaMeoKVIRPYuQ2rKF5amsPG
 DwAVF2tfbX3kupilZ+hs94szJlP8SXUktKUsLvaWustQ2HJ2RQT4HHPOR0+GUx8NwnsqndJ6SNQ
 j7gQ1UXvSRQL+Jz61zy07b+cAtHelX6K9G42x/ckFFq8n4ekWzms8Ov6a+zSC0zdSxoBxITCc6E
 TqquznWJljkBncVM3PO3faL5YQAHh8x11Y2f7kutulS1USG6iLG606VVvBLpCUCUtRO6h6Owlk8
 j8FplNJPxyEaSxQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23222-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3211734CB5

Add testCopyToSameFile (COPY11) which writes 4KB at offset 0, copies
it to offset 8192 within the same file, and verifies the data at the
destination offset matches the source.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index bec92e8d86b2..1a392f9377b8 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -300,3 +300,26 @@ def testOffloadStatusNoState(t, env):
     ops = [op.putfh(src_fh), op.offload_status(_bad_stateid())]
     res = sess.compound(ops)
     check(res, NFS4ERR_BAD_STATEID, msg="OFFLOAD_STATUS with bad stateid")
+
+def testCopyToSameFile(t, env):
+    """copy within the same file to non-overlapping region
+
+    FLAGS: copy
+    CODE: COPY11
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    fh, stateid = _create_and_open(sess, env.testname(t))
+    data = b"F" * 4096
+    write_file(sess, fh, data, 0, stateid)
+
+    res = _do_copy(sess, fh, stateid, fh, stateid,
+                   src_offset=0, dst_offset=8192, count=4096, synchronous=1)
+    check(res)
+    cr = res.resarray[-1]
+    if cr.cr_response.wr_count != 4096:
+        fail("Expected to copy 4096 bytes, got %d" % cr.cr_response.wr_count)
+
+    res = read_file(sess, fh, 8192, 4096, stateid)
+    check(res)
+    if res.data != data:
+        fail("Same-file copy: data at offset 8192 does not match source")

-- 
2.55.0


