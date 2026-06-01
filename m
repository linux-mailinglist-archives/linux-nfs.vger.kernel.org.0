Return-Path: <linux-nfs+bounces-22161-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM2FHHJRHWpfYwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22161-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 11:31:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A961C77B
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 11:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74B3304CA48
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788AC390603;
	Mon,  1 Jun 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YhQZhvp+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAC73905EE;
	Mon,  1 Jun 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305963; cv=none; b=OPVdoa0/6+0uF/ype6dADPWDA0YRTLsB40eAzjTd8BbZ0YYm0ut/qtOnxbe86Bvy20lTqUu3Fr7e0kaS2kBYZSnjf4ye2oH9L9Vu6Av1B4vErQMtXcDcSfwR8gxpAjYitI2P3wA/jqwma343AvJin+TyJEF7rRExSjpJxFFAemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305963; c=relaxed/simple;
	bh=g0Qn17WuiJfYW1mtzTggVteztmmFFv/1No4E7NGncjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XU2kwd7F/WRwhfK6c2okYXJQqbL3jsMP2jiDOoS0r461rRJxA8Zji5AGlfsccEm9gj9RVIpmw/MVvGLd2p+yXrMlOfEJw0SyTEL+yICYcM3eW2WEXXxeqCdwGkRduyhxj6gdojSoza9XTaq60Z6EkdH6V9qntO0lCKRvulZ3qcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YhQZhvp+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 37BF220B7168; Mon,  1 Jun 2026 02:25:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37BF220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780305948;
	bh=BFX78O88CjQY7Y/2w6tN7zdXgkfzRGM2fLKan91nyeM=;
	h=From:To:Cc:Subject:Date:From;
	b=YhQZhvp+4kezuyxW+zI3oJ5OX/Kde7aBxRAqF5BBU0jS+/Ob7sdaDghDaC1rktdgQ
	 1J0v6Lm3vkt0+woPell8kmvbe2cm10VJzReObeHH2L+pOgorQGR0PW+sJmCY8pDbNs
	 +jnDfDNUmqj213NRaMzICItf/K6StUWBpSZJPw10=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: mkalderon@marvell.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	zyjzyj2000@gmail.com,
	sagi@grimberg.me,
	mgurtovoy@nvidia.com,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	bvanassche@acm.org,
	kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	metze@samba.org,
	tom@talpey.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	trondmy@kernel.org,
	anna@kernel.org,
	achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ebadger@purestorage.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH rdma-next v6] RDMA: Change capability fields in ib_device_attr from int to u32
Date: Mon,  1 Jun 2026 02:25:15 -0700
Message-ID: <20260601092534.1764560-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22161-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,linux.intel.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: C77A961C77B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The capability counter fields in struct ib_device_attr are declared
as signed int, but these values are inherently non-negative. Drivers
maintain their cached caps as u32 and assign them directly into these
int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
negative value visible to the IB core.

Change the signed int capability fields to u32 to match the
underlying nature of the data. Also update consumers across the IB
core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
are not forced back through signed int or u8 via min()/min_t() or
narrowing local variables.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v6:
* Fix subject prefix: net-next -> rdma-next.
Changes in v5:
* Add U8_MAX clamps in iser_verbs, nvme/host, nvme/target, isert, rds/ib_cm,
  smbdirect/connect and smbdirect/accept where u32 capability fields were
  directly narrowed into u8 rdma_conn_param fields without clamping
* Guard the inline_sge_count calculation in nvmet_rdma_find_get_device() to
  prevent u32 underflow when both max_sge_rd and max_recv_sge are zero
* Expand type migration to 9 additional fields (max_mw, max_raw_ethy_qp,
  max_mcast_grp, max_mcast_qp_attach, max_total_mcast_qp_attach, max_ah,
  max_srq, max_srq_wr, max_srq_sge)
* Fix min_t(int,...) in svc_rdma_transport; min_t(u32,...) in ipoib, srpt,
  nvme/target, rds/ib, rtrs-clt, rtrs-srv, xprtrdma/verbs
* Fix frwr_ops.c u32 underflow guard (reorder check before subtraction)
* Change sc_max_send_sges to unsigned int, inline_sge_count to u32
* Fix %d -> %u in rxe_qp, rxe_srq, ipoib_cm, ib_isert, svc_rdma_transport
* Update commit message.
Changes in v4:
* Drop clamping the values in mana_ib_query_device, instead update
  the props values from int to u32.
