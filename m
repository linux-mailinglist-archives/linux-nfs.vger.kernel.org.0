Return-Path: <linux-nfs+bounces-18335-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGCeMeaecmm/ngAAu9opvQ
	(envelope-from <linux-nfs+bounces-18335-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A656E069
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 23:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FF8D301E7F3
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA23D4121;
	Thu, 22 Jan 2026 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4kBK4bU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D192C375E;
	Thu, 22 Jan 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119450; cv=none; b=jH4u6I2vOLfai6vG0pBZE9Gl0OrvEmpWWt1xZfj6n2e85Lvh71BzxKNK93/3Q5FMBWMsSc2sVM4ok1Ioew24eHJF9yiWOcUI+BkHZxRWeLGARR0Zojn9doqn3jKy0IuntqLhCNNldJg7f35wLnjPyh5JCy3cqDszliIcYgZZ0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119450; c=relaxed/simple;
	bh=EzcCdJ2AnSa4eaNOx1e7NCC497IfIm4NMYt/sXFlVic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmulRL2ddF87xZ1PXsUiMLOhE8b5UWtlzn5fXj66LnTNHH1eJ8Avsp6qAb0VlaPu8+FAOM/nMyUurMotevSkNped2VV27NUrdsrqKEO869S+JRppmxg1vJrwDbMfNGuAEwVl/nQTJp4cNK9+Xkp3O87lstVLjDS3E4KtJkyX100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4kBK4bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B3FC19423;
	Thu, 22 Jan 2026 22:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119449;
	bh=EzcCdJ2AnSa4eaNOx1e7NCC497IfIm4NMYt/sXFlVic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4kBK4bUsmC/UzUGB2pP3ygyFqD5hwkSY1JkTPFpQ8Z2CISs8kZcIsJ6Ix17F9nMs
	 BD1DQ+hgv/YwvJZBrsYOQTKAfziVGqV0/AwLse/VUnc+6Fe8RgJV4HxJv2oixR9ol5
	 rNbWVszNKKeGb/Z5Q624YN0qdKIrxq4MGrgXn1V5zlfztziD7ocRPjh+M6anLvKeHW
	 TkhAQ0uesYfgTfZgNS3STkWz8pKrT54SxlDsZnj3Biq2W2m9gOhI7AGbRWM+D/v39p
	 WzBR9fJ4jLwqkrPu3xkB3wLdyx0vpoMjj0GvglqlkCcL/YaeQpKPXEacFLr/ouuSVH
	 il4J5rlOU/xBA==
From: Chuck Lever <cel@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 4/5] RDMA/core: add rdma_rw_max_sge() helper for SQ sizing
Date: Thu, 22 Jan 2026 17:04:00 -0500
Message-ID: <20260122220401.1143331-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122220401.1143331-1-cel@kernel.org>
References: <20260122220401.1143331-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18335-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88A656E069
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_accept() computes sc_sq_depth as the sum of rq_depth and the
number of rdma_rw contexts (ctxts). This value is used to allocate the
Send CQ and to initialize the sc_sq_avail credit pool.

However, when the device uses memory registration for RDMA operations,
rdma_rw_init_qp() inflates the QP's max_send_wr by a factor of three
per context to account for REG and INV work requests. The Send CQ and
credit pool remain sized for only one work request per context,
causing Send Queue exhaustion under heavy NFS WRITE workloads.

Introduce rdma_rw_max_sge() to compute the actual number of Send Queue
entries required for a given number of rdma_rw contexts. Upper layer
protocols call this helper before creating a Queue Pair so that their
Send CQs and credit accounting match the QP's true capacity.

Update svc_rdma_accept() to use rdma_rw_max_sge() when computing
sc_sq_depth, ensuring the credit pool reflects the work requests
that rdma_rw_init_qp() will reserve.

Fixes: 00bd1439f464 ("RDMA/rw: Support threshold for registration vs scattering to local pages")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/rw.c             | 53 +++++++++++++++++-------
 include/rdma/rw.h                        |  2 +
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  8 +++-
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 3a00b788417d..4bca8a8ab695 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -1099,34 +1099,57 @@ unsigned int rdma_rw_mr_factor(struct ib_device *device, u32 port_num,
 }
 EXPORT_SYMBOL(rdma_rw_mr_factor);
 
