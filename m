Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78B61B64A9
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgDWTnU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDWTnT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:43:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF67C09B042
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:43:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so5946541qtb.5
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+AE51vMhMRmnKr1C0p9d5nMOGQsfWTJDmE45ZxSurVE=;
        b=GuO4VlcIBkdXyeibRra5mDjQuM4L0nb9tdpL32ApLTPK6Hhp35Q6H//5nJDt56AjUz
         yH2Xy8LUrQhaLpLCoH0yMuzTMP+nOjoRzBbOBb+KBRtK2vOy7UImqB30vMpeI5Pdqx6z
         D3b9NQsRNCymUeGFEJF07Fbq9m3HBDSpXg3SpDALLpjcH3U813h6nQgFfQurRTW+LIt4
         hfsylDXco30X7r/39APSsfu/xSzmfwLBUDiAM+nyaMST0eBZPG25RYTvsOnZFGsYPanr
         6YmJKVQvcZIwxSq6ChAg14Pd/LuCorMTuDApkTZ0mOThafNAskZ62UAiJO3HIXVzlx84
         i4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+AE51vMhMRmnKr1C0p9d5nMOGQsfWTJDmE45ZxSurVE=;
        b=NduwRhLsQ4PBzCd+++HO0gg+cIahtSFW1u75OEMIR4G6A81GVWkfIGXAE1jXR6ZaKV
         PaalQtIPK+RmPjAbRgrhtDmeemmKQEQPK9/6EP8ST2+IJjEC3sTg8+QWj8QyMiPn9Hl/
         DfSCIdXRBUW+jJ1ydjRdfi0WQHII1Z5dTzJFJKJMST4GuCliWl27ErE+Wq96ajIwu+Z1
         mtHd7JbgiS5xlbS6eIJ9kencLiQGelaVE/mCPZLz5XbyG3HWJvGdm0QxyVT6mOrkdV0T
         MnwRenFR/xz378owA4bldeVqzrzlhxhF9LP6jVc/XiFF+Zai10sb4YFM/oe+geXJr6Iy
         fKiw==
X-Gm-Message-State: AGi0Pubd7MeUsjgHsc1hc0SwCxgXQV8kdTy9y/9WKLqRG5c3SPWp8DNi
        d2S5aj2wtpArkwJz2CeTDMX+5WYx
X-Google-Smtp-Source: APiQypJg2VccbNIPDyfeR/zYhyHVu3tgNj5xAtsC9PcB/ars2BbxlsnCHwO0B7nVEYCHdM5CrrqF4w==
X-Received: by 2002:aed:2de7:: with SMTP id i94mr5911294qtd.248.1587670998975;
        Thu, 23 Apr 2020 12:43:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e8sm2112461qkl.57.2020.04.23.12.43.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:43:18 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03NJhH8H030434;
        Thu, 23 Apr 2020 19:43:17 GMT
Subject: [PATCH RFC2 2/2] sunrpc: Ensure signalled RPC tasks exit
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Apr 2020 15:43:17 -0400
Message-ID: <20200423194317.7849.3375.stgit@manet.1015granger.net>
In-Reply-To: <20200423194311.7849.36326.stgit@manet.1015granger.net>
References: <20200423194311.7849.36326.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If an RPC task is signaled while it is running and the transport is
not connected, it will never sleep and never be terminated. This can
happen when a RPC transport is shut down: the remaining tasks are
signalled, but the transport is disconnected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/sched.h |    3 ++-
 net/sunrpc/sched.c           |   14 ++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index df696efdd675..9f5e48f154c5 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -170,7 +170,8 @@ struct rpc_task_setup {
 
 #define RPC_IS_ACTIVATED(t)	test_bit(RPC_TASK_ACTIVE, &(t)->tk_runstate)
 
-#define RPC_SIGNALLED(t)	test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate)
+#define RPC_SIGNALLED(t)	\
+	unlikely(test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate) != 0)
 
 /*
  * Task priorities.
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 7eba20a88438..99b7b834a110 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -912,6 +912,12 @@ static void __rpc_execute(struct rpc_task *task)
 		trace_rpc_task_run_action(task, do_action);
 		do_action(task);
 
+		if (RPC_SIGNALLED(task)) {
+			task->tk_rpc_status = -ERESTARTSYS;
+			rpc_exit(task, -ERESTARTSYS);
+			break;
+		}
+
 		/*
 		 * Lockless check for whether task is sleeping or not.
 		 */
@@ -919,14 +925,6 @@ static void __rpc_execute(struct rpc_task *task)
 			continue;
 
 		/*
-		 * Signalled tasks should exit rather than sleep.
-		 */
-		if (RPC_SIGNALLED(task)) {
-			task->tk_rpc_status = -ERESTARTSYS;
-			rpc_exit(task, -ERESTARTSYS);
-		}
-
-		/*
 		 * The queue->lock protects against races with
 		 * rpc_make_runnable().
 		 *

