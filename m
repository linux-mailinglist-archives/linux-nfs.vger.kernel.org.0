Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6B3D044
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbfFKPIQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39157 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391203AbfFKPIQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:16 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so5287486ite.4;
        Tue, 11 Jun 2019 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6zZ4tkwEhPr42aF/uPwSUocP/SoqMOuOJIwVpK5kan0=;
        b=rGnBHQhlBD1dDFyz/GH5KsrGyDAxzPkz8EbkrR80YVx9WXF2/NywEqGIob3cYkpAwJ
         cXAI+PB+6S+kmfteKipMgdJvAxZ1xKOg5yz18tk8OsVOQgG1jqKXBwAhJMfMC1lpELEX
         4WpUTeISm72Jw2WdUuNujpM5QJG9wPKS5QzrTdIldRECIbUZWRvsJSYtjFQ17He4hZj1
         Wb88FwQHpQUTnB5DpoyvokFt3gzNMKZmHKF1dX9in9c3J5muFpPXxVK1/63Jalf6Ohje
         BfdYyNp7aJji9jVqz3FFfEQGa/6UBZRK0JfVbInVIm+YB9/Qxv59kZCGqM9ABQxn3cEW
         HJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6zZ4tkwEhPr42aF/uPwSUocP/SoqMOuOJIwVpK5kan0=;
        b=AvjCRCiRpp4j/e2AYFJUaE6xZUoDr18Fxe843ryy5rFjIpWq1hZIQUZ/Zdgmo2tBfn
         /YyxhEvwZc+2pD6Oj+qFo4t9gTaJz6K+TzkqR5fh4FO6+PztFVNLHF616ckkxXKJTOSf
         vuOadyglIgvgmZ81ZWgoFsYubpdVFJ6AkEb+RfVDsKxLWDScGIJ4q5wG5FWyKjvaPp7c
         +L0RyMlRFlQnJgSfz7EzlUtv22k3wUVnceNgn3Or6HntGdeUPCSzBrgiX/f94iMvbzVy
         62f/LTvaxaGRO7u9dvYQ75Et63I16oAMxGsKBEZCDUt5r5FNMjj19XiCkkOb8dyHECaJ
         zLNA==
X-Gm-Message-State: APjAAAXCJDPcA2iPjnSTYyYIi1Rgdatj20Ra2QHYDjo7LZDC6NwzIJH/
        vSpZG8xnpv976JoVO+D5twx2vd+y
X-Google-Smtp-Source: APXvYqzoXVkXTkSqko+ayFs6+SQ7sUTkc9X+euOV/iLPcbaDF5zkAn461y/5tjIouyggiTm27fQEFw==
X-Received: by 2002:a24:6885:: with SMTP id v127mr18457554itb.177.1560265695441;
        Tue, 11 Jun 2019 08:08:15 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d3sm1384827itg.9.2019.06.11.08.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:15 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF8Elv021734;
        Tue, 11 Jun 2019 15:08:14 GMT
Subject: [PATCH v2 03/19] xprtrdma: Replace use of xdr_stream_pos in
 rpcrdma_marshal_req
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:14 -0400
Message-ID: <20190611150814.2877.87715.stgit@manet.1015granger.net>
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

