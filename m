Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316969D4B3
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfHZRMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 13:12:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46079 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbfHZRMy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 13:12:54 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so39003082ioj.12;
        Mon, 26 Aug 2019 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RQoJN2hvBY//xO9E8IV63DB37M6yExeRmnmKSd8OfME=;
        b=BfAOARIPMmED0WF1WvGs55/Cn3kILmsJEyAIdmkIeBTRRq+kThoPer9IhjWzsPvnFY
         17XfRJAWM2nSpTCahsTtt5dOrjkcI/FUHZ9i9EEhPvVx3m9RmBCvnVDPN9PrEM2tQxgx
         7vXdY8bUa/CbQA9bCZbuUhY6796XjXC5a9DJlPRTHgZah+Sek7lgxOTPOH0fQ9opK5nD
         YuVYDay01h/YgB8PUt6vCLhVH6WjhZk7zPdmIIe/9afecgL6OEDSADs3OLu+vY/u24p1
         uxd0WjNpWTe9x3CAPtmahccJQFqOh9DB4QrcWIZ0MKRq1ISmwB8wXI+FGGMgASTauNDf
         S1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RQoJN2hvBY//xO9E8IV63DB37M6yExeRmnmKSd8OfME=;
        b=ksLZWcxj8QzRrLxe3rUqm1TACUs/6mNWFrgpxjxjLa9NbomVOfsW40oB+UJwccXrKR
         iylu+HC+so20TAANl+BT4WaT+d0ms9gXLBkwOnd4DIaoZq0Uby4jX30OuduqAXT9hnf7
         93sb5XW6DS0UzNX+IlvIWhy0h2GNIhrCd4pssLdp0CJ5vEV0ad+j6ceL7F0uSCRkW4ky
         6pHNimte0pvbOs+eiwe26KM52vYW/djOAEc9zRfVkWlC2Mg0NmT94ZVS6cvtssg0OCA5
         jL5E8J4fkhE96HdhMVQ13SYstJracNFOnMLhblGut1/K++fkESaEKXNQzSnKTJmPoa2K
         +/Hg==
X-Gm-Message-State: APjAAAWP12gVlSq0Foup/QAlnykgo5fHY5qAZHDKjS2Q+GuzboR9Tg3N
        oqMtTdMuycpRsOav4yfWb9w=
X-Google-Smtp-Source: APXvYqxawTgUNb3Bhn/VRgA36NTdiLGiNkSnkgRbbhMRxLMJmYxnvK0qtqB1bkTSXZw+I2PEipm0FA==
X-Received: by 2002:a5e:8f4d:: with SMTP id x13mr9054867iop.118.1566839573203;
        Mon, 26 Aug 2019 10:12:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q5sm11416146iot.5.2019.08.26.10.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 10:12:52 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x7QHCpJj031323;
        Mon, 26 Aug 2019 17:12:51 GMT
Subject: [PATCH 2/3] xprtrdma: Clear xprt->reestablish_timeout on close
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 26 Aug 2019 13:12:51 -0400
Message-ID: <20190826171251.4841.25254.stgit@manet.1015granger.net>
In-Reply-To: <20190826171107.4841.41733.stgit@manet.1015granger.net>
References: <20190826171107.4841.41733.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that the re-establishment delay does not grow exponentially
on each good reconnect. This probably should have been part of
commit 675dd90ad093 ("xprtrdma: Modernize ops->connect").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    8 ++++++--
 net/sunrpc/xprtrdma/transport.c |    3 +--
 net/sunrpc/xprtrdma/verbs.c     |    2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 19dd29a..b86b5fd 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1261,8 +1261,6 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	struct rpc_rqst *rqst = rep->rr_rqst;
 	int status;
 
-	xprt->reestablish_timeout = 0;
-
 	switch (rep->rr_proc) {
 	case rdma_msg:
 		status = rpcrdma_decode_msg(r_xprt, rep, rqst);
@@ -1321,6 +1319,12 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	u32 credits;
 	__be32 *p;
 
+	/* Any data means we had a useful conversation, so
+	 * then we don't need to delay the next reconnect.
+	 */
+	if (xprt->reestablish_timeout)
+		xprt->reestablish_timeout = 0;
+
 	/* Fixed transport header fields */
 	xdr_init_decode(&rep->rr_stream, &rep->rr_hdrbuf,
 			rep->rr_hdrbuf.head[0].iov_base, NULL);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 993b96f..160558b 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -423,8 +423,6 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 
 	if (ep->rep_connected == -ENODEV)
 		return;
-	if (ep->rep_connected > 0)
-		xprt->reestablish_timeout = 0;
 	rpcrdma_ep_disconnect(ep, ia);
 
 	/* Prepare @xprt for the next connection by reinitializing
@@ -434,6 +432,7 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 	xprt->cwnd = RPC_CWNDSHIFT;
 
 out:
+	xprt->reestablish_timeout = 0;
 	++xprt->connect_cookie;
 	xprt_disconnect_done(xprt);
 }
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index ac2abf4..1dadc9e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -731,6 +731,8 @@ void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out;
 
+	if (xprt->reestablish_timeout < RPCRDMA_INIT_REEST_TO)
+		xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
 	wait_event_interruptible(ep->rep_connect_wait, ep->rep_connected != 0);
 	if (ep->rep_connected <= 0) {
 		if (ep->rep_connected == -EAGAIN)

