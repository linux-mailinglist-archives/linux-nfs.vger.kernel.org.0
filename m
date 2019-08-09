Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8463A877E8
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2019 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfHIKyk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Aug 2019 06:54:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41550 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIKyk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Aug 2019 06:54:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id w5so5958624edl.8;
        Fri, 09 Aug 2019 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzZxle7lNkZ9B4/i4Gon6TBKR47JpvPvE4izkujl8YM=;
        b=EkOM5lkgvLyrjTYeM9Q7a0FqxbVuO4OLbMogFhnoh6esvWygzKw6beBCaUDrV7NZQx
         uYJd2ma6KZzcuv8Vsq+3dbay0wv/3tjpAOQ3AIrCfLyexobtMD9L0PzaADFGeYz4ou7r
         dDDqNdTF89MI/S+9uUcPm8SpFIk/+xMgVbulDgmSKRn8jIfLOqjAy1XntAfv+miJvuky
         v9IdDoZe+huJqKLktnEphTZDwMwDrNrd2oeCnpD0Fi+Ba8gE3rNcFGNdpYA2LLi6kylz
         KfLRNpWrtT0LMCWdXa71xQroh4f76T8sAIeOjY1ZtMDQOX+qDB1Mq/Negx6JtGngKhEx
         q8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzZxle7lNkZ9B4/i4Gon6TBKR47JpvPvE4izkujl8YM=;
        b=nJtBHk/Z6J0K8YJpQEKSBOvxWaoYUaYAsSWAfVr7OG+QtuxswTvAaap5HFgL7yMn/f
         AcJ2xWVPu2hVkJxtSoEhVC/rKdA7r6DZU0Z0VqksMsp6p5XhQ8Em2Cc+6dUXJZuXIAyY
         vAd6NnA5QntYfArjwOVGtyjFYuorftxkZIdo3lb+RMqv19zjVitSuDHKPuCMNQNszysv
         stYqVS/NZyrkkmnTdkU0NuEKybKqQhCWB7ZxEdku8aphgliBjLGGr/ytelwepZx+dNAQ
         eX0UYMei8omI0FSm07O5vwTT50YKmf50iU9BwW4AmGpe9thQiiOxyRRzdsL2TCtvhEqx
         yvRQ==
X-Gm-Message-State: APjAAAVO+Ge+TQ3vu79UQAru4/IAwi+BI6g8cjoJc3lwg4cytHMFxIx2
        bl4N+mjLIi+atlWsDXjVX8zId1cAhiPCUw==
X-Google-Smtp-Source: APXvYqyYRnt2CBmgFNhC8PE+CdaVR7Y/y7lKJiovfOr3eSwTbHKe7RhQ/18rruyiHkafJgBn6JiW7g==
X-Received: by 2002:a50:b87c:: with SMTP id k57mr20712295ede.226.1565348076039;
        Fri, 09 Aug 2019 03:54:36 -0700 (PDT)
Received: from continental.suse.de ([177.96.42.43])
        by smtp.gmail.com with ESMTPSA id x55sm22289167edm.11.2019.08.09.03.54.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 03:54:35 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Tim Waugh <tim@cyberelk.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
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
        Johannes Thumshirn <jthumshirn@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ming Lei <ming.lei@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>, Chris Boot <bootc@bootc.net>,
        Zachary Hays <zhays@lexmark.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org (open list:BSG (block layer generic sg v4
        driver)),
        virtualization@lists.linux-foundation.org (open list:VIRTIO BLOCK AND
        SCSI DRIVERS),
        linux-ide@vger.kernel.org (open list:IDE SUBSYSTEM),
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-nfs@vger.kernel.org (open list:KERNEL NFSD, SUNRPC, AND LOCKD
        SERVERS)
