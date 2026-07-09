Return-Path: <linux-nfs+bounces-23182-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5dFROJ43T2oucQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23182-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 07:54:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ED872CE77
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 07:54:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=Y+7E2AjR;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23182-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23182-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE6C3017C3D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E233A7858;
	Thu,  9 Jul 2026 05:53:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166953890F8;
	Thu,  9 Jul 2026 05:53:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576383; cv=none; b=fOz1kBRK0iB0k2HdjzqY+mYltF2p8o0QC2aC/dh2agcsJGWS/kr1cseMxZJiFl0i6DNDuFPJ+5lMmjKOOEUJQ/JABxKRt4AYauK6jYhUeN/s0Jed8jj6LUHUznPGgZa+RleBnT2tzjzAJulJef3OsmNymPTCgVFADJZ36JaGq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576383; c=relaxed/simple;
	bh=2w8LJvWrERr/VMcurZnKsPgH9L2XAJJy7y4BBEuJHbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBoyZuRZ645SY3riR1cxfDOb7RnA6JVJ3HlUh8Z1qBEoRqZsGtupekouPnDFrkR8yUGV3gYqgEeqMxKOrTEcUNN4CHdC6DpvfT7LA78+LCPDntyBK6IjeUOgFMqLn10qGtMin8kpZnRgLJKbrwk6Ar/8rKKl2+NMDQNH7Qerej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y+7E2AjR; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 579C620B716B; Wed,  8 Jul 2026 22:52:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 579C620B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783576375;
	bh=PvD7ZW1YhyyiRApFeZHWb2bsdT3h+s7PPmq42xe+LvI=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+7E2AjR0ZdFr6iNAvezuZTvMpy9YCCNQ+2RHtH9TzCg9otSfcCmZoXhZx9pX49wG
	 rDUaJqCMYtQxffhOg9MZVXDltIhPT6k0BC7YTtv/XKmsoUFb3RAYsoy+BY9DvnorEE
	 IEXb0u9elh/D14Em/XHIqwlZe0L8mBQ6CXO1UZh4=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	mkalderon@marvell.com,
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
	cel@kernel.org,
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
	michaelgur@nvidia.com,
	edwards@nvidia.com,
	phaddad@nvidia.com,
	eadavis@qq.com,
	yishaih@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com,
	andriy.shevchenko@linux.intel.com,
	clm@meta.com,
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
Subject: [PATCH v10 rdma-next] RDMA: Change capability fields in ib_device_attr from int to u32
Date: Wed,  8 Jul 2026 22:51:29 -0700
Message-ID: <20260709055211.2498307-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:mkalderon@marvell.com,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:michaelgur@nvidia.com,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:eadavis@qq.com,m:yishaih@nvidia.com,m:kalesh-anakkur.purayil@broadcom.com,m:andriy.shevchenko@linux.intel.com,m:clm@meta.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@
 vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:ernis@linux.microsoft.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23182-lists,linux-nfs=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,marvell.com,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,brown.name,redhat.com,oracle.com,davemloft.net,google.com,qq.com,broadcom.com,linux.intel.com,meta.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09ED872CE77

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

The nvmet-rdma consumer of max_srq clamps it against
ib_device.num_comp_vectors, which stays a signed int, so that site
uses min_t() instead of min() to handle the signed/unsigned mismatch.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Acked-by: Stefan Metzmacher <metze@samba.org> # smbdirect
---
Changes in v10:
* Convert max_srq to u32. Use min_t() against the still-signed ib_device.num_comp_vectors.
* Update commit message.
* Change rdma_restrack_count() to return u32 and make fill_res_info()'s curr and max u64.
Changes in v9:
* Switch the srq_size module parameter accessors to param_get_uint and
  kstrtouint()/param_set_uint() so they match the now-unsigned
  nvmet_rdma_srq_size variable.
Changes in v8:
* Convert the remaining non-negative counter fields max_ee_rd_atom,
  max_ee_init_rd_atom, max_ee, max_rdd, max_raw_ipv6_qp and max_srq_wr
  to u32; keep max_srq as int (its consumer compares it against
  ib_device.num_comp_vectors, still int).
