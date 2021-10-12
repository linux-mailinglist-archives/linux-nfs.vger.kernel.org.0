Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8D42A40E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbhJLMNd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 08:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbhJLMNd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 08:13:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3FC061570;
        Tue, 12 Oct 2021 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+Z3bPGauP7YICVQ9NovXbznqUa/Id0iz8BTpNdCvDKo=; b=IHyGT5Rlm/jwhQVGOb7aK+Jtu8
        ciW+MKjmwfK00iQDS0esp9tOSF1Ie3yNJW5Gquz3TeOORDJ1uqjGKPWa+a28wZm06ZgnUp3mYDwxA
        LQNTS4M5a/IQIpd4aWOzlfTpargPwY3ydeivLCKEK2E4G/44gmrTOhQi6tL1cSG4qxXG2ky7y326D
        SBxBUTlYaErP0OaDjYq4CX4hKE5AgTaDDsLYLIDYTNJTfgkzmOiPQpWiD9KO6n4dxD8fsHrbH10xP
        uGTzMiz9EOLefLeYKnT6KaIM5lT4biFo9kDzBZQOM1Rs6IOpjAMyxW97p0m3wAOt9PHuF2LLemiXO
        hMfM37Yw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGbE-006U1p-T8; Tue, 12 Oct 2021 12:10:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] scsi: add a scsi_alloc_request helper
Date:   Tue, 12 Oct 2021 14:04:43 +0200
Message-Id: <20211012120445.861860-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012120445.861860-1-hch@lst.de>
References: <20211012120445.861860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a new helper that calls blk_get_request and initializes the
scsi_request to avoid the indirect call through ->.initialize_rq_fn.

Note that this makes the pktcdvd driver depend on the SCSI core, but
given that only SCSI devices support SCSI passthrough requests that
is not a functional change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index 0f26b2510a756..7d3558aef58a5 100644
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
index 33fd9a01330ce..d787b7bd9cb06 100644
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

