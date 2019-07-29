Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7ED791F9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 19:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfG2RWN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 13:22:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42216 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2RWN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jul 2019 13:22:13 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so91350180iob.9;
        Mon, 29 Jul 2019 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=R7WM1mP9dHKgOvOOeHJvri8jBS7JjQUoOhPlHTRSHgg=;
        b=E8Tw2LfGWL1MYb2alpqHiKjnCQ9ss3826ZpOOvVPlOsrZE1TL8exkSYAlqgE8RKaid
         dLTlSzJ7VwLg/YUTsElDFpA3VEamJa/4KMrSsqr71fuXlfZz0yM+6ncMRQscKFoDuj+S
         fO+TuFhC22BrXLIWjGin2fkyv/p0ymOVtqrU6K7YB0R2HcKAXv52oRh0ae9tlOkb2wgT
         F+uZwceS2AXvPhZcTU2p3Ns5lHbiB/SHEHyb/jRqTSDyEELJenV5bBMlOvduvmnJ8rCU
         HaLAiG3TzxRL1uoZHJnNRrrgaIIcso5nu78cTxVXkLjrueuECPQoVO++GsRakgsy1bCR
         /uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=R7WM1mP9dHKgOvOOeHJvri8jBS7JjQUoOhPlHTRSHgg=;
        b=lKqARy7MewKap8/MW1YJTzesLeJ8oL9MPZPrvSna/W+Epl1bRIlTeAqZvbbcs3sRtQ
         Cmqp1LtyIHtW/5MLstUUOkoH3rJlO+zEzIBcb7lfUXat4KwsAKd3N/F2QP0ywzVyE0Vk
         9gfNfckI4YTfsVmNSLy1n5995UFSO3c/NpIrB4u6UPp8ixsNOnDleka+PTH4JOQ8Lthu
         /6VRz0udsR/GFpKebNLX6cau5eC79Oi9gkJgDIyOkAKitqGhlwy7CS7HJ1ZxjCrt7NdO
         8kxt4xlWgY/5E11wqKRzWrg7KyaSMHtCkOYdlIol5zI6xNG8yA0FtjdBMeZiIE/najxF
         I4Dw==
X-Gm-Message-State: APjAAAVICKfZS1NNQ6tWqFxQKNyukdvC8JdkvXv02Y+fLdjpHhCv5mav
        czFjtW4/BI97rVwhRbkgHsAt5LCd
X-Google-Smtp-Source: APXvYqwKTpgTv/56WMJr6rLdGnXUng6esUGd9p/w4LSMWGEyEWHK0UMcN/nd5nncRfpanYf1awBbIQ==
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr105992933iod.134.1564420931583;
        Mon, 29 Jul 2019 10:22:11 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x22sm44926014ioh.87.2019.07.29.10.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 10:22:10 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x6THM9qk004036;
        Mon, 29 Jul 2019 17:22:09 GMT
Subject: [PATCH v3] rdma: Enable ib_alloc_cq to spread work over a device's
 comp_vectors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Date:   Mon, 29 Jul 2019 13:22:09 -0400
Message-ID: <20190729171923.13428.52555.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Send and Receive completion is handled on a single CPU selected at
the time each Completion Queue is allocated. Typically this is when
an initiator instantiates an RDMA transport, or when a target
accepts an RDMA connection.

Some ULPs cannot open a connection per CPU to spread completion
workload across available CPUs and MSI vectors. For such ULPs,
provide an API that allows the RDMA core to select a completion
vector based on the device's complement of available comp_vecs.

ULPs that invoke ib_alloc_cq() with only comp_vector 0 are converted
to use the new API so that their completion workloads interfere less
with each other.

Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Cc: <linux-cifs@vger.kernel.org>
Cc: <v9fs-developer@lists.sourceforge.net>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    8 ++++----
 net/sunrpc/xprtrdma/verbs.c              |   13 ++++++-------
 2 files changed, 10 insertions(+), 11 deletions(-)

