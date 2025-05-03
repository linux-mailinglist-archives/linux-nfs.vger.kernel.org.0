Return-Path: <linux-nfs+bounces-11409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B9AA826C
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249A75A423A
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 19:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BC27E7E8;
	Sat,  3 May 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="disRDT4n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751827E7E3;
	Sat,  3 May 2025 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302382; cv=none; b=EAPbhfLAs7lpeonYF2QhY35fCw0m3WMsBsYfEFKVNcSUqWSDMX3oZodykzTLm0mY6ghJ3TQTlQ+HIp2zMKAHmNzrBubuGxPW5Sbs/X+WM9MNYnxUz6ykxpZQRyie3apqF0k4WgeB1xyUEeLJaW6L82+dLaXjV4vTTi/Xb8UL1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302382; c=relaxed/simple;
	bh=KJPgf046JQUt43qmgHzqKe/F6+epeQhsks3OVpFEwuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/pS7GT1PD/WwoJEn+rXE6J3YqE6KKhGsWZDD0wHroRljMf2XtAQf55txIHbthVmmJYB2lY7KsCj7F+C7U0Y7mdOqd/ccqur1dduYpN8MairGxyHFRpLkdL4gcUwBl+3jiqw+A+aEAvvBDIn1/D9dZEBSsiYmfPtmukHTtE1/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=disRDT4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0D9C4CEEE;
	Sat,  3 May 2025 19:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302382;
	bh=KJPgf046JQUt43qmgHzqKe/F6+epeQhsks3OVpFEwuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=disRDT4nDLWGR7Yxa4HCcDXsbiiOuoRv+3o4xek7RVJOiQ8iZBesZegN7S12g0o9s
	 4IrMhBCspxxaTznEYymZaOOxdmzqbHgN0Cpody0AJKpBQTMmCb6v1mEWCoRFK47Vaj
	 0cwTJ5nRGwBkIh01Zz8cNbgqu1usdH+fLpI3NaSN3ZjUDeia3uMaa2LzPYLIuPfhYw
	 u0N5Ji22nLbT2T+qPDdzY3dsWY5kWHFKTBasZNemZo4U/UDq+guWjEAYpxDhXzoSWA
	 e9VqP6Mt2yMW6nOI7PExiroEmGiQ0mUSvCv1vgP78OB6px5YZx9X6/C54hHDljcYnD
	 pYM8lWfeP4pxw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 01/18] NFSD: Use sockaddr instead of a generic array
Date: Sat,  3 May 2025 15:59:19 -0400
Message-ID: <20250503195936.5083-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Record and emit presentation addresses using tracing helpers
designed for the task.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 0d49fc064f72..f67ab3d1b506 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -18,22 +18,23 @@
 #include "nfsfh.h"
 #include "xdr4.h"
 
-#define NFSD_TRACE_PROC_RES_FIELDS \
+#define NFSD_TRACE_PROC_RES_FIELDS(r) \
 		__field(unsigned int, netns_ino) \
 		__field(u32, xid) \
 		__field(unsigned long, status) \
-		__array(unsigned char, server, sizeof(struct sockaddr_in6)) \
-		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+		__sockaddr(server, (r)->rq_xprt->xpt_locallen) \
+		__sockaddr(client, (r)->rq_xprt->xpt_remotelen)
 
-#define NFSD_TRACE_PROC_RES_ASSIGNMENTS(error) \
+#define NFSD_TRACE_PROC_RES_ASSIGNMENTS(r, error) \
 		do { \
-			__entry->netns_ino = SVC_NET(rqstp)->ns.inum; \
-			__entry->xid = be32_to_cpu(rqstp->rq_xid); \
+			struct svc_xprt *xprt = (r)->rq_xprt; \
+			__entry->netns_ino = SVC_NET(r)->ns.inum; \
+			__entry->xid = be32_to_cpu((r)->rq_xid); \
 			__entry->status = be32_to_cpu(error); \
-			memcpy(__entry->server, &rqstp->rq_xprt->xpt_local, \
-			       rqstp->rq_xprt->xpt_locallen); \
-			memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote, \
-			       rqstp->rq_xprt->xpt_remotelen); \
+			__assign_sockaddr(server, &xprt->xpt_local, \
+					  xprt->xpt_locallen); \
+			__assign_sockaddr(client, &xprt->xpt_remote, \
+					  xprt->xpt_remotelen); \
 		} while (0);
 
 DECLARE_EVENT_CLASS(nfsd_xdr_err_class,
@@ -145,14 +146,14 @@ TRACE_EVENT(nfsd_compound_decode_err,
 	),
 	TP_ARGS(rqstp, args_opcnt, resp_opcnt, opnum, status),
 	TP_STRUCT__entry(
-		NFSD_TRACE_PROC_RES_FIELDS
+		NFSD_TRACE_PROC_RES_FIELDS(rqstp)
 
 		__field(u32, args_opcnt)
 		__field(u32, resp_opcnt)
 		__field(u32, opnum)
 	),
 	TP_fast_assign(
-		NFSD_TRACE_PROC_RES_ASSIGNMENTS(status)
+		NFSD_TRACE_PROC_RES_ASSIGNMENTS(rqstp, status)
 
 		__entry->args_opcnt = args_opcnt;
 		__entry->resp_opcnt = resp_opcnt;
@@ -171,12 +172,12 @@ DECLARE_EVENT_CLASS(nfsd_compound_err_class,
 	),
 	TP_ARGS(rqstp, opnum, status),
 	TP_STRUCT__entry(
-		NFSD_TRACE_PROC_RES_FIELDS
+		NFSD_TRACE_PROC_RES_FIELDS(rqstp)
 
 		__field(u32, opnum)
 	),
 	TP_fast_assign(
-		NFSD_TRACE_PROC_RES_ASSIGNMENTS(status)
+		NFSD_TRACE_PROC_RES_ASSIGNMENTS(rqstp, status)
 
 		__entry->opnum = opnum;
 	),
-- 
2.49.0