Subject: [PATCHv2  2/4] fs/block/drivers: Remove request_queue argument from blk_execute_rq
Date:   Fri,  9 Aug 2019 07:54:31 -0300
Message-Id: <20190809105433.8946-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809105433.8946-1-marcos.souza.org@gmail.com>
References: <20190809105433.8946-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The only user of the request_queue argument was removed in commit
552cef2b8b03 ("block: Remove request_queue argument from
blk_execute_rq_nowait"), so now we can safely removed the same argument
from blk_execute_rq and all places that calls this function.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-exec.c                  |  4 +---
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
 drivers/nvme/host/lightnvm.c      |  4 ++--
 drivers/scsi/scsi_lib.c           |  2 +-
 fs/nfsd/blocklayout.c             |  2 +-
 include/linux/blkdev.h            |  3 +--
 24 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 80890b0b9c67..7862f8be39d1 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -63,7 +63,6 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);

 /**
  * blk_execute_rq - insert a request into queue for execution
- * @q:		queue to insert the request in
  * @bd_disk:	matching gendisk
  * @rq:		request to insert
  * @at_head:    insert request at head or tail of queue
@@ -72,8 +71,7 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
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
index 833c44b3d458..180c26ea131d 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -181,7 +181,7 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)

 	bio = rq->bio;

-	blk_execute_rq(q, NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
+	blk_execute_rq(NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
 	ret = rq->q->bsg_dev.ops->complete_rq(rq, &hdr);
 	blk_rq_unmap_user(bio);

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index f5e0ad65e86a..5411fb322c56 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -354,7 +354,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 	 * (if he doesn't check that is his problem).
 	 * N.B. a non-zero SCSI status is _not_ necessarily an error.
 	 */
-	blk_execute_rq(q, bd_disk, rq, at_head);
+	blk_execute_rq(bd_disk, rq, at_head);

 	hdr->duration = jiffies_to_msecs(jiffies - start_time);

@@ -490,7 +490,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 		goto error;
 	}

-	blk_execute_rq(q, disk, rq, 0);
+	blk_execute_rq(disk, rq, 0);

 	err = req->result & 0xff;	/* only 8 bit SCSI status */
 	if (err) {
@@ -529,7 +529,7 @@ static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
 	scsi_req(rq)->cmd[0] = cmd;
 	scsi_req(rq)->cmd[4] = data;
 	scsi_req(rq)->cmd_len = 6;
-	blk_execute_rq(q, bd_disk, rq, 0);
+	blk_execute_rq(bd_disk, rq, 0);
 	err = scsi_req(rq)->result ? -EIO : 0;
 	blk_put_request(rq);

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 964f78cfffa0..707c2a21d75e 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1014,7 +1014,7 @@ static int mtip_exec_internal_command(struct mtip_port *port,
 	rq->timeout = timeout;

 	/* insert request and run queue */
-	blk_execute_rq(rq->q, NULL, rq, true);
+	blk_execute_rq(NULL, rq, true);

 	if (int_cmd->status) {
 		dev_err(&dd->pdev->dev, "Internal command [%02X] failed %d\n",
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 6f9ad3fc716f..22f36dc28018 100644
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
index 024060165afa..00b0aa14ca07 100644
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
index 7ffd719d89de..e84aefc89780 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -374,7 +374,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	if (err)
 		goto out;

-	blk_execute_rq(vblk->disk->queue, vblk->disk, req, false);
+	blk_execute_rq(vblk->disk, req, false);
 	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
 out:
 	blk_put_request(req);
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index ac42ae4651ce..fa85c6ab4915 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2221,7 +2221,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 		rq->timeout = 60 * HZ;
 		bio = rq->bio;

-		blk_execute_rq(q, cdi->disk, rq, 0);
+		blk_execute_rq(cdi->disk, rq, 0);
 		if (scsi_req(rq)->result) {
 			struct scsi_sense_hdr sshdr;

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 80bc3bf82f4d..f3e5f25e4065 100644
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
index 9d117936bee1..31a6d1af0c2f 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -466,7 +466,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 			}
 		}

-		blk_execute_rq(drive->queue, info->disk, rq, 0);
+		blk_execute_rq(info->disk, rq, 0);
 		error = scsi_req(rq)->result ? -EIO : 0;

 		if (buffer)
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 46f2df288c6a..011eab9c69b7 100644
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
index f2f93ed40356..ca1d4b3d3878 100644
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
index 197912af5c2f..ffb42a566c2b 100644
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
index d48c17003874..45a313cd8698 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -128,7 +128,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)

 		rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 		ide_req(rq)->type = ATA_PRIV_TASKFILE;
-		blk_execute_rq(drive->queue, NULL, rq, 0);
+		blk_execute_rq(NULL, rq, 0);
 		err = scsi_req(rq)->result ? -EIO : 0;
 		blk_put_request(rq);

@@ -227,7 +227,7 @@ static int generic_drive_reset(ide_drive_t *drive)
 	ide_req(rq)->type = ATA_PRIV_MISC;
 	scsi_req(rq)->cmd_len = 1;
 	scsi_req(rq)->cmd[0] = REQ_DRIVE_RESET;
-	blk_execute_rq(drive->queue, NULL, rq, 1);
+	blk_execute_rq(NULL, rq, 1);
 	ret = scsi_req(rq)->result;
 	blk_put_request(rq);
 	return ret;
diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index 8af7af6001eb..a80a0f28f7b9 100644
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
index 192e6c65d34e..fc3cb37fec14 100644
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
index db1a65f4b490..56f66cb0d6b6 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -867,7 +867,7 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int size)
 			goto out_put;
 	}

