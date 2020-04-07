Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600E51A0F6E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgDGOjm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 10:39:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46709 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgDGOjm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 10:39:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id g74so1325558qke.13
        for <linux-nfs@vger.kernel.org>; Tue, 07 Apr 2020 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bEniR3Qv0ee0JUVrgDAOsWW+OJOabx3LY6SGg72vTLo=;
        b=qp88F1/uzb1d8Pmwmmsj38jMRvG+8ziPE+xlJ93zO9sdASzVR8cLKvGtgJGZQXKIjT
         4GLsZvx0BIL2WShW/qQvtAlM5UKoFj0DM035mziLH4h85gmeYiZX9xuTvLmG5nB0jl9t
         ltcMK7+7U30PNQr6tlS3492HBh/xxlaGqN2eVVU1xyTAIhyEaxH7Gkd+IopW+gk4TBW5
         jnYvSzgxl3eCkpTDL8UqPwaDyKcweorrjhqc5pTjgtWzK23Og3/dI3FE+rU50D637q0a
         vomd16ws2BNG6/pJFMqEHJH00ncUVzJhoyVvoTVvNVLZ/w/iEjIjt7+UBg7LGlJgDYIJ
         quDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bEniR3Qv0ee0JUVrgDAOsWW+OJOabx3LY6SGg72vTLo=;
        b=X08dr8Lhs6S5p5K3k+rfZCq9phCWe49zhSIorpz+xRKLf3Lkie01cSNBadfQkLB7gi
         QVWihziu4UO0pT9cnOGjVHtPHCBMku29Y3LmXkp2285fmpMkK9Hj4GJZ61aekEGtrSUk
         Dmg8cLnIx5IpCRGJ6MwqYgjlqWoLJiLdsvsIQoPBOGw9dtfeNHONxVcnsHGE5sj5lm06
         PL6vsEklgBhV9cLybkXDXvhS+OJBjjxk76OpCC1zg4kMCEVMVUFF7FtDu/RA0rj1VEoM
         zE1UuSWaqOBkKBbf2vqnv7B8HRToQgmYwNtpq/AjE84lZaua06fO7ABGeHh7+hRyBN0o
         N8uQ==
X-Gm-Message-State: AGi0Pub+NSZkpAJHtr420dMtq6Y2BvnNFG70GFBquGiv9QJJ+Szug+Jp
        OeG36ENc8o2KUMtSBDR6CWDwHoPn
X-Google-Smtp-Source: APiQypJC6wg67ii1VQmL5xgDjtebofnoNr9RIWaO9lNdxAz5959b2Ngc29VkhlSNMbEugSAQxq6O/w==
X-Received: by 2002:a37:bb01:: with SMTP id l1mr2512336qkf.37.1586270381267;
        Tue, 07 Apr 2020 07:39:41 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f14sm16485301qtp.55.2020.04.07.07.39.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 07:39:40 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 037Edc62009628
        for <linux-nfs@vger.kernel.org>; Tue, 7 Apr 2020 14:39:39 GMT
Subject: [PATCH v2] SUNRPC: Fix backchannel RPC soft lockups
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 07 Apr 2020 10:39:38 -0400
Message-ID: <20200407143502.2747.20020.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-8-g198f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, after the forward channel connection goes away,
backchannel operations are causing soft lockups on the server
because call_transmit_status's SOFTCONN logic ignores ENOTCONN.
Such backchannel Calls are aggressively retried until the client
reconnects.

Backchannel Calls should use RPC_TASK_NOCONNECT rather than
RPC_TASK_SOFTCONN. If there is no forward connection, the server is
not capable of establishing a connection back to the client, thus
that backchannel request should fail before the server attempts to
send it. Commit 58255a4e3ce5 ("NFSD: NFSv4 callback client should
use RPC_TASK_SOFTCONN") was merged several years before
RPC_TASK_NOCONNECT was available.

Because setup_callback_client() explicitly sets NOPING, the NFSv4.0
callback connection depends on the first callback RPC to initiate
a connection to the client. Thus NFSv4.0 needs to continue to use
RPC_TASK_SOFTCONN.

I'm not entirely certain when this behavior started, so I cannot
provide a precise Fixes tag.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c                     |    4 +++-
 net/sunrpc/svc_xprt.c                      |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 ++
 net/sunrpc/xprtsock.c                      |    1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

I spent considerable time introducing static trace points in the
server code to nail this down. I will post that work separately.
Anyway, the lockup fix is bigger than it used to be, but is still
not egregious.

I would like to include this fix in 5.7-rc. Comments?


diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c3b11a715082..5cf91322de0f 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1312,6 +1312,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 		container_of(work, struct nfsd4_callback, cb_work);
 	struct nfs4_client *clp = cb->cb_clp;
 	struct rpc_clnt *clnt;
+	int flags;
 
 	if (cb->cb_need_restart) {
 		cb->cb_need_restart = false;
@@ -1340,7 +1341,8 @@ nfsd4_run_cb_work(struct work_struct *work)
 	}
 
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
-	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
+	flags = clp->cl_minorversion ? RPC_TASK_NOCONNECT : RPC_TASK_SOFTCONN;
+	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,
 			cb->cb_ops ? &nfsd4_cb_ops : &nfsd4_cb_probe_ops, cb);
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 220ad0097b81..2284ff038dad 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1037,6 +1037,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 
 	dprintk("svc: svc_delete_xprt(%p)\n", xprt);
 	xprt->xpt_ops->xpo_detach(xprt);
+	if (xprt->xpt_bc_xprt)
+		xprt->xpt_bc_xprt->ops->close(xprt->xpt_bc_xprt);
 
 	spin_lock_bh(&serv->sv_lock);
 	list_del_init(&xprt->xpt_list);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index d510a3a15d4b..af7eb8d202ae 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -244,6 +244,8 @@ static void
 xprt_rdma_bc_close(struct rpc_xprt *xprt)
 {
 	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
+
+	xprt_disconnect_done(xprt);
 	xprt->cwnd = RPC_CWNDSHIFT;
 }
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 17cb902e5153..32ce45c70c52 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2584,6 +2584,7 @@ static int bc_send_request(struct rpc_rqst *req)
 
 static void bc_close(struct rpc_xprt *xprt)
 {
+	xprt_disconnect_done(xprt);
 }
 
 /*

