Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C513E877F5
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2019 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfHIKzG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Aug 2019 06:55:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40174 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406093AbfHIKzG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Aug 2019 06:55:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id h8so6403263edv.7;
        Fri, 09 Aug 2019 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFobf+v5u7ekboCmajvIduUsjW5C7G85pX/gGR/QpIM=;
        b=tCVqZ9yL9JRYNlLzVmtpUSGoiEHAXl7Gl9ND+MXKzQlU/RUUaM/5bN9Kk7mUzsTTwa
         yg6TA7AeENPsR/QEcdxMiPFD0Fv2XbGajVMHBCELBf5FHplv06FBVJTyr9DrS/34r2m2
         5x5qn1mFKhJzJDhnPwqQlyYlmmnJMDncuNyHf0/agTQ52b0kcOi/7kWEMFIenQRlRj6s
         hd/46ggl5vja/w8/J2HnFwNsJ0b4wMZGnNNrJZgGvUkZ7MmXqPadFmnTOfAAmxtRP/G0
         PID9NT88lIQrwcle3Dof8flzKWwhGRUthpFDrCY+ygjxljm1VgSodK+Qfj+WGlEhKmk5
         pXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFobf+v5u7ekboCmajvIduUsjW5C7G85pX/gGR/QpIM=;
        b=S+jbTMoOH5QdHvAdDhfmiJQIANZ1f8DjiQdZH0KAhgf1OobyBjspOQ0Ga7maSZ0cU7
         a9mvL2bo0bwNv1xkjMJlid1F/dLmdgjVf7PfwjmvNfgICLZF2bOdJs2gnd/IlUmbThic
         Hzy/GEFx3hdCy7ntp5cfwFwNB4/S7LoyBMGAEs0TzFn4eQjXuwWGWuVYpRsoCM2RJ/eU
         nmZd22GA1/wU7lt+U0lQUCt60iCih+4mCmFNYXqfwyMjjg8NajbzkIFJT0Z9Qxtxa5fV
         K3B800gvdf3bDuOnABBlA7seUREhyXOBhHVZ23nSLgRlpMOdQGBxHytGyIuvMKlXRoIP
         Jwaw==
X-Gm-Message-State: APjAAAUeZmQi6LruCjv81l0XDOz9cmXYq71Noq1xa7/2NR3yS6CkPE+k
        atsLSHC+T9Hk7Ki3eRFZJAR37pGEG/t7Ww==
X-Google-Smtp-Source: APXvYqx6MCjOzh34eccuqlRuKfyP8sl1s9oDvFEvvd5eq4SJxQXMPvyIgigEYkc1hRt6l/rfQJWTZA==
X-Received: by 2002:a50:91e5:: with SMTP id h34mr20734238eda.72.1565348102877;
        Fri, 09 Aug 2019 03:55:02 -0700 (PDT)
Received: from continental.suse.de ([177.96.42.43])
        by smtp.gmail.com with ESMTPSA id x55sm22289167edm.11.2019.08.09.03.54.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 03:55:02 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Tim Waugh <tim@cyberelk.net>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Avri Altman <avri.altman@wdc.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-ide@vger.kernel.org (open list:IDE SUBSYSTEM),
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
        linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD
        SERVERS)
Subject: [PATCHv2  4/4] block: Change at_head argument of blk_execute_rq to bool
Date:   Fri,  9 Aug 2019 07:54:33 -0300
Message-Id: <20190809105433.8946-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809105433.8946-1-marcos.souza.org@gmail.com>
References: <20190809105433.8946-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-exec.c             |  2 +-
 block/scsi_ioctl.c           |  8 ++++----
 drivers/block/paride/pd.c    |  2 +-
 drivers/block/pktcdvd.c      |  2 +-
 drivers/cdrom/cdrom.c        |  2 +-
 drivers/ide/ide-atapi.c      |  2 +-
 drivers/ide/ide-cd.c         |  2 +-
 drivers/ide/ide-cd_ioctl.c   |  2 +-
 drivers/ide/ide-devsets.c    |  2 +-
 drivers/ide/ide-disk.c       |  2 +-
 drivers/ide/ide-ioctls.c     |  4 ++--
 drivers/ide/ide-park.c       |  2 +-
 drivers/ide/ide-pm.c         |  2 +-
 drivers/ide/ide-tape.c       |  2 +-
 drivers/ide/ide-taskfile.c   |  2 +-
 drivers/mmc/core/block.c     | 10 +++++-----
 drivers/nvme/host/core.c     |  2 +-
 drivers/nvme/host/lightnvm.c |  4 ++--
 drivers/scsi/scsi_lib.c      |  2 +-
 fs/nfsd/blocklayout.c        |  2 +-
 include/linux/blkdev.h       |  2 +-
 21 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index c8b88f469988..dcc4bfb7b981 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
  */
