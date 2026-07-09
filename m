Return-Path: <linux-nfs+bounces-23214-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ETaCaDyT2rdqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23214-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC67734CCC
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JMYNf7BT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23214-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23214-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 505783045469
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02F243FD3F;
	Thu,  9 Jul 2026 19:02:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D83B6BEB
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623769; cv=none; b=EMsrPTive38ewic0J1dzpuoIApWW+X9FNureiJhHlhmoL9qhMjYthXzgOWLCgLtQEd4IphSd5x+PCNGA97tfV/lNxgSyaZK8PPRiWu3ZUWqnRnv34NU2uHwQNJCnHqrYDZaLxNVM8lmnTJ566lXUSQXWpPv4HlGouB5aSC8P9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623769; c=relaxed/simple;
	bh=Allabl58f0SvS6CfU3vy/y3YcQKfevCwnwEk9SqTBdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCAbO14LbUE7qj7At4pqEJgnBb/S0gA93fkAffPaRJnGLthkW9aBFzhk/w30cJpWqQ4TWUXwWgYyDnEHdyrdhB6uUaTBgjIC1vnMU0sOrUpGJQKkPN3vd6c9ZkoYB0RnAXvlKXxv7O2iyu8lf7qMlf8crB6vbrJ9zN8kdJvBuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMYNf7BT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F081F00AC4;
	Thu,  9 Jul 2026 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623767;
	bh=2hF6wa+IvXp+UUdAjSWivfitB20BJksR2Ku+mNX99Kk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JMYNf7BT+ufz0ATNdhKLc8BmJw/cgLZ8sokM2tBCHvcQrVb5IkemmvbF1s+nUZHsQ
	 pVZ/e1ywI+o9Abz1DjD8i6YeWMNIZXyoM4DZlZbAq57hQrGQubsJmSQT+2NNOfkK6x
	 BILXw4kiXT+FIKe4cc1I5qsrZPS5EBHdlnZPLCSWs5MPKGHD05YLYOm4LehKz+P9Gz
	 BCs9IHI+5CA9k1Lp7V7YY6zTmy+rfiVy+33HnEVxjibsm8x+EZ5DgwHYgVIhcAN9Tg
	 HQ6apBulFd+G2HgHuRCtGpB4plRzEldLm7cZA1efcCg08AGkX4SHNMgJCUHwCwRcIS
	 OG0KVZDsdVJuw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:29 -0400
Subject: [PATCH pynfs 01/13] server41tests: add helpers and basic
 synchronous COPY test
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-1-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5406; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Allabl58f0SvS6CfU3vy/y3YcQKfevCwnwEk9SqTBdc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BRtZ4bu18n6TotEOXy8fSNTcbhsPAhrZsLN
 8/3jynnjAyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wUQAKCRAADmhBGVaC
 FbPdD/9dwd8gOazbYCY2KTALZt5Bz9XHFJYW5tQP279ev+m2e10qd+TT/aXSNeqXnnvPw89YxaN
 quX0UQCoQTGRASObvP1U1UYCSUS2+auiepLjnTUfWYzejoMK5ngwsmaYH+650PmvwQRqkyNX8XZ
 fe9IxFp8QD5eklJFe9dL1wp8FAksm+sG0cQvXKzwV9AZ1XDAr4Mgyf6oAwFB1+I0EuBYaGmr+Wx
 zSkEipyKAcRag3ifuRhAwv1aAA8+fx5JN5WvPjOhbMt+QKZLlqvXhkPv+FRfVV8Q5xPq0wOK0ri
 zpAot9sTAYjxsV+MXhuL67eCWESMS+MMwDC17cmvPfi86SPnRzNX3WDa9QbXBFpMUBxR7i60lR0
 UnLE7UtPZiOFe/9O+AoVPgUSgZADmT/8b4cEodXb8HEMFSlpRJX43h14iLZEhnBl304e+ZE3Boc
 u1WLxjIC0Po1UkyvuEI1EOkvhsqwSumyaFT1KTFSiH3s85ExzRLOjCPA0aMh6ZrOM0TEOdl0RlW
 MZrnVB1df9LuUC9Pmeo2HcbStiXx2bJRLquynhxhPU3TTWDPXtByc9q1m1LOL58t5mJZ9ELm00y
 HYSnTzGBGMou97VMhIu8c3xuXvtiIrStjVp2sVhalMWlTCMaAm7QzvhlEN4h/6pTJEUNDNkSyGH
 C/ns2vj7LCOfufA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23214-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,res.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FC67734CCC

Add helpers to reduce boilerplate in COPY tests: _do_copy(),
_create_and_open(), _poll_offload_status(), and chunked _write_data()/
_verify_data() that split I/O into pieces bounded by the session's
negotiated ca_maxrequestsize/ca_maxresponsesize (a single large WRITE or
READ would otherwise fail with NFS4ERR_REQ_TOO_BIG).

