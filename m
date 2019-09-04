Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC7A8993
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2019 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfIDPef (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 11:34:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33530 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfIDPef (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Sep 2019 11:34:35 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so13154003ioo.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Sep 2019 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KeqwnwdKLgt7jCjdzXiOwV9Z95dYZoP60wd8ejp1j+I=;
        b=a2/Urt2e8ufEzA+TDjXv76p7u5gfrX8Kk9qoRHqxw+Fk9PW3S3eh0NjVBx2b2eRAvD
         NaqiavgkKuOhEucazNUl8Ux+txz/5ynS5+8evYIqQKEZbP2fKnyIZUajzMlT9pEkjZ0+
         R/qg4TBTUsS/L8oF2t+r2SeYkfzBzymJ0cbJsGjuRFUjmxY7Ca/oHdJVqmJVmUPjeCo4
         kXRDhJIQaq4n81CAU/WphLWmpkrsdC5pJHACzn0812is8Z1JkcgNiCmyAuWR80Bw9e+H
         SNdLjEaK1OMb6FC7ETDZEZMAfybWS0jwBgCgU6PGIKPJqbgIITDrF6zOsFq6iWUOkQqH
         FFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KeqwnwdKLgt7jCjdzXiOwV9Z95dYZoP60wd8ejp1j+I=;
        b=n57Ogp8U0t3RLpMiQACSrGFDo4PCF4a/07Kb4peM/c4pDaXpY0K5EZL/RCx+7pQXjb
         ekewCUc/ct84cnZyTaHsh4AO0lWkLk7CRY2v9M2g60eHOYgy1+5bwjuMUAbGlKq2imdW
         h0Nf+26TpCZVOF3OvdD51ulv/lsPgTZ0xZy5yvcLUBZKjJ+1+7BRRQtWvraiImgOZHGj
         Y/dliWz4v2SfyUyHriuP2uZ/gNsRrOtmMZUkYo5zpu2zJxUPHZ7N7FO+sF0I/dkf4qjh
         RCxISnS66Vvl7OoqYhL4Qf9g0kFKNDdH7ur+UWZjretneq7R8wYzA/W+0QDhvDL+FSwi
         GYag==
X-Gm-Message-State: APjAAAXicvh6pabFyzVkEiAAKFtcV+GVzE27SRot2Mj5QB8Yf6XsjKtg
        hyNmgQZ7VKk2AMHkla4624s=
X-Google-Smtp-Source: APXvYqwXpCdFWIZBJ1RqUgTZysshqtzWJbf+Qr9GVBwK7D+0hHIy29+YX/DAd5blN5hjr4lwmMF7hg==
X-Received: by 2002:a05:6602:2492:: with SMTP id g18mr2633580ioe.266.1567611274132;
        Wed, 04 Sep 2019 08:34:34 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e139sm10967588iof.60.2019.09.04.08.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 08:34:33 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x84FYUc4024235;
        Wed, 4 Sep 2019 15:34:31 GMT
Subject: [PATCH RFC] xprtrdma: Connection becomes unstable after a reconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 04 Sep 2019 11:34:30 -0400
Message-ID: <20190904152755.3784.29689.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is because xprt_request_get_cong() is allowing more than one
RPC Call to be transmitted before the first Receive on the new
connection. The first Receive fills the Receive Queue based on the
server's credit grant. Before that Receive, there is only a single
Receive WR posted because the client doesn't know the server's
credit grant.

Solution is to clear rq_cong on all outstanding rpc_rqsts when the
the cwnd is reset. This is because an RPC/RDMA credit is good for
one connection instance only.

Fixes: 75891f502f5f ("SUNRPC: Support for congestion control ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    3 +++
 net/sunrpc/xprtrdma/verbs.c     |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

Hey Anna, Trond-

Please consider this fix for the v5.4 merge window. It addresses
misbehavior I've observed locally with disconnect injection
testing.

Trond, I'm especially interested in your take here, as author of
75891f502f5f. I understand how rq_cong is used for a connectionless
transport like UDP, but I'm not sure it is meaningful for a
transport where the congestion credit is valid for only one
connection instance.


diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 160558b..c67d465 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -428,8 +428,11 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 	/* Prepare @xprt for the next connection by reinitializing
 	 * its credit grant to one (see RFC 8166, Section 3.3.3).
 	 */
+	spin_lock(&xprt->transport_lock);
 	r_xprt->rx_buf.rb_credits = 1;
+	xprt->cong = 0;
 	xprt->cwnd = RPC_CWNDSHIFT;
+	spin_unlock(&xprt->transport_lock);
 
 out:
 	xprt->reestablish_timeout = 0;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 7969457..65f78d6 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -75,6 +75,7 @@
  * internal functions
  */
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_sendctx *sc);
+static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
@@ -781,6 +782,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 	trace_xprtrdma_disconnect(r_xprt, rc);
 
 	rpcrdma_xprt_drain(r_xprt);
+	rpcrdma_reqs_reset(r_xprt);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
@@ -1043,6 +1045,26 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	return NULL;
 }
 
+/**
+ * rpcrdma_reqs_reset - Reset all reqs owned by a transport
+ * @r_xprt: controlling transport instance
+ *
+ * ASSUMPTION: the rb_allreqs list is stable for the duration,
+ * and thus can be walked without holding rb_lock. Eg. the
+ * caller is holding the transport send lock to exclude
+ * device removal or disconnection.
+ */
+static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
+{
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	struct rpcrdma_req *req;
+
+	list_for_each_entry(req, &buf->rb_allreqs, rl_all) {
+		/* Credits are valid only for one connection */
+		req->rl_slot.rq_cong = 0;
+	}
+}
+
 static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 					      bool temp)
 {

