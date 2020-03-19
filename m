Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD518BAE3
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCSPUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:20:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33694 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPUy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:20:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id p6so3464555qkm.0;
        Thu, 19 Mar 2020 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pS9rupJUqhMQcoM6W8MhtxI26MZJvmGSodgflnz/efU=;
        b=OcMozvFBQ2gs9DPc9WYC6ozueLLbwrPFU1wM+ZQGMwEKilLUM5dX7BujB4euZKTd2U
         sfvI6//KnmwYMAkunCVlUOMnpRvYhtYkty65CUufHRsTQduL4rIuOSL7nw04mNL8UW0a
         YelRWBceseYOx33VVMeGsc36paq2Murs4G5Mf42rQHtoyiA6G06ydLK5YRMTW7rWEtcG
         QZ+YoxHqK6uxFAunMzyS5BFimJU3g33fghIEEh5bOezQ+cLsguRwQHHCczfHfRKCDcBV
         burERjqROVlauWVgF2/KgyzZXKisz9ZXSZ5kPpFJ9Cgp/xb/irs0+8V42Vncc014xyMV
         FLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pS9rupJUqhMQcoM6W8MhtxI26MZJvmGSodgflnz/efU=;
        b=OfFmAHY6hoinNaPCQZBZnKHVDTD48ubjQIQ/NoCirVoe0jatptaejVP4VBlyDdS2RT
         I0blVeHFvCWCbSZxx97lk9gqomVjOHwHAj3rDo9/IJ4gL4eJTWNgj1N1PeQ46jdLqtjB
         C/rT1PiaJUUKEvET2UP4g6rPtvojKFw5reX1LjZudM69ni7MLIubPbZmNJVJPA5QqpeZ
         Pbmmi4ZySHut4HUx56astdxyzK1BG1WTZt/Q5NHeB0Xjk0tI7/ziI9S7vbN03PW5jSbU
         uOAs9T0RUEtk99Lomk6ghETis46VeBNahgui2mdqVdnO0G8ckZyfwQuAqQfjgIpwHVS4
         3y5Q==
X-Gm-Message-State: ANhLgQ3FAAW2nXucGYMs9bueMHAgrUUaWWeCt/3f1tJcDUbG31qp71+Z
        AqLQt/dPqO7h8jOfb/03uDgwZ2ARUJI=
X-Google-Smtp-Source: ADFU+vuKonM8drxTAruxlk09RD+QqebwCpC7ChQFPnUbzpD9m+X4Pis1Jf5+7ALEa+xBcij7l/iPgg==
X-Received: by 2002:ae9:efd1:: with SMTP id d200mr3090642qkg.79.1584631251314;
        Thu, 19 Mar 2020 08:20:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 31sm1747520qta.56.2020.03.19.08.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:20:50 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFKnx1011160;
        Thu, 19 Mar 2020 15:20:49 GMT
Subject: [PATCH RFC 05/11] svcrdma: Clean up svc_rdma_encode_reply_chunk()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:20:49 -0400
Message-ID: <20200319152049.16298.55010.stgit@klimt.1015granger.net>
In-Reply-To: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
References: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Match the control flow of svc_rdma_encode_write_list().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |    3 +++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   25 ++++++++++++-------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 065dfd8b5b22..080a55456911 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -610,6 +610,9 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	struct svc_rdma_write_info *info;
 	int consumed, ret;
 
+	if (!rctxt->rc_reply_chunk)
+		return 0;
+
 	info = svc_rdma_write_info_alloc(rdma, rctxt->rc_reply_chunk);
 	if (!info)
 		return -ENOMEM;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 94adeb2a43cf..89bc8db0289e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -507,7 +507,10 @@ svc_rdma_encode_reply_chunk(const struct svc_rdma_recv_ctxt *rctxt,
 		.rp_length	= length,
 	};
 
-	return svc_rdma_encode_write_chunk(sctxt, &payload);
+	if (!rctxt->rc_reply_chunk)
+		return xdr_stream_encode_item_absent(&sctxt->sc_stream);
+	else
+		return svc_rdma_encode_write_chunk(sctxt, &payload);
 }
 
 static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
@@ -868,7 +871,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
-	__be32 *rp_ch = rctxt->rc_reply_chunk;
 	struct svc_rdma_send_ctxt *sctxt;
 	__be32 *p;
 	int ret;
@@ -888,25 +890,22 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 			      rpcrdma_fixed_maxsz * sizeof(*p));
 	if (!p)
 		goto err0;
+
+	ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
+	if (ret < 0)
+		goto err2;
+
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
-	*p   = rp_ch ? rdma_nomsg : rdma_msg;
+	*p = rctxt->rc_reply_chunk ? rdma_nomsg : rdma_msg;
 
 	if (svc_rdma_encode_read_list(sctxt) < 0)
 		goto err0;
 	if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
 		goto err0;
-	if (rp_ch) {
-		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
-		if (ret < 0)
-			goto err2;
-		if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
-			goto err0;
-	} else {
-		if (xdr_stream_encode_item_absent(&sctxt->sc_stream) < 0)
-			goto err0;
-	}
+	if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
+		goto err0;
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)

