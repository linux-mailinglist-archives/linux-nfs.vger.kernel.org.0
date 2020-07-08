Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF124219131
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgGHUJu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGHUJt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F9C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e12so35560637qtr.9
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LZ/TSeddVKnqydUOnApISJSaqN1aYRsqtsoPvYzwq9E=;
        b=JMOaX2wjIqDjOHzEFCEC4LnV5T3dPUjN2jhJi14GIssDpR3onXkxmOpQfJ98aI2JwX
         gPp6jC5HyQ2JeSnSzwPxunhRSvkE/FHYO4fW+yJWYS+rNKDC/FCFneVLZ6G3Dvzad5NL
         wIlFLgJPNXWPPF4iIVPruJ6vuFATSLxxKSsqQ1ZjL0SfsN7ZoVbLB2doeDe8hWDdhVef
         I81EvPIgq9qXa3OF+rle0KTAazwfeWBxiCLAhF0okQD/7i68wSXJ241zmWsBh3ukcxTV
         Kx4xZb0btFmxk8dCRQ5rDDtMmWfd+xlmNf+F+0Kfq+Er1j3jbXTO1nv4PJvxjAa/4aNV
         r01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=LZ/TSeddVKnqydUOnApISJSaqN1aYRsqtsoPvYzwq9E=;
        b=l32NHRbPzjtF+q/yBnyFoNFNfOaDGjkuNTA8k5SMTSZT2v+Rc1uydCV+tGMOufb0+F
         /HprVOUnSPm4ShX5Zhl7XOOAEOdmtlH/ZPw3816GMjYMMxBSVqRqWWMlS9xDANBQK0TZ
         kFoAWOrc38XtgWqvf8QyBJ+2sC4Gc+9/AUPPI6PfZY1VUOTCxUjOMu/gt3YM0jVf3m/b
         0ZfsOOKc+351a+G2yEtjThqHGWcf4XslQdeDIHiMp4iWNGU3VjYbVT0kuaMQ1IhXiINk
         HPu+3jZm+FXEouV+YdC1aMGaBk088yOqWwLb8iMXa1RZ9Vk7UN0eMjsG5MO2a0bpIFTd
         ZTkg==
X-Gm-Message-State: AOAM530AXMvecKGotF0T5Iw7XtFiabOuXTwOFZT0k8pFDpvCUPDMUuQr
        vA0DneNf/9A8Pxs+QzuOqs2zEY4M
X-Google-Smtp-Source: ABdhPJye7aqSMwzBdnNRQZMMJYIRYNxIS9fl3aqultn20pynCV8t+gNbaQEBSldgT5hNRNyD/VYw5g==
X-Received: by 2002:ac8:24c6:: with SMTP id t6mr63016692qtt.39.1594238988908;
        Wed, 08 Jul 2020 13:09:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h6sm771056qtu.2.2020.07.08.13.09.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:48 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9lJ3006090
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:47 GMT
Subject: [PATCH v1 09/22] SUNRPC: Replace connect dprintk call sites with a
 tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:47 -0400
Message-ID: <20200708200947.22129.28974.stgit@manet.1015granger.net>
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

This trace event can be used to audit transport connections from the
client.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/clnt.c             |    4 ----
 net/sunrpc/xprt.c             |    3 +--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index dbde6a0eb821..06cb201cdfd3 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -983,6 +983,7 @@ DECLARE_EVENT_CLASS(rpc_xprt_lifetime_class,
 			TP_ARGS(xprt))
 
 DEFINE_RPC_XPRT_LIFETIME_EVENT(create);
+DEFINE_RPC_XPRT_LIFETIME_EVENT(connect);
 DEFINE_RPC_XPRT_LIFETIME_EVENT(disconnect_auto);
 DEFINE_RPC_XPRT_LIFETIME_EVENT(disconnect_done);
 DEFINE_RPC_XPRT_LIFETIME_EVENT(disconnect_force);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 533de318fab9..3a4f1ce31e22 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2055,10 +2055,6 @@ call_connect(struct rpc_task *task)
 		return;
 	}
 
-	dprintk("RPC: %5u call_connect xprt %p %s connected\n",
-			task->tk_pid, xprt,
-			(xprt_connected(xprt) ? "is" : "is not"));
-
 	task->tk_action = call_connect_status;
 	if (task->tk_status < 0)
 		return;
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 1ce89778119c..a03f67520780 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -825,8 +825,7 @@ void xprt_connect(struct rpc_task *task)
 {
 	struct rpc_xprt	*xprt = task->tk_rqstp->rq_xprt;
 
-	dprintk("RPC: %5u xprt_connect xprt %p %s connected\n", task->tk_pid,
-			xprt, (xprt_connected(xprt) ? "is" : "is not"));
+	trace_xprt_connect(xprt);
 
 	if (!xprt_bound(xprt)) {
 		task->tk_status = -EAGAIN;

