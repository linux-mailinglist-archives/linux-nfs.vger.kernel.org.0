Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA417D14E7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfJIRHg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 13:07:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41887 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRHg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 13:07:36 -0400
Received: by mail-io1-f67.google.com with SMTP id n26so6621550ioj.8;
        Wed, 09 Oct 2019 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+2MlgiRc3Dhzscg9dsXGedOrjDQX3x+rEItIK/b1K2s=;
        b=b4giwvtU9Mo9btJMUW6pRnhvkcbABjDHiSZGPqPEa04GurvT0dauoRNUdRzS0R1xVn
         S7/n0zQhYuSoXI6CnF8cl2tiA6ZS4aF4cMOWHgfI7vRc2489PmbKO6oyRm8WvHNfFd+j
         bpmVYxXkX1vEBQK423BTOhppXPDKMfVjxATfeJdeM0DK8szWO92xnkvZVmX2OVLBfF/p
         7WdQYXL0Ad4omFemXCQFRBMAuI2Jpq4w7QQzCI5D3qn3kEYxV/p9jk7w11kyw5VTNjss
         n4NZet7iD0eotWumR51jfcCN3cAxNDGnbWCo/UC3P5PQqmGPMPX4wIvAwlSewqN9DsZj
         CppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+2MlgiRc3Dhzscg9dsXGedOrjDQX3x+rEItIK/b1K2s=;
        b=AhnJInq3GR9yr/ivTHF7Ipd+3QwuM0ibtxoYWvYoLo9xY9T7DJxLDWk8RY+IXGl2IM
         8trlaYM8RPsfdt1hehzgixmlzOmT8kONrUSxjwNY8FNPSfI7TO4w93GV+9QnsHnkxwCS
         sZAYPSlIwn6YmOC6gEJZwxF4GmhIolJdtNhs3iXHjTpcTDGe8VpOVx5NEGubYrMFbBhy
         U6OtKbmXuYfVuKJSWFucHmwyljJ0sJ1yPTNJ6xaVvaG6iBIVPnqTQU3qk43bNQ5X6bIE
         MP6D27piXKMRke55bQKZ901VIY/JvrAhDB+kheGYyGxGrqnmeIfOtKzivZVQJmbiGDBh
         2LOw==
X-Gm-Message-State: APjAAAVfp64aogRaeWsV6U19ese1kpmE/Gipeg143AeQPeWEIGX22cia
        qGIjUvLgJBUs4uFG3DAr3dFziy1z
X-Google-Smtp-Source: APXvYqz0kCITGHU0cyilHwZ+C6iFwZQHpHZBOjN60Edtz8uPApSnqa9m+AxINW1qefu+V1bIrBMgjQ==
X-Received: by 2002:a6b:b54c:: with SMTP id e73mr4594933iof.259.1570640853790;
        Wed, 09 Oct 2019 10:07:33 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a25sm1096357iod.62.2019.10.09.10.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:07:33 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99H7WE2001495;
        Wed, 9 Oct 2019 17:07:32 GMT
Subject: [PATCH v1 3/6] xprtrdma: Initialize rb_credits in one place
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 13:07:32 -0400
Message-ID: <20191009170732.2978.21414.stgit@manet.1015granger.net>
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

Clean up/code de-duplication.

Nit: RPC_CWNDSHIFT is incorrect as the initial value for xprt->cwnd.
This mistake does not appear to have operational consequences, since
the cwnd value is replaced with a valid value upon the first Receive
completion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |   42 +++++++++++++++++++++++++++++++++------
 net/sunrpc/xprtrdma/transport.c |    9 --------
 net/sunrpc/xprtrdma/verbs.c     |    2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index b86b5fd..f1e3639 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -916,6 +916,40 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	return ret;
 }
 
+static void __rpcrdma_update_cwnd_locked(struct rpc_xprt *xprt,
+					 struct rpcrdma_buffer *buf,
+					 u32 grant)
+{
+	buf->rb_credits = grant;
+	xprt->cwnd = grant << RPC_CWNDSHIFT;
+}
+
+static void rpcrdma_update_cwnd(struct rpcrdma_xprt *r_xprt, u32 grant)
+{
+	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+
+	spin_lock(&xprt->transport_lock);
+	__rpcrdma_update_cwnd_locked(xprt, &r_xprt->rx_buf, grant);
+	spin_unlock(&xprt->transport_lock);
+}
+
+/**
+ * rpcrdma_reset_cwnd - Reset the xprt's congestion window
+ * @r_xprt: controlling transport instance
+ *
+ * Prepare @r_xprt for the next connection by reinitializing
+ * its credit grant to one (see RFC 8166, Section 3.3.3).
+ */
+void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt)
+{
+	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+
+	spin_lock(&xprt->transport_lock);
+	xprt->cong = 0;
+	__rpcrdma_update_cwnd_locked(xprt, &r_xprt->rx_buf, 1);
+	spin_unlock(&xprt->transport_lock);
+}
+
 /**
  * rpcrdma_inline_fixup - Scatter inline received data into rqst's iovecs
  * @rqst: controlling RPC request
@@ -1356,12 +1390,8 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		credits = 1;	/* don't deadlock */
 	else if (credits > buf->rb_max_requests)
 		credits = buf->rb_max_requests;
-	if (buf->rb_credits != credits) {
-		spin_lock(&xprt->transport_lock);
-		buf->rb_credits = credits;
-		xprt->cwnd = credits << RPC_CWNDSHIFT;
-		spin_unlock(&xprt->transport_lock);
-	}
+	if (buf->rb_credits != credits)
+		rpcrdma_update_cwnd(r_xprt, credits);
 
 	req = rpcr_to_rdmar(rqst);
 	if (req->rl_reply) {
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index c67d465..0711308 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -425,15 +425,6 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 		return;
 	rpcrdma_ep_disconnect(ep, ia);
 
-	/* Prepare @xprt for the next connection by reinitializing
-	 * its credit grant to one (see RFC 8166, Section 3.3.3).
-	 */
-	spin_lock(&xprt->transport_lock);
-	r_xprt->rx_buf.rb_credits = 1;
-	xprt->cong = 0;
-	xprt->cwnd = RPC_CWNDSHIFT;
-	spin_unlock(&xprt->transport_lock);
-
 out:
 	xprt->reestablish_timeout = 0;
 	++xprt->connect_cookie;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index f4b1365..97bc15e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -727,6 +727,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 	ep->rep_connected = 0;
 	xprt_clear_connected(xprt);
 
+	rpcrdma_reset_cwnd(r_xprt);
 	rpcrdma_post_recvs(r_xprt, true);
 
 	rc = rdma_connect(ia->ri_id, &ep->rep_remote_cma);
@@ -1163,7 +1164,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 		list_add(&req->rl_list, &buf->rb_send_bufs);
 	}
 
-	buf->rb_credits = 1;
 	init_llist_head(&buf->rb_free_reps);
 
 	rc = rpcrdma_sendctxs_create(r_xprt);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 65e6b0e..b170cf5 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -576,6 +576,7 @@ int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc);
 int rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst);
 void rpcrdma_set_max_header_sizes(struct rpcrdma_xprt *);
+void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_complete_rqst(struct rpcrdma_rep *rep);
 void rpcrdma_reply_handler(struct rpcrdma_rep *rep);
 

