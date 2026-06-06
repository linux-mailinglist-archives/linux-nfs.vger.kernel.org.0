Return-Path: <linux-nfs+bounces-22335-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YmKQM1fHI2rayAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22335-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 09:08:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5264CCA8
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 09:08:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b="RBIO7/Mv";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22335-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22335-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 777A030074D2
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 07:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086C30D40E;
	Sat,  6 Jun 2026 07:08:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A3199385;
	Sat,  6 Jun 2026 07:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780729681; cv=none; b=G5w7lizg6C9EHMpCOV9gNX9ZWFT1Z8a0/sfhIEFV0ii9cCzQRAZjX18iynN+1rVxAjw30zKcbl68vK5pC9goc/dof9RrnC01B1OYAP2Oem0xbhc6ZV7MtRQbiayTj+fHHGaOS1ZgAKEKX4Si2W3/zCIbs9dN7tnJhRnXbm0DqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780729681; c=relaxed/simple;
	bh=dDeFHoWXU/AClfP0c2mcs+PQkLuhtqdodOEUzeX0SiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJmadXPUcqSDpdEXSVaMSHUC0hH1SLKU3h2R1vQXYAkZGswnur5yds+bRSdN5gs0dToXGI5TmN2i69ZVNBCPeQtG23yrTotsPZVNMb/cS9QP9nu6HSmbqjlBgPvOt7uAvcxmAvCaoZyCZTJmJ7QPOx7GE2s4Nbi4QBYidFG8uTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RBIO7/Mv; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id DDB2D20B7168; Sat,  6 Jun 2026 00:07:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDB2D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780729663;
	bh=qJyFThdgAAitwDUeyh+YH6FKMESy/AXEeNRgGdzSElc=;
	h=From:To:Cc:Subject:Date:From;
	b=RBIO7/MvUqzY/UFEbsbEPXMzWe3vJla36rNNNgkvhfevT7+LGpyEPzKadOGRa9mMf
	 TeXMUOOjLdPKOyAiB2F3xk6kYDSB9VVK+wQ3f7Axpf3hSeEEeGLgE/tD9qXCLlr5LZ
	 XA9TtkSoTiIEubYXB4JjurpecRidypki87mfBgI0=
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
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
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
Subject: [PATCH rdma-next v7] RDMA: Change capability fields in ib_device_attr from int to u32
Date: Sat,  6 Jun 2026 00:07:15 -0700
Message-ID: <20260606070735.2163063-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andriy.shevchenko@linux.intel.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:ernis@linux.micro
 soft.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,linux.intel.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22335-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,linux.microsoft.com:mid,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2B5264CCA8

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
Changes in v7:
* Drop min_t() in all sites where a plain min() (or min3()) works
  cleanly
* Guard nvme/host/rdma.c num_inline_segments computation against a
  device reporting max_send_sge == 0, so the u32 subtract
  cannot wrap to UINT_MAX.
* Use %u when printing the newly-u32 capability fields
  in diagnostic messages.
Changes in v6:
* Fix subject prefix: net-next -> rdma-next.
Changes in v5:
* Add U8_MAX clamps in iser_verbs, nvme/host, nvme/target, isert,
* rds/ib_cm,
  smbdirect/connect and smbdirect/accept where u32 capability fields
were
  directly narrowed into u8 rdma_conn_param fields without clamping
* Guard the inline_sge_count calculation in nvmet_rdma_find_get_device()
* to
  prevent u32 underflow when both max_sge_rd and max_recv_sge are zero
* Expand type migration to 9 additional fields (max_mw, max_raw_ethy_qp,
  max_mcast_grp, max_mcast_qp_attach, max_total_mcast_qp_attach, max_ah,
  max_srq, max_srq_wr, max_srq_sge)
* Fix min_t(int,...) in svc_rdma_transport; min_t(u32,...) in ipoib,
* srpt,
  nvme/target, rds/ib, rtrs-clt, rtrs-srv, xprtrdma/verbs
