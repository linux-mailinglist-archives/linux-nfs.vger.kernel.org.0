Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4E30216F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 05:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAYEwQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jan 2021 23:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbhAYEv4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Jan 2021 23:51:56 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE50C061794
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jan 2021 20:51:11 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i7so8097614pgc.8
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jan 2021 20:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b20EVFR4jQUqzV9b5OeBW4DLUOgVDLjqPMnMHeRaWK8=;
        b=DVEyGbITFK1fMjkw3JVbFwwcu7fHaXwm57H25QNgY3a2Z+t71BenIjsFDbU0FfxE7H
         oqoq6eWAiGw5/yBqe2HkQ+mi2MRF566aopGojsUF6gwwKyXYWECY1v72BiUSmM43/dO3
         4ccCiDhVzLV8rBQ3FxV5bVSazvrxrTpgr1i17Pd5W7W5F0xfdWjHwm0YTRMbbuDyq3m7
         pHHp1Q7uh7RbBX9vCA/zys9sKelbo5e/lBUP/NGvGU0w16BP8AFST9kvHXZXarZQUpRu
         G6Qd+pACvUFZ9s2GJ0LT5S/Aj7omU+Iv6jS1vAcq2DkBitQlI7WhKvhSGCHHts7WyXr3
         VhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b20EVFR4jQUqzV9b5OeBW4DLUOgVDLjqPMnMHeRaWK8=;
        b=Q+KHSPCF3hSG/X1INnTsWStmKiW2/o8zSDbkgiky3/3v8x+Ifgy9ABahl41lmhieFM
         qC+96U/yZh/rXCN/izCX2BwZH5mqE2zhBmPTh6Dv5McEvVdjQNUZbUcJYp68gFdUCziy
         WQN9n4I4jMb4a7CczVq/ScGvbbw7s74ZB9W+G+8HoaRciIGvUcMCwOTFbInH/4sjsAPd
         zzsTSy2C4WiaDtVagBVZ4e9TakJF7AKVgWNh19nPPAa8s+ZL7v6FZ8eFWe/JbpNZh8Fw
         L7lIqFTqW44gJQz6yRwLenFmHlL5fs5zANnTQw4aFQq9hIA5EsnpZcnrxCuSuaBaPQuY
         gY6A==
X-Gm-Message-State: AOAM531jrHF6HMAdgJYsI7ckHTpuFcjQlDu2oFZ2X7hOzASQIkJ9a7UQ
        PfoaZ8LVeGfjAzO+BaimGVHHkA==
X-Google-Smtp-Source: ABdhPJzQZdfFWyM3GWC+GoWvB1CkSCnXZgacXSQJjaP5qpwIhyqZKV7RHKc3Ys1cHcKceyNNzQNRiA==
X-Received: by 2002:a62:f943:0:b029:1a5:43f9:9023 with SMTP id g3-20020a62f9430000b02901a543f99023mr6241473pfm.75.1611550269307;
        Sun, 24 Jan 2021 20:51:09 -0800 (PST)
Received: from gqjiang-home.profitbricks.net ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id l14sm16459423pjy.15.2021.01.24.20.50.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:51:08 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        hch@infradead.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 2/2] block: remove unnecessary argument from blk_execute_rq
Date:   Mon, 25 Jan 2021 05:49:58 +0100
Message-Id: <1611550198-17142-3-git-send-email-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
References: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We can remove 'q' from blk_execute_rq as well after the previous change
in blk_execute_rq_nowait.

And more importantly it never really was needed to start with given
that we can trivial derive it from struct request.

Cc: linux-scsi@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-ide@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: linux-nfs@vger.kernel.org
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # for mmc
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-exec.c                  |  3 +--
 block/bsg.c                       |  2 +-
 block/scsi_ioctl.c                |  6 +++---
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 drivers/block/paride/pd.c         |  2 +-
 drivers/block/pktcdvd.c           |  2 +-
 drivers/block/virtio_blk.c        |  2 +-
 drivers/cdrom/cdrom.c             |  2 +-
 drivers/ide/ide-atapi.c           |  2 +-
 drivers/ide/ide-cd.c              |  2 +-
 drivers/ide/ide-cd_ioctl.c        |  2 +-
 drivers/ide/ide-devsets.c         |  2 +-
 drivers/ide/ide-disk.c            |  2 +-
 drivers/ide/ide-ioctls.c          |  4 ++--
 drivers/ide/ide-park.c            |  2 +-
 drivers/ide/ide-pm.c              |  4 ++--
 drivers/ide/ide-tape.c            |  2 +-
 drivers/ide/ide-taskfile.c        |  2 +-
 drivers/mmc/core/block.c          | 10 +++++-----
 drivers/nvme/host/core.c          |  4 ++--
 drivers/nvme/host/lightnvm.c      |  2 +-
 drivers/scsi/scsi_lib.c           |  2 +-
 fs/nfsd/blocklayout.c             |  2 +-
 include/linux/blkdev.h            |  3 +--
 24 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 2e37e85..0ab873f 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -74,8 +74,7 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
  */
