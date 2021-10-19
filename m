Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45C433033
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhJSH4u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 03:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhJSH4s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 03:56:48 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9A0C061768;
        Tue, 19 Oct 2021 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q3jm9Tk7zAzK5BgZAZGbiTxN6Hr9Dxr1oLqGtQ3CgH0=; b=tO421y1UIFYznSmCisg7xRIk+h
        BfOoG30GAlG2gS0MnmWZkd2WXFDZHmPoma9fB4dbpzFzDuYm/Dj2pTmP+A2F+BfH6nDoyBA1IBd6h
        +c50syZq+QJCJ9cM5CttmELUDPflVk1PiHyQXTowmvMKolIJ+uKhUrmA8Eh9k9MGqDB2nTz0o9Eb3
        AG4asZ3CERmp1Bb3Suh5exC6pxLWmG2iQ24+sOS5ndPN3xFPDkPCVQ2/fq4QpEQfb4E4XKejlsZgX
        eRL1XCTraKpEuzbTKsirFDxcbJ/Q7mVj3hhQHBQqb8FSurkuv/xnXzA+MJlZYS/TdiFNHLTijjnRx
        fknFE5Dw==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjxB-000TAz-KE; Tue, 19 Oct 2021 07:54:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/7] scsi: add a scsi_alloc_request helper
Date:   Tue, 19 Oct 2021 09:54:16 +0200
Message-Id: <20211019075418.2332481-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019075418.2332481-1-hch@lst.de>
References: <20211019075418.2332481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a new helper that calls blk_get_request and initializes the
scsi_request to avoid the indirect call through ->.initialize_rq_fn.

Note that this makes the pktcdvd driver depend on the SCSI core, but
given that only SCSI devices support SCSI passthrough requests that
is not a functional change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/Kconfig              |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/scsi/scsi_bsg.c            |  4 ++--
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_ioctl.c          |  4 ++--
 drivers/scsi/scsi_lib.c            | 19 +++++++++++++------
 drivers/scsi/sg.c                  |  4 ++--
 drivers/scsi/sr.c                  |  2 +-
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 include/scsi/scsi_cmnd.h           |  3 +++
 11 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ab3e37aa1830c..9151e8ffba1cf 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -304,8 +304,8 @@ config BLK_DEV_RAM_SIZE
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media (DEPRECATED)"
 	depends on !UML
+	depends on SCSI
 	select CDROM
-	select SCSI_COMMON
 	help
 	  Note: This driver is deprecated and will be removed from the
 	  kernel in the near future!
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index cb52cce6fb039..ea2262ec76d2c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -703,7 +703,7 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 	struct request *rq;
 	int ret = 0;
 
