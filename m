Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5194448755
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfFQPdO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:33:14 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:46841 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfFQPdN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:33:13 -0400
Received: by mail-io1-f48.google.com with SMTP id i10so21996536iol.13;
        Mon, 17 Jun 2019 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FVf87Ck26LWlmoyHAOegSUqYq5QkTCEpjcdBJDqE+Ds=;
        b=NEnNnIPBRlpz4h1+3W5UG+wXZAxzG+8hOS85DyuTm6fa0SrWoBZzg5EA8YsISqStvY
         HhqQbIJYmisB+CRbFAkAScCiSD/8fmE7SfcudhoppmonESw/cVCmgHJP+K0/SDnmpx7n
         mr4hOu4iST2AJ2/LTGUC7v6rbeF0xVeNnNCWN/45YChtxLmM+6GvR4a1iQ0GWBQMNvp/
         labuIhJaamb7GRG0/BuWP8bpt+eM4orTAP7lgk6x2vZVikm3mA36WRNC1GV9Jar9Gz5O
         zjOVEueuSI/GHdnhO0NxYfsG7bgO39JbEYEMVMD18kNDKdl6ZUU62d4X3l9BnFNJZdPh
         aIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=FVf87Ck26LWlmoyHAOegSUqYq5QkTCEpjcdBJDqE+Ds=;
        b=bEFNxcd4R/nNXTwx/+9S+2qOfGPIHQ6bkDXIcXRPG4UIxtwe3ehCUV1dA2sJNGcG62
         xxtMTYcfWNscnrb3MThLf1ioz42a+5ov8xcpjwHvc0m4kjN3Zgg8Uz3AOSGJsSRcjJrN
         qUBsdfy/yYDDmqcUpK7L5ND2XAnq1VBcFqDaZmzen+o0vunTHf+xDIJ51Q2Rsi14BBsv
         sKqM8Ir7Sc95bxvUboSaGZPXXWHmU+PHtjAGwLyK1nAgghXyV3wwNggAZJrO90hiEAl6
         ICMkWR6yrxMzheubWC24MtIihgO68XZmhbccG0NtxtjYlgyJ/xdt7C9natpReJdgUcTh
         zzyQ==
X-Gm-Message-State: APjAAAUSePJDRNOXjSfBVdhWXToS+WhiXDM0b8KaMY3xuVqRRk+w65Z2
        Qn5i1o7HNLT+fCCw8luM7kx97PZh
X-Google-Smtp-Source: APXvYqwK79ydxZooNfdrMs/IJj1+P7hF3t2Kwn9goGe5YU402xp6Tu8pFDmwDiy1bCbZ8+eFYH+3OQ==
X-Received: by 2002:a02:ca57:: with SMTP id i23mr1690776jal.25.1560785592646;
        Mon, 17 Jun 2019 08:33:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u11sm19602iob.22.2019.06.17.08.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:33:12 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFXBAc031242;
        Mon, 17 Jun 2019 15:33:11 GMT
Subject: [PATCH v3 19/19] NFS: Record task, client ID,
 and XID in xdr_status trace points
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:33:11 -0400
Message-ID: <20190617153311.12090.88952.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
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