Changes since v2:
- Reviewed-by tag added
- Fix initialization of comp_vector value
- Clarify comments based on review

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 7c59987..bbfded6 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -253,6 +253,34 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 EXPORT_SYMBOL(__ib_alloc_cq_user);
 
 /**
+ * __ib_alloc_cq_any - allocate a completion queue
+ * @dev:		device to allocate the CQ for
+ * @private:		driver private data, accessible from cq->cq_context
+ * @nr_cqe:		number of CQEs to allocate
+ * @poll_ctx:		context to poll the CQ from
+ * @caller:		module owner name
+ *
+ * Attempt to spread ULP Completion Queues over each device's interrupt
+ * vectors. A simple best-effort mechanism is used.
+ */
+struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
+				int nr_cqe, enum ib_poll_context poll_ctx,
+				const char *caller)
+{
+	static atomic_t counter;
+	int comp_vector = 0;
+
+	if (dev->num_comp_vectors > 1)
+		comp_vector =
+			atomic_inc_return(&counter) %
+			min_t(int, dev->num_comp_vectors, num_online_cpus());
+
+	return __ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, poll_ctx,
+				  caller, NULL);
+}
+EXPORT_SYMBOL(__ib_alloc_cq_any);
+
+/**
  * ib_free_cq_user - free a completion queue
  * @cq:		completion queue to free.
  * @udata:	User data or NULL for kernel object
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 1a039f1..e25c70a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1767,8 +1767,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 		goto out;
 
 retry:
-	ch->cq = ib_alloc_cq(sdev->device, ch, ch->rq_size + sq_size,
-			0 /* XXX: spread CQs */, IB_POLL_WORKQUEUE);
+	ch->cq = ib_alloc_cq_any(sdev->device, ch, ch->rq_size + sq_size,
+				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(ch->cq)) {
 		ret = PTR_ERR(ch->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index cd07e53..3c91fa9 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1654,15 +1654,17 @@ static struct smbd_connection *_smbd_get_connection(
 
 	info->send_cq = NULL;
 	info->recv_cq = NULL;
-	info->send_cq = ib_alloc_cq(info->id->device, info,
-			info->send_credit_target, 0, IB_POLL_SOFTIRQ);
+	info->send_cq =
+		ib_alloc_cq_any(info->id->device, info,
+				info->send_credit_target, IB_POLL_SOFTIRQ);
 	if (IS_ERR(info->send_cq)) {
 		info->send_cq = NULL;
 		goto alloc_cq_failed;
 	}
 
-	info->recv_cq = ib_alloc_cq(info->id->device, info,
-			info->receive_credit_max, 0, IB_POLL_SOFTIRQ);
+	info->recv_cq =
+		ib_alloc_cq_any(info->id->device, info,
+				info->receive_credit_max, IB_POLL_SOFTIRQ);
 	if (IS_ERR(info->recv_cq)) {
 		info->recv_cq = NULL;
 		goto alloc_cq_failed;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c5f8a9f..2a1523cc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3711,6 +3711,25 @@ static inline struct ib_cq *ib_alloc_cq(struct ib_device *dev, void *private,
 				NULL);
 }
 
+struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
+				int nr_cqe, enum ib_poll_context poll_ctx,
+				const char *caller);
+
+/**
+ * ib_alloc_cq_any: Allocate kernel CQ
+ * @dev: The IB device
+ * @private: Private data attached to the CQE
+ * @nr_cqe: Number of CQEs in the CQ
+ * @poll_ctx: Context used for polling the CQ
+ */
+static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
+					    void *private, int nr_cqe,
+					    enum ib_poll_context poll_ctx)
+{
+	return __ib_alloc_cq_any(dev, private, nr_cqe, poll_ctx,
+				 KBUILD_MODNAME);
+}
+
 /**
  * ib_free_cq_user - Free kernel/user CQ
  * @cq: The CQ to free
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index bac8dad..b21c3c2 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -685,9 +685,9 @@ static int p9_rdma_bind_privport(struct p9_trans_rdma *rdma)
 		goto error;
 
 	/* Create the Completion Queue */
-	rdma->cq = ib_alloc_cq(rdma->cm_id->device, client,
-			opts.sq_depth + opts.rq_depth + 1,
-			0, IB_POLL_SOFTIRQ);
+	rdma->cq = ib_alloc_cq_any(rdma->cm_id->device, client,
+				   opts.sq_depth + opts.rq_depth + 1,
+				   IB_POLL_SOFTIRQ);
 	if (IS_ERR(rdma->cq))
 		goto error;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3fe6651..4d3db6e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -454,14 +454,14 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		dprintk("svcrdma: error creating PD for connect request\n");
 		goto errout;
 	}
-	newxprt->sc_sq_cq = ib_alloc_cq(dev, newxprt, newxprt->sc_sq_depth,
-					0, IB_POLL_WORKQUEUE);
+	newxprt->sc_sq_cq = ib_alloc_cq_any(dev, newxprt, newxprt->sc_sq_depth,
+					    IB_POLL_WORKQUEUE);
 	if (IS_ERR(newxprt->sc_sq_cq)) {
 		dprintk("svcrdma: error creating SQ CQ for connect request\n");
 		goto errout;
 	}
-	newxprt->sc_rq_cq = ib_alloc_cq(dev, newxprt, rq_depth,
-					0, IB_POLL_WORKQUEUE);
+	newxprt->sc_rq_cq =
+		ib_alloc_cq_any(dev, newxprt, rq_depth, IB_POLL_WORKQUEUE);
 	if (IS_ERR(newxprt->sc_rq_cq)) {
 		dprintk("svcrdma: error creating RQ CQ for connect request\n");
 		goto errout;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 805b1f35..b10aa16 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -521,18 +521,17 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	init_waitqueue_head(&ep->rep_connect_wait);
 	ep->rep_receive_count = 0;
 
-	sendcq = ib_alloc_cq(ia->ri_id->device, NULL,
-			     ep->rep_attr.cap.max_send_wr + 1,
-			     ia->ri_id->device->num_comp_vectors > 1 ? 1 : 0,
-			     IB_POLL_WORKQUEUE);
+	sendcq = ib_alloc_cq_any(ia->ri_id->device, NULL,
+				 ep->rep_attr.cap.max_send_wr + 1,
+				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(sendcq)) {
 		rc = PTR_ERR(sendcq);
 		goto out1;
 	}
 
-	recvcq = ib_alloc_cq(ia->ri_id->device, NULL,
-			     ep->rep_attr.cap.max_recv_wr + 1,
-			     0, IB_POLL_WORKQUEUE);
+	recvcq = ib_alloc_cq_any(ia->ri_id->device, NULL,
+				 ep->rep_attr.cap.max_recv_wr + 1,
+				 IB_POLL_WORKQUEUE);
 	if (IS_ERR(recvcq)) {
 		rc = PTR_ERR(recvcq);
 		goto out2;

