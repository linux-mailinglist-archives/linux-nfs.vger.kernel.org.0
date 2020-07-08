Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1F7219139
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGHUKc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGHUKc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:32 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1207C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h18so21097938qvl.3
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EYL5pfyxev1ue7nS1OOFkjzC0qFEfIjvypZrx/P98BM=;
        b=VlrJqKZ1EccGfoj0s4kbjZ8yjYH2hL4G5W0Iq3M/xbDSqrHWvSMoFC7Rw/JOCfxuGq
         T+hghiFsiA3cIyTAR7Mb5+4GPuY4A9TUBdQVJrgf+XrQ1NvMSXB9Y0wP15Sh7k9aqQGp
         xSPFraqlctI44brfklvewSXm0fj/W4KD/InPAb8xKhP+0dR8qJN6xinkDTwP4D1su7sp
         PSxpkCqGm9Nczjh7duU5BY7xxKqU03wSYabmXk18+EVyuFAvYj8Wc8p+2PoyItxJftwx
         3c8lVn88bLOp3mAnOB/o8jyP9Jnfq3uLPfZyx2yYYM4XyaCZSZa6kgnRdqAxUupL6CPP
         7AfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EYL5pfyxev1ue7nS1OOFkjzC0qFEfIjvypZrx/P98BM=;
        b=jZlJx2HC8ngWpsIPy+sVrbtpaO8IyF7PR2xjU5afqYUHlDgY/uY9RTKyf3+lkVqHdO
         FG96Usfbg3/El588ymThWneoISNll4wQylnxkGYuT885BUFeXeP4YvP3ixNKzn6hbcXY
         kJl6mv8WlecaAmjxjtNV1fzpzwzIfJC3JnEbfR9jUKiCNel2sLd3C8/ifdwr2VDjl+se
         zKcvJ/03qJs3+OGBJcDIE+/88ymq0ULGkzrRB4X0a3BVY3BDAmEiAvtfIxZdSWWG66OZ
         GYFw4BrwYUC01YrWZjfuyIVMwNzNHC6UdxV6rjb3qA6GvQafQoiLK3E6BKyyevVb3eou
         dWNA==
X-Gm-Message-State: AOAM531qa9KDC5ycBeVHXmHLm9RpJsx5AKrQMqllOhyoerwfqMPYev4v
        0i3FF2Wh8ZZ7gMs79bQCtEa20/ie
X-Google-Smtp-Source: ABdhPJz7u/tad2pHzhSmzQ7Ccnh8kwrHWbahY1BUvyeH8AdyVfbh1BckESatZXjYwjCDPG+7ov5FVw==
X-Received: by 2002:a05:6214:9af:: with SMTP id du15mr58435399qvb.188.1594239031060;
        Wed, 08 Jul 2020 13:10:31 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d135sm890904qkg.117.2020.07.08.13.10.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:30 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KATLA006124
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:29 GMT
Subject: [PATCH v1 17/22] SUNRPC: Remove dprintk call sites in rpcbind XDR
 functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:29 -0400
Message-ID: <20200708201029.22129.31971.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Other XDR functions no longer have dprintk call sites.
These were added during development and can be removed now that
the code is mature.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/rpcb_clnt.c |   28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 596c83ba647f..6df12a13edc6 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -840,11 +840,6 @@ static void rpcb_enc_mapping(struct rpc_rqst *req, struct xdr_stream *xdr,
 	const struct rpcbind_args *rpcb = data;
 	__be32 *p;
 
-	dprintk("RPC: %5u encoding PMAP_%s call (%u, %u, %d, %u)\n",
-			req->rq_task->tk_pid,
-			req->rq_task->tk_msg.rpc_proc->p_name,
-			rpcb->r_prog, rpcb->r_vers, rpcb->r_prot, rpcb->r_port);
-
 	p = xdr_reserve_space(xdr, RPCB_mappingargs_sz << 2);
 	*p++ = cpu_to_be32(rpcb->r_prog);
 	*p++ = cpu_to_be32(rpcb->r_vers);
@@ -866,8 +861,6 @@ static int rpcb_dec_getport(struct rpc_rqst *req, struct xdr_stream *xdr,
 		return -EIO;
 
 	port = be32_to_cpup(p);
-	dprintk("RPC: %5u PMAP_%s result: %lu\n", req->rq_task->tk_pid,
-			req->rq_task->tk_msg.rpc_proc->p_name, port);
 	if (unlikely(port > USHRT_MAX))
 		return -EIO;
 
@@ -888,11 +881,6 @@ static int rpcb_dec_set(struct rpc_rqst *req, struct xdr_stream *xdr,
 	*boolp = 0;
 	if (*p != xdr_zero)
 		*boolp = 1;
-
-	dprintk("RPC: %5u RPCB_%s call %s\n",
-			req->rq_task->tk_pid,
-			req->rq_task->tk_msg.rpc_proc->p_name,
-			(*boolp ? "succeeded" : "failed"));
 	return 0;
 }
 
@@ -917,12 +905,6 @@ static void rpcb_enc_getaddr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	const struct rpcbind_args *rpcb = data;
 	__be32 *p;
 
-	dprintk("RPC: %5u encoding RPCB_%s call (%u, %u, '%s', '%s')\n",
-			req->rq_task->tk_pid,
-			req->rq_task->tk_msg.rpc_proc->p_name,
-			rpcb->r_prog, rpcb->r_vers,
-			rpcb->r_netid, rpcb->r_addr);
-
 	p = xdr_reserve_space(xdr, (RPCB_program_sz + RPCB_version_sz) << 2);
 	*p++ = cpu_to_be32(rpcb->r_prog);
 	*p = cpu_to_be32(rpcb->r_vers);
@@ -952,11 +934,8 @@ static int rpcb_dec_getaddr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	 * If the returned universal address is a null string,
 	 * the requested RPC service was not registered.
 	 */
-	if (len == 0) {
-		dprintk("RPC: %5u RPCB reply: program not registered\n",
-				req->rq_task->tk_pid);
+	if (len == 0)
 		return 0;
-	}
 
 	if (unlikely(len > RPCBIND_MAXUADDRLEN))
 		goto out_fail;
@@ -964,8 +943,6 @@ static int rpcb_dec_getaddr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	p = xdr_inline_decode(xdr, len);
 	if (unlikely(p == NULL))
 		goto out_fail;
-	dprintk("RPC: %5u RPCB_%s reply: %s\n", req->rq_task->tk_pid,
-			req->rq_task->tk_msg.rpc_proc->p_name, (char *)p);
 
 	if (rpc_uaddr2sockaddr(req->rq_xprt->xprt_net, (char *)p, len,
 				sap, sizeof(address)) == 0)
@@ -975,9 +952,6 @@ static int rpcb_dec_getaddr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	return 0;
 
 out_fail:
-	dprintk("RPC: %5u malformed RPCB_%s reply\n",
-			req->rq_task->tk_pid,
-			req->rq_task->tk_msg.rpc_proc->p_name);
 	return -EIO;
 }
 