-void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
+void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, bool at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 5411fb322c56..3231c347ee94 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -281,7 +281,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 	unsigned long start_time;
 	ssize_t ret = 0;
 	int writing = 0;
-	int at_head = 0;
+	bool at_head = false;
 	struct request *rq;
 	struct scsi_request *req;
 	struct bio *bio;
@@ -304,7 +304,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 			break;
 		}
 	if (hdr->flags & SG_FLAG_Q_AT_HEAD)
-		at_head = 1;
+		at_head = true

 	ret = -ENOMEM;
 	rq = blk_get_request(q, writing ? REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, 0);
@@ -490,7 +490,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 		goto error;
 	}

-	blk_execute_rq(disk, rq, 0);
+	blk_execute_rq(disk, rq, false);

 	err = req->result & 0xff;	/* only 8 bit SCSI status */
 	if (err) {
@@ -529,7 +529,7 @@ static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
 	scsi_req(rq)->cmd[0] = cmd;
 	scsi_req(rq)->cmd[4] = data;
 	scsi_req(rq)->cmd_len = 6;
-	blk_execute_rq(bd_disk, rq, 0);
+	blk_execute_rq(bd_disk, rq, false);
 	err = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 22f36dc28018..d02c57247c9d 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -781,7 +781,7 @@ static int pd_special_command(struct pd_unit *disk,
 	req = blk_mq_rq_to_pdu(rq);

 	req->func = func;
-	blk_execute_rq(disk->gd, rq, 0);
+	blk_execute_rq(disk->gd, rq, false);
 	blk_put_request(rq);
 	return 0;
 }
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 00b0aa14ca07..6bd163c4c5c2 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -722,7 +722,7 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 	if (cgc->quiet)
 		rq->rq_flags |= RQF_QUIET;

-	blk_execute_rq(pd->bdev->bd_disk, rq, 0);
+	blk_execute_rq(pd->bdev->bd_disk, rq, false);
 	if (scsi_req(rq)->result)
 		ret = -EIO;
 out:
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index fa85c6ab4915..b5406301e823 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2221,7 +2221,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 		rq->timeout = 60 * HZ;
 		bio = rq->bio;

-		blk_execute_rq(cdi->disk, rq, 0);
+		blk_execute_rq(cdi->disk, rq, false);
 		if (scsi_req(rq)->result) {
 			struct scsi_sense_hdr sshdr;

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index f3e5f25e4065..571e30187a0f 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -107,7 +107,7 @@ int ide_queue_pc_tail(ide_drive_t *drive, struct gendisk *disk,
 	memcpy(scsi_req(rq)->cmd, pc->c, 12);
 	if (drive->media == ide_tape)
 		scsi_req(rq)->cmd[13] = REQ_IDETAPE_PC1;
-	blk_execute_rq(disk, rq, 0);
+	blk_execute_rq(disk, rq, false);
 	error = scsi_req(rq)->result ? -EIO : 0;
 put_req:
 	blk_put_request(rq);
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 31a6d1af0c2f..3d0dbb11fa8f 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -466,7 +466,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 			}
 		}

-		blk_execute_rq(info->disk, rq, 0);
+		blk_execute_rq(info->disk, rq, false);
 		error = scsi_req(rq)->result ? -EIO : 0;

 		if (buffer)
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 011eab9c69b7..2eed0e43bb2b 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -299,7 +299,7 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	rq->rq_flags = RQF_QUIET;
-	blk_execute_rq(cd->disk, rq, 0);
+	blk_execute_rq(cd->disk, rq, false);
 	ret = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
 	/*
diff --git a/drivers/ide/ide-devsets.c b/drivers/ide/ide-devsets.c
index ca1d4b3d3878..304df2b35b42 100644
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -173,7 +173,7 @@ int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 	*(int *)&scsi_req(rq)->cmd[1] = arg;
 	ide_req(rq)->special = setting->set;

-	blk_execute_rq(NULL, rq, 0);
+	blk_execute_rq(NULL, rq, false);
 	ret = scsi_req(rq)->result;
 	blk_put_request(rq);

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index ffb42a566c2b..2d2614607df9 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -482,7 +482,7 @@ static int set_multcount(ide_drive_t *drive, int arg)

 	drive->mult_req = arg;
 	drive->special_flags |= IDE_SFLAG_SET_MULTMODE;
-	blk_execute_rq(NULL, rq, 0);
+	blk_execute_rq(NULL, rq, false);
 	blk_put_request(rq);

 	return (drive->mult_count == arg) ? 0 : -EIO;
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 45a313cd8698..fd861037b723 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -128,7 +128,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)

 		rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 		ide_req(rq)->type = ATA_PRIV_TASKFILE;
-		blk_execute_rq(NULL, rq, 0);
+		blk_execute_rq(NULL, rq, false);
 		err = scsi_req(rq)->result ? -EIO : 0;
 		blk_put_request(rq);

@@ -227,7 +227,7 @@ static int generic_drive_reset(ide_drive_t *drive)
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	scsi_req(rq)->cmd_len = 1;
 	scsi_req(rq)->cmd[0] = REQ_DRIVE_RESET;
-	blk_execute_rq(NULL, rq, 1);
+	blk_execute_rq(NULL, rq, true);
 	ret = scsi_req(rq)->result;
 	blk_put_request(rq);
 	return ret;
diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index a80a0f28f7b9..0069feb228fd 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -37,7 +37,7 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	scsi_req(rq)->cmd_len = 1;
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	ide_req(rq)->special = &timeout;
-	blk_execute_rq(NULL, rq, 1);
+	blk_execute_rq(NULL, rq, true);
 	rc = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);
 	if (rc)
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index fc3cb37fec14..7c53449dc462 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -27,7 +27,7 @@ int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 		mesg.event = PM_EVENT_FREEZE;
 	rqpm.pm_state = mesg.event;

-	blk_execute_rq(NULL, rq, 0);
+	blk_execute_rq(NULL, rq, false);
 	ret = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 56f66cb0d6b6..484daef19ffe 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -867,7 +867,7 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int size)
 			goto out_put;
 	}

-	blk_execute_rq(tape->disk, rq, 0);
+	blk_execute_rq(tape->disk, rq, false);

 	/* calculate the number of transferred bytes and update buffer state */
 	size -= scsi_req(rq)->resid_len;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 577e34b80244..4f9422deaf28 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -444,7 +444,7 @@ int ide_raw_taskfile(ide_drive_t *drive, struct ide_cmd *cmd, u8 *buf,
 	ide_req(rq)->special = cmd;
 	cmd->rq = rq;

-	blk_execute_rq(NULL, rq, 0);
+	blk_execute_rq(NULL, rq, false);
 	error = scsi_req(rq)->result ? -EIO : 0;
 put_req:
 	blk_put_request(rq);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7cba68054435..2543850aee99 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -249,7 +249,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
-	blk_execute_rq(NULL, req, 0);
+	blk_execute_rq(NULL, req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_put_request(req);

@@ -664,7 +664,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
-	blk_execute_rq(NULL, req, 0);
+	blk_execute_rq(NULL, req, false);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
 	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
 	blk_put_request(req);
@@ -733,7 +733,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
-	blk_execute_rq(NULL, req, 0);
+	blk_execute_rq(NULL, req, false);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;

 	/* copy to user if data and response */
@@ -2752,7 +2752,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
-	blk_execute_rq(NULL, req, 0);
+	blk_execute_rq(NULL, req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
 		*val = ret;
@@ -2791,7 +2791,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
-	blk_execute_rq(NULL, req, 0);
+	blk_execute_rq(NULL, req, false);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_put_request(req);
 	if (err) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 38c1a5db9e56..0aa72962f2a7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -884,7 +884,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		}
 	}

-	blk_execute_rq(disk, req, 0);
+	blk_execute_rq(disk, req, false);
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index c09989376c3b..220e34097f94 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -706,7 +706,7 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
 	/* I/Os can fail and the error is signaled through rqd. Callers must
 	 * handle the error accordingly.
 	 */
-	blk_execute_rq(NULL, rq, 0);
+	blk_execute_rq(NULL, rq, false);
 	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;

@@ -835,7 +835,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		bio->bi_disk = disk;
 	}

-	blk_execute_rq(NULL, rq, 0);
+	blk_execute_rq(NULL, rq, false);

 	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9551bc93ad0c..b02df7b09312 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -276,7 +276,7 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	/*
 	 * head injection *required* here otherwise quiesce won't work
 	 */
-	blk_execute_rq(NULL, req, 1);
+	blk_execute_rq(NULL, req, true);

 	/*
 	 * Some devices (USB mass-storage in particular) may transfer
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index b6fc7f7a0568..407b633b7691 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -253,7 +253,7 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
 	req->cmd[4] = bufflen & 0xff;
 	req->cmd_len = COMMAND_SIZE(INQUIRY);

-	blk_execute_rq(NULL, rq, 1);
+	blk_execute_rq(NULL, rq, true);
 	if (req->result) {
 		pr_err("pNFS: INQUIRY 0x83 failed with: %x\n",
 			req->result);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 19ed996f0074..405f8ae31e5c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -865,7 +865,7 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct gendisk *, struct request *, int);
+extern void blk_execute_rq(struct gendisk *, struct request *, bool);
 extern void blk_execute_rq_nowait(struct gendisk *, struct request *, bool,
 				rq_end_io_fn *);

--
2.22.0