+/**
+ * rdma_rw_max_send_wr - compute max Send WRs needed for RDMA R/W contexts
+ * @dev: RDMA device
+ * @port_num: port number
+ * @max_rdma_ctxs: number of rdma_rw_ctx structures
+ * @create_flags: QP create flags (pass IB_QP_CREATE_INTEGRITY_EN if
+ *                data integrity will be enabled on the QP)
+ *
+ * Returns the total number of Send Queue entries needed for
+ * @max_rdma_ctxs. The result accounts for memory registration and
+ * invalidation work requests when the device requires them.
+ *
+ * ULPs use this to size Send Queues and Send CQs before creating a
+ * Queue Pair.
+ */
+unsigned int rdma_rw_max_send_wr(struct ib_device *dev, u32 port_num,
+				 unsigned int max_rdma_ctxs, u32 create_flags)
+{
+	unsigned int factor = 1;
+	unsigned int result;
+
+	if (create_flags & IB_QP_CREATE_INTEGRITY_EN ||
+	    rdma_rw_can_use_mr(dev, port_num))
+		factor += 2;	/* reg + inv */
+
+	if (check_mul_overflow(factor, max_rdma_ctxs, &result))
+		return UINT_MAX;
+	return result;
+}
+EXPORT_SYMBOL(rdma_rw_max_send_wr);
+
 void rdma_rw_init_qp(struct ib_device *dev, struct ib_qp_init_attr *attr)
 {
-	u32 factor;
+	unsigned int factor = 1;
 
 	WARN_ON_ONCE(attr->port_num == 0);
 
 	/*
-	 * Each context needs at least one RDMA READ or WRITE WR.
-	 *
-	 * For some hardware we might need more, eventually we should ask the
-	 * HCA driver for a multiplier here.
-	 */
-	factor = 1;
-
-	/*
-	 * If the device needs MRs to perform RDMA READ or WRITE operations,
-	 * we'll need two additional MRs for the registrations and the
-	 * invalidation.
+	 * If the device uses MRs to perform RDMA READ or WRITE operations,
+	 * or if data integrity is enabled, account for registration and
+	 * invalidation work requests.
 	 */
 	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN ||
 	    rdma_rw_can_use_mr(dev, attr->port_num))
-		factor += 2;	/* inv + reg */
+		factor += 2;	/* reg + inv */
 
 	attr->cap.max_send_wr += factor * attr->cap.max_rdma_ctxs;
 
 	/*
-	 * But maybe we were just too high in the sky and the device doesn't
-	 * even support all we need, and we'll have to live with what we get..
+	 * The device might not support all we need, and we'll have to
+	 * live with what we get.
 	 */
 	attr->cap.max_send_wr =
 		min_t(u32, attr->cap.max_send_wr, dev->attrs.max_qp_wr);
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 53ed0f05fa25..5f96ff754be7 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -88,6 +88,8 @@ int rdma_rw_ctx_post(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 
 unsigned int rdma_rw_mr_factor(struct ib_device *device, u32 port_num,
 		unsigned int maxpages);
+unsigned int rdma_rw_max_send_wr(struct ib_device *dev, u32 port_num,
+		unsigned int max_rdma_ctxs, u32 create_flags);
 void rdma_rw_init_qp(struct ib_device *dev, struct ib_qp_init_attr *attr);
 int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr);
 void rdma_rw_cleanup_mrs(struct ib_qp *qp);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index b7b318ad25c4..9b623849723e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -462,7 +462,10 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		newxprt->sc_max_bc_requests = 2;
 	}
 
-	/* Arbitrary estimate of the needed number of rdma_rw contexts.
+	/* Estimate the needed number of rdma_rw contexts. The maximum
+	 * Read and Write chunks have one segment each. Each request
+	 * can involve one Read chunk and either a Write chunk or Reply
+	 * chunk; thus a factor of three.
 	 */
 	maxpayload = min(xprt->xpt_server->sv_max_payload,
 			 RPCSVC_MAXPAYLOAD_RDMA);
@@ -470,7 +473,8 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		rdma_rw_mr_factor(dev, newxprt->sc_port_num,
 				  maxpayload >> PAGE_SHIFT);
 
-	newxprt->sc_sq_depth = rq_depth + ctxts;
+	newxprt->sc_sq_depth = rq_depth +
+		rdma_rw_max_send_wr(dev, newxprt->sc_port_num, ctxts, 0);
 	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
 	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
-- 
2.52.0