Changes in v3:
* Drop clamping from mana_ib_gd_query_adapter_caps(). The internal u32
  caps cache does not need to be clamped.
* Move all clamping exclusively to mana_ib_query_device(), which is the
  only place the cached u32 values are narrowed into the signed int
  fields of struct ib_device_attr.
* Reframe commit message: this is a u32-to-int type boundary fix, not a
  CVM/untrusted-hardware hardening patch.
Changes in v2:
* Update patch title.
---
 drivers/infiniband/hw/qedr/verbs.c       |  4 +--
 drivers/infiniband/sw/rxe/rxe_qp.c       | 16 ++++-----
 drivers/infiniband/sw/rxe/rxe_srq.c      | 16 ++++-----
 drivers/infiniband/ulp/ipoib/ipoib_cm.c  |  7 ++--
 drivers/infiniband/ulp/iser/iser_verbs.c |  2 +-
 drivers/infiniband/ulp/isert/ib_isert.c  |  8 ++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c   | 12 +++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c   |  6 ++--
 drivers/infiniband/ulp/srp/ib_srp.c      |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c    |  6 ++--
 drivers/nvme/host/rdma.c                 |  3 +-
 drivers/nvme/target/rdma.c               | 17 +++++-----
 fs/smb/smbdirect/accept.c                |  4 +--
 fs/smb/smbdirect/connect.c               |  4 +--
 include/linux/sunrpc/svc_rdma.h          |  2 +-
 include/rdma/ib_verbs.h                  | 42 ++++++++++++------------
 net/rds/ib.c                             |  4 +--
 net/rds/ib_cm.c                          |  6 ++--
 net/sunrpc/xprtrdma/frwr_ops.c           |  7 ++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  4 +--
 net/sunrpc/xprtrdma/verbs.c              |  2 +-
 21 files changed, 90 insertions(+), 84 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 679aa6f3a63b..64ea72529682 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -151,8 +151,8 @@ int qedr_query_device(struct ib_device *ibdev,
 	attr->max_qp_init_rd_atom =
 	    1 << (fls(qattr->max_qp_req_rd_atomic_resc) - 1);
 	attr->max_qp_rd_atom =
-	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
-		attr->max_qp_init_rd_atom);
+	    min_t(u32, 1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
+		  attr->max_qp_init_rd_atom);
 
 	attr->max_srq = qattr->max_srq;
 	attr->max_srq_sge = qattr->max_srq_sge;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f3dff1aea96a..b25bbf6606f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -67,27 +67,27 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
 {
 	if (cap->max_send_wr > rxe->attr.max_qp_wr) {
-		rxe_dbg_dev(rxe, "invalid send wr = %u > %d\n",
-			 cap->max_send_wr, rxe->attr.max_qp_wr);
+		rxe_dbg_dev(rxe, "invalid send wr = %u > %u\n",
+			    cap->max_send_wr, rxe->attr.max_qp_wr);
 		goto err1;
 	}
 
 	if (cap->max_send_sge > rxe->attr.max_send_sge) {
-		rxe_dbg_dev(rxe, "invalid send sge = %u > %d\n",
-			 cap->max_send_sge, rxe->attr.max_send_sge);
+		rxe_dbg_dev(rxe, "invalid send sge = %u > %u\n",
+			    cap->max_send_sge, rxe->attr.max_send_sge);
 		goto err1;
 	}
 
 	if (!has_srq) {
 		if (cap->max_recv_wr > rxe->attr.max_qp_wr) {
-			rxe_dbg_dev(rxe, "invalid recv wr = %u > %d\n",
-				 cap->max_recv_wr, rxe->attr.max_qp_wr);
+			rxe_dbg_dev(rxe, "invalid recv wr = %u > %u\n",
+				    cap->max_recv_wr, rxe->attr.max_qp_wr);
 			goto err1;
 		}
 
 		if (cap->max_recv_sge > rxe->attr.max_recv_sge) {
-			rxe_dbg_dev(rxe, "invalid recv sge = %u > %d\n",
-				 cap->max_recv_sge, rxe->attr.max_recv_sge);
+			rxe_dbg_dev(rxe, "invalid recv sge = %u > %u\n",
+				    cap->max_recv_sge, rxe->attr.max_recv_sge);
 			goto err1;
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index c9a7cd38953d..74904a6fdf2b 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -13,8 +13,8 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 	struct ib_srq_attr *attr = &init->attr;
 
 	if (attr->max_wr > rxe->attr.max_srq_wr) {
-		rxe_dbg_dev(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
-			attr->max_wr, rxe->attr.max_srq_wr);
+		rxe_dbg_dev(rxe, "max_wr(%u) > max_srq_wr(%u)\n",
+			    attr->max_wr, rxe->attr.max_srq_wr);
 		goto err1;
 	}
 
@@ -27,8 +27,8 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 		attr->max_wr = RXE_MIN_SRQ_WR;
 
 	if (attr->max_sge > rxe->attr.max_srq_sge) {
-		rxe_dbg_dev(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
-			attr->max_sge, rxe->attr.max_srq_sge);
+		rxe_dbg_dev(rxe, "max_sge(%u) > max_srq_sge(%u)\n",
+			    attr->max_sge, rxe->attr.max_srq_sge);
 		goto err1;
 	}
 
@@ -107,8 +107,8 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 	if (mask & IB_SRQ_MAX_WR) {
 		if (attr->max_wr > rxe->attr.max_srq_wr) {
-			rxe_dbg_srq(srq, "max_wr(%d) > max_srq_wr(%d)\n",
-				attr->max_wr, rxe->attr.max_srq_wr);
+			rxe_dbg_srq(srq, "max_wr(%u) > max_srq_wr(%u)\n",
+				    attr->max_wr, rxe->attr.max_srq_wr);
 			goto err1;
 		}
 
@@ -129,8 +129,8 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 	if (mask & IB_SRQ_LIMIT) {
 		if (attr->srq_limit > rxe->attr.max_srq_wr) {
-			rxe_dbg_srq(srq, "srq_limit(%d) > max_srq_wr(%d)\n",
-				attr->srq_limit, rxe->attr.max_srq_wr);
+			rxe_dbg_srq(srq, "srq_limit(%u) > max_srq_wr(%u)\n",
+				    attr->srq_limit, rxe->attr.max_srq_wr);
 			goto err1;
 		}
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 57fec88a1629..58606501bcd7 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1582,7 +1582,8 @@ static void ipoib_cm_create_srq(struct net_device *dev, int max_sge)
 int ipoib_cm_dev_init(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
-	int max_srq_sge, i;
+	int i;
+	u32 max_srq_sge;
 	u8 addr;
 
 	INIT_LIST_HEAD(&priv->cm.passive_ids);
@@ -1600,9 +1601,9 @@ int ipoib_cm_dev_init(struct net_device *dev)
 
 	skb_queue_head_init(&priv->cm.skb_queue);
 
-	ipoib_dbg(priv, "max_srq_sge=%d\n", priv->ca->attrs.max_srq_sge);
+	ipoib_dbg(priv, "max_srq_sge=%u\n", priv->ca->attrs.max_srq_sge);
 
-	max_srq_sge = min_t(int, IPOIB_CM_RX_SG, priv->ca->attrs.max_srq_sge);
+	max_srq_sge = min_t(u32, IPOIB_CM_RX_SG, priv->ca->attrs.max_srq_sge);
 	ipoib_cm_create_srq(dev, max_srq_sge);
 	if (ipoib_cm_has_srq(dev)) {
 		priv->cm.max_cm_mtu = max_srq_sge * PAGE_SIZE - 0x10;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index f03b3bb3c0c4..a9a366fb3a34 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -589,7 +589,7 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 		goto failure;
 
 	memset(&conn_param, 0, sizeof conn_param);
-	conn_param.responder_resources = ib_dev->attrs.max_qp_rd_atom;
+	conn_param.responder_resources = min_t(u32, U8_MAX, ib_dev->attrs.max_qp_rd_atom);
 	conn_param.initiator_depth = 1;
 	conn_param.retry_count = 7;
 	conn_param.rnr_retry_count = 6;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 348005e71891..3bebf99f600c 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -214,9 +214,9 @@ isert_create_device_ib_res(struct isert_device *device)
 	struct ib_device *ib_dev = device->ib_device;
 	int ret;
 
-	isert_dbg("devattr->max_send_sge: %d devattr->max_recv_sge %d\n",
+	isert_dbg("devattr->max_send_sge: %u devattr->max_recv_sge %u\n",
 		  ib_dev->attrs.max_send_sge, ib_dev->attrs.max_recv_sge);
-	isert_dbg("devattr->max_sge_rd: %d\n", ib_dev->attrs.max_sge_rd);
+	isert_dbg("devattr->max_sge_rd: %u\n", ib_dev->attrs.max_sge_rd);
 
 	device->pd = ib_alloc_pd(ib_dev, 0);
 	if (IS_ERR(device->pd)) {
@@ -381,8 +381,8 @@ isert_set_nego_params(struct isert_conn *isert_conn,
 	struct ib_device_attr *attr = &isert_conn->device->ib_device->attrs;
 
 	/* Set max inflight RDMA READ requests */
-	isert_conn->initiator_depth = min_t(u8, param->initiator_depth,
-				attr->max_qp_init_rd_atom);
+	isert_conn->initiator_depth = min_t(u32, param->initiator_depth,
+					    attr->max_qp_init_rd_atom);
 	isert_dbg("Using initiator_depth: %u\n", isert_conn->initiator_depth);
 
 	if (param->private_data) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index e351552733df..5245b4b7fb4e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1682,7 +1682,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		 * in case qp gets into error state.
 		 */
 		max_send_wr =
-			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
+			min_t(u32, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
 		max_recv_wr = max_send_wr;
 	} else {
 		/*
@@ -1698,11 +1698,11 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		wr_limit = clt_path->s.dev->ib_dev->attrs.max_qp_wr;
 		/* Shared between connections */
 		clt_path->s.dev_ref++;
-		max_send_wr = min_t(int, wr_limit,
-			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
-			      clt_path->queue_depth * 4 + 1);
-		max_recv_wr = min_t(int, wr_limit,
-			      clt_path->queue_depth * 3 + 1);
+		max_send_wr = min_t(u32, wr_limit,
+				    /* QD * (REQ + RSP + FR REGS or INVS) + drain */
+				    clt_path->queue_depth * 4 + 1);
+		max_recv_wr = min_t(u32, wr_limit,
+				    clt_path->queue_depth * 3 + 1);
 		max_send_sge = 2;
 	}
 	atomic_set(&con->c.sq_wr_avail, max_send_wr);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6482ad859bd1..852213365ecd 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1731,7 +1731,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
 		 * All receive and all send (each requiring invalidate)
 		 * + 2 for drain and heartbeat
 		 */
-		max_send_wr = min_t(int, wr_limit,
+		max_send_wr = min_t(u32, wr_limit,
 				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);
 		max_recv_wr = max_send_wr;
 		s->signal_interval = min_not_zero(srv->queue_depth,
@@ -1740,11 +1740,11 @@ static int create_con(struct rtrs_srv_path *srv_path,
 		/* when always_invlaidate enalbed, we need linv+rinv+mr+imm */
 		if (always_invalidate)
 			max_send_wr =
-				min_t(int, wr_limit,
+				min_t(u32, wr_limit,
 				      srv->queue_depth * (1 + 4) + 1);
 		else
 			max_send_wr =
-				min_t(int, wr_limit,
+				min_t(u32, wr_limit,
 				      srv->queue_depth * (1 + 2) + 1);
 
 		max_recv_wr = srv->queue_depth + 1;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b58868e1cf11..dc30d069ab3d 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -557,7 +557,7 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
 	init_attr->cap.max_send_wr     = m * target->queue_size;
 	init_attr->cap.max_recv_wr     = target->queue_size + 1;
 	init_attr->cap.max_recv_sge    = 1;
-	init_attr->cap.max_send_sge    = min(SRP_MAX_SGE, attr->max_send_sge);
+	init_attr->cap.max_send_sge    = min_t(u32, SRP_MAX_SGE, attr->max_send_sge);
 	init_attr->sq_sig_type         = IB_SIGNAL_REQ_WR;
 	init_attr->qp_type             = IB_QPT_RC;
 	init_attr->send_cq             = send_cq;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9aec5d80117f..2ffa4f54cd4e 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1884,7 +1884,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	 * both both, as RDMA contexts will also post completions for the
 	 * RDMA READ case.
 	 */
-	qp_init->cap.max_send_wr = min(sq_size / 2, attrs->max_qp_wr);
+	qp_init->cap.max_send_wr = min_t(u32, sq_size / 2, attrs->max_qp_wr);
 	qp_init->cap.max_rdma_ctxs = sq_size / 2;
 	qp_init->cap.max_send_sge = attrs->max_send_sge;
 	qp_init->cap.max_recv_sge = 1;
@@ -2298,7 +2298,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	 * depth to avoid that the initiator driver has to report QUEUE_FULL
 	 * to the SCSI mid-layer.
 	 */
-	ch->rq_size = min(MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
+	ch->rq_size = min_t(u32, MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
 	spin_lock_init(&ch->spinlock);
 	ch->state = CH_CONNECTING;
 	INIT_LIST_HEAD(&ch->cmd_wait_list);
@@ -3225,7 +3225,7 @@ static int srpt_add_one(struct ib_device *device)
 
 	sdev->lkey = sdev->pd->local_dma_lkey;
 
-	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
+	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);
 
 	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..f45d79816bc8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1845,7 +1845,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 	param.qp_num = queue->qp->qp_num;
 	param.flow_control = 1;
 
-	param.responder_resources = queue->device->dev->attrs.max_qp_rd_atom;
+	param.responder_resources = min_t(u32, U8_MAX,
+					  queue->device->dev->attrs.max_qp_rd_atom);
 	/* maximum retry count */
 	param.retry_count = 7;
 	param.rnr_retry_count = 7;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e6e2c3f9afdf..fd6923198ec1 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1149,10 +1149,10 @@ static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
 		return 0;
 	}
 
-	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
-			     nvmet_rdma_srq_size);
-	ndev->srq_count = min(ndev->device->num_comp_vectors,
-			      ndev->device->attrs.max_srq);
+	ndev->srq_size = min_t(u32, ndev->device->attrs.max_srq_wr,
+			       nvmet_rdma_srq_size);
+	ndev->srq_count = min_t(u32, ndev->device->num_comp_vectors,
+				ndev->device->attrs.max_srq);
 
 	ndev->srqs = kzalloc_objs(*ndev->srqs, ndev->srq_count);
 	if (!ndev->srqs)
@@ -1197,7 +1197,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	struct nvmet_port *nport = port->nport;
 	struct nvmet_rdma_device *ndev;
 	int inline_page_count;
-	int inline_sge_count;
+	u32 inline_sge_count;
 	int ret;
 
 	mutex_lock(&device_list_mutex);
@@ -1213,7 +1213,8 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 
 	inline_page_count = num_pages(nport->inline_data_size);
 	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
-				cm_id->device->attrs.max_recv_sge) - 1;
+				cm_id->device->attrs.max_recv_sge);
+	inline_sge_count = inline_sge_count ? inline_sge_count - 1 : 0;
 	if (inline_page_count > inline_sge_count) {
 		pr_warn("inline_data_size %d cannot be supported by device %s. Reducing to %lu.\n",
 			nport->inline_data_size, cm_id->device->name,
@@ -1553,8 +1554,8 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 
 	param.rnr_retry_count = 7;
 	param.flow_control = 1;
-	param.initiator_depth = min_t(u8, p->initiator_depth,
-		queue->dev->device->attrs.max_qp_init_rd_atom);
+	param.initiator_depth = (u8)min_t(u32, p->initiator_depth,
+		min_t(u32, U8_MAX, queue->dev->device->attrs.max_qp_init_rd_atom));
 	param.private_data = &priv;
 	param.private_data_len = sizeof(priv);
 	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
diff --git a/fs/smb/smbdirect/accept.c b/fs/smb/smbdirect/accept.c
index 529740005838..890ce6985f4d 100644
--- a/fs/smb/smbdirect/accept.c
+++ b/fs/smb/smbdirect/accept.c
@@ -32,8 +32,8 @@ int smbdirect_accept_connect_request(struct smbdirect_socket *sc,
 	/*
 	 * First set what the we as server are able to support
 	 */
-	sp->initiator_depth = min_t(u8, sp->initiator_depth,
-				    sc->ib.dev->attrs.max_qp_rd_atom);
+	sp->initiator_depth = min_t(u32, sp->initiator_depth,
+				    min_t(u32, U8_MAX, sc->ib.dev->attrs.max_qp_rd_atom));
 
 	peer_initiator_depth = param->initiator_depth;
 	peer_responder_resources = param->responder_resources;
diff --git a/fs/smb/smbdirect/connect.c b/fs/smb/smbdirect/connect.c
index cd726b399afe..1a38772bb08c 100644
--- a/fs/smb/smbdirect/connect.c
+++ b/fs/smb/smbdirect/connect.c
@@ -182,8 +182,8 @@ static int smbdirect_connect_rdma_connect(struct smbdirect_socket *sc)
 	if (sc->ib.dev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
 		sc->mr_io.type = IB_MR_TYPE_SG_GAPS;
 
-	sp->responder_resources = min_t(u8, sp->responder_resources,
-					sc->ib.dev->attrs.max_qp_rd_atom);
+	sp->responder_resources = min_t(u32, sp->responder_resources,
+					min_t(u32, U8_MAX, sc->ib.dev->attrs.max_qp_rd_atom));
 	smbdirect_log_rdma_mr(sc, SMBDIRECT_LOG_INFO,
 		"responder_resources=%d\n",
 		sp->responder_resources);
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index df6e08aaad57..05935e9f5530 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -79,7 +79,7 @@ struct svcxprt_rdma {
 	struct list_head     sc_accept_q;	/* Conn. waiting accept */
 	struct rpcrdma_notification sc_rn;	/* removal notification */
 	int		     sc_ord;		/* RDMA read limit */
-	int                  sc_max_send_sges;
+	unsigned int         sc_max_send_sges;
 	bool		     sc_snd_w_inv;	/* OK to use Send With Invalidate */
 
 	atomic_t             sc_sq_avail;	/* SQEs ready to be consumed */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0b..987309b9a675 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -406,36 +406,36 @@ struct ib_device_attr {
 	u32			vendor_id;
 	u32			vendor_part_id;
 	u32			hw_ver;
-	int			max_qp;
-	int			max_qp_wr;
+	u32			max_qp;
+	u32			max_qp_wr;
 	u64			device_cap_flags;
 	u64			kernel_cap_flags;
-	int			max_send_sge;
-	int			max_recv_sge;
-	int			max_sge_rd;
-	int			max_cq;
-	int			max_cqe;
-	int			max_mr;
-	int			max_pd;
-	int			max_qp_rd_atom;
+	u32			max_send_sge;
+	u32			max_recv_sge;
+	u32			max_sge_rd;
+	u32			max_cq;
+	u32			max_cqe;
+	u32			max_mr;
+	u32			max_pd;
+	u32			max_qp_rd_atom;
 	int			max_ee_rd_atom;
-	int			max_res_rd_atom;
-	int			max_qp_init_rd_atom;
+	u32			max_res_rd_atom;
+	u32			max_qp_init_rd_atom;
 	int			max_ee_init_rd_atom;
 	enum ib_atomic_cap	atomic_cap;
 	enum ib_atomic_cap	masked_atomic_cap;
 	int			max_ee;
 	int			max_rdd;
-	int			max_mw;
+	u32			max_mw;
 	int			max_raw_ipv6_qp;
-	int			max_raw_ethy_qp;
-	int			max_mcast_grp;
-	int			max_mcast_qp_attach;
-	int			max_total_mcast_qp_attach;
-	int			max_ah;
-	int			max_srq;
-	int			max_srq_wr;
-	int			max_srq_sge;
+	u32			max_raw_ethy_qp;
+	u32			max_mcast_grp;
+	u32			max_mcast_qp_attach;
+	u32			max_total_mcast_qp_attach;
+	u32			max_ah;
+	u32			max_srq;
+	u32			max_srq_wr;
+	u32			max_srq_sge;
 	unsigned int		max_fast_reg_page_list_len;
 	unsigned int		max_pi_fast_reg_page_list_len;
 	u16			max_pkeys;
diff --git a/net/rds/ib.c b/net/rds/ib.c
index 39f87272e071..d493bdd2d3e9 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -151,7 +151,7 @@ static int rds_ib_add_one(struct ib_device *device)
 	INIT_LIST_HEAD(&rds_ibdev->conn_list);
 
 	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
-	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
+	rds_ibdev->max_sge = min_t(u32, device->attrs.max_send_sge, RDS_IB_MAX_SGE);
 
 	rds_ibdev->odp_capable =
 		!!(device->attrs.kernel_cap_flags &
@@ -204,7 +204,7 @@ static int rds_ib_add_one(struct ib_device *device)
 		goto put_dev;
 	}
 
-	rdsdebug("RDS/IB: max_mr = %d, max_wrs = %d, max_sge = %d, max_1m_mrs = %d, max_8k_mrs = %d\n",
+	rdsdebug("RDS/IB: max_mr = %u, max_wrs = %d, max_sge = %d, max_1m_mrs = %d, max_8k_mrs = %d\n",
 		 device->attrs.max_mr, rds_ibdev->max_wrs, rds_ibdev->max_sge,
 		 rds_ibdev->max_1m_mrs, rds_ibdev->max_8k_mrs);
 
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 0c64c504f79d..50292dc9884f 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -174,9 +174,11 @@ static void rds_ib_cm_fill_conn_param(struct rds_connection *conn,
 	memset(conn_param, 0, sizeof(struct rdma_conn_param));
 
 	conn_param->responder_resources =
-		min_t(u32, rds_ibdev->max_responder_resources, max_responder_resources);
+		(u8)min3(rds_ibdev->max_responder_resources,
+			 max_responder_resources, (unsigned int)U8_MAX);
 	conn_param->initiator_depth =
-		min_t(u32, rds_ibdev->max_initiator_depth, max_initiator_depth);
+		(u8)min3(rds_ibdev->max_initiator_depth,
+			 max_initiator_depth, (unsigned int)U8_MAX);
 	conn_param->retry_count = min_t(unsigned int, rds_ib_retry_count, 7);
 	conn_param->rnr_retry_count = 7;
 
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 7f79a0a2601e..19f7088a7b54 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -172,7 +172,8 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 {
 	const struct ib_device_attr *attrs = &device->attrs;
-	int max_qp_wr, depth, delta;
+	u32 max_qp_wr;
+	int depth, delta;
 	unsigned int max_sge;
 
 	if (!(attrs->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS) ||
@@ -229,10 +230,10 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 	}
 
 	max_qp_wr = attrs->max_qp_wr;
+	if (max_qp_wr < RPCRDMA_BACKWARD_WRS + 1 + RPCRDMA_MIN_SLOT_TABLE)
+		return -ENOMEM;
 	max_qp_wr -= RPCRDMA_BACKWARD_WRS;
 	max_qp_wr -= 1;
-	if (max_qp_wr < RPCRDMA_MIN_SLOT_TABLE)
-		return -ENOMEM;
 	if (ep->re_max_requests > max_qp_wr)
 		ep->re_max_requests = max_qp_wr;
 	ep->re_attr.cap.max_send_wr = ep->re_max_requests * depth;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f18bc60d9f4f..a2ff2752a591 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -544,7 +544,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	set_bit(RDMAXPRT_CONN_PENDING, &newxprt->sc_flags);
 	memset(&conn_param, 0, sizeof conn_param);
 	conn_param.responder_resources = 0;
-	conn_param.initiator_depth = min_t(int, newxprt->sc_ord,
+	conn_param.initiator_depth = min_t(u32, newxprt->sc_ord,
 					   dev->attrs.max_qp_init_rd_atom);
 	if (!conn_param.initiator_depth) {
 		ret = -EINVAL;
@@ -570,7 +570,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
 		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
 		dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
-		dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
+		dprintk("    max_sge         : %u\n", newxprt->sc_max_send_sges);
 		dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
 		dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
 		dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index aecf9c0a153f..236ec233c579 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -453,7 +453,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	/* Client offers RDMA Read but does not initiate */
 	ep->re_remote_cma.initiator_depth = 0;
 	ep->re_remote_cma.responder_resources =
-		min_t(int, U8_MAX, device->attrs.max_qp_rd_atom);
+		min_t(u32, U8_MAX, device->attrs.max_qp_rd_atom);
 
 	/* Limit transport retries so client can detect server
 	 * GID changes quickly. RPC layer handles re-establishing
-- 
2.34.1