-void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
-		   struct request *rq, int at_head)
+void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
diff --git a/block/bsg.c b/block/bsg.c
index 3d78e84..bd10922 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -183,7 +183,7 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 
 	bio = rq->bio;
 
-	blk_execute_rq(q, NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
+	blk_execute_rq(NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
 	ret = rq->q->bsg_dev.ops->complete_rq(rq, &hdr);
 	blk_rq_unmap_user(bio);
 
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index c9f009c..6599bac 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -357,7 +357,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 	 * (if he doesn't check that is his problem).
 	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
 	 */
-	blk_execute_rq(q, bd_disk, rq, at_head);
+	blk_execute_rq(bd_disk, rq, at_head);
 
 	hdr->duration = jiffies_to_msecs(jiffies - start_time);
 
@@ -493,7 +493,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 		goto error;
 	}
 
-	blk_execute_rq(q, disk, rq, 0);
+	blk_execute_rq(disk, rq, 0);
 
 	err = req->result & 0xff;	/* only 8 bit SCSI status */
 	if (err) {
@@ -532,7 +532,7 @@ static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
 	scsi_req(rq)->cmd[0] = cmd;
 	scsi_req(rq)->cmd[4] = data;
 	scsi_req(rq)->cmd_len = 6;
-	blk_execute_rq(q, bd_disk, rq, 0);
+	blk_execute_rq(bd_disk, rq, 0);
 	err = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 53ac59d..3fd9983 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1015,7 +1015,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	rq->timeout = timeout;
 
 	/* insert request and run queue */
-	blk_execute_rq(rq->q, NULL, rq, true);
+	blk_execute_rq(NULL, rq, true);
 
 	if (int_cmd->status) {
 		dev_err(&dd->pdev->dev, "Internal command [%02X] failed %d\n",
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index a7af4f2..897acda 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -781,7 +781,7 @@ static int pd_special_command(struct pd_unit *disk,
 	req = blk_mq_rq_to_pdu(rq);
 
 	req->func = func;
-	blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
+	blk_execute_rq(disk->gd, rq, 0);
 	blk_put_request(rq);
 	return 0;
 }
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 658a098..fc4b0f1 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -722,7 +722,7 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 	if (cgc->quiet)
 		rq->rq_flags |= RQF_QUIET;
 
-	blk_execute_rq(rq->q, pd->bdev->bd_disk, rq, 0);
+	blk_execute_rq(pd->bdev->bd_disk, rq, 0);
 	if (scsi_req(rq)->result)
 		ret = -EIO;
 out:
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 145606d..b0285db 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -320,7 +320,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	if (err)
 		goto out;
 
-	blk_execute_rq(vblk->disk->queue, vblk->disk, req, false);
+	blk_execute_rq(vblk->disk, req, false);
 	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
 out:
 	blk_put_request(req);
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 8f0e52a..90ad34c 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2214,7 +2214,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 		rq->timeout = 60 * HZ;
 		bio = rq->bio;
 
-		blk_execute_rq(q, cdi->disk, rq, 0);
+		blk_execute_rq(cdi->disk, rq, 0);
 		if (scsi_req(rq)->result) {
 			struct scsi_sense_hdr sshdr;
 
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 013ad33..a1ce9f5 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -107,7 +107,7 @@ int ide_queue_pc_tail(ide_drive_t *drive, struct gendisk *disk,
 	memcpy(scsi_req(rq)->cmd, pc->c, 12);
 	if (drive->media == ide_tape)
 		scsi_req(rq)->cmd[13] = REQ_IDETAPE_PC1;
-	blk_execute_rq(drive->queue, disk, rq, 0);
+	blk_execute_rq(disk, rq, 0);
 	error = scsi_req(rq)->result ? -EIO : 0;
 put_req:
 	blk_put_request(rq);
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 25d2d88..cffbcc2 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -467,7 +467,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 			}
 		}
 
-		blk_execute_rq(drive->queue, info->disk, rq, 0);
+		blk_execute_rq(info->disk, rq, 0);
 		error = scsi_req(rq)->result ? -EIO : 0;
 
 		if (buffer)
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 46f2df2..011eab9 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -299,7 +299,7 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	rq->rq_flags = RQF_QUIET;
-	blk_execute_rq(drive->queue, cd->disk, rq, 0);
+	blk_execute_rq(cd->disk, rq, 0);
 	ret = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
 	/*
diff --git a/drivers/ide/ide-devsets.c b/drivers/ide/ide-devsets.c
index f2f93ed..ca1d4b3 100644
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -173,7 +173,7 @@ int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 	*(int *)&scsi_req(rq)->cmd[1] = arg;
 	ide_req(rq)->special = setting->set;
 
-	blk_execute_rq(q, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);
 	ret = scsi_req(rq)->result;
 	blk_put_request(rq);
 
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 34b94410..8413731 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -482,7 +482,7 @@ static int set_multcount(ide_drive_t *drive, int arg)
 
 	drive->mult_req = arg;
 	drive->special_flags |= IDE_SFLAG_SET_MULTMODE;
-	blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);
 	blk_put_request(rq);
 
 	return (drive->mult_count == arg) ? 0 : -EIO;
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 58994da..43fbc37d 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -137,7 +137,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, void __user *argp)
 
 		rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 		ide_req(rq)->type = ATA_PRIV_TASKFILE;
-		blk_execute_rq(drive->queue, NULL, rq, 0);
+		blk_execute_rq(NULL, rq, 0);
 		err = scsi_req(rq)->result ? -EIO : 0;
 		blk_put_request(rq);
 
@@ -235,7 +235,7 @@ static int generic_drive_reset(ide_drive_t *drive)
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	scsi_req(rq)->cmd_len = 1;
 	scsi_req(rq)->cmd[0] = REQ_DRIVE_RESET;
-	blk_execute_rq(drive->queue, NULL, rq, 1);
+	blk_execute_rq(NULL, rq, 1);
 	ret = scsi_req(rq)->result;
 	blk_put_request(rq);
 	return ret;
diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index 8af7af6..a80a0f2 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -37,7 +37,7 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	scsi_req(rq)->cmd_len = 1;
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	ide_req(rq)->special = &timeout;
-	blk_execute_rq(q, NULL, rq, 1);
+	blk_execute_rq(NULL, rq, 1);
 	rc = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
 	if (rc)
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 82ab308..d680b3e 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -27,7 +27,7 @@ int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 		mesg.event = PM_EVENT_FREEZE;
 	rqpm.pm_state = mesg.event;
 
-	blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);
 	ret = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
 
@@ -50,7 +50,7 @@ static int ide_pm_execute_rq(struct request *rq)
 		blk_mq_end_request(rq, BLK_STS_OK);
 		return -ENXIO;
 	}
-	blk_execute_rq(q, NULL, rq, true);
+	blk_execute_rq(NULL, rq, true);
 
 	return scsi_req(rq)->result ? -EIO : 0;
 }
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 88b9643..fa05e7e 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -868,7 +868,7 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int size)
 			goto out_put;
 	}
 
-	blk_execute_rq(drive->queue, tape->disk, rq, 0);
+	blk_execute_rq(tape->disk, rq, 0);
 
 	/* calculate the number of transferred bytes and update buffer state */
 	size -= scsi_req(rq)->resid_len;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index d016cbe..6665fc4 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -443,7 +443,7 @@ int ide_raw_taskfile(ide_drive_t *drive, struct ide_cmd *cmd, u8 *buf,
 	ide_req(rq)->special = cmd;
 	cmd->rq = rq;
 
-	blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);
 	error = scsi_req(rq)->result ? -EIO : 0;
 put_req:
 	blk_put_request(rq);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 42e27a2..a1d6b68 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -253,7 +253,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_put_request(req);
 
@@ -629,7 +629,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
 	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
 	blk_put_request(req);
@@ -698,7 +698,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
 
 	/* copy to user if data and response */
@@ -2722,7 +2722,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
 		*val = ret;
@@ -2761,7 +2761,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_put_request(req);
 	if (err) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0bea9ae..eb7963f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -964,7 +964,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (poll)
 		nvme_execute_rq_polled(req->q, NULL, req, at_head);
 	else
-		blk_execute_rq(req->q, NULL, req, at_head);
+		blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -1101,7 +1101,7 @@ void nvme_execute_passthru_rq(struct request *rq)
 	u32 effects;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	blk_execute_rq(rq->q, disk, rq, 0);
+	blk_execute_rq(disk, rq, 0);
 	nvme_passthru_end(ctrl, effects);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 0e5a550..ec38128 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -819,7 +819,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		bio->bi_bdev = ns->disk->part0;
 	}
 
-	blk_execute_rq(q, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);
 
 	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b3f14f0..4d22806 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -269,7 +269,7 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	/*
 	 * head injection *required* here otherwise quiesce won't work
 	 */
-	blk_execute_rq(req->q, NULL, req, 1);
+	blk_execute_rq(NULL, req, 1);
 
 	/*
 	 * Some devices (USB mass-storage in particular) may transfer
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index a07c39c..1058659 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -254,7 +254,7 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
 	req->cmd[4] = bufflen & 0xff;
 	req->cmd_len = COMMAND_SIZE(INQUIRY);
 
-	blk_execute_rq(rq->q, NULL, rq, 1);
+	blk_execute_rq(NULL, rq, 1);
 	if (req->result) {
 		pr_err("pNFS: INQUIRY 0x83 failed with: %x\n",
 			req->result);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 623a612..20f3706 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -948,8 +948,7 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct request_queue *, struct gendisk *,
-			  struct request *, int);
+extern void blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
-- 
2.7.4

