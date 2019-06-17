Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12F948730
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfFQPbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:31:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40435 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPbr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:31:47 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so22067978ioc.7;
        Mon, 17 Jun 2019 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6zZ4tkwEhPr42aF/uPwSUocP/SoqMOuOJIwVpK5kan0=;
        b=Jch0lauyHvJPTRzh6SDbX5hxmEeIohqTqiD6ZM3ViXvE5LvQa9Jpt8c4MPtd9QG7HP
         olOOmzqQL4HliaWP8IouW7/4fRZ6Y+4+mH/jrQP9TtMPeHPDLaMIZdERn9E6ZESgvarL
         NbBvp8VJczA5DC6NvhJaq+Vqd5Dsa6nJ8ixQ9O+6+SHMqJSGO3FIjEYexMYYx974kpLu
         ibSStGnkHmstrllOIa0cNBjA5v54SLn9QaOzY1ypayKmFfbMs4eFHykdZHrJOwT9rKLm
         XXnfMjDrdU25bfgabLZBvFgxEpRx8LuYflp5+VLpjW4M1c9Cr6HsYLNPSVvNp+gD590u
         N4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6zZ4tkwEhPr42aF/uPwSUocP/SoqMOuOJIwVpK5kan0=;
        b=mLm0LIJ7CeZ46Mzv1yhqj4MfZoE+PwfpyFKCwxXwAWWOqQCyyJixqwaN4QdnYmgshx
         7rBK+uzZ7r8o80uxJGjk0HCZsQI4IzVdsb9CmER9DD5kkASQSnzks00aX3IH4h0DeI1I
         w9QsBMk+QGiTV2EdIyoBiQiqwVtP3EgzT3wyTrhqDXFdkPWvEI5rhd73CSAKFA0isbcj
         HlsVirtmf9dPGno5vjpuzKdtTu6FEMSsGlnVnwddDgTYCxmd/UObtt+26NvW6WmDczhX
         +/IDBmPBbOnuvlRyAYVsHJavAtUhXZqaSXZGbHU92stVRYQV+x1CM3w5yQyen7ppkLpC
         voog==
X-Gm-Message-State: APjAAAVm2czO7Ru/tQaweG/Aay4J6Rc0XwnC03LRIB9R97pDGj0JVIV0
        EK6z/eqIMITfFyj0CGQqTHFsZHto
X-Google-Smtp-Source: APXvYqyiimvJ+ff5L8STqZE3aX930n/p15qhKSFzV2iw2WmMQssajl3eArgxTCD18XMQERneiDNQ0Q==
X-Received: by 2002:a6b:e61a:: with SMTP id g26mr948145ioh.300.1560785506836;
        Mon, 17 Jun 2019 08:31:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z17sm12054592iol.73.2019.06.17.08.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:31:46 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFVjkB031194;
        Mon, 17 Jun 2019 15:31:45 GMT
Subject: [PATCH v3 03/19] xprtrdma: Replace use of xdr_stream_pos in
 rpcrdma_marshal_req
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:31:45 -0400
Message-ID: <20190617153145.12090.40856.stgit@manet.1015granger.net>
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

This is a latent bug. xdr_stream_pos works by subtracting
xdr_stream::nwords from xdr_buf::len. But xdr_stream::nwords is not
initialized by xdr_init_encode().

It works today only because all fields in rpcrdma_req::rl_stream
are initialized to zero by rpcrdma_req_create, making the
subtraction in xdr_stream_pos always a no-op.

I found this issue via code inspection. It was introduced by commit
39f4cd9e9982 ("xprtrdma: Harden chunk list encoding against send
buffer overflow"), but the code has changed enough since then that
this fix can't be automatically applied to stable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    9 +++++----
 net/sunrpc/xprtrdma/rpc_rdma.c |    6 +++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index f0678e3..59492a93 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -470,13 +470,12 @@
 
 TRACE_EVENT(xprtrdma_marshal,
 	TP_PROTO(
-		const struct rpc_rqst *rqst,
-		unsigned int hdrlen,
+		const struct rpcrdma_req *req,
 		unsigned int rtype,
 		unsigned int wtype
 	),
 
-	TP_ARGS(rqst, hdrlen, rtype, wtype),
+	TP_ARGS(req, rtype, wtype),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
@@ -491,10 +490,12 @@
 	),
 
 	TP_fast_assign(
+		const struct rpc_rqst *rqst = &req->rl_slot;
+
 		__entry->task_id = rqst->rq_task->tk_pid;
 		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->hdrlen = hdrlen;
+		__entry->hdrlen = req->rl_hdrbuf.len;
 		__entry->headlen = rqst->rq_snd_buf.head[0].iov_len;
 		__entry->pagelen = rqst->rq_snd_buf.page_len;
 		__entry->taillen = rqst->rq_snd_buf.tail[0].iov_len;
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 85115a2..97bfb80 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -867,12 +867,12 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	if (ret)
 		goto out_err;
 
-	trace_xprtrdma_marshal(rqst, xdr_stream_pos(xdr), rtype, wtype);
-
-	ret = rpcrdma_prepare_send_sges(r_xprt, req, xdr_stream_pos(xdr),
+	ret = rpcrdma_prepare_send_sges(r_xprt, req, req->rl_hdrbuf.len,
 					&rqst->rq_snd_buf, rtype);
 	if (ret)
 		goto out_err;
+
+	trace_xprtrdma_marshal(req, rtype, wtype);
 	return 0;
 
 out_err:

