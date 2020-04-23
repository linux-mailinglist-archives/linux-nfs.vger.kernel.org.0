Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEE31B64C7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgDWTt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgDWTtz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:49:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E2C09B042
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:49:54 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v18so3515987qvx.9
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lmiGKU/0BzK3kvDCVebAFBHLnXuLfxEKHT7+An2vDSY=;
        b=WX5wtw+GwE83H5Bq6pnrwfD2t/fD9F75lbC5X0g2mTk62KtKYeN/6SMpzxQ7bDVDI+
         w9993YYrfd76ZCniXxhWXAh0j7CEyuaYFu2H+zmsWfhWldkCkUP7fQ5fPb+nlruvBTBK
         8Th5JfvLc0x30iu8GONx66iFaBmdXYVy3J496KMYX13bWXx576g0tbGD6deaqpzuU+QF
         g/h9Pxouq+2ps6flqnBBBOD2pKJVwmHYIdXIf/E615YxkydHfeLagRRkACALRRpkFhex
         eatSa5bV0wUctRT1ahySokBSbyLpIipkr/OHuoPBc5LLYmyRxf6/PfzFoP3KnxmgWaCG
         AQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lmiGKU/0BzK3kvDCVebAFBHLnXuLfxEKHT7+An2vDSY=;
        b=lP9NJmud+ekhHekoB33yEJFy+QQiu8Tps6xjhA/BN10Aw1TIak9o7IHjTM7gPuVsCf
         mnnIKhR2lD8mGqAXFwzahtQ86LhEZyh2zhdnGjhb6avAB0mjAYATsxIfVGa8TuoLKoCI
         aGPynkdfEcyw0XhyoDskTl2LZYz4X/1o7dOkfDcC96MgKJJIkcdoP13gAefbibqTfZ5z
         Fqodq7is15QCH6Xkl7nRq/khQTAgzRsqQ3V8K9HI7fiypnHCU7qLPmZw8vU8bo0MzHjV
         PfcX+F5li6cpn1MCKIYTRfKL8hwzTkwU11QHEGtSZiUBQCKMg2+YENzxrVe13Ob1nmc6
         4dLQ==
X-Gm-Message-State: AGi0PuaRsAQiVam9oC0dV5tnNnQPU3QL9w+7RrYtKcuQwljGB6eehGC6
        PcOABde4JXIk2QtMwXulSdFTAoa5
X-Google-Smtp-Source: APiQypJT5ctOL2i+7C+fjsYG/d8aVg215HqQNJd8xrcQ8wrJIXx0z6LIAx9Bt6jzvAU91PcHM8wAIw==
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr5959424qvj.26.1587671393386;
        Thu, 23 Apr 2020 12:49:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q17sm2409768qtk.84.2020.04.23.12.49.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:49:52 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03NJno7N030442;
        Thu, 23 Apr 2020 19:49:50 GMT
Subject: [PATCH RFC3 1/2] SUNRPC: Set SOFTCONN when destroying GSS contexts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Apr 2020 15:49:50 -0400
Message-ID: <20200423194950.7923.29614.stgit@manet.1015granger.net>
In-Reply-To: <20200423194434.7923.31241.stgit@manet.1015granger.net>
References: <20200423194434.7923.31241.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prevent a (temporary) hang when shutting down an rpc_clnt that has
used one or more GSS creds.

I noticed that callers of rpc_call_null_helper() use a common set of
flags, so I collected them all in that helper function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c |    2 +-
 net/sunrpc/clnt.c              |   10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index ac5cac0dd24b..16cec9755b86 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1285,7 +1285,7 @@ static void gss_pipe_free(struct gss_pipe *p)
 		ctx->gc_proc = RPC_GSS_PROC_DESTROY;
 
 		task = rpc_call_null(gss_auth->client, &new->gc_base,
-				RPC_TASK_ASYNC|RPC_TASK_SOFT);
+				     RPC_TASK_ASYNC);
 		if (!IS_ERR(task))
 			rpc_put_task(task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 325a0858700f..ddc98b97c170 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2742,7 +2742,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_op_cred = cred,
 		.callback_ops = (ops != NULL) ? ops : &rpc_default_ops,
 		.callback_data = data,
-		.flags = flags | RPC_TASK_NULLCREDS,
+		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
+			 RPC_TASK_NULLCREDS,
 	};
 
 	return rpc_run_task(&task_setup_data);
@@ -2805,8 +2806,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto success;
 	}
 
-	task = rpc_call_null_helper(clnt, xprt, NULL,
-			RPC_TASK_SOFT|RPC_TASK_SOFTCONN|RPC_TASK_ASYNC|RPC_TASK_NULLCREDS,
+	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -2850,9 +2850,7 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto out_err;
 
 	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL,
-				    RPC_TASK_SOFT | RPC_TASK_SOFTCONN | RPC_TASK_NULLCREDS,
-				    NULL, NULL);
+	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
 	if (IS_ERR(task)) {
 		status = PTR_ERR(task);
 		goto out_err;

