Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9153000A6
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 11:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhAVKsr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 05:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbhAVJaI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 04:30:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A082C0617AA
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 01:28:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id bx12so5746768edb.8
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 01:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gy+m5b/MpNl75+rvuADDvuvZdDur+rLnZjEt2V5VJu8=;
        b=c96FNvIBo+d76PGg2h22AXLzbzNojslFyX2m+9F7mZEFba2aPyYIUDVE9vbpeNKgC3
         pZo2hYyLfHf5icuu+iwQ+Mmx1AinyNSSPOabCUGI5+Igv72efZyeV5EDfYOHpvPEsyTf
         9VykIeFFMSbdI8v9nU8m3aaoxGKJqGCDKTf6aGDV7Y5FB0SX+l2WcvQtOQIHHe/G7PjE
         9APYTzjCin3UweKiEdYPT/GHXIcXKcvEp7Z2RcxC3wRFuU0kmxuZQ8HwLt89kIKhW2Ic
         2tB3Su+d0EA2Dx4GGJ+Z4ANYyurMnRwTnLC+JzisnF53fssG8q1dFjN9gdpKetP+dyK2
         Ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gy+m5b/MpNl75+rvuADDvuvZdDur+rLnZjEt2V5VJu8=;
        b=hv793HHCJY9JaN08Otji91og6E5jiAgzjPa0UASkTz0yOL+ylt/m0Q2WAdoKveQkty
         myQeIBq5mapCodk26YroGjhcyDvRHHtYyoH1Q72vqACtLaLn14KHwRaKErLijur8Wa+9
         +NRgBSTwSQoXNUOBmI5DHekVSfroev1JhF6lr/3iNpebFVQ1ZJGPO+SumDl5JQK7yOjt
         yTNzQXgkcoe2sveduIdz9vi9G40q6YK8rVN07uztarLkTkpQ1cGe1IFiCpx2Qt5FbEVy
         yWg7UB2dAklteai/T9mf8tzyWgSgN1zOHPcE3gHQBlTCyOCXMjSTKmVGZOjp7PwTl7dR
         Gerg==
X-Gm-Message-State: AOAM5328qhr5tPSUI2EcDs3YPjpcmq65UMtcX1VoeP4fCDky2KN7FnS5
        JVHE4a2ipMCPHWL5zCdYmqYvfA==
X-Google-Smtp-Source: ABdhPJwBs+h2/oob0/YichSq036E8Te/eQQlFqwN1S+8lnnkni/ZFj+8n14tY2VDy71YxT0adcvlVQ==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr2442254edc.135.1611307714827;
        Fri, 22 Jan 2021 01:28:34 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
        by smtp.gmail.com with ESMTPSA id g17sm4684508edb.39.2021.01.22.01.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 01:28:34 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        hch@infradead.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 1/2] block: remove unnecessary argument from blk_execute_rq_nowait
Date:   Fri, 22 Jan 2021 10:28:23 +0100
Message-Id: <20210122092824.20971-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
elevator code"), also update the comment of the function.

And more importantly it never really was needed to start with given
that we can trivial derive it from struct request.

Cc: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-ide@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-exec.c                   | 10 ++++------
 drivers/block/sx8.c                |  4 ++--
 drivers/nvme/host/core.c           |  4 ++--
 drivers/nvme/host/lightnvm.c       |  2 +-
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 include/linux/blkdev.h             |  2 +-
 11 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 85324d53d072..2e37e85456fb 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -31,8 +31,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 }
 
 /**
- * blk_execute_rq_nowait - insert a request into queue for execution
- * @q:		queue to insert the request in
+ * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
  * @bd_disk:	matching gendisk
  * @rq:		request to insert
  * @at_head:    insert request at head or tail of queue
@@ -45,9 +44,8 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
  * Note:
  *    This function will invoke @done directly if the queue is dead.
  */