-	blk_execute_rq(drive->queue, tape->disk, rq, 0);
+	blk_execute_rq(tape->disk, rq, 0);

 	/* calculate the number of transferred bytes and update buffer state */
 	size -= scsi_req(rq)->resid_len;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index aab6a10435b6..577e34b80244 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -444,7 +444,7 @@ int ide_raw_taskfile(ide_drive_t *drive, struct ide_cmd *cmd, u8 *buf,
 	ide_req(rq)->special = cmd;
 	cmd->rq = rq;

-	blk_execute_rq(drive->queue, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);
 	error = scsi_req(rq)->result ? -EIO : 0;
 put_req:
 	blk_put_request(rq);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a434c915..7cba68054435 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -249,7 +249,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_put_request(req);

@@ -664,7 +664,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
 	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
 	blk_put_request(req);
@@ -733,7 +733,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;

 	/* copy to user if data and response */
@@ -2752,7 +2752,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
 		*val = ret;
@@ -2791,7 +2791,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
-	blk_execute_rq(mq->queue, NULL, req, 0);
+	blk_execute_rq(NULL, req, 0);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_put_request(req);
 	if (err) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6682fdcece0f..4a2ed03223b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -791,7 +791,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (poll)
 		nvme_execute_rq_polled(req->q, NULL, req, at_head);
 	else
-		blk_execute_rq(req->q, NULL, req, at_head);
+		blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -884,7 +884,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		}
 	}

-	blk_execute_rq(req->q, disk, req, 0);
+	blk_execute_rq(disk, req, 0);
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 5d0e330e86d0..9c82a5044b75 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -706,7 +706,7 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
 	/* I/Os can fail and the error is signaled through rqd. Callers must
 	 * handle the error accordingly.
 	 */
-	blk_execute_rq(q, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);
 	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;

@@ -835,7 +835,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		bio->bi_disk = disk;
 	}

-	blk_execute_rq(q, NULL, rq, 0);
+	blk_execute_rq(NULL, rq, 0);

 	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 11e64b50497f..9551bc93ad0c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -276,7 +276,7 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	/*
 	 * head injection *required* here otherwise quiesce won't work
 	 */
-	blk_execute_rq(req->q, NULL, req, 1);
+	blk_execute_rq(NULL, req, 1);

 	/*
 	 * Some devices (USB mass-storage in particular) may transfer
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 66d4c55eb48e..b6fc7f7a0568 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -253,7 +253,7 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
 	req->cmd[4] = bufflen & 0xff;
 	req->cmd_len = COMMAND_SIZE(INQUIRY);

-	blk_execute_rq(rq->q, NULL, rq, 1);
+	blk_execute_rq(NULL, rq, 1);
 	if (req->result) {
 		pr_err("pNFS: INQUIRY 0x83 failed with: %x\n",
 			req->result);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8e8f088c75a5..c9d9ca686290 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -865,8 +865,7 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct request_queue *, struct gendisk *,
-			  struct request *, int);
+extern void blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *, struct request *, int,
 				rq_end_io_fn *);

--
2.22.0