Add testSyncCopy (COPY1): write 64KB to a source file, copy it, and
verify the destination contents.  RFC 7862 permits a server to perform
the copy asynchronously even when a synchronous copy is requested, so
honor cr_resok4.cr_requirements.cr_synchronous: poll OFFLOAD_STATUS to
completion when the server downgrades to async instead of failing on a
zero wr_count.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 90 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index a4bdb77ca407..c7e48adf6fbe 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -1,14 +1,102 @@
+import time
+
 from .st_create_session import create_session
 from xdrdef.nfs4_const import *
 
 from .environment import check, fail, create_file, open_file, close_file
-from .environment import open_create_file_op, use_obj, write_file
+from .environment import open_create_file_op, use_obj, write_file, read_file
 from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
 from xdrdef.nfs4_type import creatverfattr, fattr4, stateid4, locker4, lock_owner4
 from xdrdef.nfs4_type import open_to_lock_owner4
 import nfs_ops
 op = nfs_ops.NFS4ops()
 
+def _do_copy(sess, src_fh, src_stateid, dst_fh, dst_stateid,
+             src_offset=0, dst_offset=0, count=0,
+             consecutive=0, synchronous=1):
+    ops = [op.putfh(src_fh), op.savefh(), op.putfh(dst_fh),
+           op.copy(src_stateid, dst_stateid, src_offset, dst_offset,
+                   count, consecutive, synchronous, [])]
+    return sess.compound(ops)
+
+def _poll_offload_status(sess, dst_fh, copy_stateid, timeout=120):
+    deadline = time.time() + timeout
+    while time.time() < deadline:
+        ops = [op.putfh(dst_fh), op.offload_status(copy_stateid)]
+        res = sess.compound(ops)
+        check(res)
+        status_res = res.resarray[-1]
+        if status_res.osr_complete:
+            return status_res
+        time.sleep(1)
+    fail("OFFLOAD_STATUS did not complete within %d seconds" % timeout)
+
+def _create_and_open(sess, name):
+    res = create_file(sess, name)
+    check(res)
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+    return fh, stateid
+
+def _write_data(sess, fh, stateid, data, offset=0):
+    """Write data in chunks bounded by the session's max request size."""
+    chunk = sess.fore_channel.maxrequestsize - 1024
+    pos = 0
+    while pos < len(data):
+        res = write_file(sess, fh, data[pos:pos + chunk], offset + pos, stateid)
+        check(res, msg="WRITE at offset %d" % (offset + pos))
+        pos += res.count
+
+def _verify_data(sess, fh, stateid, data, offset=0):
+    """Read back and compare data in chunks bounded by max response size."""
+    chunk = sess.fore_channel.maxresponsesize - 1024
+    pos = 0
+    while pos < len(data):
+        res = read_file(sess, fh, offset + pos, min(chunk, len(data) - pos),
+                        stateid)
+        check(res)
+        if not res.data:
+            fail("Short read at offset %d" % (offset + pos))
+        if res.data != data[pos:pos + len(res.data)]:
+            fail("Data mismatch at offset %d" % (offset + pos))
+        pos += len(res.data)
+
+def testSyncCopy(t, env):
+    """synchronous copy of a file and verify contents
+
+    FLAGS: copy
+    CODE: COPY1
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, src_stateid = _create_and_open(sess, env.testname(t))
+    data = b"A" * 65536
+    _write_data(sess, src_fh, src_stateid, data)
+
+    dst_fh, dst_stateid = _create_and_open(sess, env.testname(t) + b"_dst")
+
+    res = _do_copy(sess, src_fh, src_stateid, dst_fh, dst_stateid,
+                   count=len(data), synchronous=1)
+    check(res)
+    cr = res.resarray[-1]
+
+    # A synchronous COPY was requested, but RFC 7862 permits the server to
+    # perform the copy asynchronously anyway; cr_requirements.cr_synchronous
+    # reports what actually happened.  Honor either, but verify the byte count.
+    if cr.cr_resok4.cr_requirements.cr_synchronous:
+        if cr.cr_response.wr_count != len(data):
+            fail("Synchronous copy expected %d bytes, got %d" %
+                 (len(data), cr.cr_response.wr_count))
+    else:
+        copy_stateid = cr.cr_response.wr_callback_id[0]
+        status = _poll_offload_status(sess, dst_fh, copy_stateid)
+        if status.osr_complete[0] != NFS4_OK:
+            fail("Async copy completed with error: %d" % status.osr_complete[0])
+        if status.osr_count != len(data):
+            fail("Expected %d bytes copied, got %d" %
+                 (len(data), status.osr_count))
+
+    _verify_data(sess, dst_fh, dst_stateid, data)
+
 def testZeroLengthCopy(t, env):
     """test that zero-length copy copies to EOF
 

-- 
2.55.0


