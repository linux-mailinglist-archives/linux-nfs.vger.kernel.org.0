Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8E21913F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGHUK6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGHUK6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:58 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2A8C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:58 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id e3so14779807qvo.10
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7IGM9EAqdmGRanqhNA3ExlUYjuyFtZv0iYCZ7IvyjkI=;
        b=N7p1knZI8NHWtVgiavGBZr+ltyvQwTJAy8NeAABnhnKPNhZjxpJzIe53g5l/3YCT24
         oMcuwe5FO9Nke2IpfoNWYwSnZDhTHVXJrN/XSjaPTZictQf3II6wpzfYCFM8u9v1wnUq
         3IlZzN2TbWibduipaTFaaeTzjUN7mNBYqKI5vWT0A9PAPuwPlJ4bV5yKdHcw04swOAXB
         WqAjJ0N+LsSaGUgyEIG8EaTGWPE49GnMX93fP+fRea1CpdS7Qf2636Ud62iag/fbiqRl
         4nifn5PAtYAyLdpSyUXizR7YJ9wFKCKkviV4v5enzJqZ/pDHkcpzgaHnD43ZJ1yEsLzl
         uRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7IGM9EAqdmGRanqhNA3ExlUYjuyFtZv0iYCZ7IvyjkI=;
        b=G49aTvzT/1ugOybXDRYLs5wjtxaDRxDB3CZFCozHSYju/SkvdP4lEehZsIp+faHpCU
         lwiqsiidKgf//PBFwSVYJe5xTkoQjJxvfspwFrfMoEUDNDnGkce9TCnRnpy3R3qcHg2q
         cVc71EAAa6P5OsUrYm9BZVKepLa6nj2lwwqsGf2p1ZHZDbQAlXpvsO0vXRkhufS0ovPU
         Ts6vaXmcez1EiDzJ001IktbwMMPP/U9AIg5+NHQ+uRtme7WY8WUpa5J0TQg2k/Qk0Id1
         ULnJ3oweK/i15b25nWdIOeH+m2081f/Bc6RSQFjmo92QnNNMGEaUzIuC6aj56iaqFps7
         jMcg==
X-Gm-Message-State: AOAM532sp7KQvX8LMRL1FRcddd3WNJrPMXn0bRkyjjsUX17TFLmDXa1j
        LFV8kr1GVi3xxpgA7QbWM4sj16Ue
X-Google-Smtp-Source: ABdhPJxRNlrvEe/XdMGKgVelpY7QhTMcEX6JH21zdilfRL9Vbpfei88QJRLa8BuxnKiLmBS12wpMUA==
X-Received: by 2002:a0c:facb:: with SMTP id p11mr57199883qvo.243.1594239057241;
        Wed, 08 Jul 2020 13:10:57 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b10sm918138qkh.124.2020.07.08.13.10.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:56 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAuAV006140
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:56 GMT
Subject: [PATCH v1 22/22] SUNRPC: Remove remaining dprintks from sched.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:56 -0400
Message-ID: <20200708201056.22129.36781.stgit@manet.1015granger.net>
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

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/sched.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 116b3abaed3f..f06d7c315017 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -27,10 +27,6 @@
 
 #include "sunrpc.h"
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-#define RPCDBG_FACILITY		RPCDBG_SCHED
-#endif
-
 #define CREATE_TRACE_POINTS
 #include <trace/events/sunrpc.h>
 
@@ -1065,9 +1061,6 @@ static void rpc_init_task(struct rpc_task *task, const struct rpc_task_setup *ta
 		task->tk_action = rpc_prepare_task;
 
 	rpc_init_task_statistics(task);
-
-	dprintk("RPC:       new task initialized, procpid %u\n",
-				task_pid_nr(current));
 }
 
 static struct rpc_task *
@@ -1091,7 +1084,6 @@ struct rpc_task *rpc_new_task(const struct rpc_task_setup *setup_data)
 
 	rpc_init_task(task, setup_data);
 	task->tk_flags |= flags;
-	dprintk("RPC:       allocated task %p\n", task);
 	return task;
 }
 
@@ -1216,7 +1208,6 @@ static int rpciod_start(void)
 	/*
 	 * Create the rpciod thread and wait for it to start.
 	 */
-	dprintk("RPC:       creating workqueue rpciod\n");
 	wq = alloc_workqueue("rpciod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!wq)
 		goto out_failed;
@@ -1241,7 +1232,6 @@ static void rpciod_stop(void)
 
 	if (rpciod_workqueue == NULL)
 		return;
-	dprintk("RPC:       destroying workqueue rpciod\n");
 
 	wq = rpciod_workqueue;
 	rpciod_workqueue = NULL;

