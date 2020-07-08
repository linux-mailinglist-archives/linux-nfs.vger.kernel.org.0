Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63697219136
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGHUKQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUKQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:16 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D8DC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so21088245qvl.4
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JE+hXXXopvB8gyPStEshb4aXwGyP9+0g2HApnYyfi8A=;
        b=IC01Htazg30ej5MnrSi3ZUuavwFiZWwgOMkyGcbA55aIBxZDic2n0s2LW7+fRoB9Dt
         bbedfLY6wAibz1FjFx+IMnbXw13cSkz9Ei2vgR82dW9vWqM6Xe5tgolEFEwUb7mruaSn
         CgyYBE0P/T00GlSMUq6BkO9yzABuduf3G6bNYPkZw9KEJlPY4bXIZDok/oeMrdnr/2RG
         u3KZkk+YPLFz0RPJAjs6fyGULOnCZCi3kSbg73YFCBL8pwiG2zuIjws5opgxxdEYRA//
         7OB6VPDDUjKzplQLrmRSV3IxndvJz5yLJ6X0focQf3ybBXd+qLaRuNFBxwhA62+Erp8W
         DwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JE+hXXXopvB8gyPStEshb4aXwGyP9+0g2HApnYyfi8A=;
        b=YkgtswHkbDGW7n/2D3NT8uFbWRMmK3mjcrKwxhj8u94LbOfjsbMYvrTSkK3DxI9uV2
         mf/edjkpUeoqoyZO56HrYiG7o/k+C/w+yYFcuMJ7PQ0/S+iKpDTNPyZQa5zP+H9y/y2n
         DyO1ZyD3vHaS4XYaZDNtbCZxA00gy3YRiNvZJEnvAg99gGAkr/suQ4jEQEa+Rqed03kG
         Aavq6cnozL2iMftnd0qD95S80fS2NRtBjw9fz9P2cz/HhedNfzvaEYtwSyfpcUo/eqMD
         3GH8t/xVtV0hA0cne1TNTI/uvlIGFqhepB1J5qM+gvZ8h8CDwgQsp7JPlLfsgggx5MAD
         k2/A==
X-Gm-Message-State: AOAM531r3ioiOLNQoc44OH8lkVE0K64TGTD+rhemSti3lnu/793A8pWC
        BKScIb5JpetCOeicYlnfyw6+Iuay
X-Google-Smtp-Source: ABdhPJzWWMPt11shRULcFNBiADiaJ+LMwLu1u50/F8Fl8eCndPds4dxIxBTRdVeOLVkhrHd4o8wKlA==
X-Received: by 2002:a05:6214:108b:: with SMTP id o11mr49178821qvr.86.1594239015210;
        Wed, 08 Jul 2020 13:10:15 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a185sm997101qkg.3.2020.07.08.13.10.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:14 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAExH006115
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:14 GMT
Subject: [PATCH v1 14/22] SUNRPC: Clean up call_bind_status() observability
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:14 -0400
Message-ID: <20200708201014.22129.22280.stgit@manet.1015granger.net>
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

Time to remove dprintk call sites in here.

Regarding the rpc_bind_status tracepoint: It's friendlier to
administrators if they don't have to look up the error code to
figure out what went wrong. Replace trace_rpc_bind_status with a
set of tracepoints that report more specifically what the problem
was, and what RPC program/version was being queried.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   14 +++++++++++++-
 net/sunrpc/clnt.c             |   20 ++++++--------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 1fcff409d91b..8bc5f966b22d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -259,7 +259,6 @@ DECLARE_EVENT_CLASS(rpc_task_status,
 			TP_ARGS(task))
 
 DEFINE_RPC_STATUS_EVENT(call);
-DEFINE_RPC_STATUS_EVENT(bind);
 DEFINE_RPC_STATUS_EVENT(connect);
 DEFINE_RPC_STATUS_EVENT(timeout);
 DEFINE_RPC_STATUS_EVENT(retry_refresh);
