Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584B812FAD8
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgACQwZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:52:25 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36155 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:52:25 -0500
Received: by mail-yb1-f194.google.com with SMTP id w126so16945091yba.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2020 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rXiIYT7cfNWtLb99yIcbO3RwkHeET8RunTTH+yoGcQ4=;
        b=WWTAGc7Opngpc5j7520gv+PS8KRq03i+4PewTRCcJ22VttU6EP/9hcequQme4ndPqr
         mCt5YDeaLhzXJwjaA/EL2QiTh46YqoTbqFg8LW+Ba+4agVvR3mCdufSAb2i4SP8R46sJ
         UoK2F/0O6DvoGdhLJBFHlo3G9HeJmbUq9gK2LxYqLtDnoPzvh/FwuN2kLV8igyooXZUZ
         XjLE3wdIq2LneObU5rnKjsQFRBzDm8/mU3xuOnMcfrgs/WkyIo8jni92t38ByYTiKeaF
         AUf68J0/RGx56yesdC/uARpt35+q1ZP6hg1e1UItmQPVCKQ+KNGoCpTSzEm3JibwPoj8
         MCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=rXiIYT7cfNWtLb99yIcbO3RwkHeET8RunTTH+yoGcQ4=;
        b=lCiNwqJxFxYVy7c+MVxOsgBoZV0a0TE+OtjHNkoLcS5i6rzqM000Ty5jPlU9H6ePcq
         04VIATfSNwHSgf2dJT+/Gac9uJAZ++QGy/pWTKsgKOsOMSeU2pmrCEyF/xRAp0B74rDq
         JuAtwEkhqvahARmP7fkdAWKd0mBrAxOYlbMiZsiZXMU6UCfNdSldbUB2AOdNEFG901zy
         XVBiq5uvXASZ8wM07L7E/GnN6ASpC8jHSOM0Pr6FruHhH773/HD/MDx9l4NsI3RWhobr
         1Go6+3MOzTD3RYSt6ZJL/7n6qNtIq5bg0pR9EsdnRy6ewCWDxaxFyQpSQYxLLgRN7GpH
         yFhQ==
X-Gm-Message-State: APjAAAUxnX4zh/kE5K5Bkg3TRiq7Tg/gfDyosMewirt7Ds7pUFLxKHwk
        o0N7j71gNVFWbNOF6g32QBB72k8C
X-Google-Smtp-Source: APXvYqz7S+trXZvsnI+ZUX9ysD0G0pBena1esKywCszx9tEwmkvVqGDFs0LXNJ3Rb+4TFNCXSuWuNA==
X-Received: by 2002:a25:a2c2:: with SMTP id c2mr63804115ybn.246.1578070344153;
        Fri, 03 Jan 2020 08:52:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g190sm23629820ywf.41.2020.01.03.08.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:52:23 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GqM4A016375;
        Fri, 3 Jan 2020 16:52:22 GMT
Subject: [PATCH 3/3] xprtrdma: Fix oops in Receive handler after device
 removal
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:52:22 -0500
Message-ID: <157807034285.3637.1107321602862156718.stgit@morisot.1015granger.net>
In-Reply-To: <157807026361.3637.2531475820164100233.stgit@morisot.1015granger.net>
References: <157807026361.3637.2531475820164100233.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since v5.4, a device removal occasionally triggered this oops:

