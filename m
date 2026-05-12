Return-Path: <linux-nfs+bounces-21558-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAAqBvBvA2qI5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21558-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E28527714
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5A231599E8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB5336C9C2;
	Tue, 12 May 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkBUtyZP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05A375F65
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609656; cv=none; b=EvZoX3hYTrlF+MZzyaT4y6t2Qas+j2MwsU6LGzCMAEna1YGavcBsohlEvc6Dapk4ZvX3osNg7ic04bVBmzAFCO6mO5GxeuyLL3tGSBu2flBj4DMB376R1bqmp/bnrwOYJ2pxP4KGlnepHHbAW7gXTpGiWwS7O4WXsD6szxxuoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609656; c=relaxed/simple;
	bh=J+BjJKIxECmZPjCaaild9UjG6TNN5KkwY7gKIfuQ1aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjSynWnvbBgRlJZJ06BhBQK6FqZNeqqa7wpDIy2mn5vD22nnW/x8Iy93Hu1pwyq51UebCnX0kj46lQJWcSDfmTwoBecKHOBuiDg5W4Fs97/EAE+5ZOI3Gv6TjUTNJzXFz+vIOlxt8Xb9GA6nOQdH2nNhBPX89pmh3Ge6uE2/q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkBUtyZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E714C2BCF5;
	Tue, 12 May 2026 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609656;
	bh=J+BjJKIxECmZPjCaaild9UjG6TNN5KkwY7gKIfuQ1aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lkBUtyZPHT3cPOZ/n+0FN++tmBjePBZFsodmEAeiBx2gzE9i+qnQAHLnKGHSxVNss
	 GqsC8Q5IWP16z2sohnN94R86zBhdHAs5nrsrUCzzyMiid1KQwKKxy+nIllft2Ci1sS
	 3dQ5h5AmwNruEZ1UHrI2cBVYNCRCBbnA9n7/Hjb0vcvxOw0LgE/1MwTTAkvkBTTB8O
	 /VRwYEo22pP7MPuqvncpa1AVzrrj4gOse1ds3UUH/IULTum4ZSIkYAk60VXAd6FWef
	 X+aLWczTPrONkqqkKc/CPGLDygalczDqsuPpewUNrfC9Sh6Td+3LP4vJt03decJYdn
	 GjmqJWX+hbG4A==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:53 -0400
Subject: [PATCH 18/38] lockd: Use xdrgen XDR functions for the NLMv3
 GRANTED procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-18-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=6045;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=NxL3V2QjLTGwpYB4EYnC5R2HiyHGVmt7KDZZ80ifzEs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23ltclWi6OeaTw1CBPU57q8q9PU7zZO8MeO4
 Qzgk6Lc/gWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 lytnD/wPrsALFmlnpOcDYkxaYUycPSXQmulNsYcsOaVaxXzQA/JK7t97+S/9gXby1ftDtha9Wuv
 oi9VmxXyJPp9wePOp3PfT9GfX9G1UmWgiCbAuxIQwBcg5ZdhG6vSLQhPKPZmgSgUE+7Nxohsm3s
 MYf1r+rxmvV7Yc8/UMSgmbICn4gfgz7GzTcIIpzQ62HQh/KpJynabTWOBkyQB+gTo2YV+IFuFP7
 T8HS4jHxfsiM9ympHtYNuT4zn+Frw6O1Olin7xGbSumPsGiFnheQuAueTs7/TSTpYWOG3qsiIyD
 XHxbZZA2RcxLDVzGp8ZicUHW8LIQZ8BvF7/ba20mNniZGrQ5dyzYk9SUT3mNM5Z4w5bKmiXEjHX
 KEu8/XPG08PqpC+yVbY5J2rnkA+vArsfdwoUaIr6s8Di0T21dXR9/ZUoN/1yd9nCh4kVBqXQyyS
 elTAoE5OIB9nR0W5UNujTHHF31EWxXj+WvHRoc4cTw3XPv0fmr1UREWut8/tz5R/lt3HmT4c0sY
 niVk8ZM0eLB2+3KET/Wb3vkdL9XxAgIv/j7rY0QIRc0SWvF4QAMJ8NtTZsi7qU9Ued9voSJAlLX
 3mIrnJsCA7n95S1W+3UP3o0Ew+T3kKIoPWiSjCJg0jVdQwwJfl53qUop/NQ2M1Z5EN+6bz8fc9G
 WANXd4ogMpivsog==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 59E28527714
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21558-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLM GRANTED procedure allows servers to notify clients when
a previously blocked lock request has been granted, completing
the asynchronous lock request flow. This patch converts the NLMv3
GRANTED procedure to use xdrgen-generated XDR functions.

The conversion replaces the legacy decoder with the xdrgen
functions nlm_svc_decode_nlm_testargs and nlm_svc_encode_nlm_res
generated from the NLM version 3 protocol specification. The
procedure handler accesses xdrgen types through a wrapper structure
that bridges between generated code and the legacy lockd_lock
representation still used by the core lockd logic.

