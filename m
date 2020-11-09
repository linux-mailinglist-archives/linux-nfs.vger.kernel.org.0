Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF92AC519
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgKITjT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITjS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:18 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEBC0613CF;
        Mon,  9 Nov 2020 11:39:18 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so6370399qkk.10;
        Mon, 09 Nov 2020 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0w3mXRdPsspn3ceNYTnJhvzjpJ3GQTNLXqPAgXD8Eao=;
        b=PLTcR3ZYQroKj4oglw0wzfAaYy99rqhncFJ95G+5J7BkO0CyI0tcLpklN60zL0/Obs
         hDvKrU6Srs64bo3YkQ29FHeVadhhHiJdNZh61/E+/PlKA6ArHTvLb9lLaUTeBAbiArSB
         4kUFEDx/vgAp5qIO2/wlQQXsU+QfGi8N30cUKrKSLxZKIMGfl56+Uw2RsUJ1LgI3CyDH
         xTLKFpVMntxfK0vSkRCe5N8dp4vFv//gx6yE9C9LELBz/ZZUh31WTG7EIqDufcSGm77m
         BG2ojGB03qwKAd/QJZQo19oh2MW047p4vNKhdSOEeM3IRFHdIngSrZLs0PPYdBdRh6+0
         Epig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0w3mXRdPsspn3ceNYTnJhvzjpJ3GQTNLXqPAgXD8Eao=;
        b=dCG6IbTavsGbSnX1QK5YIZLPJHpZ9l4w7HJojWGj2Uko03N/mwb5ktnBCDcBg9HnN1
         dG3Bm2oI1jpNCK1AG8VS4MOUhAsQ/H1KniTmzO96/fIXbL8njoF9evrhw+LupaDL3wfR
         UfFAgaX+oWZ0LS562q9SlhJbWvjkXb1+iGvOR+vnCSJVv2H2jvsPFrF4ktvTdt/8gotf
         sdiiGS1+IWISjPwjClhQxvpo0siS+9sxjVFdLvBiqTKkPMpxKgzkhgUK5uw9rMj8xttq
         UFwsQqRY9caM80fRInQwQ2eSoQsykajlpMWPaubkj8q6h0n3nNbIdX8khBEWIfqOmShd
         N5Kg==
X-Gm-Message-State: AOAM530VfkNQBJSdzlpeeM8riQWUaqvztQcj/U5yxtR87HJ/CMRN7eWC
        A81SdgN/ZqDEBL89VkqxvpxYsAdWdHA=
X-Google-Smtp-Source: ABdhPJyc5C2uP6JVzkKgWrVaIYbEhxtlLtXxDPoOjgbDg7G7KtEQmZOi0rK9N/OOLmnA2cj1NVZNLA==
X-Received: by 2002:a37:b785:: with SMTP id h127mr14815096qkf.77.1604950757523;
        Mon, 09 Nov 2020 11:39:17 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a206sm6792021qkb.64.2020.11.09.11.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:16 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdF7d021791;
        Mon, 9 Nov 2020 19:39:15 GMT
Subject: [PATCH v1 01/13] xprtrdma: Replace dprintk call sites in ERR_CHUNK
 path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:15 -0500
Message-ID: <160495075571.2072548.12857644844291007553.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   82 ++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c |   13 +-----
 2 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index bf1065772228..d5e66428e27e 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1128,6 +1128,88 @@ DEFINE_REPLY_EVENT(xprtrdma_reply_rqst);
 DEFINE_REPLY_EVENT(xprtrdma_reply_short);
 DEFINE_REPLY_EVENT(xprtrdma_reply_hdr);
 
+TRACE_EVENT(xprtrdma_err_vers,
+	TP_PROTO(
+		const struct rpc_rqst *rqst,
+		__be32 *min,
+		__be32 *max
+	),
+
+	TP_ARGS(rqst, min, max),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+		__field(u32, min)
+		__field(u32, max)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__entry->min = be32_to_cpup(min);
+		__entry->max = be32_to_cpup(max);
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x versions=[%u, %u]",
+		__entry->task_id, __entry->client_id, __entry->xid,
+		__entry->min, __entry->max
+	)
+);
+
+TRACE_EVENT(xprtrdma_err_chunk,
+	TP_PROTO(
+		const struct rpc_rqst *rqst
+	),
+
+	TP_ARGS(rqst),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x",
+		__entry->task_id, __entry->client_id, __entry->xid
+	)
+);
+
+TRACE_EVENT(xprtrdma_err_unrecognized,
+	TP_PROTO(
+		const struct rpc_rqst *rqst,
+		__be32 *procedure
+	),
+
+	TP_ARGS(rqst, procedure),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+		__field(u32, procedure)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->procedure = be32_to_cpup(procedure);
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x procedure=%u",
+		__entry->task_id, __entry->client_id, __entry->xid,
+		__entry->procedure
+	)
+);
+
 TRACE_EVENT(xprtrdma_fixup,
 	TP_PROTO(
 		const struct rpc_rqst *rqst,
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0f5120c7668f..c178f93aa40b 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1322,20 +1322,13 @@ rpcrdma_decode_error(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep,
 		p = xdr_inline_decode(xdr, 2 * sizeof(*p));
 		if (!p)
 			break;
-		dprintk("RPC:       %s: server reports "
-			"version error (%u-%u), xid %08x\n", __func__,
-			be32_to_cpup(p), be32_to_cpu(*(p + 1)),
-			be32_to_cpu(rep->rr_xid));
+		trace_xprtrdma_err_vers(rqst, p, p + 1);
 		break;
 	case err_chunk:
-		dprintk("RPC:       %s: server reports "
-			"header decoding error, xid %08x\n", __func__,
-			be32_to_cpu(rep->rr_xid));
+		trace_xprtrdma_err_chunk(rqst);
 		break;
 	default:
-		dprintk("RPC:       %s: server reports "
-			"unrecognized error %d, xid %08x\n", __func__,
-			be32_to_cpup(p), be32_to_cpu(rep->rr_xid));
+		trace_xprtrdma_err_unrecognized(rqst, p);
 	}
 
 	return -EIO;


