Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37D4BBB7
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfFSOeL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:34:11 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:42156 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOeL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:34:11 -0400
Received: by mail-io1-f52.google.com with SMTP id u19so38560542ior.9;
        Wed, 19 Jun 2019 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FVf87Ck26LWlmoyHAOegSUqYq5QkTCEpjcdBJDqE+Ds=;
        b=Q6k88KsLDB0IkAAuFpUyOBsvFWv1TLLLRd5B/r5qiWe0X47Jx29K7YNq6wsS6wK5TD
         9YDg79inRN/5oY7XlLUalKnjKxzon64+uqVMk4IAmURXg80OZUr0ZK4XsjhlHrRFNif2
         SnIqZ5kDmwmKSLJu0/47xopCPb6z+lwx32LNHhHZ2fIAU/3sZ9TznPnvD+a7fyBwU4em
         NUuX6A8I6N8cSWnP7RUr28ZgMR9WWtZr1rM4HYNqVdWH2E3EXzb+Li2coC/Ls+lJu2rJ
         TzBFwgu4R7cc8mzABrecFCj+3pi/TlsjP/girsBv/SnzofhXGzyP8gnPZxPqcjyIGgza
         NITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=FVf87Ck26LWlmoyHAOegSUqYq5QkTCEpjcdBJDqE+Ds=;
        b=F4IRUgxcThyohkDKEvWR6mQdu8bvK6XFzamz57D5h+xAV7eC4YU8EMwBGXgpkT0bfn
         fAXGwhFPLY64W3fb2GYjnV7K2B3m+1DCcfpE5kPohIU038dqSDuN/GcSPL4bSjZQPF8P
         YVhuM3bf/EacMdlDp/lw9o/odWKsiyfW0rOY5k6yldiXSdu4JPaKU01HO5gXdfm3hGG/
         ECfmrPUL5haJcMay7pAcswOSzpi6tSFTXskUh2zsyoZcJd5t6SEe8ZZqZk/waxaicuIv
         /bcD6p5pfcMOVdxYnChD73/Vc4TpjmqdkVazgngw848ie78yJvXBm5aEA/I9+5W0f0Ju
         1ZPQ==
X-Gm-Message-State: APjAAAVCgOJid3xQA3HQfkwi7rc+IOemUJ10/+r4Q/BGOFT5jkuEOjuv
        P6e6xAKO9yHv1L2l3OxOXoR26EVF
X-Google-Smtp-Source: APXvYqyelma7ZhBsaZ2nm75hjWrAM+u36Kwv7f/z6Oqn/iXsCLKZqRoTfT9DeX5L4C205OD3O92b/w==
X-Received: by 2002:a5d:9a04:: with SMTP id s4mr33428483iol.19.1560954850463;
        Wed, 19 Jun 2019 07:34:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c23sm17613432iod.11.2019.06.19.07.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:34:10 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEY91o004548;
        Wed, 19 Jun 2019 14:34:09 GMT
Subject: [PATCH v4 19/19] NFS: Record task, client ID,
 and XID in xdr_status trace points
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:34:09 -0400
Message-ID: <20190619143409.3826.69836.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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
index 9a39fd5..d85f209 100644
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
-			"error=%ld (%s) operation %d:",
+			"task:%u@%d xid=0x%08x error=%ld (%s) operation=%u",
+			__entry->task_id, __entry->client_id, __entry->xid,
 			-__entry->error, show_nfsv4_errors(__entry->error),
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
index cd09356..976d408 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1139,21 +1139,32 @@
 
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
-			"error=%ld (%s)",
+			"task:%u@%d xid=0x%08x error=%ld (%s)",
+			__entry->task_id, __entry->client_id, __entry->xid,
 			-__entry->error, nfs_show_status(__entry->error)
 		)
 );

