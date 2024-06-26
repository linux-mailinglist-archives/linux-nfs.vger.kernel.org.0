Return-Path: <linux-nfs+bounces-4346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AEE918E70
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F187C287F40
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49037190680;
	Wed, 26 Jun 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjIDwkaI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A1190670;
	Wed, 26 Jun 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426484; cv=none; b=AUzRLL4JAroWE8l56RsOjIAv1LgBAb+qoUZLNQR9F347VCerEeGWWBpSDyTncRcT7Xt9jZ5O0C/3DXpYnArkaHzhu2uBUO4/BsLuS5gvu+3t+0n9h3XMBckEO6AbJZayT4IDom6Od4Gkbjx6Tt9HRrgY9lQaZ15InPdU9Wi+TLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426484; c=relaxed/simple;
	bh=mUXoOORlfk0p8dZ15nWYoTWVRGfem9OjwPIECWFk5OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocwffVpnpdw74+2buYxSKe23eVuF8LbxZDOCKevgOzsN6WlFcYIPIB0mSU30B84jbJ8C66OjsGGedMXVPb1oU+1rNNclrmBRKcuoEGgc/BpVrmSbggfPLZTIuVT8NOOSXnTNqBgaYmFzno/SMQOWRAtV0sGZbrcX8CpsO+mw/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjIDwkaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76848C32789;
	Wed, 26 Jun 2024 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426484;
	bh=mUXoOORlfk0p8dZ15nWYoTWVRGfem9OjwPIECWFk5OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjIDwkaIiCKbUMJhO/TebQNu1zSYQwAJn1a+Z87pcQ+Ztra74TA6UOELhudnr2szt
	 KI9tJnhhuK8oWOztGKNI4jLbmVEEZtzGBp1cIE+s13/6C9tbY7BtadZ/2ORWqiwIJn
	 Od8z+C1GV+ZtOLPisTabwh6L1WuA/83Yn/WDOXjlCk2tX0CYZB6U3FPDGHzAI3ZxD2
	 eLvBiFGdpnGZr3dWasBjC1bmV+UTuftjaua/wukCW4oN0/Ldl2RaX/tm/RbqbYUkhY
	 pqIJOIPNR3f9fcCsDCtNTUMrH9DPFuMIwnLaxi1dcC3KkHXGatLH/EqDAkMuj3D/ND
	 FkEqdwZTPWoGg==
From: cel@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<stable@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10 2/5] SUNRPC: Fix a NULL pointer deref in trace_svc_stats_latency()
Date: Wed, 26 Jun 2024 14:27:42 -0400
Message-ID: <20240626182745.288665-3-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240626182745.288665-1-cel@kernel.org>
References: <20240626182745.288665-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 5c11720767f70d34357d00a15ba5a0ad052c40fe ]

Some paths through svc_process() leave rqst->rq_procinfo set to
NULL, which triggers a crash if tracing happens to be enabled.

Fixes: 89ff87494c6e ("SUNRPC: Display RPC procedure names instead of proc numbers")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h    |  1 +
 include/trace/events/sunrpc.h |  8 ++++----
 net/sunrpc/svc.c              | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1cf7a7799cc0..8583825c4aea 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -498,6 +498,7 @@ void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
 struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
+const char *	   svc_proc_name(const struct svc_rqst *rqstp);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 56e4a57d2538..5d34deca0f30 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1578,7 +1578,7 @@ TRACE_EVENT(svc_process,
 		__field(u32, vers)
 		__field(u32, proc)
 		__string(service, name)
-		__string(procedure, rqst->rq_procinfo->pc_name)
+		__string(procedure, svc_proc_name(rqst))
 		__string(addr, rqst->rq_xprt ?
 			 rqst->rq_xprt->xpt_remotebuf : "(null)")
 	),
@@ -1588,7 +1588,7 @@ TRACE_EVENT(svc_process,
 		__entry->vers = rqst->rq_vers;
 		__entry->proc = rqst->rq_proc;
 		__assign_str(service, name);
-		__assign_str(procedure, rqst->rq_procinfo->pc_name);
+		__assign_str(procedure, svc_proc_name(rqst));
 		__assign_str(addr, rqst->rq_xprt ?
 			     rqst->rq_xprt->xpt_remotebuf : "(null)");
 	),
@@ -1854,7 +1854,7 @@ TRACE_EVENT(svc_stats_latency,
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(unsigned long, execute)
-		__string(procedure, rqst->rq_procinfo->pc_name)
+		__string(procedure, svc_proc_name(rqst))
 		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
@@ -1862,7 +1862,7 @@ TRACE_EVENT(svc_stats_latency,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->execute = ktime_to_us(ktime_sub(ktime_get(),
 							 rqst->rq_stime));
-		__assign_str(procedure, rqst->rq_procinfo->pc_name);
+		__assign_str(procedure, svc_proc_name(rqst));
 		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ac7b3a93d992..f8815ae776e6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1612,6 +1612,21 @@ u32 svc_max_payload(const struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_max_payload);
 
+/**
+ * svc_proc_name - Return RPC procedure name in string form
+ * @rqstp: svc_rqst to operate on
+ *
+ * Return value:
+ *   Pointer to a NUL-terminated string
+ */
+const char *svc_proc_name(const struct svc_rqst *rqstp)
+{
+	if (rqstp && rqstp->rq_procinfo)
+		return rqstp->rq_procinfo->pc_name;
+	return "unknown";
+}
+
+
 /**
  * svc_encode_result_payload - mark a range of bytes as a result payload
  * @rqstp: svc_rqst to operate on
-- 
2.45.1