Dec  2 17:13:53 manet kernel: BUG: unable to handle page fault for address: 0000000c00000219
Dec  2 17:13:53 manet kernel: #PF: supervisor read access in kernel mode
Dec  2 17:13:53 manet kernel: #PF: error_code(0x0000) - not-present page
Dec  2 17:13:53 manet kernel: PGD 0 P4D 0
Dec  2 17:13:53 manet kernel: Oops: 0000 [#1] SMP
Dec  2 17:13:53 manet kernel: CPU: 2 PID: 468 Comm: kworker/2:1H Tainted: G        W         5.4.0-00050-g53717e43af61 #883
Dec  2 17:13:53 manet kernel: Hardware name: Supermicro SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
Dec  2 17:13:53 manet kernel: Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
Dec  2 17:13:53 manet kernel: RIP: 0010:rpcrdma_wc_receive+0x7c/0xf6 [rpcrdma]
Dec  2 17:13:53 manet kernel: Code: 6d 8b 43 14 89 c1 89 45 78 48 89 4d 40 8b 43 2c 89 45 14 8b 43 20 89 45 18 48 8b 45 20 8b 53 14 48 8b 30 48 8b 40 10 48 8b 38 <48> 8b 87 18 02 00 00 48 85 c0 75 18 48 8b 05 1e 24 c4 e1 48 85 c0
Dec  2 17:13:53 manet kernel: RSP: 0018:ffffc900035dfe00 EFLAGS: 00010246
Dec  2 17:13:53 manet kernel: RAX: ffff888467290000 RBX: ffff88846c638400 RCX: 0000000000000048
Dec  2 17:13:53 manet kernel: RDX: 0000000000000048 RSI: 00000000f942e000 RDI: 0000000c00000001
Dec  2 17:13:53 manet kernel: RBP: ffff888467611b00 R08: ffff888464e4a3c4 R09: 0000000000000000
Dec  2 17:13:53 manet kernel: R10: ffffc900035dfc88 R11: fefefefefefefeff R12: ffff888865af4428
Dec  2 17:13:53 manet kernel: R13: ffff888466023000 R14: ffff88846c63f000 R15: 0000000000000010
Dec  2 17:13:53 manet kernel: FS:  0000000000000000(0000) GS:ffff88846fa80000(0000) knlGS:0000000000000000
Dec  2 17:13:53 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec  2 17:13:53 manet kernel: CR2: 0000000c00000219 CR3: 0000000002009002 CR4: 00000000001606e0
Dec  2 17:13:53 manet kernel: Call Trace:
Dec  2 17:13:53 manet kernel: __ib_process_cq+0x5c/0x14e [ib_core]
Dec  2 17:13:53 manet kernel: ib_cq_poll_work+0x26/0x70 [ib_core]
Dec  2 17:13:53 manet kernel: process_one_work+0x19d/0x2cd
Dec  2 17:13:53 manet kernel: ? cancel_delayed_work_sync+0xf/0xf
Dec  2 17:13:53 manet kernel: worker_thread+0x1a6/0x25a
Dec  2 17:13:53 manet kernel: ? cancel_delayed_work_sync+0xf/0xf
Dec  2 17:13:53 manet kernel: kthread+0xf4/0xf9
Dec  2 17:13:53 manet kernel: ? kthread_queue_delayed_work+0x74/0x74
Dec  2 17:13:53 manet kernel: ret_from_fork+0x24/0x30

The proximal cause is that this rpcrdma_rep has a rr_rdmabuf that
is still pointing to the old ib_device, which has been freed. The
only way that is possible is if this rpcrdma_rep was not destroyed
by rpcrdma_ia_remove.

Debugging showed that was indeed the case: this rpcrdma_rep was
still in use by a completing RPC at the time of the device removal,
and thus wasn't on the rep free list. So, it was not found by
rpcrdma_reps_destroy().

The fix is to introduce a list of all rpcrdma_reps so that they all
can be found when a device is removed. That list is used to perform
only regbuf DMA unmapping, replacing that call to
rpcrdma_reps_destroy().

Meanwhile, to prevent corruption of this list, I've moved the
destruction of temp rpcrdma_rep objects to rpcrdma_post_recvs().
rpcrdma_xprt_drain() ensures that post_recvs (and thus rep_destroy) is
not invoked while rpcrdma_reps_unmap is walking rb_all_reps, thus
protecting the rb_all_reps list.

Fixes: b0b227f071a0 ("xprtrdma: Use an llist to manage free rpcrdma_reps")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |   25 +++++++++++++++++++------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2c40465a19e1..fda3889993cb 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -77,7 +77,7 @@
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
-static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
+static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
 static struct rpcrdma_regbuf *
@@ -421,7 +421,7 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 	/* The ULP is responsible for ensuring all DMA
 	 * mappings and MRs are gone.
 	 */
-	rpcrdma_reps_destroy(buf);
+	rpcrdma_reps_unmap(r_xprt);
 	list_for_each_entry(req, &buf->rb_allreqs, rl_all) {
 		rpcrdma_regbuf_dma_unmap(req->rl_rdmabuf);
 		rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
@@ -1092,6 +1092,7 @@ static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	rep->rr_recv_wr.sg_list = &rep->rr_rdmabuf->rg_iov;
 	rep->rr_recv_wr.num_sge = 1;
 	rep->rr_temp = temp;
+	list_add(&rep->rr_all, &r_xprt->rx_buf.rb_all_reps);
 	return rep;
 
 out_free:
@@ -1102,6 +1103,7 @@ static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 
 static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
 {
+	list_del(&rep->rr_all);
 	rpcrdma_regbuf_free(rep->rr_rdmabuf);
 	kfree(rep);
 }
@@ -1120,10 +1122,16 @@ static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct rpcrdma_buffer *buf)
 static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
 			    struct rpcrdma_rep *rep)
 {
-	if (!rep->rr_temp)
-		llist_add(&rep->rr_node, &buf->rb_free_reps);
-	else
-		rpcrdma_rep_destroy(rep);
+	llist_add(&rep->rr_node, &buf->rb_free_reps);
+}
+
+static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
+{
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	struct rpcrdma_rep *rep;
+
+	list_for_each_entry(rep, &buf->rb_all_reps, rr_all)
+		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
 }
 
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
@@ -1154,6 +1162,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 
 	INIT_LIST_HEAD(&buf->rb_send_bufs);
 	INIT_LIST_HEAD(&buf->rb_allreqs);
+	INIT_LIST_HEAD(&buf->rb_all_reps);
 
 	rc = -ENOMEM;
 	for (i = 0; i < buf->rb_max_requests; i++) {
@@ -1506,6 +1515,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	wr = NULL;
 	while (needed) {
 		rep = rpcrdma_rep_get_locked(buf);
+		if (rep && rep->rr_temp) {
+			rpcrdma_rep_destroy(rep);
+			continue;
+		}
 		if (!rep)
 			rep = rpcrdma_rep_create(r_xprt, temp);
 		if (!rep)
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 5d15140a0266..d796d68609ed 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -203,6 +203,7 @@ struct rpcrdma_rep {
 	struct xdr_stream	rr_stream;
 	struct llist_node	rr_node;
 	struct ib_recv_wr	rr_recv_wr;
+	struct list_head	rr_all;
 };
 
 /* To reduce the rate at which a transport invokes ib_post_recv
@@ -368,6 +369,7 @@ struct rpcrdma_buffer {
 
 	struct list_head	rb_allreqs;
 	struct list_head	rb_all_mrs;
+	struct list_head	rb_all_reps;
 
 	struct llist_head	rb_free_reps;
 


