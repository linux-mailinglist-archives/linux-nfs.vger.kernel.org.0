Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3E1D006E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgELVN0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVNZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ECDC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j2so12139449qtr.12
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RdNAlrj6LZd/V2JW5yOLHXRFrYJSCJCQ5KQ5tVPjKss=;
        b=XtsoRNeoyp3SyRACd4XHRxRAh95mDhcAwhLZ5RQ99fyxjjt3G0QQcoaNsxIPNDk06r
         6FVY1Ky2GdxKwQ4aN6BBnaN7ZD8nFXxyoftXQBeDq7OLIUss0zkkplbmEcp6cEjVZMDt
         3fs9tmKAnafizjsQhJ/1OoUoSYVF3IqvUISML41nZ65A1dQavFckxHGjHNPeQZdp8nEV
         RGN2jIojgYpcQqU8bz7uuAXahjZ92ljvTJR9pNg0V75SxQnMjEnfn9w0BF4jt2umxT8w
         Jrtq+1wd9QK2G560EuDjMnQzx2ay5R/PyFK4FAsEC5r+t5F/lCRGXLQ3n/Sx4Duv4qDR
         0IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RdNAlrj6LZd/V2JW5yOLHXRFrYJSCJCQ5KQ5tVPjKss=;
        b=JE8fhyFmi3vwp3glxDtxxH/Nu4Seys6T6Pv0YSOg5T2ZEWTyvlY33HOK/rfIHP/RrR
         fF4E1O+BP4xlDq3czndB6YlMojz8eT/KpCrEVR4HSrdF6sCgHzrsz7mAVGZWO+EOJnW9
         GZasx8q348Smlu/oI7uitlx1houGot9z5fE8+Snqt+/zAMMCdovrYN6cRad8EwuMqu9z
         EsGQBdhg25Fl0f96H06t+FCbsQIwarFnjZKUrHgyMzkpMvRKUZD25/bnUNPeJUniXdLX
         cGgZk5qHxFnvwxX9K0+17H9C6dNUh2m2YIJO97Dg6LPNAcgfcrUnZj+JBDcvBAtjQjm6
         NxkQ==
X-Gm-Message-State: AGi0PubwjS/qgoPKk3oyepdejL7Gb4gj/kvykj6UJLreC95x0coNfXuj
        gMdl3L96BOp4iHkXT9NV3fs=
X-Google-Smtp-Source: APiQypKg8No99ACNwSCFbjg9jawMxeK/jabMyKZ9ILui3uzOZs0/+nBNaI4iYSZFxiW8ZqH2rXdS2w==
X-Received: by 2002:ac8:7743:: with SMTP id g3mr23432834qtu.341.1589318004969;
        Tue, 12 May 2020 14:13:24 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a194sm11918800qkb.21.2020.05.12.14.13.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:24 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDNAM009801;
        Tue, 12 May 2020 21:13:23 GMT
Subject: [PATCH v1 06/15] SUNRPC: Add tracepoint to rpc_call_rpcerror()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:23 -0400
Message-ID: <20200512211323.3288.1681.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a tracepoint in another common exit point for failing RPCs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   28 ++++++++++++++++++++++++++++
 net/sunrpc/clnt.c             |    1 +
 2 files changed, 29 insertions(+)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f6896bcfd97f..f1fd3fae5b0f 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -365,6 +365,34 @@
 DEFINE_RPC_REPLY_EVENT(bad_creds);
 DEFINE_RPC_REPLY_EVENT(auth_tooweak);
 
+TRACE_EVENT(rpc_call_rpcerror,
+	TP_PROTO(
+		const struct rpc_task *task,
+		int tk_status,
+		int rpc_status
+	),
+
+	TP_ARGS(task, tk_status, rpc_status),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(int, tk_status)
+		__field(int, rpc_status)
+	),
+
+	TP_fast_assign(
+		__entry->client_id = task->tk_client->cl_clid;
+		__entry->task_id = task->tk_pid;
+		__entry->tk_status = tk_status;
+		__entry->rpc_status = rpc_status;
+	),
+
+	TP_printk("task:%u@%u tk_status=%d rpc_status=%d",
+		__entry->task_id, __entry->client_id,
+		__entry->tk_status, __entry->rpc_status)
+);
+
 TRACE_EVENT(rpc_stats_latency,
 
 	TP_PROTO(
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 456e64ca14bc..9151ade01a55 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1624,6 +1624,7 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 static void
 __rpc_call_rpcerror(struct rpc_task *task, int tk_status, int rpc_status)
 {
+	trace_rpc_call_rpcerror(task, tk_status, rpc_status);
 	task->tk_rpc_status = rpc_status;
 	rpc_exit(task, tk_status);
 }