-void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
-			   struct request *rq, int at_head,
-			   rq_end_io_fn *done)
+void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
+			   int at_head, rq_end_io_fn *done)
 {
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
@@ -83,7 +81,7 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
 	unsigned long hang_check;
 
 	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
+	blk_execute_rq_nowait(bd_disk, rq, at_head, blk_end_sync_rq);
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 4478eb7efee0..2cdf2771f8e8 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -539,7 +539,7 @@ static int carm_array_info (struct carm_host *host, unsigned int array_idx)
 	spin_unlock_irq(&host->lock);
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
+	blk_execute_rq_nowait(NULL, rq, true, NULL);
 
 	return 0;
 
@@ -578,7 +578,7 @@ static int carm_send_special (struct carm_host *host, carm_sspc_t func)
 	crq->msg_bucket = (u32) rc;
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
+	blk_execute_rq_nowait(NULL, rq, true, NULL);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..63c469edb1bc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -925,7 +925,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 
 	rq->cmd_flags |= REQ_HIPRI;
 	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(q, bd_disk, rq, at_head, nvme_end_sync_rq);
+	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
 	while (!completion_done(&wait)) {
 		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
@@ -1202,7 +1202,7 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
 
-	blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvme_keep_alive_end_io);
+	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 470cef3abec3..439f2b52e985 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -695,7 +695,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd,
 
 	rq->end_io_data = rqd;
 
-	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
+	blk_execute_rq_nowait(NULL, rq, 0, nvme_nvm_end_io);
 
 	return 0;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50d9a20568a2..6aa11067c8d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1327,7 +1327,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	abort_req->end_io_data = NULL;
-	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
+	blk_execute_rq_nowait(NULL, abort_req, 0, abort_endio);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
@@ -2238,7 +2238,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
-	blk_execute_rq_nowait(q, NULL, req, false,
+	blk_execute_rq_nowait(NULL, req, false,
 			opcode == nvme_admin_delete_cq ?
 				nvme_del_cq_end : nvme_del_queue_end);
 	return 0;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b9776fc8f08f..cbc88acdd233 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -275,7 +275,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		schedule_work(&req->p.work);
 	} else {
 		rq->end_io_data = req;
-		blk_execute_rq_nowait(rq->q, ns ? ns->disk : NULL, rq, 0,
+		blk_execute_rq_nowait(ns ? ns->disk : NULL, rq, 0,
 				      nvmet_passthru_req_done);
 	}
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index f11f51e2465f..c00f06e9ecb0 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2007,7 +2007,7 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 	req->timeout = 10 * HZ;
 	rq->retries = 5;
 
-	blk_execute_rq_nowait(req->q, NULL, req, 1, eh_lock_door_done);
+	blk_execute_rq_nowait(NULL, req, 1, eh_lock_door_done);
 }
 
 /**
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index bfa8d77322d7..4383d93110f8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -829,8 +829,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 
 	srp->rq->timeout = timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
-	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
-			      srp->rq, at_head, sg_rq_end_io);
+	blk_execute_rq_nowait(sdp->disk, srp->rq, at_head, sg_rq_end_io);
 	return 0;
 }
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 43f7624508a9..841ad2fc369a 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -585,7 +585,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 	rq->retries = retries;
 	req->end_io_data = SRpnt;
 
-	blk_execute_rq_nowait(req->q, NULL, req, 1, st_scsi_execute_end);
+	blk_execute_rq_nowait(NULL, req, 1, st_scsi_execute_end);
 	return 0;
 }
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 7994f27e4527..33770e5808ce 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1000,8 +1000,7 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 		req->timeout = PS_TIMEOUT_OTHER;
 	scsi_req(req)->retries = PS_RETRY;
 
-	blk_execute_rq_nowait(pdv->pdv_sd->request_queue, NULL, req,
-			(cmd->sam_task_attr == TCM_HEAD_TAG),
+	blk_execute_rq_nowait(NULL, req, (cmd->sam_task_attr == TCM_HEAD_TAG),
 			pscsi_req_done);
 
 	return 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 070de09425ad..bf0ddef8aa10 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -942,7 +942,7 @@ extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       gfp_t);
 extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 			  struct request *, int);
-extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
+extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
-- 
2.17.1