A new helper function nlm_lock_to_lockd_lock() converts an xdrgen
nlm_lock into the legacy lockd_lock format. The helper complements
the existing nlm3svc_lookup_host() and nlm3svc_lookup_file()
functions used throughout this series.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so the
zeroing memset performed by the dispatch layer is not needed. The
helper populates each field of the wrapper's lock member that any
downstream consumer reads: fh, oh, svid, and the file_lock byte
range. Because pc_argzero no longer scrubs the rq_argp slot, the
shared nlmclnt_lock_event tracepoint class is updated to source
its byte-range fields from lock->fl.fl_start and lock->fl.fl_end,
which both the client and server populate unconditionally; the old
lock_start and lock_len fields are no longer required by the trace.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 65 +++++++++++++++++++++++++++++++++++++++++++++---------
 fs/lockd/trace.h   | 12 +++++-----
 2 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index ccc6a633df7b..264212e44ec5 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -89,6 +89,20 @@ nlm_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 	return nlm_granted;
 }
 
+static __be32
+nlm_lock_to_lockd_lock(struct lockd_lock *lock, struct nlm_lock *alock)
+{
+	if (alock->fh.len != NLM3_FHSIZE)
+		return nlm_lck_denied;
+	lock->fh.size = alock->fh.len;
+	memcpy(lock->fh.data, alock->fh.data, alock->fh.len);
+	lock->oh.len = alock->oh.len;
+	lock->oh.data = alock->oh.data;
+	lock->svid = alock->uppid;
+	lockd_set_file_lock_range3(&lock->fl, alock->l_offset, alock->l_len);
+	return nlm_granted;
+}
+
 static struct nlm_host *
 nlm3svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
@@ -700,10 +714,41 @@ __nlmsvc_proc_granted(struct svc_rqst *rqstp, struct lockd_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlmsvc_proc_granted - GRANTED: Blocked lock has been granted
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * RPC synopsis:
+ *   nlm_res NLM_GRANTED(nlm_testargs) = 5;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The granted lock was accepted.
+ *   %LCK_DENIED:		The procedure failed, possibly due to
+ *				internal resource constraints.
+ *   %LCK_DENIED_GRACE_PERIOD:	The client host recently restarted and
+ *				its NLM is re-establishing existing locks,
+ *				so it is not yet ready to accept callbacks.
+ */
 static __be32
 nlmsvc_proc_granted(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_granted(rqstp, rqstp->rq_resp);
+	struct nlm_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_res_wrapper *resp = rqstp->rq_resp;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm_lock_to_lockd_lock(&argp->lock,
+							&argp->xdrgen.alock);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
+
+out:
+	return rpc_success;
 }
 
 /*
@@ -1012,15 +1057,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_res_sz,
 		.pc_name	= "UNLOCK",
 	},
-	[NLMPROC_GRANTED] = {
-		.pc_func = nlmsvc_proc_granted,
-		.pc_decode = nlmsvc_decode_testargs,
-		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "GRANTED",
+	[NLM_GRANTED] = {
+		.pc_func	= nlmsvc_proc_granted,
+		.pc_decode	= nlm_svc_decode_nlm_testargs,
+		.pc_encode	= nlm_svc_encode_nlm_res,
+		.pc_argsize	= sizeof(struct nlm_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_res_wrapper),
+		.pc_xdrressize	= NLM3_nlm_res_sz,
+		.pc_name	= "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlmsvc_proc_test_msg,
diff --git a/fs/lockd/trace.h b/fs/lockd/trace.h
index aa858d9d406d..a11d04e8c835 100644
--- a/fs/lockd/trace.h
+++ b/fs/lockd/trace.h
@@ -61,8 +61,8 @@ DECLARE_EVENT_CLASS(nlmclnt_lock_event,
 			__field(u32, svid)
 			__field(u32, fh)
 			__field(unsigned long, status)
-			__field(u64, start)
-			__field(u64, len)
+			__field(loff_t, start)
+			__field(loff_t, end)
 			__sockaddr(addr, addrlen)
 		),
 
@@ -70,16 +70,16 @@ DECLARE_EVENT_CLASS(nlmclnt_lock_event,
 			__entry->oh = ~crc32_le(0xffffffff, lock->oh.data, lock->oh.len);
 			__entry->svid = lock->svid;
 			__entry->fh = nfs_fhandle_hash(&lock->fh);
-			__entry->start = lock->lock_start;
-			__entry->len = lock->lock_len;
+			__entry->start = lock->fl.fl_start;
+			__entry->end = lock->fl.fl_end;
 			__entry->status = be32_to_cpu(status);
 			__assign_sockaddr(addr, addr, addrlen);
 		),
 
 		TP_printk(
-			"addr=%pISpc oh=0x%08x svid=0x%08x fh=0x%08x start=%llu len=%llu status=%s",
+			"addr=%pISpc oh=0x%08x svid=0x%08x fh=0x%08x start=%lld end=%lld status=%s",
 			__get_sockaddr(addr), __entry->oh, __entry->svid,
-			__entry->fh, __entry->start, __entry->len,
+			__entry->fh, __entry->start, __entry->end,
 			show_nlm_status(__entry->status)
 		)
 );

-- 
2.54.0


