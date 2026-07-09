Return-Path: <linux-nfs+bounces-23225-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ddNbF4LyT2rZqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23225-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B1734CBD
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:12:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oeakFHnd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23225-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23225-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1AE830BD661
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F793A5E7E;
	Thu,  9 Jul 2026 19:02:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D03A1A29
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623778; cv=none; b=f30zB0A2u5ToNEt2b1Pwycs2RKZ7Q4bSk0pcimuIdXn2Wh3cXGfr+llNCa4c2t1OxSfRaClfujemZOxZdI0xDo66Qfqf2Z5+MlzvtKONeCHjIyZ0kjjRhgsxRxC0rdbk4C8yNgE9OxOqDyUZiumzFFwswjPFnOYtMouzJiggVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623778; c=relaxed/simple;
	bh=qJ//FUdU0xzAtTvyoaKH2eKJM3V5CFLhJnZ9fem7Ldo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIdVCEakettm0KsBWNBmQEkKRWcVqg9Fv2QuXZXeaSxnS4UTGx7t251Oa7wMvkcyVkoPDo6gr774Z71BDFFv3Nz1IHT+tLi7CElclcU++W26n8DZa6sqFi4J/yKFCKmRy7BUxiZmZZiQwBoaY9rXC/q0LyBPqRBu/vCd0Xs8OyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeakFHnd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983881F000E9;
	Thu,  9 Jul 2026 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623777;
	bh=9R7Bk/67cIUFzPEFQtnTwlSPS8Zv+yro1G2CQBY2V0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oeakFHndthk49rjAKDnVsldY4ZDEH1T8sNVtbeDVRHrrYclVcIu9jysvSyj09VXFe
	 fTCG1jlOixRpEZdZcahvzMXgx/te81Dl0kEf7u8/+k8f8AiDdoLtCiY1CMeCjqxEfe
	 7zqOX1vB5jfNKFjeBAXcUZX137s2wLz/VZj6cp/MeZP6XWU2OF4meWsNnbyvT6zYTN
	 GRqHAOhU6ClP1d6LwDCH1p1O+Xzj5W4iOGIJi4IAjZiN7+2Atm2GjpaQwu3XyMi1Qc
	 FrRBUnf/e+ZKlzOJUrHwIAZq0idJk0n/sLX81m9Aw7HkAeOaxmsQg/bqEBpI77ELdZ
	 mEPjzLU6iW+VA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:41 -0400
