Return-Path: <linux-nfs+bounces-11392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7496AA8137
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423EB17FA28
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC42798F4;
	Sat,  3 May 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENy5x4h8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A72798E3;
	Sat,  3 May 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285107; cv=none; b=W9c1midAAt90ShnI3Cg4I5GUyIv/yFJCmTf6xJ+cUR3VMVathwhd2B6DHLFk8otviX+tQjdKjhvHZxoLEtlkb++gD7XmYxUZiWmi1ohEZWeT2+K/B7UVHFEZi4xmVo7c2Vs/JQ73oVDTj6mAyh2MjmNIF4DNiYEAu5GGVUQQP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285107; c=relaxed/simple;
	bh=nWujkl8G3L8Ckh/Pl5UjtwHrwNM2VvWfPcxzyr8cBPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqyLkU1h1Aw3ssSDZBWtLamlCetoOkhqdvws48+UCNMUnNWogE7uKPPzH/oiI7sY31Zxvp8Io4lqDNtG986Z0yWeGJloz1RX/f6fvnLekgukpdqQdVtRzfx1JMop2Vyghe6+hiuqOS996XapyvA7n2IOCYbU5GDBPbMGq5FaX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENy5x4h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA83C4CEF0;
	Sat,  3 May 2025 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285106;
	bh=nWujkl8G3L8Ckh/Pl5UjtwHrwNM2VvWfPcxzyr8cBPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ENy5x4h8aMs8AWgYEWo4iEEQBHZL76wgNRFXeqKS42oBfOwVrwAFh0gRVnpvAVRmc
	 tVD0tggJ8vBcBNr1Qu5SxvonGTTa5hECVQ75cDDCQodaSaE7Wc0ESiBvsr2JPwBNF1
	 lLg63Inv/g4VCfQbcnS+5qV8RZo1EykJXBCxQQ4jmV32FJS9yvffCQKCiA1ynK4Wdr
	 OB0M5yFzeF9TWpj97Wp7INSOiLUeP+LgVE/3DCjZUaSxYQgPukgzJqyB0lpkS4SYGU
	 Syc6LqHOEZnI8KRf6/2q3dSmtAnqnk0Oz9Flf0gpMi6S9do6D4Z68tkIQySj/h0fqS
	 AMOli7m0QBaCg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:18 -0400
Subject: [PATCH v3 02/17] nfsd: add a tracepoint for nfsd_setattr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-2-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nWujkl8G3L8Ckh/Pl5UjtwHrwNM2VvWfPcxzyr8cBPg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIssOmVnXmohHKhxQiNYOuGLHBcbjPQmIenM
 Hzc0RoPkCqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLAAKCRAADmhBGVaC
 FTn/D/9y41R3Z2zsf9QlMCz7qawM0an0n4zdUFUDmfg3SXicPTx45DViV4J+p08HCG6dPqs/Jf5
 ITLV7m/bWKanWIzk6hD+P83t1j/BwvFq8528TLudTGdRzlqzx3IpyrJEX8xPm1QdMxjUFbMg5KD
 D3+LNmz+b4WLuOgMw2GZp1ngdjY9kqms44fCcSnrStIx6Ivr8LLJV6sat//H4zxvjb81g1lVXQ/
 iw+JYhaVsxfbd9rrKozJVP2tVUcb5qXv30PeNlpnsHPeNPG0ka0jW6bx4xrACpowvd+l/hEvbqa
 IAOZ8hYpxfcgqsaRLYpkAiWzIz2/YKhDXokD2GfELCBqoedMTIiA83YhX6xG+2cexoPUEg7pYQW
 LLFLch6+3PxQf/77TIuFjEL7kkh3Rzy5P8MfDMxhDkVA9kC/GA9qPJI0Bdw8hfCJuhT/bcyyX4B
 cjDoNg6NPK+9R6R0hqqXBYhhyzPiGIpLQgLXeHRhXZjx49Vz5k7O9j1Tq4a8kRtYv80nVxudJtA
 fFJisbjmx7OGyZnOWAW1G6KS0a1u3KWVNvaWLJ9rapJYMcOmcCWzEmon1mfSOoBuPM9L/mtROZm
 TSENfVoPfCzbTbGYRxS3adorFd1+qwWaaFDDBFG62Lc093IBQR+EXKjHJVdDuGcD3cW7fET+/aa
 mRMELCsY10Row1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Turn Sargun's internal kprobe based implementation of this into a normal
static tracepoint. Also, remove the dprintk's that got added recently
with the fix for zero-length ACLs.