-	rq = blk_get_request(q, (cgc->data_direction == CGC_DATA_WRITE) ?
+	rq = scsi_alloc_request(q, (cgc->data_direction == CGC_DATA_WRITE) ?
 			     REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 81c3853a2a800..551727a6f6941 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -25,8 +25,8 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 		return -EOPNOTSUPP;
 	}
 
-	rq = blk_get_request(q, hdr->dout_xfer_len ?
-			     REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
+	rq = scsi_alloc_request(q, hdr->dout_xfer_len ?
+				REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 	rq->timeout = timeout;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index b6c86cce57bfa..71d027b94be40 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1998,7 +1998,7 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 	struct request *req;
 	struct scsi_request *rq;
 
-	req = blk_get_request(sdev->request_queue, REQ_OP_DRV_IN, 0);
+	req = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req))
 		return;
 	rq = scsi_req(req);
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 6ff2207bd45a0..0078975e3c07c 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -438,7 +438,7 @@ static int sg_io(struct scsi_device *sdev, struct gendisk *disk,
 		at_head = 1;
 
 	ret = -ENOMEM;
-	rq = blk_get_request(sdev->request_queue, writing ?
+	rq = scsi_alloc_request(sdev->request_queue, writing ?
 			     REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
@@ -561,7 +561,7 @@ static int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk,
 
 	}
 
-	rq = blk_get_request(q, in_len ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
+	rq = scsi_alloc_request(q, in_len ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq)) {
 		err = PTR_ERR(rq);
 		goto error_free_buffer;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 30f7d0b4eb732..a0f801fc8943b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -216,7 +216,7 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	struct scsi_request *rq;
 	int ret;
 
-	req = blk_get_request(sdev->request_queue,
+	req = scsi_alloc_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 			rq_flags & RQF_PM ? BLK_MQ_REQ_PM : 0);
@@ -1079,9 +1079,6 @@ EXPORT_SYMBOL(scsi_alloc_sgtables);
  * This function initializes the members of struct scsi_cmnd that must be
  * initialized before request processing starts and that won't be
  * reinitialized if a SCSI command is requeued.
- *
- * Called from inside blk_get_request() for pass-through requests and from
- * inside scsi_init_command() for filesystem requests.
  */
 static void scsi_initialize_rq(struct request *rq)
 {
@@ -1098,6 +1095,18 @@ static void scsi_initialize_rq(struct request *rq)
 	cmd->retries = 0;
 }
 
+struct request *scsi_alloc_request(struct request_queue *q,
+		unsigned int op, blk_mq_req_flags_t flags)
+{
+	struct request *rq;
+
+	rq = blk_get_request(q, op, flags);
+	if (!IS_ERR(rq))
+		scsi_initialize_rq(rq);
+	return rq;
+}
+EXPORT_SYMBOL_GPL(scsi_alloc_request);
+
 /*
  * Only called when the request isn't completed by SCSI, and not freed by
  * SCSI
@@ -1864,7 +1873,6 @@ static const struct blk_mq_ops scsi_mq_ops_no_commit = {
 #endif
 	.init_request	= scsi_mq_init_request,
 	.exit_request	= scsi_mq_exit_request,
-	.initialize_rq_fn = scsi_initialize_rq,
 	.cleanup_rq	= scsi_cleanup_rq,
 	.busy		= scsi_mq_lld_busy,
 	.map_queues	= scsi_map_queues,
@@ -1894,7 +1902,6 @@ static const struct blk_mq_ops scsi_mq_ops = {
 #endif
 	.init_request	= scsi_mq_init_request,
 	.exit_request	= scsi_mq_exit_request,
-	.initialize_rq_fn = scsi_initialize_rq,
 	.cleanup_rq	= scsi_cleanup_rq,
 	.busy		= scsi_mq_lld_busy,
 	.map_queues	= scsi_map_queues,
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3c98f08dc25d9..85f57ac0b844e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1718,13 +1718,13 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	 *
 	 * With scsi-mq enabled, there are a fixed number of preallocated
 	 * requests equal in number to shost->can_queue.  If all of the
-	 * preallocated requests are already in use, then blk_get_request()
+	 * preallocated requests are already in use, then scsi_alloc_request()
 	 * will sleep until an active command completes, freeing up a request.
 	 * Although waiting in an asynchronous interface is less than ideal, we
 	 * do not want to use BLK_MQ_REQ_NOWAIT here because userspace might
 	 * not expect an EWOULDBLOCK from this condition.
 	 */
-	rq = blk_get_request(q, hp->dxfer_direction == SG_DXFER_TO_DEV ?
+	rq = scsi_alloc_request(q, hp->dxfer_direction == SG_DXFER_TO_DEV ?
 			REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq)) {
 		kfree(long_cmdp);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 115f7ef7a5def..7c4d9a9647999 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -967,7 +967,7 @@ static int sr_read_cdda_bpc(struct cdrom_device_info *cdi, void __user *ubuf,
 	struct bio *bio;
 	int ret;
 
-	rq = blk_get_request(disk->queue, REQ_OP_DRV_IN, 0);
+	rq = scsi_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 	req = scsi_req(rq);
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 9933722acfd96..1275299f61597 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -543,7 +543,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 	int err = 0;
 	struct scsi_tape *STp = SRpnt->stp;
 
-	req = blk_get_request(SRpnt->stp->device->request_queue,
+	req = scsi_alloc_request(SRpnt->stp->device->request_queue,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req))
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 75ef52f008ff6..b5705a2bd7618 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -980,11 +980,10 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 	memcpy(pt->pscsi_cdb, cmd->t_task_cdb,
 		scsi_command_size(cmd->t_task_cdb));
 
-	req = blk_get_request(pdv->pdv_sd->request_queue,
+	req = scsi_alloc_request(pdv->pdv_sd->request_queue,
 			cmd->data_direction == DMA_TO_DEVICE ?
 			REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req)) {
-		pr_err("PSCSI: blk_get_request() failed\n");
 		ret = TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 		goto fail;
 	}
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index eaf04c9a1dfcb..31078063afac2 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -396,4 +396,7 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 extern void scsi_build_sense(struct scsi_cmnd *scmd, int desc,
 			     u8 key, u8 asc, u8 ascq);
 
+struct request *scsi_alloc_request(struct request_queue *q,
+		unsigned int op, blk_mq_req_flags_t flags);
+
 #endif /* _SCSI_SCSI_CMND_H */
-- 
2.30.2

