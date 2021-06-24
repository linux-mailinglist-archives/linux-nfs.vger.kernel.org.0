Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294D3B257D
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFXDbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFXDbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3069FC061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:05 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k16so6100680ios.10
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHBCy9w3wXSZMZ1zRa/auMjewfvBPVGOk6hJ8eHii8c=;
        b=UV0UJrBhLakck9qC+n+xG00ki+whU4F+nwBDx/xmdxQKfZmSh/3eMPau4wBGzsuNkz
         AIAnxsp1MUdoiX0OGRfn/d7wyIflMLpjcqfeJ09c66O1TbhHRPOnnYiNrE6ylUaSOZof
         frxRE9s2Wjef4JPVgsl4samq8GriBvGuSWf7jiwJzvJxEXUrb1Iiz70/i+FD/gLVsdGr
         voCRYT7afOBM4/cLknwDPizsjNS9p0ESqR2pFyWCv2FuyQRPy5sI/ptmafGT8GNA21RX
         AkkUY/WLLUJUahVwWnaW8PNvRUEMP3Lh39xmazIhMpKlZduoVEqC49wJ1Mbx4GeD6KwO
         Vaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHBCy9w3wXSZMZ1zRa/auMjewfvBPVGOk6hJ8eHii8c=;
        b=TaO+ntETd3Jis0dTOL1q9RneQTguiRcwf3dbSeBBLskox24wUWd0eJzOin/OQDwXh2
         HWd3rU5OhBPYnHVceMOsxieD+HYWqs+ATFcLXdMqm5R2iIA1jxtSzy3PMeWQ1lrQEyML
         mIYO4wQEwthZBUnwTc521+baPT2DTQpMV2IuEMRMo6s4drsG9JfGZbmT2RZBnTHNLsPD
         +RKhQ8UsepAhi4v6R+eq6WkL8MuneQiAbHjD5fkSEXOTT0i9lwEQGSBD5km75o9ilnyM
         wCzulJl0LD74TIyCQVkRF7JS3KcMv8bWHeVfp+vvY4wg7anxl/IUO3zC89ZecfU2C5Wr
         8pTg==
X-Gm-Message-State: AOAM531s8T7PxxoGbNQ54nDT36k6JNcDHRrt07M3Y3jchCF7g6cKkh+8
        MZw6EgEke53ZTmhuXHRZisjRrADAcA0oQA==
X-Google-Smtp-Source: ABdhPJwGlotvefyTNIi/IWFiztLGCD9jtABKv6bf+Lct45beoAFjgFrGAp5bHkkHIFRWp419QQunvA==
X-Received: by 2002:a6b:4418:: with SMTP id r24mr2272875ioa.123.1624505344638;
        Wed, 23 Jun 2021 20:29:04 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.29.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:29:04 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 8/8] sunrpc: remove an offlined xprt using sysfs
Date:   Wed, 23 Jun 2021 23:28:53 -0400
Message-Id: <20210624032853.4776-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/clnt.c           | 24 ++++++++++++++++++++++++
 net/sunrpc/sysfs.c          | 26 ++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index b8ed7fa1b4ca..c8c39f22d3b1 100644
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
index 7ca946567e13..f8ec29b06d0d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2106,6 +2106,30 @@ call_connect_status(struct rpc_task *task)
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
+			if (xps->xps_nxprts > 1) {
+				long value;
+
+				xprt_release(task);
+				value = atomic_long_dec_return(&xprt->queuelen);
+				if (value == 0)
+					rpc_xprt_switch_remove_xprt(xps, saved);
+				xprt_put(saved);
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
index 754bd010ea29..34b60db5321f 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -133,7 +133,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 	int locked, connected, connecting, close_wait, bound, binding,
-	    closing, congested, cwnd_wait, write_space, offline;
+	    closing, congested, cwnd_wait, write_space, offline, remove;
 
 	if (!xprt)
 		return 0;
@@ -152,8 +152,9 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 		cwnd_wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
 		write_space = test_bit(XPRT_WRITE_SPACE, &xprt->state);
 		offline = test_bit(XPRT_OFFLINE, &xprt->state);
+		remove = test_bit(XPRT_REMOVE, &xprt->state);
 
-		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s %s\n",
+		ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s %s %s %s\n",
 			      locked ? "LOCKED" : "",
 			      connected ? "CONNECTED" : "",
 			      connecting ? "CONNECTING" : "",
@@ -164,7 +165,8 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 			      congested ? "CONGESTED" : "",
 			      cwnd_wait ? "CWND_WAIT" : "",
 			      write_space ? "WRITE_SPACE" : "",
-			      offline ? "OFFLINE" : "");
+			      offline ? "OFFLINE" : "",
+			      remove ? "REMOVE" : "");
 	}
 
 	xprt_put(xprt);
@@ -253,7 +255,7 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 					   const char *buf, size_t count)
 {
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
-	int offline = 0, online = 0;
+	int offline = 0, online = 0, remove = 0;
 	struct rpc_xprt_switch *xps = rpc_sysfs_xprt_kobj_get_xprt_switch(kobj);
 
 	if (!xprt)
@@ -263,6 +265,8 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 		offline = 1;
 	else if (!strncmp(buf, "online", 6))
 		online = 1;
+	else if (!strncmp(buf, "remove", 6))
+		remove = 1;
 	else
 		return -EINVAL;
 
@@ -284,6 +288,20 @@ static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
 		spin_lock(&xps->xps_lock);
 		xps->xps_nactive++;
 		spin_unlock(&xps->xps_lock);
+	} else if (remove) {
+		if (test_bit(XPRT_OFFLINE, &xprt->state)) {
+			set_bit(XPRT_REMOVE, &xprt->state);
+			xprt_force_disconnect(xprt);
+			if (test_bit(XPRT_CONNECTED, &xprt->state)) {
+				if (!xprt->sending.qlen &&
+				    !xprt->pending.qlen &&
+				    !xprt->backlog.qlen &&
+				    !atomic_long_read(&xprt->queuelen))
+					rpc_xprt_switch_remove_xprt(xps, xprt);
+			}
+		} else {
+			count = -EINVAL;
+		}
 	}
 
 release_tasks:
-- 
2.27.0

