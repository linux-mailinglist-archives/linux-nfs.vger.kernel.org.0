Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA11B64C8
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgDWTuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgDWTt7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:49:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B338C09B042
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:49:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 71so5940980qtc.12
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+AE51vMhMRmnKr1C0p9d5nMOGQsfWTJDmE45ZxSurVE=;
        b=KO7mr1Ml8iU58NpmEEJIqmy4mcTA1Isj0wB/LhcOJ9UIbiRGN/csUeggvOXwWwo23R
         HkoISMejhpKI2Ho6+rAXU+HNKotzwdd5rn73lZuHYs4DnHAnSOgRtsbbTKVgRopR+SW4
         xXJvWR/W77AZLUFD0e/nGPETaBUCQqcngG7dq/3a4ZbqR3y6lYcN678EDSZSkmrQsqhz
         olrOd4bYtUUnCDYgY/d/tSIQ08dNS7xWepU5zdxN2QQL5nj8cYqnSq9CHgi+ePQpqW2w
         WjnUKRklA0CnHb85ZaWQlO0QcpraC9UdbVWaBjKeinPa0VEmfk8nWXeiuW182rZWT9Ns
         1CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+AE51vMhMRmnKr1C0p9d5nMOGQsfWTJDmE45ZxSurVE=;
        b=eNtwr/xk934rN50BtVCoYorONwxjQ+z3rUV3gztQie/H+BIFMsWnNTqf+XcXFie/qg
         76DDinEH3RozxuD2sx9YxTjFgzFRVnceS0uoORSM2cECabBiq6W5CA7BZMS1LN+Ky434
         m+cvYP5zMU80YLXxxeIU1RH/q9noPmXLMCf96ixWCbBHM/6zj7eZZC4Rm6jccgkcddUm
         /Y1RzkGq7mU60qRjHOwEnVmyT1L0ufdq19n4kMhUBgBO/jbNr3yMtLvHvudseeZ2rAx/
         LKlITaaUFIF4Mjx2Dk5ok35FaYXDWCTkKc+aw78/aa4nb7IG9i84YnaGwJsom64H8M5b
         J3xQ==
X-Gm-Message-State: AGi0PuaOsANkglc1yX8UC1O+AdYjRsEBkIS6bZXlKQlPkOPIIvaHic+w
        49LAElLNh98O0w876yT3kkk=
X-Google-Smtp-Source: APiQypJ6tGFmqdUONnIp0/35IHSs/WACA0T6kx/Ft6EnD3rBHb1Aya8HCbtazXrp7tvvSRzbrFctww==
X-Received: by 2002:aed:2046:: with SMTP id 64mr5791930qta.187.1587671398380;
        Thu, 23 Apr 2020 12:49:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f68sm2232392qtb.19.2020.04.23.12.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:49:57 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03NJntjO030445;
        Thu, 23 Apr 2020 19:49:55 GMT
Subject: [PATCH RFC3 2/2] sunrpc: Ensure signalled RPC tasks exit
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Apr 2020 15:49:55 -0400
Message-ID: <20200423194955.7923.37542.stgit@manet.1015granger.net>
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