* Fix frwr_ops.c u32 underflow guard (reorder check before subtraction)
* Change sc_max_send_sges to unsigned int, inline_sge_count to u32
* Fix %d -> %u in rxe_qp, rxe_srq, ipoib_cm, ib_isert,
* svc_rdma_transport
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
 drivers/infiniband/hw/qedr/verbs.c       |  2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c       | 16 ++++-----
 drivers/infiniband/sw/rxe/rxe_srq.c      | 16 ++++-----
 drivers/infiniband/ulp/ipoib/ipoib_cm.c  |  7 ++--
 drivers/infiniband/ulp/iser/iser_verbs.c |  2 +-
 drivers/infiniband/ulp/isert/ib_isert.c  |  8 ++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c   | 12 +++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c   |  8 ++---
 drivers/infiniband/ulp/srp/ib_srp.c      |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c    | 18 +++++-----
 drivers/nvme/host/rdma.c                 |  8 +++--
 drivers/nvme/target/rdma.c               | 18 +++++-----
 fs/smb/smbdirect/accept.c                |  5 +--
 fs/smb/smbdirect/connect.c               |  5 +--
 fs/smb/smbdirect/connection.c            |  8 ++---
 include/linux/sunrpc/svc_rdma.h          |  4 +--
 include/rdma/ib_verbs.h                  | 42 ++++++++++++------------
 net/rds/ib.c                             |  2 +-
 net/rds/ib_cm.c                          |  6 ++--
 net/sunrpc/xprtrdma/frwr_ops.c           |  7 ++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  6 ++--
 net/sunrpc/xprtrdma/verbs.c              |  2 +-
 22 files changed, 107 insertions(+), 97 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 679aa6f3a63b..a85ad0171134 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -151,7 +151,7 @@ int qedr_query_device(struct ib_device *ibdev,
 	attr->max_qp_init_rd_atom =
 	    1 << (fls(qattr->max_qp_req_rd_atomic_resc) - 1);
 	attr->max_qp_rd_atom =
-	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
+	    min(1U << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
 		attr->max_qp_init_rd_atom);
 
 	attr->max_srq = qattr->max_srq;
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
index 57fec88a1629..c58459492dee 100644
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
+	max_srq_sge = min(priv->ca->attrs.max_srq_sge, IPOIB_CM_RX_SG);
 	ipoib_cm_create_srq(dev, max_srq_sge);
 	if (ipoib_cm_has_srq(dev)) {
 		priv->cm.max_cm_mtu = max_srq_sge * PAGE_SIZE - 0x10;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index f03b3bb3c0c4..d56e0927a947 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -589,7 +589,7 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 		goto failure;
 
 	memset(&conn_param, 0, sizeof conn_param);
-	conn_param.responder_resources = ib_dev->attrs.max_qp_rd_atom;
+	conn_param.responder_resources = min(ib_dev->attrs.max_qp_rd_atom, U8_MAX);
 	conn_param.initiator_depth = 1;
 	conn_param.retry_count = 7;
 	conn_param.rnr_retry_count = 6;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 348005e71891..6d0a74d64607 100644
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
+	isert_conn->initiator_depth = min(param->initiator_depth,
+					  attr->max_qp_init_rd_atom);
 	isert_dbg("Using initiator_depth: %u\n", isert_conn->initiator_depth);
 
 	if (param->private_data) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index e351552733df..cd26bdcfffab 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1682,7 +1682,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		 * in case qp gets into error state.
 		 */
 		max_send_wr =
-			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
+			min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
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
index 6482ad859bd1..b2583338d0f0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1731,8 +1731,8 @@ static int create_con(struct rtrs_srv_path *srv_path,
 		 * All receive and all send (each requiring invalidate)
 		 * + 2 for drain and heartbeat
 		 */
-		max_send_wr = min_t(int, wr_limit,
-				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);
+		max_send_wr = min(wr_limit,
+				  SERVICE_CON_QUEUE_DEPTH * 2 + 2);
 		max_recv_wr = max_send_wr;
 		s->signal_interval = min_not_zero(srv->queue_depth,
 						  (size_t)SERVICE_CON_QUEUE_DEPTH);
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
index b58868e1cf11..f585d9426b83 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -557,7 +557,7 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
 	init_attr->cap.max_send_wr     = m * target->queue_size;
 	init_attr->cap.max_recv_wr     = target->queue_size + 1;
 	init_attr->cap.max_recv_sge    = 1;
-	init_attr->cap.max_send_sge    = min(SRP_MAX_SGE, attr->max_send_sge);
+	init_attr->cap.max_send_sge    = min(attr->max_send_sge, SRP_MAX_SGE);
 	init_attr->sq_sig_type         = IB_SIGNAL_REQ_WR;
 	init_attr->qp_type             = IB_QPT_RC;
 	init_attr->send_cq             = send_cq;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9aec5d80117f..7b0d7ff3d6d7 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -77,8 +77,8 @@ module_param(srp_max_req_size, int, 0444);
 MODULE_PARM_DESC(srp_max_req_size,
 		 "Maximum size of SRP request messages in bytes.");
 
-static int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
-module_param(srpt_srq_size, int, 0444);
+static unsigned int srpt_srq_size = DEFAULT_SRPT_SRQ_SIZE;
+module_param(srpt_srq_size, uint, 0444);
 MODULE_PARM_DESC(srpt_srq_size,
 		 "Shared receive queue (SRQ) size.");
 
@@ -1850,7 +1850,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	struct srpt_port *sport = ch->sport;
 	struct srpt_device *sdev = sport->sdev;
 	const struct ib_device_attr *attrs = &sdev->device->attrs;
-	int sq_size = sport->port_attrib.srp_sq_size;
+	u32 sq_size = sport->port_attrib.srp_sq_size;
 	int i, ret;
 
 	WARN_ON(ch->rq_size < 1);
@@ -1911,13 +1911,13 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 		bool retry = sq_size > MIN_SRPT_SQ_SIZE;
 
 		if (retry) {
-			pr_debug("failed to create queue pair with sq_size = %d (%d) - retrying\n",
+			pr_debug("failed to create queue pair with sq_size = %u (%d) - retrying\n",
 				 sq_size, ret);
 			ib_cq_pool_put(ch->cq, ch->cq_size);
 			sq_size = max(sq_size / 2, MIN_SRPT_SQ_SIZE);
 			goto retry;
 		} else {
-			pr_err("failed to create queue pair with sq_size = %d (%d)\n",
+			pr_err("failed to create queue pair with sq_size = %u (%d)\n",
 			       sq_size, ret);
 			goto err_destroy_cq;
 		}
@@ -1925,7 +1925,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 
 	atomic_set(&ch->sq_wr_avail, qp_init->cap.max_send_wr);
 
-	pr_debug("%s: max_cqe= %d max_sge= %d sq_size = %d ch= %p\n",
+	pr_debug("%s: max_cqe= %d max_sge= %d sq_size = %u ch= %p\n",
 		 __func__, ch->cq->cqe, qp_init->cap.max_send_sge,
 		 qp_init->cap.max_send_wr, ch);
 
@@ -2298,7 +2298,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	 * depth to avoid that the initiator driver has to report QUEUE_FULL
 	 * to the SCSI mid-layer.
 	 */
-	ch->rq_size = min(MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
+	ch->rq_size = min(sdev->device->attrs.max_qp_wr, MAX_SRPT_RQ_SIZE);
 	spin_lock_init(&ch->spinlock);
 	ch->state = CH_CONNECTING;
 	INIT_LIST_HEAD(&ch->cmd_wait_list);
@@ -3136,7 +3136,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 		return PTR_ERR(srq);
 	}
 
-	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
+	pr_debug("create SRQ #wr= %d max_allow=%u dev= %s\n", sdev->srq_size,
 		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
 
 	sdev->req_buf_cache = srpt_cache_get(srp_max_req_size);
@@ -3951,7 +3951,7 @@ static int __init srpt_init_module(void)
 
 	if (srpt_srq_size < MIN_SRPT_SRQ_SIZE
 	    || srpt_srq_size > MAX_SRPT_SRQ_SIZE) {
-		pr_err("invalid value %d for kernel module parameter srpt_srq_size -- must be in the range [%d..%d].\n",
+		pr_err("invalid value %u for kernel module parameter srpt_srq_size -- must be in the range [%d..%d].\n",
 		       srpt_srq_size, MIN_SRPT_SRQ_SIZE, MAX_SRPT_SRQ_SIZE);
 		goto out;
 	}
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..a1f757cd5d38 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -394,8 +394,9 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 		goto out_free_pd;
 	}
 
-	ndev->num_inline_segments = min(NVME_RDMA_MAX_INLINE_SEGMENTS,
-					ndev->dev->attrs.max_send_sge - 1);
+	ndev->num_inline_segments = min(ndev->dev->attrs.max_send_sge ?
+					ndev->dev->attrs.max_send_sge - 1 : 0,
+					NVME_RDMA_MAX_INLINE_SEGMENTS);
 	list_add(&ndev->entry, &device_list);
 out_unlock:
 	mutex_unlock(&device_list_mutex);
@@ -1845,7 +1846,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 	param.qp_num = queue->qp->qp_num;
 	param.flow_control = 1;
 
-	param.responder_resources = queue->device->dev->attrs.max_qp_rd_atom;
+	param.responder_resources = min(queue->device->dev->attrs.max_qp_rd_atom,
+					U8_MAX);
 	/* maximum retry count */
 	param.retry_count = 7;
 	param.rnr_retry_count = 7;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e6e2c3f9afdf..5df308bc7916 100644
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
@@ -1553,8 +1554,9 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 
 	param.rnr_retry_count = 7;
 	param.flow_control = 1;
-	param.initiator_depth = min_t(u8, p->initiator_depth,
-		queue->dev->device->attrs.max_qp_init_rd_atom);
+	param.initiator_depth = min3(p->initiator_depth,
+				     queue->dev->device->attrs.max_qp_init_rd_atom,
+				     U8_MAX);
 	param.private_data = &priv;
 	param.private_data_len = sizeof(priv);
 	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
diff --git a/fs/smb/smbdirect/accept.c b/fs/smb/smbdirect/accept.c
index 529740005838..44b681a20725 100644
--- a/fs/smb/smbdirect/accept.c
+++ b/fs/smb/smbdirect/accept.c
@@ -32,8 +32,9 @@ int smbdirect_accept_connect_request(struct smbdirect_socket *sc,
 	/*
 	 * First set what the we as server are able to support
 	 */
-	sp->initiator_depth = min_t(u8, sp->initiator_depth,
-				    sc->ib.dev->attrs.max_qp_rd_atom);
+	sp->initiator_depth = min3(sp->initiator_depth,
+				   sc->ib.dev->attrs.max_qp_rd_atom,
+				   U8_MAX);
 
 	peer_initiator_depth = param->initiator_depth;
 	peer_responder_resources = param->responder_resources;
diff --git a/fs/smb/smbdirect/connect.c b/fs/smb/smbdirect/connect.c
index cd726b399afe..34a3e72c38fb 100644
--- a/fs/smb/smbdirect/connect.c
+++ b/fs/smb/smbdirect/connect.c
@@ -182,8 +182,9 @@ static int smbdirect_connect_rdma_connect(struct smbdirect_socket *sc)
 	if (sc->ib.dev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
 		sc->mr_io.type = IB_MR_TYPE_SG_GAPS;
 
-	sp->responder_resources = min_t(u8, sp->responder_resources,
-					sc->ib.dev->attrs.max_qp_rd_atom);
+	sp->responder_resources = min3(sp->responder_resources,
+				       sc->ib.dev->attrs.max_qp_rd_atom,
+				       U8_MAX);
 	smbdirect_log_rdma_mr(sc, SMBDIRECT_LOG_INFO,
 		"responder_resources=%d\n",
 		sp->responder_resources);
diff --git a/fs/smb/smbdirect/connection.c b/fs/smb/smbdirect/connection.c
index 8adf58097534..690acb84e1b5 100644
--- a/fs/smb/smbdirect/connection.c
+++ b/fs/smb/smbdirect/connection.c
@@ -287,7 +287,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
 	    qp_cap.max_send_wr > sc->ib.dev->attrs.max_qp_wr) {
 		pr_err("Possible CQE overrun: max_send_wr %d\n",
 		       qp_cap.max_send_wr);
-		pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
+		pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
 		       IB_DEVICE_NAME_MAX,
 		       sc->ib.dev->name,
 		       sc->ib.dev->attrs.max_cqe,
@@ -302,7 +302,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
 	     max_send_wr >= sc->ib.dev->attrs.max_qp_wr)) {
 		pr_err("Possible CQE overrun: rdma_send_wr %d + max_send_wr %d = %d\n",
 		       rdma_send_wr, qp_cap.max_send_wr, max_send_wr);
-		pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
+		pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
 		       IB_DEVICE_NAME_MAX,
 		       sc->ib.dev->name,
 		       sc->ib.dev->attrs.max_cqe,
@@ -316,7 +316,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
 	    qp_cap.max_recv_wr > sc->ib.dev->attrs.max_qp_wr) {
 		pr_err("Possible CQE overrun: max_recv_wr %d\n",
 		       qp_cap.max_recv_wr);
-		pr_err("device %.*s reporting max_cqe %d max_qp_wr %d\n",
+		pr_err("device %.*s reporting max_cqe %u max_qp_wr %u\n",
 		       IB_DEVICE_NAME_MAX,
 		       sc->ib.dev->name,
 		       sc->ib.dev->attrs.max_cqe,
@@ -328,7 +328,7 @@ int smbdirect_connection_create_qp(struct smbdirect_socket *sc)
 
 	if (qp_cap.max_send_sge > sc->ib.dev->attrs.max_send_sge ||
 	    qp_cap.max_recv_sge > sc->ib.dev->attrs.max_recv_sge) {
-		pr_err("device %.*s max_send_sge/max_recv_sge = %d/%d too small\n",
+		pr_err("device %.*s max_send_sge/max_recv_sge = %u/%u too small\n",
 		       IB_DEVICE_NAME_MAX,
 		       sc->ib.dev->name,
 		       sc->ib.dev->attrs.max_send_sge,
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index df6e08aaad57..217f000be5d6 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -78,8 +78,8 @@ struct svcxprt_rdma {
 	struct rdma_cm_id    *sc_cm_id;		/* RDMA connection id */
 	struct list_head     sc_accept_q;	/* Conn. waiting accept */
 	struct rpcrdma_notification sc_rn;	/* removal notification */
-	int		     sc_ord;		/* RDMA read limit */
-	int                  sc_max_send_sges;
+	u32		     sc_ord;		/* RDMA read limit */
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
index 39f87272e071..4273c0279c35 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -204,7 +204,7 @@ static int rds_ib_add_one(struct ib_device *device)
 		goto put_dev;
 	}
 
-	rdsdebug("RDS/IB: max_mr = %d, max_wrs = %d, max_sge = %d, max_1m_mrs = %d, max_8k_mrs = %d\n",
+	rdsdebug("RDS/IB: max_mr = %u, max_wrs = %d, max_sge = %d, max_1m_mrs = %d, max_8k_mrs = %d\n",
 		 device->attrs.max_mr, rds_ibdev->max_wrs, rds_ibdev->max_sge,
 		 rds_ibdev->max_1m_mrs, rds_ibdev->max_8k_mrs);
 
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 6b40345ba44d..ff5fd15ee3b1 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -174,9 +174,11 @@ static void rds_ib_cm_fill_conn_param(struct rds_connection *conn,
 	memset(conn_param, 0, sizeof(struct rdma_conn_param));
 
 	conn_param->responder_resources =
-		min_t(u32, rds_ibdev->max_responder_resources, max_responder_resources);
+		min3(rds_ibdev->max_responder_resources,
+		     max_responder_resources, U8_MAX);
 	conn_param->initiator_depth =
-		min_t(u32, rds_ibdev->max_initiator_depth, max_initiator_depth);
+		min3(rds_ibdev->max_initiator_depth,
+		     max_initiator_depth, U8_MAX);
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
index f18bc60d9f4f..5f07914e2231 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -544,8 +544,8 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	set_bit(RDMAXPRT_CONN_PENDING, &newxprt->sc_flags);
 	memset(&conn_param, 0, sizeof conn_param);
 	conn_param.responder_resources = 0;
-	conn_param.initiator_depth = min_t(int, newxprt->sc_ord,
-					   dev->attrs.max_qp_init_rd_atom);
+	conn_param.initiator_depth = min(newxprt->sc_ord,
+					 dev->attrs.max_qp_init_rd_atom);
 	if (!conn_param.initiator_depth) {
 		ret = -EINVAL;
 		trace_svcrdma_initdepth_err(newxprt, ret);
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
index aecf9c0a153f..8ed9da6d2d2f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -453,7 +453,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	/* Client offers RDMA Read but does not initiate */
 	ep->re_remote_cma.initiator_depth = 0;
 	ep->re_remote_cma.responder_resources =
-		min_t(int, U8_MAX, device->attrs.max_qp_rd_atom);
+		min(device->attrs.max_qp_rd_atom, U8_MAX);
 
 	/* Limit transport retries so client can detect server
 	 * GID changes quickly. RPC layer handles re-establishing
-- 
2.34.1


