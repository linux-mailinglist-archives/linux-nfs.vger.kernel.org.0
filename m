Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D71045BC
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKTVZu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 16:25:50 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37584 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTVZu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Nov 2019 16:25:50 -0500
Received: by mail-yw1-f66.google.com with SMTP id 4so125674ywx.4
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2019 13:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CMLjzhH7wAQdxajkLk6Te3osxkpCtVMDh8MCgQyT21g=;
        b=Rju6np2GRji+Am1tg1xTEl4Dpn+rEd1k6dXZCLVn2agcPzZ8BoWh5WG1Aum71TQ/Ky
         iYebSJ5FY6cS0H74YXbYLtuH2IpDKR9liBtovBM8xMOH4tXPiiOKTZMjJ+qoq3U3tf6v
         wuDlitE2j8AjsYoEbkUJEzzT23qdvoL2EnSjQUDGAkoReJTkNfYgdZFdLttdxy+IiTCf
         JklbvlLYQpW2QDx/wuXseY4GhU+7snVGABmhHnQwRdG8wxGlLJTikCogkEui23+lvItX
         r/+OdDLZDw8NIxPFkX5YiW4vPRsRDJCu/8UviXrgySrFCPEX1WYBNVnZrKDVS/+9d3/9
         FuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CMLjzhH7wAQdxajkLk6Te3osxkpCtVMDh8MCgQyT21g=;
        b=mXwhVweM29FS1d3JMY00GWxJgHVUoLAZ55Lqh3hbYgHL5R6PZmypbc6PpUEIgr0zrg
         Y8l3WmBCdMLcOzOdEoolFJ4TdD0GxOeCYjQIWdwcBFv8+lHdOeXVNP6S/d8wziI7A2Dr
         kSm2ck4viUB9s5zRM4o33uuw94G7MBv6/El6RXXdK0+JF2JrGs4zEHz4L/JZdJdvibEM
         wiSSJxCifzhOij5OBs2jZ0wyRVkSrKo0S/qhdBhjV7+7zQjug5fuDdOWL/zF5gj8V3Rv
         m9pknvFSA0FyC+GoQE+/SANfkXDgYBHsYPfMGc7LKlP8HTUF/uVDFmItqctplfdnNGDy
         8wPw==
X-Gm-Message-State: APjAAAV2wITa3WmvEAFoTQY5FfiWRCSgyzYSkAgHOQ0LH3JgzEkCxaJl
        cXR8StFb20nabRdaXlKJflM=
X-Google-Smtp-Source: APXvYqwZgKd9xGYPGg6bEeSpOcZo1tMXMpvJgefi1EesWmBw0roRArrdyHPiRHq4Fmt5Q1B//p5txA==
X-Received: by 2002:a81:4320:: with SMTP id q32mr530106ywa.11.1574285148289;
        Wed, 20 Nov 2019 13:25:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p83sm332117ywc.11.2019.11.20.13.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 13:25:47 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAKLPkjG016817;
        Wed, 20 Nov 2019 21:25:46 GMT
Subject: [PATCH v1 1/2] SUNRPC: Fix backchannel latency metrics
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, trond.myklebust@primarydata.com,
        anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 20 Nov 2019 16:25:46 -0500
Message-ID: <20191120212546.2140.2677.stgit@klimt.1015granger.net>
In-Reply-To: <20191120212443.2140.88674.stgit@klimt.1015granger.net>
References: <20191120212443.2140.88674.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I noticed that for callback requests, the reported backlog latency
is always zero, and the rtt value is crazy big. The problem was that
rqst->rq_xtime is never set for backchannel requests.

Fixes: 78215759e20d ("SUNRPC: Make RTT measurement more ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    1 +
 net/sunrpc/xprtsock.c                      |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index d1fcc41d5eb5..908e78bb87c6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -195,6 +195,7 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 	pr_info("%s: %*ph\n", __func__, 64, rqst->rq_buffer);
 #endif
 
+	rqst->rq_xtime = ktime_get();
 	rc = svc_rdma_bc_sendto(rdma, rqst, ctxt);
 	if (rc) {
 		svc_rdma_send_ctxt_put(rdma, ctxt);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 70e52f567b2a..5361b98f31ae 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2659,6 +2659,8 @@ static int bc_sendto(struct rpc_rqst *req)
 		.iov_len	= sizeof(marker),
 	};
 
+	req->rq_xtime = ktime_get();
+
 	len = kernel_sendmsg(transport->sock, &msg, &iov, 1, iov.iov_len);
 	if (len != iov.iov_len)
 		return -EAGAIN;
@@ -2684,7 +2686,6 @@ static int bc_send_request(struct rpc_rqst *req)
 	struct svc_xprt	*xprt;
 	int len;
 
-	dprintk("sending request with xid: %08x\n", ntohl(req->rq_xid));
 	/*
 	 * Get the server socket associated with this callback xprt
 	 */

