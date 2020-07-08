Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA20421912E
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgGHUJe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUJe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5090C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z63so42797120qkb.8
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=F9kZdgRW70yDI4ojOAJCksFJYZsd0iiM3ePu+uDTbfc=;
        b=iaw439Y4iNM8h5T+iejTI4EbeI2HXQTq8bprFMw+escAfc2fF+/BIrgOnz3w4troWA
         qelfoZtxlmNTzq5xDEDI0WGfWVPMRjEVEtbYdg6ynrTputkV1PWW27zCn/fbfDCZTGXc
         RLpe/187Aw09BOidVMv5LY/bSwIofjHIrzevEXCCEHuqUADN9Qx6x4QylZoJKQKEIe2C
         4JSFDwtOvJuLXt2I0ezJes8rA1rkDb+PD5qlKdUXFuB06OKFKgKea08IyDOA+2I1KDXO
         1jkRHGKhzwX9r10+3surZN+LV5B3/WYKz9bXH3XV+9eHkxAVvynO6Mw+dUQexLpT+m8I
         Bk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=F9kZdgRW70yDI4ojOAJCksFJYZsd0iiM3ePu+uDTbfc=;
        b=MglHt1BqFPJXX1IA7CSpIiBP2HXx/K1RbZi0UcGvsBT2LgXRBTkPKrYllwJ+bDwkqq
         E3x8QpDhY5+EB/PTWOajdC1jWh2JIlIm0uz9HXYtAHqQeZhIdtStI2zFUD6ptu9IaWwi
         amEXWpTeUFrVczJO06uDgGfIQ/C4yigOixuYPFAghGMfaYbDg82huKSLd9ZraOrtA0HD
         5XppKUt54aSs9KrNnfbFiX9UgrO/kEaDDnvkEycPjSxx0AQH762NJSLFtHfNmbhd/7Po
         Q8ZcfXMrm/oegrBG4j+w7yPCqBWsf8WWX7kgqvjae570OZd6ELzhweD8ygwQYiRNNfol
         0tuA==
X-Gm-Message-State: AOAM533cwDIHeL6cErRuzluV3nd97bZEbiSr6lRwFsLT4AZ8gDCyVp8F
        5XRKXJ5VWGlkF94TT8zj3BHp9PRj
X-Google-Smtp-Source: ABdhPJxcIMMAZ82Sc50YkS/0hBtzSKHocfmgVvDelgEUyuBEegV5kYqud3RxJPV482wSySA740GU3Q==
X-Received: by 2002:a37:2dc3:: with SMTP id t186mr49189014qkh.157.1594238973047;
        Wed, 08 Jul 2020 13:09:33 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q13sm762466qtp.42.2020.07.08.13.09.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:32 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9WB0006081
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:32 GMT
Subject: [PATCH v1 06/22] SUNRPC: Replace dprintk() call site in xs_nospace()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:32 -0400
Message-ID: <20200708200932.22129.11905.stgit@manet.1015granger.net>
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

"no socket space" is an exceptional and infrequent condition
that troubleshooters want to know about.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   28 ++++++++++++++++++++++++++++
 net/sunrpc/xprtsock.c         |    5 +----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index b5d1ed7f996a..dbde6a0eb821 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -898,6 +898,34 @@ DEFINE_RPC_SOCKET_EVENT_DONE(rpc_socket_reset_connection);
 DEFINE_RPC_SOCKET_EVENT(rpc_socket_close);
 DEFINE_RPC_SOCKET_EVENT(rpc_socket_shutdown);
 
+TRACE_EVENT(rpc_socket_nospace,
+	TP_PROTO(
+		const struct rpc_rqst *rqst,
+		const struct sock_xprt *transport
+	),
+
+	TP_ARGS(rqst, transport),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(unsigned int, total)
+		__field(unsigned int, remaining)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->total = rqst->rq_slen;
+		__entry->remaining = rqst->rq_slen - transport->xmit.offset;
+	),
+
+	TP_printk("task:%u@%u total=%u remaining=%u",
+		__entry->task_id, __entry->client_id,
+		__entry->total, __entry->remaining
+	)
+);
+
 TRACE_DEFINE_ENUM(XPRT_LOCKED);
 TRACE_DEFINE_ENUM(XPRT_CONNECTED);
 TRACE_DEFINE_ENUM(XPRT_CONNECTING);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 914508ea9b84..07cf824bc0c9 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -762,10 +762,7 @@ static int xs_nospace(struct rpc_rqst *req)
 	struct sock *sk = transport->inet;
 	int ret = -EAGAIN;
 
-	dprintk("RPC: %5u xmit incomplete (%u left of %u)\n",
-			req->rq_task->tk_pid,
-			req->rq_slen - transport->xmit.offset,
-			req->rq_slen);
+	trace_rpc_socket_nospace(req, transport);
 
 	/* Protect against races with write_space */
 	spin_lock(&xprt->transport_lock);

