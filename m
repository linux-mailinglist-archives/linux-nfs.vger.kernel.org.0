Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E586D71FF8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfGWTOA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 15:14:00 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39851 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfGWTOA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jul 2019 15:14:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id u3so29625487vsh.6;
        Tue, 23 Jul 2019 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mCFR2IQNm0hmioLVOd7QF/xJfVRtWFkovxZJz2yC7AU=;
        b=kghJOur2nzo23SRl91iCsTz2CjZTC1wGF6CEwLnGg2mcWP4nqZdK2clgIQN65Cg0dH
         6dWW6CgwPIfvcr+K0hjDuMU9SupACSGDGyzsXaqFFACM7Ta00flpJ0L9W8romd9Cp1yX
         lgrGGuUPYT88AHImPcytWvhg/4qaAt6TK6QI06uJQvtIBzTPv99KOrclKTOA4e7lS/Xq
         vpI2bvzjlA+o2VBhfCYN6HESRPlu1INeMvsg4mVVOzq69ZDUFyA+c264iXb3hWR7eEYq
         a+pLa6EIpOby+4ffhrQ7Ve8i6oXc3hQJXkS/4Sf7oxbIqRn9/tl19JtfaaHgw6wLTb+i
         f+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mCFR2IQNm0hmioLVOd7QF/xJfVRtWFkovxZJz2yC7AU=;
        b=H1pCc3vsNuZpmIbHObqco6H/Lu96VH4g1Nj8eMGeMMQgfRIRHBAvY6pJdJ/OoNdoeX
         BLQI81dyiLTpea9LcWLmKh4rkkhrvlau/WjpS/DSZfgIzi0dSctEet23iw52EasY4nPK
         Yd77HNPO6P4Fe0q99jJIfdYOCnXowPhTfycMu46E2A1F6GEFEQHr30ivKJmhhEciaQCB
         M9Bh010cAQ5nxAL5n9kdTZG0R2ShQa6deBLVP5K5I0b5vFQf3eZUNnaqsQpXKDQU6S7M
         3t+qjqXmHBoREx3wbDRGdK7FiGhqYIgxnFeIcBaVFALDl0WgUzUz2kM74bC8AKTp44Kp
         Bwxg==
X-Gm-Message-State: APjAAAUfvrlJU983VqZdTYcILMRp7dRdziFxqL7cDgtuXvijAUd9ZAoj
        rfSVUg1ON/EI+6qydOcwJP/FWB0o9WK8Ww==
X-Google-Smtp-Source: APXvYqyxG/2hpnYJeRDXmNuM0ujhurNc4eqen+D0JDOO8yhUGCACahyO/ghn4Gd3Miss4oXPjxwPrw==
X-Received: by 2002:a67:f75a:: with SMTP id w26mr45539455vso.148.1563909238532;
        Tue, 23 Jul 2019 12:13:58 -0700 (PDT)
Received: from seurat29.1015granger.net (dhcp-82c9.meeting.ietf.org. [31.133.130.201])
        by smtp.gmail.com with ESMTPSA id j80sm5541004vkj.47.2019.07.23.12.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 12:13:58 -0700 (PDT)
Subject: [PATCH v1] rdma: Enable ib_alloc_cq to spread work over a device's
 comp_vectors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 23 Jul 2019 15:13:37 -0400
Message-ID: <156390915496.6759.4305845732131573253.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
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
workload across available CPUs. For these ULPs, allow the RDMA core
to select a completion vector based on the device's complement of
available comp_vecs.

When a ULP elects to use RDMA_CORE_ANY_COMPVEC, if multiple CPUs are
available, a different CPU will be selected for each Completion
Queue. For the moment, a simple round-robin mechanism is used.

Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cq.c             |   20 +++++++++++++++++++-
 include/rdma/ib_verbs.h                  |    3 +++
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 ++++--
 net/sunrpc/xprtrdma/verbs.c              |    5 ++---
 4 files changed, 28 insertions(+), 6 deletions(-)

Jason-

If this patch is acceptable to all, then I would expect you to take
it through the RDMA tree.


diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 7c599878ccf7..a89d549490c4 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -165,12 +165,27 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 	queue_work(cq->comp_wq, &cq->work);
 }
 
+/*
+ * Attempt to spread ULP completion queues over a device's completion
+ * vectors so that all available CPU cores can help service the device's
+ * interrupt workload. This mechanism may be improved at a later point
+ * to dynamically take into account the system's actual workload.
+ */
+static int ib_get_comp_vector(struct ib_device *dev)
+{
+	static atomic_t cv;
+
+	if (dev->num_comp_vectors > 1)
+		return atomic_inc_return(&cv) % dev->num_comp_vectors;
+	return 0;
+}
+
 /**
  * __ib_alloc_cq_user - allocate a completion queue
  * @dev:		device to allocate the CQ for
  * @private:		driver private data, accessible from cq->cq_context
  * @nr_cqe:		number of CQEs to allocate
- * @comp_vector:	HCA completion vectors for this CQ
+ * @comp_vector:	HCA completion vector for this CQ
  * @poll_ctx:		context to poll the CQ from.
  * @caller:		module owner name.
  * @udata:		Valid user data or NULL for kernel object
@@ -208,6 +223,9 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	cq->res.type = RDMA_RESTRACK_CQ;
 	rdma_restrack_set_task(&cq->res, caller);
 
+	if (comp_vector == RDMA_CORE_ANY_COMPVEC)
+		cq_attr.comp_vector = ib_get_comp_vector(dev);
+
 	ret = dev->ops.create_cq(cq, &cq_attr, NULL);
 	if (ret)
 		goto out_free_wc;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c5f8a9f17063..547d36bcef7e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3669,6 +3669,9 @@ static inline int ib_post_recv(struct ib_qp *qp,
 	return qp->device->ops.post_recv(qp, recv_wr, bad_recv_wr ? : &dummy);
 }
 
+/* Tell the RDMA core to select an appropriate comp_vector */
+#define RDMA_CORE_ANY_COMPVEC	((int)(-1))
+
 struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 				 int nr_cqe, int comp_vector,
 				 enum ib_poll_context poll_ctx,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3fe665152d95..7df6de6e9162 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -455,13 +455,15 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 	}
 	newxprt->sc_sq_cq = ib_alloc_cq(dev, newxprt, newxprt->sc_sq_depth,
-					0, IB_POLL_WORKQUEUE);
+					RDMA_CORE_ANY_COMPVEC,
+					IB_POLL_WORKQUEUE);
 	if (IS_ERR(newxprt->sc_sq_cq)) {
 		dprintk("svcrdma: error creating SQ CQ for connect request\n");
 		goto errout;
 	}
 	newxprt->sc_rq_cq = ib_alloc_cq(dev, newxprt, rq_depth,
-					0, IB_POLL_WORKQUEUE);
+					RDMA_CORE_ANY_COMPVEC,
+					IB_POLL_WORKQUEUE);
 	if (IS_ERR(newxprt->sc_rq_cq)) {
 		dprintk("svcrdma: error creating RQ CQ for connect request\n");
 		goto errout;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 805b1f35e1ca..6e5989e2b8ed 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -523,8 +523,7 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 	sendcq = ib_alloc_cq(ia->ri_id->device, NULL,
 			     ep->rep_attr.cap.max_send_wr + 1,
-			     ia->ri_id->device->num_comp_vectors > 1 ? 1 : 0,
-			     IB_POLL_WORKQUEUE);
+			     RDMA_CORE_ANY_COMPVEC, IB_POLL_WORKQUEUE);
 	if (IS_ERR(sendcq)) {
 		rc = PTR_ERR(sendcq);
 		goto out1;
@@ -532,7 +531,7 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 	recvcq = ib_alloc_cq(ia->ri_id->device, NULL,
 			     ep->rep_attr.cap.max_recv_wr + 1,
-			     0, IB_POLL_WORKQUEUE);
+			     RDMA_CORE_ANY_COMPVEC, IB_POLL_WORKQUEUE);
 	if (IS_ERR(recvcq)) {
 		rc = PTR_ERR(recvcq);
 		goto out2;

