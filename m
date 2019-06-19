Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C755C4BB93
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFSOcp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:32:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46158 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOcp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:32:45 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so38490353iol.13;
        Wed, 19 Jun 2019 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6zZ4tkwEhPr42aF/uPwSUocP/SoqMOuOJIwVpK5kan0=;
        b=ZXQLgcf2voPcs2p3paWRzcmxAZaU60Q5sgAtboxevdPpvRULpNf1h9sIh9quxD3M3b
         uaa2JnEAgvMBzKbo8wUUiwkMXXcYfZDEDZS6pALecGta91uQfiqyTan3IIiXxrRtBf+w
         XtMwUy06U4t++ubeTP6MDTF6M4cJG+XB49G8c0KPyAp2NTSTBs0XDyy3LJyea7U33uka
         CAUZTVsfDAzSZaH3MhTW1q3V38Inj3Zz7zQoXepbR/p96kIX+D3fXA2+naN2lfFa78E4
         TdPgXxJPVptf3MFg9E0/Onfdmh+HZdXx28fijhFcIeSi576WPhZELopTCa/rz3ChEvx7
         B6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6zZ4tkwEhPr42aF/uPwSUocP/SoqMOuOJIwVpK5kan0=;
        b=mXhjrCn4P8mHkOLRS/uDdtPw3fn67YT99m8AV/y7+qAK1SSt/hC3ztLCFCIOoFqRlY
         W3Zc7ef1XzdXCilJvJ04LwdAob4lzkl2wEbljC0swfEgvAJ5fJdglEd0MQy1CvFeV4An
         ffeq3tdnORdSIh0cKD3kz+by2j+HDqvVPfsvjN1nzmYUI7oZcwM/MTTTiJzo3S6rjNrv
         sLCuq/xlFKXYA2Yb09DT2ekiyGOsK7ndaspeTW6G91DWMS8cJraLOZnDYc0fKjiijx1u
         TXpq2aARj/bIDkZjN4jR06Y9kjDFKyWGFt1eUvv0wgzTT3z6KlVWln3OKRdNcS8XpMch
         MVWQ==
X-Gm-Message-State: APjAAAUp+FrPf+ZmAh/E8oGMJFusoKLsGFyfzoPYVxCCQDOJhOP//HjJ
        TXWsdLcUttkM33JszDi8lvw=
X-Google-Smtp-Source: APXvYqw5Bhrj+nFzav8OwaYBBTWdsH/frOXTQEl+FhvcsqeyvcY34pxK8gEi0+dgFu2cGa9IxxgXzA==
X-Received: by 2002:a5d:9e49:: with SMTP id i9mr7801111ioi.290.1560954764350;
        Wed, 19 Jun 2019 07:32:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 15sm20119933ioe.46.2019.06.19.07.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:32:44 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEWhbB004500;
        Wed, 19 Jun 2019 14:32:43 GMT
Subject: [PATCH v4 03/19] xprtrdma: Replace use of xdr_stream_pos in
 rpcrdma_marshal_req
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:32:43 -0400
Message-ID: <20190619143243.3826.68067.stgit@manet.1015granger.net>
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

