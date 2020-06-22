Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD94A204256
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgFVVBX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 17:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVVBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jun 2020 17:01:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E7C061573;
        Mon, 22 Jun 2020 14:01:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w1so16913919qkw.5;
        Mon, 22 Jun 2020 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O0yZJkvLrK6LFmPqzu5suqBMbRhXZtym0DCUxXeWW9I=;
        b=PNTz1S2H3JQktJ2KRCeXr9K5fB3rCUjsbhx4eQ7huiD9lc0XwkD8Okx14VINqigAFM
         6pNrLS+AIEn1DYvQblEd2kRV10zylD6Hwj2yjaogrqsHjx+LE7k9+Z1U/dQkj/eE1qE3
         xPYh9pwUGVPjDLXDGNeE/pD7fUqB4lTcLmw10WxarvLA4Fevjzv1PGC/mQXIw/BHlQbc
         Cc3kIgnl1Wzgf7Ec41DHzoA/XpNDl7CWQrt55YIcWyAIR4Ep5aBSVdlLZDvivyt/oWXv
         X2CQOdtRXi6uAbuI049Y3twLJiE92j+BAIfLW3g7fT3JHXNCCeG1Fab+I7hZdZWKkulg
         /6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=O0yZJkvLrK6LFmPqzu5suqBMbRhXZtym0DCUxXeWW9I=;
        b=qgW3/LfXQ5jvPuteReHpeBykSJ3dWGQ35tHzMbf1sYVLtC+9bpfX8+b0tOXZX5nC8P
         dNzNGKgKIpgGh+r1SCEjBjXn5606ynSRDg9Vb3z9oPMbscOYHCESi33kdlHDgWpWOykK
         c1fH5zs6f/Z98FjTwESYRnJzGb5UEqsDX2NSZ9ktwivJQbTlqXcEtMM9K3001aec9Wat
         DF39Pf4lhfLkM8eLbYZJpMKZ3DKn5YnhYz2YxCziLOQK2f6WZskA0x9telXaoQFg2FqE
         KvkVsgJdpUw1Cceg7NYJsoUWYznYTSx/8MptAnIDOH9fE7g3ZzqdRdlvPjhaBYKniWH2
         Mf2A==
X-Gm-Message-State: AOAM530G98247fuQEhOIa/ozJRug0lNQjJ5aCnEUpY7g+486a0VwlVz6
        yN+uVyP+4g+vjq1OTE3Tvv5noLRF
X-Google-Smtp-Source: ABdhPJyn+8qESwT72eiJX/81svftMEA2Qzg55itQs5Kqf3aJQL4JhSmxsPJiyPBw4qw9cuf3oWkuMQ==
X-Received: by 2002:a37:a89:: with SMTP id 131mr17228696qkk.92.1592859682150;
        Mon, 22 Jun 2020 14:01:22 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p7sm9430593qki.61.2020.06.22.14.01.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 14:01:21 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05ML1Lqg018832;
        Mon, 22 Jun 2020 21:01:21 GMT
Subject: [PATCH v1 4/6] svcrdma: Add a @status parameter to
 svc_rdma_send_error_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 22 Jun 2020 17:01:21 -0400
Message-ID: <20200622210121.2144.12399.stgit@klimt.1015granger.net>
In-Reply-To: <20200622205906.2144.43930.stgit@klimt.1015granger.net>
References: <20200622205906.2144.43930.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The common "send RDMA_ERR" function should be in svc_rdma_sendto.c,
since that is where the other Send-related functions are located.
So from here, I will beef up svc_rdma_send_error_msg() and deprecate
svc_rdma_send_error().

A generic svc_rdma_send_error_msg() will need to handle both
ERR_CHUNK and ERR_VERS. Copy that logic from svc_rdma_send_error()
to svc_rdma_send_error_msg().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 47ada61411c3..73fe7a213169 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -812,7 +812,8 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
  */
 static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *sctxt,
-				   struct svc_rdma_recv_ctxt *rctxt)
+				   struct svc_rdma_recv_ctxt *rctxt,
+				   int status)
 {
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	__be32 *p;
@@ -821,16 +822,35 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	xdr_init_encode(&sctxt->sc_stream, &sctxt->sc_hdrbuf,
 			sctxt->sc_xprt_buf, NULL);
 
-	p = xdr_reserve_space(&sctxt->sc_stream, RPCRDMA_HDRLEN_ERR);
+	p = xdr_reserve_space(&sctxt->sc_stream,
+			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
 		return -ENOMSG;
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
-	*p++ = rdma_error;
-	*p   = err_chunk;
-	trace_svcrdma_err_chunk(*rdma_argp);
+	*p = rdma_error;
+
+	switch (status) {
+	case -EPROTONOSUPPORT:
+		p = xdr_reserve_space(&sctxt->sc_stream, 3 * sizeof(*p));
+		if (!p)
+			return -ENOMSG;
+
+		*p++ = err_vers;
+		*p++ = rpcrdma_version;
+		*p = rpcrdma_version;
+		trace_svcrdma_err_vers(*rdma_argp);
+		break;
+	default:
+		p = xdr_reserve_space(&sctxt->sc_stream, sizeof(*p));
+		if (!p)
+			return -ENOMSG;
+
+		*p = err_chunk;
+		trace_svcrdma_err_chunk(*rdma_argp);
+	}
 
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
@@ -930,7 +950,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	 * of previously posted RDMA Writes.
 	 */
 	svc_rdma_save_io_pages(rqstp, sctxt);
-	ret = svc_rdma_send_error_msg(rdma, sctxt, rctxt);
+	ret = svc_rdma_send_error_msg(rdma, sctxt, rctxt, ret);
 	if (ret < 0)
 		goto err1;
 	return 0;

