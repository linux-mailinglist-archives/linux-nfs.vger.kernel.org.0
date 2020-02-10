Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736ED15835D
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBJTQI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:08 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37197 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBJTQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:08 -0500
Received: by mail-yw1-f66.google.com with SMTP id l5so3952827ywd.4
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DHtLO0P0Zh+VIrDFcyw7AYu4iOARJCtRd5zyI+nBa7U=;
        b=sL1kiPZbuQUD7GMMkSObcRQKjOtJUpRQMlgY2bTY5LAj22TX+Z6wooONERmedkCWIU
         uf4Gu7H6+zLVxgbRuNXOE753J3bdoTp67sGzPRY/UZSmhbMCpTqD5kKObOfc4wYi7vCj
         ZCVMLQZ/1h8bC9C6m9i3XClxUPyELkrf+YspgmiQ1+k9ozNdtGRj3H4rHS8uhs0V8wP7
         jIirKPm1BABM9a5YjcwUu5Jnqlkn/0wf0/kQ2YwQXDBamQnRUf7OTgEpDpcNAfJXSpy+
         R+TVLbrQrZlsVTKXoJtgVYt/VXKRHuHouTmaLANEfHngfNYOmPwDQZHEuvfG3U0B0vrG
         08TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHtLO0P0Zh+VIrDFcyw7AYu4iOARJCtRd5zyI+nBa7U=;
        b=WQQwMADrUEFciIVL+YaPXgxgj/l+fJ9ljB5KOW2uZl2QNfHQ2jKCSRfpDIWz+HtvUy
         GDC8IATQIOg0p5j2Qg2ktdlzHYpmUn0YG2/XxUUm5NzQqWIWOIk2T79x8iOJWzFAtplz
         nc8nytpnl9GGL4MF15tdIHdb5D8Iaashhqnt6L02dhMWHL59G4sE9yOTqTuOUkI0/eLo
         bBsWyBrlvBkH6oQU4fsl8j7dMXW/nBQNM/bhFBPvtLWDmAAYUWaKEzJ+aGv7r1vg2Lva
         aDMEGqyzPzFwFxfRDluMS3lVMTjbDUT1NuSkOSZ7DuhbOjKSGv+eLgMe6dVNFywGByt1
         o/mw==
X-Gm-Message-State: APjAAAWpCLDb0+mBl1byi1gywYQq6UwWFHDRWiq+YoUVrZ0+1MgLPR2S
        gNO0mKUnpvLONRnJ5wlzPvwHQQkA3g==
X-Google-Smtp-Source: APXvYqyZtdlHbuj7v9r6j3S6VJVR1MFa600geyb7YpLpTf8PTQuFHODF5UqquuGox+UxiARe5f/KgA==
X-Received: by 2002:a81:a642:: with SMTP id d63mr2367225ywh.202.1581362166768;
        Mon, 10 Feb 2020 11:16:06 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:06 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/8] SUNRPC: Add a flag to avoid reference counts on credentials
Date:   Mon, 10 Feb 2020 14:13:39 -0500
Message-Id: <20200210191345.557460-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210191345.557460-2-trond.myklebust@hammerspace.com>
References: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
 <20200210191345.557460-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a flag to signal to the RPC layer that the credential is already
pinned for the duration of the RPC call.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/sched.h | 1 +
 net/sunrpc/clnt.c            | 5 +++--
 net/sunrpc/sched.c           | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index a6ef35184ef1..df696efdd675 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -132,6 +132,7 @@ struct rpc_task_setup {
 #define RPC_TASK_TIMEOUT	0x1000		/* fail with ETIMEDOUT on timeout */
 #define RPC_TASK_NOCONNECT	0x2000		/* return ENOTCONN if not connected */
 #define RPC_TASK_NO_RETRANS_TIMEOUT	0x4000		/* wait forever for a reply */
+#define RPC_TASK_CRED_NOREF	0x8000		/* No refcount on the credential */
 
 #define RPC_IS_ASYNC(t)		((t)->tk_flags & RPC_TASK_ASYNC)
 #define RPC_IS_SWAPPER(t)	((t)->tk_flags & RPC_TASK_SWAPPER)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 7324b21f923e..2345e563c2f4 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1099,8 +1099,9 @@ rpc_task_set_rpc_message(struct rpc_task *task, const struct rpc_message *msg)
 		task->tk_msg.rpc_proc = msg->rpc_proc;
 		task->tk_msg.rpc_argp = msg->rpc_argp;
 		task->tk_msg.rpc_resp = msg->rpc_resp;
-		if (msg->rpc_cred != NULL)
-			task->tk_msg.rpc_cred = get_cred(msg->rpc_cred);
+		task->tk_msg.rpc_cred = msg->rpc_cred;
+		if (!(task->tk_flags & RPC_TASK_CRED_NOREF))
+			get_cred(task->tk_msg.rpc_cred);
 	}
 }
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 55e900255b0c..6eff14119a88 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1162,7 +1162,8 @@ static void rpc_release_resources_task(struct rpc_task *task)
 {
 	xprt_release(task);
 	if (task->tk_msg.rpc_cred) {
-		put_cred(task->tk_msg.rpc_cred);
+		if (!(task->tk_flags & RPC_TASK_CRED_NOREF))
+			put_cred(task->tk_msg.rpc_cred);
 		task->tk_msg.rpc_cred = NULL;
 	}
 	rpc_task_release_client(task);
-- 
2.24.1