Subject: [PATCH pynfs 13/13] server41tests: test inter-server COPY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-13-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5149; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qJ//FUdU0xzAtTvyoaKH2eKJM3V5CFLhJnZ9fem7Ldo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BVqBYoX00U0+3cfW23SYhPAdLzoB4CHcfUW
 4uBTpaD4WWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wVQAKCRAADmhBGVaC
 FYvPEADNjWGwzErJKeOxf/KkvC6zYXTb+YXhCRGw+04gFqL+3jrxMXJy064XLbCkoq44JXnh9N1
 ik4anEvVJj8GxyxaH3Y/2Um48igKmqzC74apPx09cuPciaxu+seHf7uTTGOtqAJRtIdhnBLqgaf
 M9x6VXPryJLrXjId0II3w8JrKDd4P/ec1Hf8c6m04HIhUGGF9bcnYMTpHU1WmDkBmBoC6r/uv5q
 nsQMATxAOHsvVE7KABACRNIMtvKONjRqSFPY12JDUTFAGqa32d1b0TBNSysusXJRd8Jl840HgQ3
 muLpGZnIoLUd+hDdX8ZIwbfuKubQoIgz6ny26hSHEjsCyXQzr51TJMzOgnWesvhPA8m/nDJdCTq
 tKGKdY4TqFgpOnWnoxkCXh8KBNxsr34yxUmoVXL25iK72aISA5PeLSYur7ZVfBZjBwvtWPNwDp9
 iqdLoxKhmG5icp2JZZHtdi4WLAjOXdWSn9tWlfwuQdXvZYyzOivM1X6d7xfzmLWjGjvH0zVLefR
 8eexzR97S0b/z5fIUDafuU1Cmex71SWKxVFeRbahih9b7HFiCWYAJvQQVrje43o2usMUxT1pXLv
 QyWUHBSGkFRv48KZRH3Liqc/IYsf/6APcBX8fWGSHvDpXBRR0/Oido3gQNZRn+UKFzSGzVLpW/2
 84WIp8p7RFaJBiQ==
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
	TAGGED_FROM(0.00)[bounces-23225-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: F09B1734CBD

Add INTERCOPY1, a full NFSv4.2 server-to-server COPY across two servers.
The source file is created on the second server and the destination on
the primary server; the client issues COPY_NOTIFY to the source, then
COPY to the destination naming the source via ca_source_server, and
verifies the copied data.

The test requires --server2 SERVER:/PATH and is reported as unsupported
when no second server is configured or when either server lacks the
inter-server copy operations.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index 7eb6e2c98c4d..9cb9c199a025 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -436,3 +436,83 @@ def testCopyNotifyNoFh(t, env):
         t.fail_support("Server does not support COPY_NOTIFY "
                        "(inter-server copy source)")
     check(res, NFS4ERR_NOFILEHANDLE, msg="COPY_NOTIFY with no filehandle")
+
+def _inter_copy_ops(src_fh, src_stateid, dst_fh, dst_stateid, source_server,
+                    src_offset=0, dst_offset=0, count=0,
+                    consecutive=0, synchronous=1):
+    """COMPOUND for an inter-server COPY, sent to the destination server.
+
+    SAVED_FH is the source file's filehandle as known to the source server;
+    the destination server treats it as opaque and forwards it to the source
+    named by source_server (a non-empty ca_source_server list is what marks
+    the copy as inter-server).
+    """
+    return [op.putfh(src_fh), op.savefh(), op.putfh(dst_fh),
+            op.copy(src_stateid, dst_stateid, src_offset, dst_offset,
+                    count, consecutive, synchronous, source_server)]
+
+def testInterServerCopy(t, env):
+    """server-to-server (inter-server) COPY across two servers
+
+    Requires a second server: pass --server2 SERVER:/PATH.  The source file
+    is created on the second server (env.c2, the copy source) and the
+    destination file on the primary server (env.c1, the copy destination).
+    The client issues COPY_NOTIFY to the source to authorize the destination,
+    then COPY to the destination naming the source via ca_source_server.
+
+    FLAGS: copy
+    CODE: INTERCOPY1
+    VERS: 2-
+    """
+    if env.c2 is None:
+        t.fail_support("No second server configured "
+                       "(pass --server2 SERVER:/PATH to enable)")
+
+    # Source file on the second server (the copy source).
+    src_sess = env.c2.new_client_session(env.testname(t) + b"_src")
+    src_fh, src_stateid = _create_and_open(src_sess, env.testname(t))
+    data = b"inter-server copy payload " * 4096
+    _write_data(src_sess, src_fh, src_stateid, data)
+
+    # Ask the source to authorize the primary server as the copy destination.
+    dest_netloc = _server_netloc(env)   # names the primary server (env.c1)
+    res = src_sess.compound([op.putfh(src_fh),
+                             op.copy_notify(src_stateid, dest_netloc)])
+    check(res, [NFS4_OK, NFS4ERR_NOTSUPP], msg="COPY_NOTIFY on source server")
+    if res.status == NFS4ERR_NOTSUPP:
+        t.fail_support("Source server does not support COPY_NOTIFY")
+    cnr = res.resarray[-1]
+    copy_src_stateid = cnr.cnr_stateid
+    source_server = cnr.cnr_source_server
+    if not source_server:
+        fail("COPY_NOTIFY returned an empty cnr_source_server list")
+
+    # Destination file on the primary server (the copy destination).
+    dst_sess = env.c1.new_client_session(env.testname(t) + b"_dst")
+    dst_fh, dst_stateid = _create_and_open(dst_sess, env.testname(t))
+
+    # COPY to the destination, naming the source via ca_source_server.
+    # Inter-server copy is asynchronous on the Linux server (a synchronous
+    # request returns NFS4ERR_NOTSUPP), so ask for async and poll below.
+    ops = _inter_copy_ops(src_fh, copy_src_stateid, dst_fh, dst_stateid,
+                          source_server, count=len(data), synchronous=0)
+    res = dst_sess.compound(ops)
+    check(res, [NFS4_OK, NFS4ERR_NOTSUPP], msg="inter-server COPY")
+    if res.status == NFS4ERR_NOTSUPP:
+        t.fail_support("Destination server does not support inter-server COPY")
+    cr = res.resarray[-1]
+
+    if cr.cr_resok4.cr_requirements.cr_synchronous:
+        if cr.cr_response.wr_count != len(data):
+            fail("Inter-server copy expected %d bytes, got %d" %
+                 (len(data), cr.cr_response.wr_count))
+    else:
+        copy_stateid = cr.cr_response.wr_callback_id[0]
+        status = _poll_offload_status(dst_sess, dst_fh, copy_stateid)
+        if status.osr_complete[0] != NFS4_OK:
+            fail("Async inter-server copy error: %d" % status.osr_complete[0])
+        if status.osr_count != len(data):
+            fail("Expected %d bytes copied, got %d" %
+                 (len(data), status.osr_count))
+
+    _verify_data(dst_sess, dst_fh, dst_stateid, data)

-- 
2.55.0


