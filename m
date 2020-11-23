Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC12C1594
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgKWUEa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKWUE3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:29 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7473DC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:28 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 11so152190qvq.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W4j98SKwgtN/8xfyf2yWXsdXmMUkUzTkpLQWBxfiNCg=;
        b=PS6Gu3vG6WpOJy/k5SsxllUl5wRZN1fr5ZBZX9/Ln2F7U3P2D66xZ+Z60weE3OyfH6
         0m305cWZ3qXxDjfuYAzmzPEI6Wn8m8EPW+ITzcdU605+eD3Vo7tTW3+2BsL4UyluxmJ8
         JA/YxofKcKn44I8dauOZSMpC5MvLXExYNnfVEGZmUEaerPOcr10Vl7AhD88ZNFWqAWrF
         bvnhoo5kHcGUZI3mkDlMf6lU5v5ErzxD9+TVJZhlxLNQSB6n+VQ1dX4NPSYZjAsuEexD
         UgSncwocQywjZtNQp7+U4MTz7h9YGAN51rQHndgPjhl8onvgZDjFRurSDP/84q8DuXCk
         cNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=W4j98SKwgtN/8xfyf2yWXsdXmMUkUzTkpLQWBxfiNCg=;
        b=hQs8P04OzEBPWScfc2A311r4Qu+d/P8BVThMukOj2BoHe23VzHNgxa/n9SIdZ0aW7d
         8UgfKZBb7n7xcimM4qCFdK9q27lSCJzY6uyHzdj7eUowcOLtjPEee+7P7GKcQ9+FODdL
         q0py5ID8Colfm/njhEF4IULu2esGsvnMo8S3VEMlR84jNnTrdsbUrO50LcMABj6aXrPg
         JaHhjOZRkHEAHXD8wTLhEV1xx8gQfuRmQZyuxC+SFqqmugYkYXkS3dFBcnQDK+VoAmrB
         CjIqFsQAjZ9VOniH2eVQisWFL75yvx7xxCaX1XbUyPdfoVOw7P++BPTn+7ltWjnofkbv
         A2tg==
X-Gm-Message-State: AOAM531VGmXGo9t3oBOiMtW4/JxHnIah+itl4qysARYQBT5XCJvhCmFM
        8UIXCbEy87pXt/EpBnstQNLiviOo+Fc=
X-Google-Smtp-Source: ABdhPJy2RFWTUeKTkUxiwRidLR3Mqpa4u0WYdTWbu6TVSgTfgqKownlkcyCdtJQ4PNwHNs7uUWdVgw==
X-Received: by 2002:a0c:e9c7:: with SMTP id q7mr1101025qvo.9.1606161867338;
        Mon, 23 Nov 2020 12:04:27 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a123sm4124988qkc.52.2020.11.23.12.04.26
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:26 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK4PjO010282
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:25 GMT
Subject: [PATCH v3 05/85] NFSD: Add tracepoints in
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:25 -0500
Message-ID: <160616186571.51996.4492471734685593106.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For troubleshooting purposes, record failures to decode NFSv4
operation arguments and encode operation results.

trace_nfsd_compound_decode_err() replaces the dprintk() call sites
that are embedded in READ_* macros that are about to be removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++-
 fs/nfsd/trace.h   |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 86a149ce0e84..66edac748272 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -54,6 +54,8 @@
 #include "pnfs.h"
 #include "filecache.h"
 
+#include "trace.h"
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
 #endif
@@ -2248,9 +2250,14 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		READ_BUF(4);
 		op->opnum = be32_to_cpup(p++);
 
-		if (nfsd4_opnum_in_range(argp, op))
+		if (nfsd4_opnum_in_range(argp, op)) {
 			op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
-		else {
+			if (op->status != nfs_ok)
+				trace_nfsd_compound_decode_err(argp->rqstp,
+							       argp->opcnt, i,
+							       op->opnum,
+							       op->status);
+		} else {
 			op->opnum = OP_ILLEGAL;
 			op->status = nfserr_op_illegal;
 		}
@@ -5203,6 +5210,8 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 	       !nfsd4_enc_ops[op->opnum]);
 	encoder = nfsd4_enc_ops[op->opnum];
 	op->status = encoder(resp, op->status, &op->u);
+	if (op->status)
+		trace_nfsd_compound_encode_err(rqstp, op->opnum, op->status);
 	if (opdesc && opdesc->op_release)
 		opdesc->op_release(&op->u);
 	xdr_commit_encode(xdr);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 0bf1707bd846..92a0973dd671 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -28,6 +28,24 @@
 			       rqstp->rq_xprt->xpt_remotelen); \
 		} while (0);
 
+#define NFSD_TRACE_PROC_RES_FIELDS \
+		__field(unsigned int, netns_ino) \
+		__field(u32, xid) \
+		__field(unsigned long, status) \
+		__array(unsigned char, server, sizeof(struct sockaddr_in6)) \
+		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+
+#define NFSD_TRACE_PROC_RES_ASSIGNMENTS(error) \
+		do { \
+			__entry->netns_ino = SVC_NET(rqstp)->ns.inum; \
+			__entry->xid = be32_to_cpu(rqstp->rq_xid); \
+			__entry->status = be32_to_cpu(error); \
+			memcpy(__entry->server, &rqstp->rq_xprt->xpt_local, \
+			       rqstp->rq_xprt->xpt_locallen); \
+			memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote, \
+			       rqstp->rq_xprt->xpt_remotelen); \
+		} while (0);
+
 TRACE_EVENT(nfsd_garbage_args_err,
 	TP_PROTO(
 		const struct svc_rqst *rqstp
@@ -127,6 +145,56 @@ TRACE_EVENT(nfsd_compound_status,
 		__get_str(name), __entry->status)
 )
 
+TRACE_EVENT(nfsd_compound_decode_err,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		u32 args_opcnt,
+		u32 resp_opcnt,
+		u32 opnum,
+		__be32 status
+	),
+	TP_ARGS(rqstp, args_opcnt, resp_opcnt, opnum, status),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_RES_FIELDS
+
+		__field(u32, args_opcnt)
+		__field(u32, resp_opcnt)
+		__field(u32, opnum)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_RES_ASSIGNMENTS(status)
+
+		__entry->args_opcnt = args_opcnt;
+		__entry->resp_opcnt = resp_opcnt;
+		__entry->opnum = opnum;
+	),
+	TP_printk("op=%u/%u opnum=%u status=%lu",
+		__entry->resp_opcnt, __entry->args_opcnt,
+		__entry->opnum, __entry->status)
+);
+
+TRACE_EVENT(nfsd_compound_encode_err,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		u32 opnum,
+		__be32 status
+	),
+	TP_ARGS(rqstp, opnum, status),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_RES_FIELDS
+
+		__field(u32, opnum)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_RES_ASSIGNMENTS(status)
+
+		__entry->opnum = opnum;
+	),
+	TP_printk("opnum=%u status=%lu",
+		__entry->opnum, __entry->status)
+);
+
+
 DECLARE_EVENT_CLASS(nfsd_fh_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,


