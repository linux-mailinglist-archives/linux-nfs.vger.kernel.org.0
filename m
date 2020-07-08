Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1EF219133
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGHUKA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUKA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:00 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF0C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u12so35554269qth.12
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NftrcMn12G3r5yxk0W3Huk020kupgNeKvzc/5Fxtuac=;
        b=gGXPAwmQ5KG0IiJpxb2754NK6PFFdwHTFRvQsjUCufos2h9+ajLLS+9AYeRg3ykWz+
         H8Y/XSxpln8Me64B1PJ79WecoI7oXuwd6HAciIrisbEn+sxkizKvX9bRRBRom7+9g/un
         GCuMnJPqxIH9XOzamIFHbsXI/D4vjT283hInWqKB5Gttsdv9VfNWEy4QVrY0t5minGMj
         gsI9FHnLBCTmROp+UXJskLWRnqJ8Qg4t77SC6CSGtod+LzXZLTJSnLvxo+I/t76Ot5XM
         IcUlZgG95qBNJYKVnGQOXLq4DRLuAhFSAAJoYv7B1w97KepY9ARNi9xphAvxCVnHNqAy
         8Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NftrcMn12G3r5yxk0W3Huk020kupgNeKvzc/5Fxtuac=;
        b=Oo8TuUxACwAeGvvOKJSjjWDeeLZmLI+27NSvRHzgznrLnXcuvxVTP/+Lakrw49CoS6
         MkAJnjvKq3by4p5J5WdpZHm8e7nWfRKo3rllyEbTVGDcm5yUDYSeJ8J9SvozCOINGl6P
         GOl6lX1E9fKpX5B2NFqfu4BpNPUmQLaveWgOh58r6vqUCh6V7XuUNMIZQMcWoSmpwKj2
         mWvH6jpDFsepGthOX8poER3TcfMgcU7F6/cLPvBwdDCClYuylaot+CnrJ6/WKDrg3zE9
         UFbzLP3sVVveiX8SJdZYovO9UA5lu659n0yT0XNqUV+SHo0UROoHNjvBqgK2d426q0GQ
         o7+g==
X-Gm-Message-State: AOAM531DRCt9Kyj+xvCxFO540QZ8cybK/zVeo7jAkWgDG8Hw3gW/mpem
        QQpkl5wv4A17NN5NlTwB6WCSTjgD
X-Google-Smtp-Source: ABdhPJwNgqclhRW/Q6d+mc5CGNCLKfCaCu6ANJ2PrErGc0UH7jDWDZj9na7hvhasBnJx97tb5yBfjw==
X-Received: by 2002:ac8:1728:: with SMTP id w37mr56500465qtj.125.1594238999518;
        Wed, 08 Jul 2020 13:09:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f18sm768885qtc.28.2020.07.08.13.09.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:59 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9wex006096
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:58 GMT
Subject: [PATCH v1 11/22] SUNRPC: Add trace_rpc_timeout_status()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:58 -0400
Message-ID: <20200708200958.22129.66745.stgit@manet.1015granger.net>
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

For a long while we've wanted a tracepoint that fires when a major
timeout is reported in the system log. Such a tracepoint can be
attached to other actions that can take place when a timeout is
detected (eg, server or connection health assessment).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/clnt.c             |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 06cb201cdfd3..f20ef9539bbf 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -261,6 +261,7 @@ DECLARE_EVENT_CLASS(rpc_task_status,
 DEFINE_RPC_STATUS_EVENT(call);
 DEFINE_RPC_STATUS_EVENT(bind);
 DEFINE_RPC_STATUS_EVENT(connect);
+DEFINE_RPC_STATUS_EVENT(timeout);
 
 TRACE_EVENT(rpc_request,
 	TP_PROTO(const struct rpc_task *task),
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 3a4f1ce31e22..cf6a295005ed 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2397,7 +2397,7 @@ rpc_check_timeout(struct rpc_task *task)
 	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
 		return;
 
-	dprintk("RPC: %5u call_timeout (major)\n", task->tk_pid);
+	trace_rpc_timeout_status(task);
 	task->tk_timeouts++;
 
 	if (RPC_IS_SOFTCONN(task) && !rpc_check_connected(task->tk_rqstp)) {