@@ -520,6 +519,19 @@ DEFINE_RPC_REPLY_EVENT(stale_creds);
 DEFINE_RPC_REPLY_EVENT(bad_creds);
 DEFINE_RPC_REPLY_EVENT(auth_tooweak);
 
+#define DEFINE_RPCB_ERROR_EVENT(name)					\
+	DEFINE_EVENT(rpc_reply_event, rpcb_##name##_err,		\
+			TP_PROTO(					\
+				const struct rpc_task *task		\
+			),						\
+			TP_ARGS(task))
+
+DEFINE_RPCB_ERROR_EVENT(prog_unavail);
+DEFINE_RPCB_ERROR_EVENT(timeout);
+DEFINE_RPCB_ERROR_EVENT(bind_version);
+DEFINE_RPCB_ERROR_EVENT(unreachable);
+DEFINE_RPCB_ERROR_EVENT(unrecognized);
+
 TRACE_EVENT(rpc_buf_alloc,
 	TP_PROTO(
 		const struct rpc_task *task,
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 90e3d9dae34c..c434ecd54cdd 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1957,7 +1957,6 @@ call_bind_status(struct rpc_task *task)
 		return;
 	}
 
-	trace_rpc_bind_status(task);
 	if (task->tk_status >= 0)
 		goto out_next;
 	if (xprt_bound(xprt)) {
@@ -1967,12 +1966,10 @@ call_bind_status(struct rpc_task *task)
 
 	switch (task->tk_status) {
 	case -ENOMEM:
-		dprintk("RPC: %5u rpcbind out of memory\n", task->tk_pid);
 		rpc_delay(task, HZ >> 2);
 		goto retry_timeout;
 	case -EACCES:
-		dprintk("RPC: %5u remote rpcbind: RPC program/version "
-				"unavailable\n", task->tk_pid);
+		trace_rpcb_prog_unavail_err(task);
 		/* fail immediately if this is an RPC ping */
 		if (task->tk_msg.rpc_proc->p_proc == 0) {
 			status = -EOPNOTSUPP;
@@ -1989,17 +1986,14 @@ call_bind_status(struct rpc_task *task)
 	case -EAGAIN:
 		goto retry_timeout;
 	case -ETIMEDOUT:
-		dprintk("RPC: %5u rpcbind request timed out\n",
-				task->tk_pid);
+		trace_rpcb_timeout_err(task);
 		goto retry_timeout;
 	case -EPFNOSUPPORT:
 		/* server doesn't support any rpcbind version we know of */
-		dprintk("RPC: %5u unrecognized remote rpcbind service\n",
-				task->tk_pid);
+		trace_rpcb_bind_version_err(task);
 		break;
 	case -EPROTONOSUPPORT:
-		dprintk("RPC: %5u remote rpcbind version unavailable, retrying\n",
-				task->tk_pid);
+		trace_rpcb_bind_version_err(task);
 		goto retry_timeout;
 	case -ECONNREFUSED:		/* connection problems */
 	case -ECONNRESET:
@@ -2010,8 +2004,7 @@ call_bind_status(struct rpc_task *task)
 	case -EHOSTUNREACH:
 	case -ENETUNREACH:
 	case -EPIPE:
-		dprintk("RPC: %5u remote rpcbind unreachable: %d\n",
-				task->tk_pid, task->tk_status);
+		trace_rpcb_unreachable_err(task);
 		if (!RPC_IS_SOFTCONN(task)) {
 			rpc_delay(task, 5*HZ);
 			goto retry_timeout;
@@ -2019,8 +2012,7 @@ call_bind_status(struct rpc_task *task)
 		status = task->tk_status;
 		break;
 	default:
-		dprintk("RPC: %5u unrecognized rpcbind error (%d)\n",
-				task->tk_pid, -task->tk_status);
+		trace_rpcb_unrecognized_err(task);
 	}
 
 	rpc_call_rpcerror(task, status);

