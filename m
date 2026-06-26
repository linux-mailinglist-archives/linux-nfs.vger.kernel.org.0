Return-Path: <linux-nfs+bounces-22866-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XQHYKHmXPmq9IgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22866-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 17:15:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAD86CE620
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 17:15:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=desy.de header.s=default header.b=sfLGCQ6q;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22866-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22866-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=desy.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C07B3300CC01
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541437C0E3;
	Fri, 26 Jun 2026 15:10:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4F26F29B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 15:10:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486642; cv=none; b=cGVj/9wBm1RmV+6J0XSOWv4Ad0dE9ZJLQkp+92eHX1DaeL/qCcRCkjG9vjq796rAtDSjle1CYpK8JtdwECKCmT7N3LU/EkIPwAa4LULSpD46OL4kKLMaoJkGiViHXGGmHO+eaaaIavnqSMZ9T0Zr8d1s9GH/Xr5SCnSzLF9U+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486642; c=relaxed/simple;
	bh=30cgHW0zmvwYrUhqScbrsADQ2klfVTKNudiVF1svDZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkLQ2nZW6CAYiYjg9g3YSX1z4Hpuz2Ojj+X+pSmWslX70JoRtixOzL24JHlfOtbrdJao2+HlQZdV3z840hzd6/sGLpe5TqoFNmtXDgVcUXpO1DgK9vfS+HNirdWfBBz8lAbWMzkj6/eLculSYnK7Xr5MH2FUDIS6EVeAFwFC9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=sfLGCQ6q; arc=none smtp.client-ip=131.169.56.155
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 3224E13F651
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 17:10:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 3224E13F651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1782486636; bh=8lL5ci55c4gk+Ww6BtQIpyZeC+Ujo7Iz89swiNSl8qA=;
	h=From:To:Cc:Subject:Date:From;
	b=sfLGCQ6qSgilzhwKLiHLzH1c5fh5jKB7K43Q1FyuPwsQOqv5DEtACOzsoP9h9is1l
	 3OZmCUnmgNR34a0Wu/pvBdLWaGXVxqj0iLFMVsDMFSG8+P0+fjordVxxmEJtsykAaQ
	 VB6xUxixp0HlRR+NCmqhOeVXMNsBz2rYHnP/loOw=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 24250120043;
	Fri, 26 Jun 2026 17:10:36 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 1308440045;
	Fri, 26 Jun 2026 17:10:36 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 85FBD10003B;
	Fri, 26 Jun 2026 17:10:34 +0200 (CEST)
Received: from z-prx-3.desy.de (z-prx-3.desy.de [131.169.10.30])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 66B9880046;
	Fri, 26 Jun 2026 17:10:34 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by z-prx-3.desy.de (Postfix) with ESMTP id 5CFD214024F;
	Fri, 26 Jun 2026 17:10:34 +0200 (CEST)
Received: from z-prx-3.desy.de ([IPv6:::1])
 by localhost (z-prx-3.desy.de [IPv6:::1]) (amavis, port 10026) with ESMTP
 id sruOLVgHkAs0; Fri, 26 Jun 2026 17:10:34 +0200 (CEST)
Received: from nairi.fritz.box (unknown [IPv6:2001:638:700:e064::1b])
	by z-prx-3.desy.de (Postfix) with ESMTPSA id 255A41400B7;
	Fri, 26 Jun 2026 17:10:31 +0200 (CEST)
