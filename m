Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C126D219134
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgGHUKG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUKF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9992C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:05 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b4so42803108qkn.11
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pAEUa4H2IBcGiKqJkyPuh7WXydmZpaahbDRFnQaXqG0=;
        b=GmxnLGyDiXU11O9eu3mnTmlTCe8I9+ZkzKHxsZPra7NN1zFb6piG08UB6YeDt8NA7X
         wxfiEA0lypgOgPRuuGMh3ZQ7GVLOJ8NncalONtg1gIiFOgH1Tat/1pWqp3iegs19/g54
         wzxG9rVxO74PBCMKt0rDYHu90qiVNVJboqCbD+X/JaOH+PAmz8tSHdeqx3IYp97ZC1aX
         ewHNhjKGmAKXlieAtuirpwQF8829OEblVQJc0q0bJpEGjIqsShBwNCkcL6r5pvhBfLnZ
         +HSBMU1U0tusN8Vhx2jICKMDrnIYt9TPDcDUybH184bDyiWX/ppkzDEJviw8yF7PPjRf
         vvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pAEUa4H2IBcGiKqJkyPuh7WXydmZpaahbDRFnQaXqG0=;
        b=aFf7EJPZShUr+AZpk/nXZENu2L5U20zmQvIAPFeFdtrf4j3fM0FrERLqNH7tenZfRj
         p6gf0uS5xj/y2xylMILS9e1zAdTOxqenHy3h6Dkpqe2fZrNZAIv7yCXf3R2FAklIF6aT
         0JljFBzVz8zwtSNaCECykYntYCQ2Gr/LqcNnxwbrr63aYPjx6VDiU1pKAY5yygD9LdJR
         hAqnhkFFEXhM2LYkCEkzHpwTP1cFEHrMvQu/OHo/g44ISMNKyBJZ8CdxKEDfDwu079Sq
         tI/Gq2dfrHdvN4RnzF3MLasnFMPI5YvSmeUWKuIj0qaRxWTWNh9MQP3sQjn0mYqGoCfH
         aErQ==
X-Gm-Message-State: AOAM532ZNEuMsBxb7pf9yH4YDFocPKzYucuDJ7lMJDrik5qNkOp+X0s9
        fIZwXJlb8qO7pEHfgfwYNGV7q/kL
X-Google-Smtp-Source: ABdhPJwFf01wX7CVOUcK/RJqiQSBI0fSpzgmtGl3de3Csqza+//tWpbgOTMmywvCcb0GrRo5CsQiww==
X-Received: by 2002:a37:a253:: with SMTP id l80mr59103030qke.197.1594239004528;
        Wed, 08 Jul 2020 13:10:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y45sm916731qtk.19.2020.07.08.13.10.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:04 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KA32D006109
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:03 GMT
Subject: [PATCH v1 12/22] SUNRPC: Trace call_refresh events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:03 -0400
Message-ID: <20200708201003.22129.99246.stgit@manet.1015granger.net>
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

Clean up: Replace dprintk call sites.

Note that rpc_call_rpcerror() already has a trace point, so perhaps
adding trace_rpc_refresh_status() isn't necessary. However, it does
report a particular category of error.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    2 ++
 net/sunrpc/clnt.c             |    9 +++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f20ef9539bbf..1fcff409d91b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -262,6 +262,8 @@ DEFINE_RPC_STATUS_EVENT(call);
 DEFINE_RPC_STATUS_EVENT(bind);
 DEFINE_RPC_STATUS_EVENT(connect);
 DEFINE_RPC_STATUS_EVENT(timeout);
+DEFINE_RPC_STATUS_EVENT(retry_refresh);
+DEFINE_RPC_STATUS_EVENT(refresh);
 
 TRACE_EVENT(rpc_request,
 	TP_PROTO(const struct rpc_task *task),
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cf6a295005ed..2bdfc4d0d860 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1752,12 +1752,10 @@ call_refreshresult(struct rpc_task *task)
 		if (!task->tk_cred_retry)
 			break;
 		task->tk_cred_retry--;
-		dprintk("RPC: %5u %s: retry refresh creds\n",
-				task->tk_pid, __func__);
+		trace_rpc_retry_refresh_status(task);
 		return;
 	}
-	dprintk("RPC: %5u %s: refresh creds failed with error %d\n",
-				task->tk_pid, __func__, status);
+	trace_rpc_refresh_status(task);
 	rpc_call_rpcerror(task, status);
 }
 
@@ -1881,8 +1879,7 @@ call_encode(struct rpc_task *task)
 			} else {
 				task->tk_action = call_refresh;
 				task->tk_cred_retry--;
-				dprintk("RPC: %5u %s: retry refresh creds\n",
-					task->tk_pid, __func__);
+				trace_rpc_retry_refresh_status(task);
 			}
 			break;
 		default:

