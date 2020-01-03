Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A412FAEC
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgACQ5B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:57:01 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39577 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgACQ5B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:57:01 -0500
Received: by mail-yb1-f195.google.com with SMTP id b12so18840297ybg.6;
        Fri, 03 Jan 2020 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CF/aJ8+vnP2vj/nR80InQ8WZ6kBg+hhJmHh5njAIuJE=;
        b=D8MXXIN5rAV7ZM50WQXHH/88Doo998v83o0oC4YKhtDxqqWkdOxpjibLd0ryQHDRwY
         W4qRdAk0qlAR2z4IbimMc3rMV35u6Y6gtDg8w4M/KRPYS1jMb2SYDW9kohSe3qkx+M4S
         eVWoJ07nSMnwVT6B7j+9BqUklyxgyP32Cs5BW1NA+JQ6WwyJaXAU72qxW2aQ5qLcSlB4
         CrQ7nnwpfdNTeVOdSsBzraIzgs+xHoKgymtguswNUmwLXwMAxLMkVWV9NqkLbBXtMOaQ
         QHKu0tCcPY+Fwc4lJ/thU5UwZqzWuwBsUQLRbUd4LVeRX+9iPEOs3UwmI819ZcsiG18M
         wnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CF/aJ8+vnP2vj/nR80InQ8WZ6kBg+hhJmHh5njAIuJE=;
        b=UkTqxyH8/Nzy0IyfKYi5saoNXgUxDBSZCzhLYSC19p9WBytjFsaANbROcfB2+81s1R
         4jzsBXJa86EOnRr0HFGurvNoAPyS/1zMrN7kMhR4HPQ88zeGrmamELEjyT5q2gHxYv2Y
         Kim30/nhBQXS+rXhFjum/j36XZSI8qorgAdRjteJ5uNflu929r7MKxzRH51Bz91ROtEn
         6ZtwAS+ZZAjbPS9vlCow10I0wTH9K5G3jlU4Ab5Kjhm4qME5XDUS1PU+nIUmnnUtoqZX
         UpYgTkX/3ZEFER9vr28czuF7i/70B91WPV+60A3LDS8ZdII0cXBEXkh6QS0cPLjK40/B
         V/OA==
X-Gm-Message-State: APjAAAX/1aP1RcOhL3F6v2bGuD46q0enm5SzIdef73GpdWsKM3XeNAJ2
        zTlfGgz7oGm442kdQl8bJMO/IOX2
X-Google-Smtp-Source: APXvYqzRrxSD8JfT4N1ugYaDCEf9rBprZIuypH69HdcXQidYNmVKhjBpxhTPLuiefS47EdIa33QL4Q==
X-Received: by 2002:a25:aab4:: with SMTP id t49mr62122149ybi.325.1578070620053;
        Fri, 03 Jan 2020 08:57:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w185sm23947286ywe.75.2020.01.03.08.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:59 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GuwWL016401;
        Fri, 3 Jan 2020 16:56:58 GMT
Subject: [PATCH v1 7/9] xprtrdma: Destroy rpcrdma_rep when Receive is flushed
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:58 -0500
Message-ID: <157807061881.4606.3320048417922431045.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This reduces the hardware and memory footprint of an unconnected
transport.

At some point in the future, transport reconnect will allow
resolving the destination IP address through a different device. The
current change enables reps for the new connection to be allocated
on whichever NUMA node the new device affines to after a reconnect.

Note that this does not destroy _all_ the transport's reps... there
will be a few that are still part of a running RPC completion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 7d06c6cd3d26..269df615a024 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -80,6 +80,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
 static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
+static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
@@ -177,7 +178,7 @@ rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	return;
 
 out_flushed:
-	rpcrdma_recv_buffer_put(rep);
+	rpcrdma_rep_destroy(rep);
 }
 
 static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
@@ -1105,6 +1106,9 @@ static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
 		rpcrdma_req_reset(req);
 }
 
+/* No locking needed here. This function is called only by the
+ * Receive completion handler.
+ */
 static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 					      bool temp)
 {
@@ -1137,6 +1141,9 @@ static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	return NULL;
 }
 
+/* No locking needed here. This function is invoked only by the
+ * Receive completion handler, or during transport shutdown.
+ */
 static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
 {
 	list_del(&rep->rr_all);


