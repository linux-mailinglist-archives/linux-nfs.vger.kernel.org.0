Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6706439AE78
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 01:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCXB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 19:01:59 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:37491 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCXB7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 19:01:59 -0400
Received: by mail-qt1-f180.google.com with SMTP id z4so2609547qts.4
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9/bK+BrZI+CvpPuTxzlZKcrMOYWFH6TlB5Awi0+0VI=;
        b=VrwvoBxZtI1n5fYafcK2MWgadthXtzHCnbDMXsDog704vjWW4ydK9ec3cli7YsfQRo
         esN3jUz/d5rt6JhQs09UYlooeRokGYYTO4uMVNMolB3VrxxKw5W2o6cv/XPwg6DHKpZz
         3vzqPF73Ho8htMvgIC5CVxb2/WguhRaB9c67CkqpqB0tyQIQnUMixdvOjVSnumiijcZT
         Nd1ov7M2sVgXj+F6eYO+RU0vKM4tPWDm3fajNNVcdo18V80XGaQ3TwdTFsRSH7Mwrp+Q
         lq7tFTimbZCPW63hs7SVQus1n6iXH210Fk3JSHOfVwCUwjnKdKL5qLHR3jJfSTAvJdvi
         mTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9/bK+BrZI+CvpPuTxzlZKcrMOYWFH6TlB5Awi0+0VI=;
        b=GfS5LefX0WtkahEMPSwI78T1QoUvQmJYWyEzt3HTunCrZ8M8D3DSVbpNQXRREGN+py
         8WVxBnM8AG3mIQPpqx3f75ZfhDoJeqDKs2SVM5C+HVmKIrZl6Mh276aJztXj3gtXzZM7
         Ldo5SbIds491KvqNgInYR3Z6ssLAlv1fNYIVYxdY2ffWGlGwgRToE3EnpKbPiQMUEWNW
         ls+3QyNCGuhSjuaWC0O8VQ8xwI2zqumaXrwlTpcXaX9+wWz2YEOqLLx+ghRAa9Hi7jh7
         Ilxc5t1U9VoLSGqMKEqOYA2OIQ2b3j/yEIn6ejLr1PHCQ/PeQ0lkjaSEfY+2/n3j4rEN
         bsMA==
X-Gm-Message-State: AOAM532kYTw5nAp7kguD+PKKddovSDvZXsKn+IbvMkq+oUoCUG7OC2eS
        EKS07YG3X9V8rizhoyAKC3aepaojnv0=
X-Google-Smtp-Source: ABdhPJxO+b7TeKGCbKTUIgxK+Se3ffVISCipesrFKl52FGXazWEeQGF90/GUq6LyAaALa4rDjgu0sQ==
X-Received: by 2002:ac8:5c8e:: with SMTP id r14mr1896687qta.248.1622761153575;
        Thu, 03 Jun 2021 15:59:13 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id h19sm1479497qtq.5.2021.06.03.15.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:59:13 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 3/3] sunrpc: remove an offlined xprt using sysfs
Date:   Thu,  3 Jun 2021 18:59:07 -0400
Message-Id: <20210603225907.19981-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
References: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Once a transport has been put offline, this transport can be also
removed from the list of transports. Any tasks that have been stuck
on this transport would find the next available active transport
and be re-tried. This transport would be removed from the xprt_switch
list and freed.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/clnt.c           | 20 ++++++++++++++++++++
 net/sunrpc/sysfs.c          | 18 ++++++++++++++----
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 72a858f032c7..c2ecf5cc3802 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -428,6 +428,7 @@ void			xprt_release_write(struct rpc_xprt *, struct rpc_task *);
 #define XPRT_BINDING		(5)
 #define XPRT_CLOSING		(6)
 #define XPRT_OFFLINE		(7)
+#define XPRT_REMOVE		(8)
 #define XPRT_CONGESTED		(9)
 #define XPRT_CWND_WAIT		(10)
 #define XPRT_WRITE_SPACE	(11)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 408618765aa5..36040ec53404 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2106,6 +2106,26 @@ call_connect_status(struct rpc_task *task)
 	case -ENOTCONN:
 	case -EAGAIN:
 	case -ETIMEDOUT:
+		if (!(task->tk_flags & RPC_TASK_NO_ROUND_ROBIN) &&
+		    (task->tk_flags & RPC_TASK_MOVEABLE) &&
+		    test_bit(XPRT_REMOVE, &xprt->state)) {
+			struct rpc_xprt *saved = task->tk_xprt;
+			struct rpc_xprt_switch *xps;
+
+			rcu_read_lock();
+			xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+			rcu_read_unlock();
+			if (xps->xps_nactive > 1) {
+				xprt_release(task);
+				xprt_put(saved);
+				rpc_xprt_switch_remove_xprt(xps, saved);
+				task->tk_xprt = NULL;
+				task->tk_action = call_start;
+			}
+			xprt_switch_put(xps);
+			if (!task->tk_xprt)
+				return;
+		}
 		goto out_retry;
 	case -ENOBUFS:
 		rpc_delay(task, HZ >> 2);
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 02c918c5061b..44a69638c55f 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -118,7 +118,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 	int locked, connected, connecting, close_wait, bound, binding,
-	    closing, congested, cwnd_wait, write_space, offline;
+	    closing, congested, cwnd_wait, write_space, offline, remove;
 
 	if (!xprt)
 		return 0;
@@ -137,8 +137,9 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 		cwnd_wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
 		write_space = test_bit(XPRT_WRITE_SPACE, &xprt->state);
 		offline = test_bit(XPRT_OFFLINE, &xprt->state);
+		remove = test_bit(XPRT_REMOVE, &xprt->state);
 
-		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s %s\n",
+		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s %s %s\n",
 			      locked ? "LOCKED" : "",
 			      connected ? "CONNECTED" : "",
 			      connecting ? "CONNECTING" : "",
@@ -149,7 +150,8 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 			      congested ? "CONGESTED" : "",
 			      cwnd_wait ? "CWND_WAIT" : "",
 			      write_space ? "WRITE_SPACE" : "",
-			      offline ? "OFFLINE" : "");
+			      offline ? "OFFLINE" : "",
+			      remove ? "REMOVE" : "");
 	}
 
 	xprt_put(xprt);
@@ -230,13 +232,15 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 					   const char *buf, size_t count)
 {
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
-	int offline = 0;
+	int offline = 0, remove = 0;
 
 	if (!xprt)
 		return 0;
 
 	if (!strncmp(buf, "offline", 7))
 		offline = 1;
+	else if (!strncmp(buf, "remove", 6))
+		remove = 1;
 	else
 		return -EINVAL;
 
@@ -249,6 +253,12 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 			count = -EINVAL;
 		else
 			set_bit(XPRT_OFFLINE, &xprt->state);
+	} else if (remove) {
+		if (!test_bit(XPRT_CONNECTED, &xprt->state) &&
+		    test_bit(XPRT_OFFLINE, &xprt->state))
+			set_bit(XPRT_REMOVE, &xprt->state);
+		else
+			count = -EINVAL;
 	}
 
 	xprt_release_write(xprt, NULL);
-- 
2.27.0