* Drop all remaining min_t() where plain min() now works.
* Make the srq_size module parameters unsigned int so the srq_size min()
  stays a plain min().
* Replace the ternary-inside-min() with the simpler "if (x) x--;".
* Reorder the send_queue_depth min() to min(value, CONST) to match the
  sibling site.
* Restore reverse xmas-tree declaration order.
* Collapse the min()/min3() assignments that now fit onto a single line
  within 100 columns.
* Print the now-u32 fields with %u instead of %d.
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
* rds/ib_cm, smbdirect/connect and smbdirect/accept where u32 capability
  fields were directly narrowed into u8 rdma_conn_param fields without
  clamping.
* Guard the inline_sge_count calculation in nvmet_rdma_find_get_device()
  to prevent u32 underflow when both max_sge_rd and max_recv_sge are
zero.
* Expand type migration to 9 additional fields (max_mw, max_raw_ethy_qp,
  max_mcast_grp, max_mcast_qp_attach, max_total_mcast_qp_attach, max_ah,
  max_srq, max_srq_wr, max_srq_sge)
* Fix min_t(int,...) in svc_rdma_transport; min_t(u32,...) in ipoib,
  srpt, nvme/target, rds/ib, rtrs-clt, rtrs-srv, xprtrdma/verbsdd.
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
 drivers/infiniband/core/cq.c               |  3 +-
 drivers/infiniband/core/nldev.c            |  3 +-
 drivers/infiniband/core/restrack.c         |  2 +-
 drivers/infiniband/hw/qedr/verbs.c         |  2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c         | 22 ++++-----
 drivers/infiniband/sw/rxe/rxe_srq.c        | 16 +++----
 drivers/infiniband/ulp/ipoib/ipoib_cm.c    | 10 ++---
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c |  3 +-
 drivers/infiniband/ulp/iser/iser_verbs.c   |  5 +--
 drivers/infiniband/ulp/isert/ib_isert.c    |  7 ++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c     | 11 ++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c     | 11 ++---
 drivers/infiniband/ulp/srp/ib_srp.c        |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c      | 21 +++++----
 drivers/nvme/host/rdma.c                   |  8 ++--
 drivers/nvme/target/rdma.c                 | 26 ++++++-----
 fs/smb/smbdirect/accept.c                  |  5 ++-
 fs/smb/smbdirect/connect.c                 |  5 ++-
 fs/smb/smbdirect/connection.c              |  8 ++--
 include/linux/sunrpc/svc_rdma.h            |  4 +-
 include/rdma/ib_verbs.h                    | 52 +++++++++++-----------
 include/rdma/restrack.h                    |  2 +-
 net/rds/ib.c                               | 10 ++---
 net/rds/ib_cm.c                            | 10 ++---
 net/sunrpc/xprtrdma/frwr_ops.c             |  7 +--
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 +--
 net/sunrpc/xprtrdma/verbs.c                |  2 +-
 27 files changed, 129 insertions(+), 133 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 3d7b6cddd131..ee98188e57fb 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -393,8 +393,7 @@ static int ib_alloc_cqs(struct ib_device *dev, unsigned int nr_cqes,
 	 * a reasonable batch size so that we can share CQs between
 	 * multiple users instead of allocating a larger number of CQs.
 	 */
-	nr_cqes = min_t(unsigned int, dev->attrs.max_cqe,
-			max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
+	nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
 	nr_cqs = min_t(unsigned int, dev->num_comp_vectors, num_online_cpus());
 	for (i = 0; i < nr_cqs; i++) {
 		cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index f599c24b34e8..aae4f3f6bcba 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -454,7 +454,8 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
 	};
 
 	struct nlattr *table_attr;
-	int ret, i, curr, max;
+	u64 curr, max;
+	int ret, i;
 
 	if (fill_nldev_handle(msg, device))
 		return -EMSGSIZE;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index cfee2071586c..1b2f9df49e28 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -61,7 +61,7 @@ void rdma_restrack_clean(struct ib_device *dev)
  * @type: actual type of object to operate
  * @show_details: count driver specific objects
  */
-int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
+u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
 			bool show_details)
 {
 	struct rdma_restrack_root *rt = &dev->res[type];
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index c90a1b5c8ee7..d5416b161340 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -148,7 +148,7 @@ int qedr_query_device(struct ib_device *ibdev,
 	attr->max_qp_init_rd_atom =
 	    1 << (fls(qattr->max_qp_req_rd_atomic_resc) - 1);
 	attr->max_qp_rd_atom =
-	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
+	    min(1U << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
 		attr->max_qp_init_rd_atom);
 
 	attr->max_srq = qattr->max_srq;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f3dff1aea96a..7a0529a17992 100644
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
@@ -537,9 +537,9 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
 		if (attr->max_rd_atomic > rxe->attr.max_qp_rd_atom) {
-			rxe_dbg_qp(qp, "invalid max_rd_atomic %d > %d\n",
-				 attr->max_rd_atomic,
-				 rxe->attr.max_qp_rd_atom);
+			rxe_dbg_qp(qp, "invalid max_rd_atomic %u > %u\n",
+				   attr->max_rd_atomic,
+				   rxe->attr.max_qp_rd_atom);
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
index 57fec88a1629..ed0592898384 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1071,8 +1071,7 @@ static struct ib_qp *ipoib_cm_create_tx_qp(struct net_device *dev, struct ipoib_
 	struct ib_qp *tx_qp;
 
 	if (dev->features & NETIF_F_SG)
-		attr.cap.max_send_sge = min_t(u32, priv->ca->attrs.max_send_sge,
-					      MAX_SKB_FRAGS + 1);
+		attr.cap.max_send_sge = min(priv->ca->attrs.max_send_sge, MAX_SKB_FRAGS + 1);
 
 	tx_qp = ib_create_qp(priv->pd, &attr);
 	tx->max_send_sge = attr.cap.max_send_sge;
@@ -1582,7 +1581,8 @@ static void ipoib_cm_create_srq(struct net_device *dev, int max_sge)
 int ipoib_cm_dev_init(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
-	int max_srq_sge, i;
+	u32 max_srq_sge;
+	int i;
 	u8 addr;
 
 	INIT_LIST_HEAD(&priv->cm.passive_ids);
@@ -1600,9 +1600,9 @@ int ipoib_cm_dev_init(struct net_device *dev)
 
 	skb_queue_head_init(&priv->cm.skb_queue);
 
-	ipoib_dbg(priv, "max_srq_sge=%d\n", priv->ca->attrs.max_srq_sge);
+	ipoib_dbg(priv, "max_srq_sge=%u\n", priv->ca->attrs.max_srq_sge);
 
-	max_srq_sge = min_t(int, IPOIB_CM_RX_SG, priv->ca->attrs.max_srq_sge);
+	max_srq_sge = min(priv->ca->attrs.max_srq_sge, IPOIB_CM_RX_SG);
 	ipoib_cm_create_srq(dev, max_srq_sge);
 	if (ipoib_cm_has_srq(dev)) {
 		priv->cm.max_cm_mtu = max_srq_sge * PAGE_SIZE - 0x10;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index 3ed1ea566690..2490696a1aab 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -147,8 +147,7 @@ int ipoib_transport_dev_init(struct net_device *dev, struct ib_device *ca)
 		.cap = {
 			.max_send_wr  = ipoib_sendq_size,
 			.max_recv_wr  = ipoib_recvq_size,
-			.max_send_sge = min_t(u32, priv->ca->attrs.max_send_sge,
-					      MAX_SKB_FRAGS + 1),
+			.max_send_sge = min(priv->ca->attrs.max_send_sge, MAX_SKB_FRAGS + 1),
 			.max_recv_sge = IPOIB_UD_RX_SG
 		},
 		.sq_sig_type = IB_SIGNAL_ALL_WR,
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index f03b3bb3c0c4..55fe68e5b837 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -244,8 +244,7 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 		max_send_wr = ISER_QP_SIG_MAX_REQ_DTOS + 1;
 	else
 		max_send_wr = ISER_QP_MAX_REQ_DTOS + 1;
-	max_send_wr = min_t(unsigned int, max_send_wr,
-			    (unsigned int)ib_dev->attrs.max_qp_wr);
+	max_send_wr = min(max_send_wr, ib_dev->attrs.max_qp_wr);
 
 	cq_size = max_send_wr + ISER_QP_MAX_RECV_DTOS;
 	ib_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1, IB_POLL_SOFTIRQ);
@@ -589,7 +588,7 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 		goto failure;
 
 	memset(&conn_param, 0, sizeof conn_param);
-	conn_param.responder_resources = ib_dev->attrs.max_qp_rd_atom;
+	conn_param.responder_resources = min(ib_dev->attrs.max_qp_rd_atom, U8_MAX);
 	conn_param.initiator_depth = 1;
 	conn_param.retry_count = 7;
 	conn_param.rnr_retry_count = 6;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 1015a51f750a..4691845bf815 100644
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
@@ -381,8 +381,7 @@ isert_set_nego_params(struct isert_conn *isert_conn,
 	struct ib_device_attr *attr = &isert_conn->device->ib_device->attrs;
 
 	/* Set max inflight RDMA READ requests */
-	isert_conn->initiator_depth = min_t(u8, param->initiator_depth,
-				attr->max_qp_init_rd_atom);
+	isert_conn->initiator_depth = min(param->initiator_depth, attr->max_qp_init_rd_atom);
 	isert_dbg("Using initiator_depth: %u\n", isert_conn->initiator_depth);
 
 	if (param->private_data) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d34d7e5f34d6..7b2c51ae614f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1675,8 +1675,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		 * + 2 for drain and heartbeat
 		 * in case qp gets into error state.
 		 */
-		max_send_wr =
-			min_t(int, wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
+		max_send_wr = min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
 		max_recv_wr = max_send_wr;
 	} else {
 		/*
@@ -1692,11 +1691,9 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		wr_limit = clt_path->s.dev->ib_dev->attrs.max_qp_wr;
 		/* Shared between connections */
 		clt_path->s.dev_ref++;
-		max_send_wr = min_t(int, wr_limit,
-			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
-			      clt_path->queue_depth * 4 + 1);
-		max_recv_wr = min_t(int, wr_limit,
-			      clt_path->queue_depth * 3 + 1);
+		/* QD * (REQ + RSP + FR REGS or INVS) + drain */
+		max_send_wr = min(wr_limit, clt_path->queue_depth * 4 + 1);
+		max_recv_wr = min(wr_limit, clt_path->queue_depth * 3 + 1);
 		max_send_sge = 2;
 	}
 	atomic_set(&con->c.sq_wr_avail, max_send_wr);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 7d8e4422cc57..5314599d29fe 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1740,21 +1740,16 @@ static int create_con(struct rtrs_srv_path *srv_path,
 		 * All receive and all send (each requiring invalidate)
 		 * + 2 for drain and heartbeat
 		 */
-		max_send_wr = min_t(int, wr_limit,
-				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);
+		max_send_wr = min(wr_limit, SERVICE_CON_QUEUE_DEPTH * 2 + 2);
 		max_recv_wr = max_send_wr;
 		s->signal_interval = min_not_zero(srv->queue_depth,
 						  (size_t)SERVICE_CON_QUEUE_DEPTH);
 	} else {
 		/* when always_invlaidate enalbed, we need linv+rinv+mr+imm */
 		if (always_invalidate)
-			max_send_wr =
-				min_t(int, wr_limit,
-				      srv->queue_depth * (1 + 4) + 1);
+			max_send_wr = min(wr_limit, srv->queue_depth * (1 + 4) + 1);
 		else
-			max_send_wr =
-				min_t(int, wr_limit,
-				      srv->queue_depth * (1 + 2) + 1);
+			max_send_wr = min(wr_limit, srv->queue_depth * (1 + 2) + 1);
 
 		max_recv_wr = srv->queue_depth + 1;
 	}
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index acbd787de265..0caebbc2810f 100644
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
index f66cfd70c263..a760b4fbee90 100644
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
 
@@ -405,8 +405,7 @@ static void srpt_get_ioc(struct srpt_port *sport, u32 slot,
 	if (sdev->use_srq)
 		send_queue_depth = sdev->srq_size;
 	else
-		send_queue_depth = min(MAX_SRPT_RQ_SIZE,
-				       sdev->device->attrs.max_qp_wr);
+		send_queue_depth = min(sdev->device->attrs.max_qp_wr, MAX_SRPT_RQ_SIZE);
 
 	memset(iocp, 0, sizeof(*iocp));
 	strcpy(iocp->id_string, SRPT_ID_STRING);
@@ -1851,7 +1850,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 	struct srpt_port *sport = ch->sport;
 	struct srpt_device *sdev = sport->sdev;
 	const struct ib_device_attr *attrs = &sdev->device->attrs;
-	int sq_size = sport->port_attrib.srp_sq_size;
+	u32 sq_size = sport->port_attrib.srp_sq_size;
 	int i, ret;
 
 	WARN_ON(ch->rq_size < 1);
@@ -1912,13 +1911,13 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
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
@@ -1926,7 +1925,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
 
 	atomic_set(&ch->sq_wr_avail, qp_init->cap.max_send_wr);
 
-	pr_debug("%s: max_cqe= %d max_sge= %d sq_size = %d ch= %p\n",
+	pr_debug("%s: max_cqe= %d max_sge= %d sq_size = %u ch= %p\n",
 		 __func__, ch->cq->cqe, qp_init->cap.max_send_sge,
 		 qp_init->cap.max_send_wr, ch);
 
@@ -2299,7 +2298,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	 * depth to avoid that the initiator driver has to report QUEUE_FULL
 	 * to the SCSI mid-layer.
 	 */
-	ch->rq_size = min(MAX_SRPT_RQ_SIZE, sdev->device->attrs.max_qp_wr);
+	ch->rq_size = min(sdev->device->attrs.max_qp_wr, MAX_SRPT_RQ_SIZE);
 	spin_lock_init(&ch->spinlock);
 	ch->state = CH_CONNECTING;
 	INIT_LIST_HEAD(&ch->cmd_wait_list);
@@ -3137,7 +3136,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 		return PTR_ERR(srq);
 	}
 
-	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
+	pr_debug("create SRQ #wr= %d max_allow=%u dev= %s\n", sdev->srq_size,
 		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
 
 	sdev->req_buf_cache = srpt_cache_get(srp_max_req_size);
@@ -3952,7 +3951,7 @@ static int __init srpt_init_module(void)
 
 	if (srpt_srq_size < MIN_SRPT_SRQ_SIZE
 	    || srpt_srq_size > MAX_SRPT_SRQ_SIZE) {
-		pr_err("invalid value %d for kernel module parameter srpt_srq_size -- must be in the range [%d..%d].\n",
+		pr_err("invalid value %u for kernel module parameter srpt_srq_size -- must be in the range [%d..%d].\n",
 		       srpt_srq_size, MIN_SRPT_SRQ_SIZE, MAX_SRPT_SRQ_SIZE);
 		goto out;
 	}
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..56cd228af1d5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -394,8 +394,10 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 		goto out_free_pd;
 	}
 
-	ndev->num_inline_segments = min(NVME_RDMA_MAX_INLINE_SEGMENTS,
-					ndev->dev->attrs.max_send_sge - 1);
+	ndev->num_inline_segments = ndev->dev->attrs.max_send_sge;
+	if (ndev->num_inline_segments)
+		ndev->num_inline_segments--;
+	ndev->num_inline_segments = min(ndev->num_inline_segments, NVME_RDMA_MAX_INLINE_SEGMENTS);
 	list_add(&ndev->entry, &device_list);
 out_unlock:
 	mutex_unlock(&device_list_mutex);
@@ -1847,7 +1849,7 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 	param.qp_num = queue->qp->qp_num;
 	param.flow_control = 1;
 
-	param.responder_resources = queue->device->dev->attrs.max_qp_rd_atom;
+	param.responder_resources = min(queue->device->dev->attrs.max_qp_rd_atom, U8_MAX);
 	/* maximum retry count */
 	param.retry_count = 7;
 	param.rnr_retry_count = 7;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ea1185b8267e..bdd28ce99faa 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -149,10 +149,10 @@ MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
 static int srq_size_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops srq_size_ops = {
 	.set = srq_size_set,
-	.get = param_get_int,
+	.get = param_get_uint,
 };
 
-static int nvmet_rdma_srq_size = 1024;
+static unsigned int nvmet_rdma_srq_size = 1024;
 module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
 MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
 
@@ -180,13 +180,14 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops;
 
 static int srq_size_set(const char *val, const struct kernel_param *kp)
 {
-	int n = 0, ret;
+	unsigned int n;
+	int ret;
 
-	ret = kstrtoint(val, 10, &n);
+	ret = kstrtouint(val, 10, &n);
 	if (ret != 0 || n < 256)
 		return -EINVAL;
 
-	return param_set_int(val, kp);
+	return param_set_uint(val, kp);
 }
 
 static int num_pages(int len)
@@ -1153,8 +1154,8 @@ static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
 
 	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
 			     nvmet_rdma_srq_size);
-	ndev->srq_count = min(ndev->device->num_comp_vectors,
-			      ndev->device->attrs.max_srq);
+	ndev->srq_count = min_t(u32, ndev->device->num_comp_vectors,
+				ndev->device->attrs.max_srq);
 
 	ndev->srqs = kzalloc_objs(*ndev->srqs, ndev->srq_count);
 	if (!ndev->srqs)
@@ -1199,7 +1200,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	struct nvmet_port *nport = port->nport;
 	struct nvmet_rdma_device *ndev;
 	int inline_page_count;
-	int inline_sge_count;
+	u32 inline_sge_count;
 	int ret;
 
 	mutex_lock(&device_list_mutex);
@@ -1215,7 +1216,9 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 
 	inline_page_count = num_pages(nport->inline_data_size);
 	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
-				cm_id->device->attrs.max_recv_sge) - 1;
+				cm_id->device->attrs.max_recv_sge);
+	if (inline_sge_count)
+		inline_sge_count--;
 	if (inline_page_count > inline_sge_count) {
 		pr_warn("inline_data_size %d cannot be supported by device %s. Reducing to %lu.\n",
 			nport->inline_data_size, cm_id->device->name,
@@ -1555,8 +1558,9 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 
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
index 5aadb47b3b0e..76aa5ec4ab40 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -77,8 +77,8 @@ struct svcxprt_rdma {
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
index 794746de8db0..8d82d303b723 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -407,36 +407,36 @@ struct ib_device_attr {
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
-	int			max_ee_rd_atom;
-	int			max_res_rd_atom;
-	int			max_qp_init_rd_atom;
-	int			max_ee_init_rd_atom;
+	u32			max_send_sge;
+	u32			max_recv_sge;
+	u32			max_sge_rd;
+	u32			max_cq;
+	u32			max_cqe;
+	u32			max_mr;
+	u32			max_pd;
+	u32			max_qp_rd_atom;
+	u32			max_ee_rd_atom;
+	u32			max_res_rd_atom;
+	u32			max_qp_init_rd_atom;
+	u32			max_ee_init_rd_atom;
 	enum ib_atomic_cap	atomic_cap;
 	enum ib_atomic_cap	masked_atomic_cap;
-	int			max_ee;
-	int			max_rdd;
-	int			max_mw;
-	int			max_raw_ipv6_qp;
-	int			max_raw_ethy_qp;
-	int			max_mcast_grp;
-	int			max_mcast_qp_attach;
-	int			max_total_mcast_qp_attach;
-	int			max_ah;
-	int			max_srq;
-	int			max_srq_wr;
-	int			max_srq_sge;
+	u32			max_ee;
+	u32			max_rdd;
+	u32			max_mw;
+	u32			max_raw_ipv6_qp;
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
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 451f99e3717d..c081384740ce 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -123,7 +123,7 @@ struct rdma_restrack_entry {
 	u32 id;
 };
 
-int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
+u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
 			bool show_details);
 /**
  * rdma_is_kernel_res() - check the owner of resource
diff --git a/net/rds/ib.c b/net/rds/ib.c
index 39f87272e071..c62684d4259c 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -162,12 +162,12 @@ static int rds_ib_add_one(struct ib_device *device)
 		   IB_ODP_SUPPORT_READ);
 
 	rds_ibdev->max_1m_mrs = device->attrs.max_mr ?
-		min_t(unsigned int, (device->attrs.max_mr / 2),
-		      rds_ib_mr_1m_pool_size) : rds_ib_mr_1m_pool_size;
+		min(device->attrs.max_mr / 2,
+		    rds_ib_mr_1m_pool_size) : rds_ib_mr_1m_pool_size;
 
 	rds_ibdev->max_8k_mrs = device->attrs.max_mr ?
-		min_t(unsigned int, ((device->attrs.max_mr / 2) * RDS_MR_8K_SCALE),
-		      rds_ib_mr_8k_pool_size) : rds_ib_mr_8k_pool_size;
+		min((device->attrs.max_mr / 2) * RDS_MR_8K_SCALE,
+		    rds_ib_mr_8k_pool_size) : rds_ib_mr_8k_pool_size;
 
 	rds_ibdev->max_initiator_depth = device->attrs.max_qp_init_rd_atom;
 	rds_ibdev->max_responder_resources = device->attrs.max_qp_rd_atom;
@@ -204,7 +204,7 @@ static int rds_ib_add_one(struct ib_device *device)
 		goto put_dev;
 	}
 
-	rdsdebug("RDS/IB: max_mr = %d, max_wrs = %d, max_sge = %d, max_1m_mrs = %d, max_8k_mrs = %d\n",
+	rdsdebug("RDS/IB: max_mr = %u, max_wrs = %d, max_sge = %d, max_1m_mrs = %d, max_8k_mrs = %d\n",
 		 device->attrs.max_mr, rds_ibdev->max_wrs, rds_ibdev->max_sge,
 		 rds_ibdev->max_1m_mrs, rds_ibdev->max_8k_mrs);
 
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 5667f0173b47..17e587c30076 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -173,11 +173,11 @@ static void rds_ib_cm_fill_conn_param(struct rds_connection *conn,
 
 	memset(conn_param, 0, sizeof(struct rdma_conn_param));
 
-	conn_param->responder_resources =
-		min_t(u32, rds_ibdev->max_responder_resources, max_responder_resources);
-	conn_param->initiator_depth =
-		min_t(u32, rds_ibdev->max_initiator_depth, max_initiator_depth);
-	conn_param->retry_count = min_t(unsigned int, rds_ib_retry_count, 7);
+	conn_param->responder_resources = min3(rds_ibdev->max_responder_resources,
+					       max_responder_resources, U8_MAX);
+	conn_param->initiator_depth = min3(rds_ibdev->max_initiator_depth,
+					   max_initiator_depth, U8_MAX);
+	conn_param->retry_count = min(rds_ib_retry_count, 7U);
 	conn_param->rnr_retry_count = 7;
 
 	if (dp) {
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index e5c71cf705a3..e83cef19e656 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -172,8 +172,9 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 {
 	const struct ib_device_attr *attrs = &device->attrs;
-	int max_qp_wr, depth, delta;
 	unsigned int max_sge;
+	u32 max_qp_wr;
+	int depth, delta;
 
 	if (!(attrs->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS) ||
 	    attrs->max_fast_reg_page_list_len == 0) {
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
index 7ca71741106b..e0289adce7f5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -562,8 +562,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	set_bit(RDMAXPRT_CONN_PENDING, &newxprt->sc_flags);
 	memset(&conn_param, 0, sizeof conn_param);
 	conn_param.responder_resources = 0;
-	conn_param.initiator_depth = min_t(int, newxprt->sc_ord,
-					   dev->attrs.max_qp_init_rd_atom);
+	conn_param.initiator_depth = min(newxprt->sc_ord, dev->attrs.max_qp_init_rd_atom);
 	if (!conn_param.initiator_depth) {
 		ret = -EINVAL;
 		trace_svcrdma_initdepth_err(newxprt, ret);
@@ -588,7 +587,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
 		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
 		dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
-		dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
+		dprintk("    max_sge         : %u\n", newxprt->sc_max_send_sges);
 		dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
 		dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
 		dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 04b286223b24..be335eed329d 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -465,7 +465,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	/* Client offers RDMA Read but does not initiate */
 	ep->re_remote_cma.initiator_depth = 0;
 	ep->re_remote_cma.responder_resources =
-		min_t(int, U8_MAX, device->attrs.max_qp_rd_atom);
+		min(device->attrs.max_qp_rd_atom, U8_MAX);
 
 	/* Limit transport retries so client can detect server
 	 * GID changes quickly. RPC layer handles re-establishing
-- 
2.34.1


