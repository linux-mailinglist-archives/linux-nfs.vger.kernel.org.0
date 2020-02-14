Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0515F2AC
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgBNPuY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 10:50:24 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34136 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgBNPuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:50:24 -0500
Received: by mail-yw1-f67.google.com with SMTP id b186so4452811ywc.1;
        Fri, 14 Feb 2020 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qKGrq16742ADTzGv+dk0VFkBm9oBbH1Kvy2o7JSpQYQ=;
        b=BpojZ8R3IVf5ub3tfRvDkwC6f0ql9S91UcqzEocvUx0s4kmxIy0LMsZlgcvZJwi1NT
         HB6ktIUQ+9JDeGlV4tNA5t80arcwToon0ZnS4kUjmrE6L+UcvOp38gMaCnMuzRjGkQ1a
         x3OzFp1/VRh8mGTkUdujJ79noagyOSCM8NH6eLPAuRYavZfXBVq1RobHFS1px4mO6oim
         rxE72D+px0J8saih9vfSQ5DWU4rxdB+yWv4be2W749Z0WD8pDoKZMHw9EdGppWSXKom9
         DetbHbZ/eujTsnsBqehxA5IItBFkkc0b2CbCtkyPudDMfwV9i8pP8xUpJXp4gysWTIq5
         Ma7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qKGrq16742ADTzGv+dk0VFkBm9oBbH1Kvy2o7JSpQYQ=;
        b=tRRto0HUVOJp06WQoLqleb8fj0dIod5ThN5CNqFgA9+TvnHOTch3cFNDZu6BJCW9ih
         1BZ848nENvQs1XK8gFHxhQ4cWzRdqUSZ02iMrFdVaJp2H++VcfEw8iSvcTWkYAJwxR2I
         Nb3+ZMA64LlkwETrxHBv4RoUTjQqSNWoko3XoQuo71371A1zFPTaq2CkIJqs4V0LbxOd
         GfnkTTpSSVG48Q3mXYmaZoA+ssniJPSIV4uKJyhcD0ysgNpeongI9G0edPBlHChMU6UZ
         At3Ic2hOjjgeo3BPYjfQx8jmRcC8a0z+o1DDufOZp9Z01oq2ObJe3epb7/nzL8eMQcIL
         VwSw==
X-Gm-Message-State: APjAAAXyWZ6Occtm3aMRa9HnRtADZ1JuBmUL5VpoUMP3QhmX/1ilLz99
        Qv+lTy5RZ7DJAjZz4eVxrGBhieeo
X-Google-Smtp-Source: APXvYqyntuopz4cDrg9a+wEWz4Y2gxi0VNVddZ7uuYU4DBtIqOY5rF5eH3ACurjQombg5ba8LKHDcQ==
X-Received: by 2002:a81:3888:: with SMTP id f130mr2767613ywa.138.1581695422264;
        Fri, 14 Feb 2020 07:50:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d199sm2716463ywh.83.2020.02.14.07.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:50:20 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFoJ7m029178;
        Fri, 14 Feb 2020 15:50:19 GMT
Subject: [PATCH RFC 7/9] svcrdma: Post RDMA Writes while XDR encoding replies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:50:19 -0500
Message-ID: <20200214155019.3848.58561.stgit@klimt.1015granger.net>
In-Reply-To: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
References: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The only RPC/RDMA ordering requirement between RDMA Writes and RDMA
Sends is that Writes have to be posted before the Send that sends
the RPC Reply for that Write payload.

The Linux NFS server implementation now has a transport method that
can post READ Payload Writes earlier than svc_rdma_sendto:

   ->xpo_read_payload.

Goals:
- Get RDMA Writes going earlier so they are more likely to be
  complete at the remote end before the Send completes.
- Allow more parallelism when dispatching RDMA operations by
  posting RDMA Writes before taking xpt_mutex.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 3c0e41d378bc..273453a336b0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -843,15 +843,9 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	*p++ = xdr_zero;
 	*p   = xdr_zero;
 
-	if (wr_lst) {
-		/* XXX: Presume the client sent only one Write chunk */
-		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr,
-						rctxt->rc_read_payload_offset,
-						rctxt->rc_read_payload_length);
-		if (ret < 0)
-			goto err2;
-		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);
-	}
+	if (wr_lst)
+		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst,
+					       rctxt->rc_read_payload_length);
 	if (rp_ch) {
 		ret = svc_rdma_send_reply_chunk(rdma, rp_ch, wr_lst, xdr);
 		if (ret < 0)
@@ -896,16 +890,16 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
  * @offset: payload's byte offset in @xdr
  * @length: size of payload, in bytes
  *
- * Returns zero on success.
- *
- * For the moment, just record the xdr_buf location of the READ
- * payload. svc_rdma_sendto will use that location later when
- * we actually send the payload.
+ * Returns zero on success, or a negative errno.
  */
 int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 			  unsigned int length)
 {
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
+	struct svcxprt_rdma *rdma;
+
+	if (!rctxt->rc_write_list)
+		return 0;
 
 	/* XXX: Just one READ payload slot for now, since our
 	 * transport implementation currently supports only one
@@ -914,5 +908,7 @@ int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 	rctxt->rc_read_payload_offset = offset;
 	rctxt->rc_read_payload_length = length;
 
-	return 0;
+	rdma = container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
+	return svc_rdma_send_write_chunk(rdma, rctxt->rc_write_list,
+					 &rqstp->rq_res, offset, length);
 }