From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To: trondmy@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] [RFC] nfs4: inject process namespace into COMPOUND tag
Date: Fri, 26 Jun 2026 17:10:29 +0200
Message-ID: <20260626151029.1516839-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desy.de,none];
	R_DKIM_ALLOW(-0.20)[desy.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22866-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:tigran.mkrtchyan@desy.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tigran.mkrtchyan@desy.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[desy.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAAD86CE620

On large shared machines often multiple jobs of a same user run in
parallel. For debugging, it's usually impossible to identify requests
coming from different processes.

The batch systems like HTCondor or SLURM start every job in it's own
namespace, thus passing namespace info to the server will help by
debugging.

192.168.122.150 → 192.168.178.69 NFS 260 V4 Call GETATTR FH: 0xd5ffb2cb
192.168.178.69 → 192.168.122.150 NFS 324 V4 Reply (Call In 89) GETATTR
192.168.122.150 → 192.168.178.69 NFS 260 V4 Call GETATTR FH: 0xd0b0a44e
192.168.178.69 → 192.168.122.150 NFS 324 V4 Reply (Call In 95) GETATTR
192.168.122.150 → 192.168.178.69 NFS 268 V4 Call ACCESS FH: 0xd0b0a44e, [Check: RD LU MD XT DL XAR XAW XAL]
192.168.178.69 → 192.168.122.150 NFS 240 V4 Reply (Call In 101) ACCESS, [Allowed: RD LU MD XT DL XAR XAW XAL]
192.168.122.150 → 192.168.178.69 NFS 284 V4 Call READDIR FH: 0xd0b0a44e
192.168.178.69 → 192.168.122.150 NFS 664 V4 Reply (Call In 105) READDIR
192.168.122.150 → 192.168.178.69 NFS 284 V4 Call ns:4026532507 GETATTR FH: 0xd67b66a5
192.168.178.69 → 192.168.122.150 NFS 340 V4 Reply (Call In 111) ns:4026532507 GETATTR
192.168.122.150 → 192.168.178.69 NFS 292 V4 Call ns:4026532507 ACCESS FH: 0xd67b66a5, [Check: RD LU MD XT DL XAR XAW XAL]
192.168.178.69 → 192.168.122.150 NFS 256 V4 Reply (Call In 117) ns:4026532507 ACCESS, [Access Denied: MD XT DL XAW], [Allowed: RD LU XAR XAL]
192.168.122.150 → 192.168.178.69 NFS 308 V4 Call ns:4026532507 READDIR FH: 0xd67b66a5
192.168.178.69 → 192.168.122.150 NFS 200 V4 Reply (Call In 121) ns:4026532507 READDIR

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/nfs4xdr.c             | 24 +++++++++++++++++++-----
 include/linux/sunrpc/sched.h |  2 ++
 net/sunrpc/sched.c           |  6 ++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c23c2eee1b5c..9c035c74a3b5 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -46,6 +46,7 @@
 #include <linux/kdev_t.h>
 #include <linux/module.h>
 #include <linux/utsname.h>
+#include <linux/pid_namespace.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/gss_api.h>
@@ -71,12 +72,8 @@ static void encode_layoutget(struct xdr_stream *xdr,
 static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 			     struct nfs4_layoutget_res *res);
 
-/* NFSv4 COMPOUND tags are only wanted for debugging purposes */
-#ifdef DEBUG
+/* Enable compound tags to include namespace information */
 #define NFS4_MAXTAGLEN		20
-#else
-#define NFS4_MAXTAGLEN		0
-#endif
 
 /* lock,open owner id:
  * we currently use size 2 (u64) out of (NFS4_OPAQUE_LIMIT  >> 2)
@@ -1034,6 +1031,23 @@ static void encode_compound_hdr(struct xdr_stream *xdr,
 {
 	__be32 *p;
 
+	/* Inject namespace info into compound tag if not already set */
+	if (hdr->taglen == 0 && req->rq_task != NULL) {
+		/* Use namespace info captured at task creation time */
+		struct rpc_task *task = req->rq_task;
+
+		if (taks->tk_ns_inum != 0) {
+			char ns_tag[NFS4_MAXTAGLEN + 1];
+
+			hdr->taglen = snprintf(ns_tag, sizeof(ns_tag), "ns:%u", taks->tk_ns_inum);
+			if (hdr->taglen > NFS4_MAXTAGLEN) {
+				hdr->taglen = NFS4_MAXTAGLEN;
+				ns_tag[NFS4_MAXTAGLEN] = '\0';
+			}
+			hdr->tag = ns_tag;
+		}
+	}
+
 	/* initialize running count of expected bytes in reply.
 	 * NOTE: the replied tag SHOULD be the same is the one sent,
 	 * but this is not required as a MUST for the server to do so. */
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 0dbdf3722537..d376b52a72a1 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -92,6 +92,8 @@ struct rpc_task {
 
 	pid_t			tk_owner;	/* Process id for batching tasks */
 
+	unsigned int		tk_ns_inum;	/* PID namespace inum for namespace tracking */
+
 	int			tk_rpc_status;	/* Result of last RPC operation */
 	unsigned short		tk_flags;	/* misc flags */
 	unsigned short		tk_timeouts;	/* maj timeouts */
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 016f16ca5779..4e8e7fa849d5 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/freezer.h>
 #include <linux/sched/mm.h>
+#include <linux/pid_namespace.h>
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/metrics.h>
@@ -1110,6 +1111,11 @@ static void rpc_init_task(struct rpc_task *task, const struct rpc_task_setup *ta
 	task->tk_priority = task_setup_data->priority - RPC_PRIORITY_LOW;
 	task->tk_owner = current->tgid;
 
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	/* Keep track on namespace id */
+	if (pid_ns != &init_pid_ns)
+		task->tk_ns_inum = pid_ns->ns.inum;
+
 	/* Initialize workqueue for async tasks */
 	task->tk_workqueue = task_setup_data->workqueue;
 
-- 
2.54.0


