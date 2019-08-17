Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA11391330
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfHQVYt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35256 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHQVYs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:48 -0400
Received: by mail-io1-f66.google.com with SMTP id i22so13251152ioh.2
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xcXU+vb6y2gxdMrgR5dsOskgKrG7qU16OXTYGfF708Y=;
        b=kP71JI2CVLdU/KiruOMBKxM7DBmbEFkD58NG/ATluJVVSJFgnbZikkAhJsMEgaJiFl
         cLHSpsTGkrQ9bwtDniz2EE4NgGnwAJuWyhDET0D+cpa377zLpavJnvXTGX4u/BP4ENTX
         EIjfwarb/yrEpYi94myXcNTQiNzxcAjl7YXrqgoLW/eIc1vH4kr07FcZ0qFkCR7ZKyVP
         fMs7ZxrlVYMthM3BI52WxA9XHbtWBkpEleN44de3ZFXe5iUcEfSlYgRXrdZW5Vy5D52G
         olNgYlRSrNpkt2uwFUfHiYZ0L1Tb2Q1sagleiimkVzX21948uWSnyyDQCqZVis2xSGIe
         YROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcXU+vb6y2gxdMrgR5dsOskgKrG7qU16OXTYGfF708Y=;
        b=aahlJJ7l5jUMcnUSwGM3bXHC+UJDhKeMnvssMFa8xgMGKliXTY+5XNXHk2trLdcbdO
         hTkIxCUKC8buT2OZDxXV1aMWhhykpGTwfKlnVOvzct7jLtmzItJ0bFBlgkJgSfCgdOpS
         wUgbJn1e2+UR1Td+Ns2uXkdRLvhUtt7SRGNPD62KHUmcwjeSIQqTgzkk9L/sDK/BEDcY
         wLXZbj8rWvJ/xAlCfUaD7S3uEkcYJZIrecxyKNhYfIzLuVKW0IR1yEr9iqYK6UFN/f5q
         KJYbGvjJDx8MtCT7wcg3miu2vfdHSg4FM8iD1PxIgBfdGVXYy/1g25L21Lb4oRgdjyTq
         xbwA==
X-Gm-Message-State: APjAAAWsIyTU2kV+qpWHXpj6pXyadVSvrnTtQUwvVQ4fP4WxxptEJ4JT
        lcQkRaAmIhnDaqAmAOucsE4VtCI=
X-Google-Smtp-Source: APXvYqzqcHTvl8HZFP0nvzP+t5CSOnFvafWD743UFhQryJm5AcYhRHryM1ns4wZYEpBvCGeIyGJvkA==
X-Received: by 2002:a02:a812:: with SMTP id f18mr18139260jaj.1.1566077087546;
        Sat, 17 Aug 2019 14:24:47 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:46 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/8] SUNRPC: Don't handle errors if the bind/connect succeeded
Date:   Sat, 17 Aug 2019 17:22:13 -0400
Message-Id: <20190817212217.22766-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817212217.22766-3-trond.myklebust@hammerspace.com>
References: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
 <20190817212217.22766-2-trond.myklebust@hammerspace.com>
 <20190817212217.22766-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Don't handle errors in call_bind_status()/call_connect_status()
if it turns out that a previous call caused it to succeed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v5.1+
---
 net/sunrpc/clnt.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d8679b6027e9..92c1c4e02855 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1970,6 +1970,7 @@ call_bind(struct rpc_task *task)
 static void
 call_bind_status(struct rpc_task *task)
 {
+	struct rpc_xprt *xprt = task->tk_rqstp->rq_xprt;
 	int status = -EIO;
 
 	if (rpc_task_transmitted(task)) {
@@ -1977,14 +1978,13 @@ call_bind_status(struct rpc_task *task)
 		return;
 	}
 
-	if (task->tk_status >= 0) {
-		dprint_status(task);
-		task->tk_status = 0;
+	dprint_status(task);
+	trace_rpc_bind_status(task);
+	if (task->tk_status >= 0 || xprt_bound(xprt)) {
 		task->tk_action = call_connect;
 		return;
 	}
 
-	trace_rpc_bind_status(task);
 	switch (task->tk_status) {
 	case -ENOMEM:
 		dprintk("RPC: %5u rpcbind out of memory\n", task->tk_pid);
@@ -2043,7 +2043,6 @@ call_bind_status(struct rpc_task *task)
 
 	rpc_call_rpcerror(task, status);
 	return;
-
 retry_timeout:
 	task->tk_status = 0;
 	task->tk_action = call_bind;
@@ -2090,6 +2089,7 @@ call_connect(struct rpc_task *task)
 static void
 call_connect_status(struct rpc_task *task)
 {
+	struct rpc_xprt *xprt = task->tk_rqstp->rq_xprt;
 	struct rpc_clnt *clnt = task->tk_client;
 	int status = task->tk_status;
 
@@ -2099,8 +2099,15 @@ call_connect_status(struct rpc_task *task)
 	}
 
 	dprint_status(task);
-
 	trace_rpc_connect_status(task);
+
+	if (task->tk_status == 0) {
+		clnt->cl_stats->netreconn++;
+		goto out_next;
+	}
+	if (xprt_connected(xprt))
+		goto out_next;
+
 	task->tk_status = 0;
 	switch (status) {
 	case -ECONNREFUSED:
@@ -2131,13 +2138,12 @@ call_connect_status(struct rpc_task *task)
 	case -EAGAIN:
 	case -ETIMEDOUT:
 		goto out_retry;
-	case 0:
-		clnt->cl_stats->netreconn++;
-		task->tk_action = call_transmit;
-		return;
 	}
 	rpc_call_rpcerror(task, status);
 	return;
+out_next:
+	task->tk_action = call_transmit;
+	return;
 out_retry:
 	/* Check for timeouts before looping back to call_bind */
 	task->tk_action = call_bind;
-- 
2.21.0

