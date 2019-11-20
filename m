Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C51045BD
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 22:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKTVZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 16:25:54 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44444 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTVZy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Nov 2019 16:25:54 -0500
Received: by mail-yb1-f196.google.com with SMTP id g38so575176ybe.11
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2019 13:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kWx6i/TKA95kuio/KPymFiCxGv+BsZYAT9yUgw/xQ2M=;
        b=KQN7nuaeXb0NWP3fOcFBB508GfX+LLVg1oicYz4codj/63THi9Ly4ZbGuviWlJ0hkJ
         qtK3FYAsvnh+KepySaBo8rVi7KD60KPUxPQOR8RunhNST/eLmfEr1pdybqTtloyKygtr
         YQujp7LAG3N8KytttYAcOiDphyH2s8nWqh1JDc6AJieGK4vV3KhbZ+JziWaFmCnhagAX
         79Ob/EKhxaoSWOp0pEk3udHhHjysDlRVyITvW5JtGgIBHFDg0eaaOT0FI9g/9aaJBoFN
         X5duiNQC7aSryL8MBQvOXPj6RWcONMyt/05AmOyxBXXUkJSbz/l1wnDvNCPZ7zL6dBsr
         NkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=kWx6i/TKA95kuio/KPymFiCxGv+BsZYAT9yUgw/xQ2M=;
        b=tvasviKjuHReHFbjPAbAHU9h5H9vVfw9W++MOQlhU3j0t8Lws2kiP2b4o4KuwnFsjr
         tqiQb70EY/6SXJ0umFToZo+NbqLeNfOvbabf+VCBHjK+dqSV+bhvQuOhJNsfc6ijJK63
         v6UfyWMpsrcafgzLT/xH1jAlZr8Ngw4JXLecTGEiYWYiNOEmRVAXPx03G/yRRhatHMJf
         tydWOTCIV4uqGuQg0h/Ur0qGqD6dBRB4u3Hxd6Db7WUiZZj1zu6Fe1D1Yws2WAXXKtp3
         EvTBpDITLJLObFJuTEoOmC3sGFFKjyPvGSaHfxZBzQyEk74X8PxNsIn97IZQ6h4zbmN/
         j50Q==
X-Gm-Message-State: APjAAAWJHTxRT3wNK56FBRqXM0O/djvgSQx+pZgKzei2PZva9p90JGl0
        UAAjuFxewOKfWmPP7J+Tmdw=
X-Google-Smtp-Source: APXvYqwanD+v6y/LJfpUEnQ4OwVjCZ4T9wpBnfrhvDWyhNfxxpC09A+4mnW+yte2ml93UxZKrN1SnQ==
X-Received: by 2002:a25:508c:: with SMTP id e134mr3762170ybb.330.1574285153757;
        Wed, 20 Nov 2019 13:25:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b199sm356191ywh.23.2019.11.20.13.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 13:25:53 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAKLPqer016820;
        Wed, 20 Nov 2019 21:25:52 GMT
Subject: [PATCH v1 2/2] SUNRPC: Capture completion of all RPC tasks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, trond.myklebust@primarydata.com,
        anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 20 Nov 2019 16:25:52 -0500
Message-ID: <20191120212552.2140.47641.stgit@klimt.1015granger.net>
In-Reply-To: <20191120212443.2140.88674.stgit@klimt.1015granger.net>
References: <20191120212443.2140.88674.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RPC tasks on the backchannel never invoke xprt_complete_rqst(), so
there is no way to report their tk_status at completion. Also, any
RPC task that exits via rpc_exit_task() before it is replied to will
also disappear without a trace.

Introduce a trace point that is symmetrical with rpc_task_begin that
captures the termination status of each RPC task.

Sample trace output for callback requests initiated on the server:
   kworker/u8:12-448   [003]   127.025240: rpc_task_end:         task:50@3 flags=ASYNC|DYNAMIC|SOFT|SOFTCONN|SENT runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
   kworker/u8:12-448   [002]   127.567310: rpc_task_end:         task:51@3 flags=ASYNC|DYNAMIC|SOFT|SOFTCONN|SENT runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task
   kworker/u8:12-448   [001]   130.506817: rpc_task_end:         task:52@3 flags=ASYNC|DYNAMIC|SOFT|SOFTCONN|SENT runstate=RUNNING|ACTIVE status=0 action=rpc_exit_task

Odd, though, that I never see trace_rpc_task_complete, either in the
forward or backchannel. Should it be removed?

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/sched.c            |    1 +
 2 files changed, 2 insertions(+)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index c358a0af683b..9972823085ba 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -185,6 +185,7 @@
 DEFINE_RPC_RUNNING_EVENT(begin);
 DEFINE_RPC_RUNNING_EVENT(run_action);
 DEFINE_RPC_RUNNING_EVENT(complete);
+DEFINE_RPC_RUNNING_EVENT(end);
 
 DECLARE_EVENT_CLASS(rpc_task_queued,
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 360afe153193..66a7a81504bf 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -824,6 +824,7 @@ void rpc_prepare_task(struct rpc_task *task)
  */
 void rpc_exit_task(struct rpc_task *task)
 {
+	trace_rpc_task_end(task, task->tk_action);
 	task->tk_action = NULL;
 	if (task->tk_ops->rpc_count_stats)
 		task->tk_ops->rpc_count_stats(task, task->tk_calldata);

