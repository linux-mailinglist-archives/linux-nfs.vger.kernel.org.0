Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D573F3D067
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbfFKPJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:09:42 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:51341 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404326AbfFKPJm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:09:42 -0400
Received: by mail-it1-f173.google.com with SMTP id m3so5518327itl.1;
        Tue, 11 Jun 2019 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x4ZI6AAcYxM1u4HoJDhmrMyYOkjjlo0+XHPXMAifCPU=;
        b=SJQQ8XeS/7096YFNvxN5WCauud98Bsda4pJxq3dGW6HLhTYAFOqkCeTqZJeEKUO33j
         K7MsK7zfY6InBikA/zcTLb0tktK6mB/FWfn2/xWN1Cr0NgLNHpjGWycp8n01b7UR3nyC
         ig5mcExvh41Y6k8fZw6cHVI91hQmLE3lMNYefpI+OLjf1WPxrTLogy7gNuHrkirtFCKR
         d7BNK1ZPLcTJu0wPA33YK2qIv8bYUIDzCUnePkyqDWUDNFzHU/msIftkUwng2rWnRwuu
         ncLvC1+aUewsLCxHN45yl4XrtxtOPgDGViOoXZ2wJMVmJD9mOtPJ02YcPOgAYjMNAstR
         fOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=x4ZI6AAcYxM1u4HoJDhmrMyYOkjjlo0+XHPXMAifCPU=;
        b=P6GwnbgwFLgsAxL7B+CoYiFCO6WcK7xC38b1Y9D9Mfug+WB4IhueCO00/3XgfNZ7se
         oSBd60n37oqBjq+UR36dod4SSDa1qZVRHLutyHRZZZENkQYt06sp8LGAOJtGLMSd5sb+
         LMDvJyu7D1PLxm5PHZQYxZ1DdDI4WQi6aaobGj5WNyqaiuGcSZhBgi+Vv9/lbDtG2Uc0
         S7JSZAtXWDvC6BvY3zNIDALfS8qP1p7uXPQOLSkWi1PIUuGifnYwsCN3cq+4dfJ2iIC6
         igEjpLA6N9DxbLUPRv7QMVaIyByl/bBJnjf/qwu5FINVNyweJufg0n49RxCd2lYwUOJw
         UiRg==
X-Gm-Message-State: APjAAAXD/5hY/nKmzvI8WXKb15XO/vyFHULYiyH9ouLNIJLzjm8+NrMy
        VpWZN0WZVpIJYkTy8QV0rgjYfWWa
X-Google-Smtp-Source: APXvYqzjyjxwrLS1XAlg8rqbke2WHS7wGE2WEwcRynT0UTCU4nou6F1cRwwuoxfne6blgau8iOtSWQ==
X-Received: by 2002:a24:c803:: with SMTP id w3mr6621815itf.30.1560265781096;
        Tue, 11 Jun 2019 08:09:41 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y17sm3363803ioa.40.2019.06.11.08.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:09:40 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF9eJ1021782;
        Tue, 11 Jun 2019 15:09:40 GMT
Subject: [PATCH v2 19/19] NFS: Record task, client ID,
 and XID in xdr_status trace points
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:09:40 -0400
Message-ID: <20190611150939.2877.26452.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When triggering an nfs_xdr_status trace point, record the task ID
and XID of the failing RPC to better pinpoint the problem.

This feels like a bit of a layering violation.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs2xdr.c   |    2 +-
 fs/nfs/nfs3xdr.c   |    2 +-
 fs/nfs/nfs4trace.h |   15 +++++++++++++--
 fs/nfs/nfs4xdr.c   |    2 +-
 fs/nfs/nfstrace.h  |   15 +++++++++++++--
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 572794d..cbc17a2 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -151,7 +151,7 @@ static int decode_stat(struct xdr_stream *xdr, enum nfs_stat *status)
 	return 0;
 out_status:
 	*status = be32_to_cpup(p);
-	trace_nfs_xdr_status((int)*status);
+	trace_nfs_xdr_status(xdr, (int)*status);
 	return 0;
 }
 
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index abbbdde..6027678 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -343,7 +343,7 @@ static int decode_nfsstat3(struct xdr_stream *xdr, enum nfs_stat *status)
 	return 0;
 out_status:
 	*status = be32_to_cpup(p);
-	trace_nfs_xdr_status((int)*status);
+	trace_nfs_xdr_status(xdr, (int)*status);
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 9a01731..6cba216 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -564,24 +564,35 @@
 
 TRACE_EVENT(nfs4_xdr_status,
 		TP_PROTO(
+			const struct xdr_stream *xdr,
 			u32 op,
 			int error
 		),
 
-		TP_ARGS(op, error),
+		TP_ARGS(xdr, op, error),
 
 		TP_STRUCT__entry(
+			__field(unsigned int, task_id)
+			__field(unsigned int, client_id)
+			__field(u32, xid)
 			__field(u32, op)
 			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
+			const struct rpc_rqst *rqstp = xdr->rqst;
+			const struct rpc_task *task = rqstp->rq_task;
+
+			__entry->task_id = task->tk_pid;
+			__entry->client_id = task->tk_client->cl_clid;
+			__entry->xid = be32_to_cpu(rqstp->rq_xid);
 			__entry->op = op;
 			__entry->error = error;
 		),
 
 		TP_printk(
-			"error=%lu (%s) operation %d:",
+			"task:%u@%d xid=0x%08x error=%lu (%s) operation=%d",
+			__entry->task_id, __entry->client_id, __entry->xid,
 			__entry->error, show_nfsv4_errors(__entry->error),
 			__entry->op
 		)
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 6024461..d974ff3 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3187,7 +3187,7 @@ static bool __decode_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected,
 	return true;
 out_status:
 	nfserr = be32_to_cpup(p);
-	trace_nfs4_xdr_status(opnum, nfserr);
+	trace_nfs4_xdr_status(xdr, opnum, nfserr);
 	*nfs_retval = nfs4_stat_to_errno(nfserr);
 	return true;
 out_bad_operation:
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 3a0ed3d..84a79ba 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1111,21 +1111,32 @@
 
 TRACE_EVENT(nfs_xdr_status,
 		TP_PROTO(
+			const struct xdr_stream *xdr,
 			int error
 		),
 
-		TP_ARGS(error),
+		TP_ARGS(xdr, error),
 
 		TP_STRUCT__entry(
+			__field(unsigned int, task_id)
+			__field(unsigned int, client_id)
+			__field(u32, xid)
 			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
+			const struct rpc_rqst *rqstp = xdr->rqst;
+			const struct rpc_task *task = rqstp->rq_task;
+
+			__entry->task_id = task->tk_pid;
+			__entry->client_id = task->tk_client->cl_clid;
+			__entry->xid = be32_to_cpu(rqstp->rq_xid);
 			__entry->error = error;
 		),
 
 		TP_printk(
-			"error=%lu (%s)",
+			"task:%u@%d xid=0x%08x error=%lu (%s)",
+			__entry->task_id, __entry->client_id, __entry->xid,
 			__entry->error, nfs_show_status(__entry->error)
 		)
 );

