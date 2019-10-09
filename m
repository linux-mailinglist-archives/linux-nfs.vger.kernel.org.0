Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2BD14E5
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfJIRHb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 13:07:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42236 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 13:07:31 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so6606570iod.9;
        Wed, 09 Oct 2019 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R+veZFw5uLnQWWdDzkaXSVH6JXa3tUr8mmWEO/GcUJs=;
        b=NFrl/zSZfSX0RzpfvNZUD9WmTwB1XbeVmOJIieGoFJ7T/7ZCnAwP3gLifhDab5DkVh
         k9GoI01ynXEk3HDpZkFaL7c8N5A8VWnYyaxWEUvnL8EvZ9AzQ7ZAz11vgaDOMVT/0Scg
         Uql1v7m/hd2axOZwU8YW23kO3hKWCLt7TqeyrpTN6JWUhOtSyFpvr7HVv0SovEHIi87R
         PmmeVkZqp+G01Md3qocrEX7qM2CMPJO2uzw3CWle5SE8KPCPyGLOJG10eOfXQQ/AmbMx
         4Ik0fJQDlEu5SY6mlDiHmGalVeWvorLsFqBvPIQUKTT63kIGM+UhU3taUQSLAlH6C/oh
         JXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=R+veZFw5uLnQWWdDzkaXSVH6JXa3tUr8mmWEO/GcUJs=;
        b=ARi5NGZD6+EpR1/IkWRdbBnTRN2yVLEXUgtEXlGt/+uetckLXiWvz/buEYC0C9/lHV
         Uog5kMbFVZgSvr//mOGlLCxiN+qg+bB0ymibnqn8gGxu+EFkgOxDC32Z1Y38GcXo1bEK
         PY5tZaBwcf3fC5mMo3bzhy9LitjPR1IL0uzm1mqrKG4AsOppqd8QL8rTH52SYjdeebaI
         zDJL/ori2eEdZXLVQd/qru1GJWIt4IpZS5RhHutp3DUv2TnMaxqbJLJQY8Li0NU2nTUG
         a8kcqQjmYKq3wPH/TUM6kIbXYhV4KyZFs7JFvY+k6vUOMpC/A8iF4epgtLOBb9jBYz/9
         r+6g==
X-Gm-Message-State: APjAAAVLrfpr4WG4XEO+GuglrUozKMg3LJZOx5jEgl/tUMMisrHyFAE5
        +xwfwcwH2JRr+ni5BqmdbO86H/Lt
X-Google-Smtp-Source: APXvYqznnvo18JlVkrZpqe51Mpn5zzZtGWKc5wAoJzwLv0r08d8Yggix7ldhbAGikdrPn0acUt+lqg==
X-Received: by 2002:a02:aa0b:: with SMTP id r11mr4349590jam.26.1570640848606;
        Wed, 09 Oct 2019 10:07:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h4sm1336763iom.17.2019.10.09.10.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:07:28 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99H7RhO001492;
        Wed, 9 Oct 2019 17:07:27 GMT
Subject: [PATCH v1 2/6] xprtrdma: Connection becomes unstable after a
 reconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 13:07:27 -0400
Message-ID: <20191009170727.2978.14774.stgit@manet.1015granger.net>
In-Reply-To: <20191009170721.2978.128.stgit@manet.1015granger.net>
References: <20191009170721.2978.128.stgit@manet.1015granger.net>
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
index 3a90753..f4b1365 100644
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
@@ -780,6 +781,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 	trace_xprtrdma_disconnect(r_xprt, rc);
 
 	rpcrdma_xprt_drain(r_xprt);
+	rpcrdma_reqs_reset(r_xprt);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
@@ -1042,6 +1044,26 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
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

