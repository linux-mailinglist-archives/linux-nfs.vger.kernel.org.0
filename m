Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB80E9D4BA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfHZRM7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 13:12:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33695 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfHZRM7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 13:12:59 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so39163661iog.0;
        Mon, 26 Aug 2019 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EmA8Pt9k4ctmz/aV8eavE1ECUTo3QhbykSiR5VH4SRc=;
        b=N7U42xHolsO+uCXckGUfZhdSzeGLQqP1/pJjX4M5UE2XVK7oQw5e9rTunKTHa1krTX
         4JbZzQFsZjzi5ifikkDAmPLXEUPrQIxS/Ql9lSae2sYRBJXbRU49PbCQH02opn7dXkaT
         UWQutu5DmOgJd6EPrAWnzW944VFck7EUqr5/4U7tHK12j1Anpx6rY/345QHSsiFsPn6S
         fafnSZ+ZL0CMwiHxbtcru0dZBUaVeT6p2mmrFAW8HLKf0pobYbbggfGn0wWch2TClnnH
         IcWzFKJ4AMeRlxL7YuS+QMJfJWnHIopgtZPwGChw8V81LMACK6adyuA4wFX/xTo4wgdb
         B2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EmA8Pt9k4ctmz/aV8eavE1ECUTo3QhbykSiR5VH4SRc=;
        b=ENdEKaU6/6CTBYmvdqYwN6g3bHgyHubWVlIdGdZw04db8Jlc7ujWesPVFD6lXa78UQ
         2YhMRgoIVi0y85Eq6M7Twk2iv7h4wyWm3UCPKz6a7ZePKasv68Yxmy0PwrX4SYZGjrkF
         qytLIU+8Mw7BnJ5c5pXq5AG3TDpd5LEomDBxa2ND7LbdLNfJXB/4Rb0y5C7vymXJVdLr
         eNQj6Hkir2eH592loujVbA69eC6mMnsq7A8BouXths+cN/1Ux5Or7CVsZEziIx5MdKKz
         /NrRYUu5Rmohwnf0exPmXeZ4OLNb/1fY3ogyODpFsnh/I5wejKONEeuegyaIiXrGIoWr
         uIRg==
X-Gm-Message-State: APjAAAW0EDF19pLtW29Rj/I4YHeypcEJk2MNoC1QvWuaiBBuCms5uZfK
        SvC96QcDIBxcEG61RoGfv5Y=
X-Google-Smtp-Source: APXvYqx1l90O8qGhET2Wj5C/9RHATifdYMPOaUpkERsPswHsWM9MYbzGrNuYdiB0G4skzSel99znfA==
X-Received: by 2002:a6b:fd19:: with SMTP id c25mr3822003ioi.267.1566839578335;
        Mon, 26 Aug 2019 10:12:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r2sm10029912ioh.61.2019.08.26.10.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 10:12:58 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x7QHCv2t031327;
        Mon, 26 Aug 2019 17:12:57 GMT
Subject: [PATCH 3/3] xprtrdma: Send Queue size grows after a reconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 26 Aug 2019 13:12:57 -0400
Message-ID: <20190826171257.4841.70242.stgit@manet.1015granger.net>
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

Eli Dorfman reports that after a series of idle disconnects, an
RPC/RDMA transport becomes unusable (rdma_create_qp returns
-ENOMEM). Problem was tracked down to increasing Send Queue size
after each reconnect.

The rdma_create_qp() API does not promise to leave its @qp_init_attr
parameter unaltered. In fact, some drivers do modify one or more of
its fields. Thus our calls to rdma_create_qp must use a fresh copy
of ib_qp_init_attr each time.

This fix is appropriate for kernels dating back to late 2007, though
it will have to be adapted, as the connect code has changed over the
years.

Reported-by: Eli Dorfman <eli@vastdata.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1dadc9e..7969457 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -606,10 +606,10 @@ void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
  * Unlike a normal reconnection, a fresh PD and a new set
  * of MRs and buffers is needed.
  */
-static int
-rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt,
-			 struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
+static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt,
+				    struct ib_qp_init_attr *qp_init_attr)
 {
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	int rc, err;
 
 	trace_xprtrdma_reinsert(r_xprt);
@@ -626,7 +626,7 @@ void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 	}
 
 	rc = -ENETUNREACH;
-	err = rdma_create_qp(ia->ri_id, ia->ri_pd, &ep->rep_attr);
+	err = rdma_create_qp(ia->ri_id, ia->ri_pd, qp_init_attr);
 	if (err) {
 		pr_err("rpcrdma: rdma_create_qp returned %d\n", err);
 		goto out3;
@@ -643,16 +643,16 @@ void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 	return rc;
 }
 
-static int
-rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt, struct rpcrdma_ep *ep,
-		     struct rpcrdma_ia *ia)
+static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
+				struct ib_qp_init_attr *qp_init_attr)
 {
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rdma_cm_id *id, *old;
 	int err, rc;
 
 	trace_xprtrdma_reconnect(r_xprt);
 
-	rpcrdma_ep_disconnect(ep, ia);
+	rpcrdma_ep_disconnect(&r_xprt->rx_ep, ia);
 
 	rc = -EHOSTUNREACH;
 	id = rpcrdma_create_id(r_xprt, ia);
@@ -674,7 +674,7 @@ void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 		goto out_destroy;
 	}
 
-	err = rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
+	err = rdma_create_qp(id, ia->ri_pd, qp_init_attr);
 	if (err)
 		goto out_destroy;
 
@@ -699,25 +699,27 @@ void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_xprt *r_xprt = container_of(ia, struct rpcrdma_xprt,
 						   rx_ia);
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+	struct ib_qp_init_attr qp_init_attr;
 	int rc;
 
 retry:
+	memcpy(&qp_init_attr, &ep->rep_attr, sizeof(qp_init_attr));
 	switch (ep->rep_connected) {
 	case 0:
 		dprintk("RPC:       %s: connecting...\n", __func__);
-		rc = rdma_create_qp(ia->ri_id, ia->ri_pd, &ep->rep_attr);
+		rc = rdma_create_qp(ia->ri_id, ia->ri_pd, &qp_init_attr);
 		if (rc) {
 			rc = -ENETUNREACH;
 			goto out_noupdate;
 		}
 		break;
 	case -ENODEV:
-		rc = rpcrdma_ep_recreate_xprt(r_xprt, ep, ia);
+		rc = rpcrdma_ep_recreate_xprt(r_xprt, &qp_init_attr);
 		if (rc)
 			goto out_noupdate;
 		break;
 	default:
-		rc = rpcrdma_ep_reconnect(r_xprt, ep, ia);
+		rc = rpcrdma_ep_reconnect(r_xprt, &qp_init_attr);
 		if (rc)
 			goto out;
 	}