Cc: Sargun Dillon <sargun@sargun.me>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h         | 35 +++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c           |  2 ++
 include/trace/misc/fs.h | 21 +++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 0d49fc064f7273f32c93732a993fd77bc0783f5d..c496fed58e2eed15458f35a158fbfef39a972c55 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -11,6 +11,7 @@
 #include <linux/tracepoint.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
+#include <trace/misc/fs.h>
 #include <trace/misc/nfs.h>
 #include <trace/misc/sunrpc.h>
 
@@ -2337,6 +2338,40 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
 DEFINE_COPY_ASYNC_DONE_EVENT(done);
 DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
 
+TRACE_EVENT(nfsd_setattr,
+	TP_PROTO(const struct svc_rqst *rqstp, const struct svc_fh *fhp,
+		 const struct iattr *iap, const struct timespec64 *guardtime),
+	TP_ARGS(rqstp, fhp, iap, guardtime),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(s64, gtime_tv_sec)
+		__field(u32, gtime_tv_nsec)
+		__field(unsigned int, ia_valid)
+		__field(loff_t, ia_size)
+		__field(uid_t, ia_uid)
+		__field(gid_t, ia_gid)
+		__field(umode_t, ia_mode)
+	),
+	TP_fast_assign(__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->gtime_tv_sec = guardtime ? guardtime->tv_sec : 0;
+		__entry->gtime_tv_nsec = guardtime ? guardtime->tv_nsec : 0;
+		__entry->ia_valid = iap->ia_valid;
+		__entry->ia_size = iap->ia_size;
+		__entry->ia_uid = __kuid_val(iap->ia_uid);
+		__entry->ia_gid = __kgid_val(iap->ia_gid);
+		__entry->ia_mode = iap->ia_mode;
+	),
+	TP_printk(
+		"xid=0x%08x fh_hash=0x%08x ia_valid=%s ia_size=%llu ia_mode=0%o ia_uid=%u ia_gid=%u guard_time=%lld.%u",
+		__entry->xid, __entry->fh_hash, show_ia_valid_flags(__entry->ia_valid),
+		__entry->ia_size, __entry->ia_mode, __entry->ia_uid, __entry->ia_gid,
+		__entry->gtime_tv_sec, __entry->gtime_tv_nsec
+	)
+)
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a61ad0da5976f2653c715e635f090aa5fd0c641f..55476fe6d9adbd338d96a9dd8f732638cd072a44 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -502,6 +502,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		retries;
 
 dprintk("nfsd_setattr pacl=%p valid=0x%x\n", attr->na_pacl, iap->ia_valid);
+	trace_nfsd_setattr(rqstp, fhp, iap, guardtime);
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype = S_IFREG;
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 738b97f22f3651f2370830037a8f4bfdf9a42ad4..0406ebe2a80a499dfcadb7e63db4d9e4a84d4d64 100644
--- a/include/trace/misc/fs.h
+++ b/include/trace/misc/fs.h
@@ -120,3 +120,24 @@
 		{ LOOKUP_BENEATH,	"BENEATH" }, \
 		{ LOOKUP_IN_ROOT,	"IN_ROOT" }, \
 		{ LOOKUP_CACHED,	"CACHED" })
+
+#define show_ia_valid_flags(flags)			\
+	__print_flags(flags, "|",			\
+		{ ATTR_MODE,		"MODE" },	\
+		{ ATTR_UID,		"UID" },	\
+		{ ATTR_GID,		"GID" },	\
+		{ ATTR_SIZE,		"SIZE" },	\
+		{ ATTR_ATIME,		"ATIME" },	\
+		{ ATTR_MTIME,		"MTIME" },	\
+		{ ATTR_CTIME,		"CTIME" },	\
+		{ ATTR_ATIME_SET,	"ATIME_SET" },	\
+		{ ATTR_MTIME_SET,	"MTIME_SET" },	\
+		{ ATTR_FORCE,		"FORCE" },	\
+		{ ATTR_KILL_SUID,	"KILL_SUID" },	\
+		{ ATTR_KILL_SGID,	"KILL_SGID" },	\
+		{ ATTR_FILE,		"FILE" },	\
+		{ ATTR_KILL_PRIV,	"KILL_PRIV" },	\
+		{ ATTR_OPEN,		"OPEN" },	\
+		{ ATTR_TIMES_SET,	"TIMES_SET" },	\
+		{ ATTR_TOUCH,		"TOUCH"},	\
+		{ ATTR_DELEG,		"DELEG"})

-- 
2.49.0


