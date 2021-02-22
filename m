Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA632211C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 22:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBVVM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 16:12:28 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22462 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBVVM0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 16:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614028346; x=1645564346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fQJsmrOVKZ+usDbmlxoHPJRQf2kBhVhLBytnku04uoA=;
  b=QK22m/TVGH7W3g3U0wIqRM7X+yr9iU5bYb8LUe3qtfXwfJMcuVs9RSEV
   HigNmijv7elwTApuY1lVYHrk8A9TBYJ+N0uTV8hqiVuenH/TW1VU6u3dH
   wigUa0uRvxLUk+DYB+kU53ZkiisbVaKQD8OT74ZnPw49dGD9TZh4DnDe9
   N7kW6xRtfdBQkcUwO7/5vZv4Npc5y4vBL45LWQq+dRbBiO2BS5hSELpgW
   AyBWWZkt2ENYpl9ugawNz7zxdYzGH7HDBJseDA7cgWoONZvTHVqvT9KIp
   9VVP88ttJshNx0yOlYDKnsC+o98i4ezag8y+yriAyQ1jEszEKgSzob+JH
   A==;
IronPort-SDR: VAmHiYwLcDs/2ttr74Bj9CDMy313ds+2e7Fzs9paoTbniTLt5UFdbJKGH5Q9IcRhRX6cdG7g+H
 kCsllWruhs0zpQLJUoG5fMrcKvPgdVo+xOYF/FmrSosUL9LC1WMlXzF7xkbBgKldoqT+4TbME2
 hV1RhRZ4Az7+rfy6yezoe0XHf8am+uXzpkevhnapSdNWqWIqfIujtcyb5qIlS7/sQNZWGJ1cjw
 IO/U0yl6/HdAXJUafRQSMkr5RMaZssr+HJ+7N4P5FA8LommC6TpQH1bPPDr4ICDBRHxLIoagxd
 jno=
X-IronPort-AV: E=Sophos;i="5.81,198,1610380800"; 
   d="scan'208";a="160544568"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 05:11:20 +0800
IronPort-SDR: koDEnCddQN882VXL5jLjf7rUwERZ4cCLEOLsoJUB4FEAJYy+Cj31yg6e42ke1RAklNsiK7J59V
 sZ0k7lUrKHvbGskfVVoVRMi/fppw1QtB5WlNlxr8vIhfVXgm9YWTi9tRefdI/dD5MH4lbHIB87
 HB0xcDXaRLkskwgYU5OhObI20zz4tmLnH127AKcDWiY3byfh2I+14157fGnu2uCsPbx513lkse
 VSXn6y8QAk1XyH/+QY9AChnNrjga5sv5isulqCfmsUkFELM4xQWNDj6Edlc16FqLKfu89xogKf
 6OtS/PjDm1c4oqsx3A9AWIie
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 12:54:39 -0800
IronPort-SDR: fRfcqDGdkdW2oAob0INVPkDULHy7+ONF7bYg/WFeMyp4ZTsYLxwO5t5AsMobCB+iAJnTe+hSsV
 RpYQpp97z4En5D6sT5iJ4fAB9bG/1B+bPRG1NbnOwN4/OhEyb3kmMTVEzGUl8hD9Kj+CD6oru3
 ksK5mTMQzY/7FXlG0X2OQeEadwyEk+/OXCJ2zdSkcbAV89dpPklnd/7q1RTWV0V1sHjlwWEM41
 0/0lfUKBXQK5nHKuIwsVn4J0JP/NeZUdqGegDiGTcG2cZAf6+qUJpttLO42bRi5wHBp779dIwZ
 KHY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Feb 2021 13:11:20 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp, tim@cyberelk.net,
        mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, davem@davemloft.net, bp@alien8.de,
        agk@redhat.com, snitzer@redhat.com, ulf.hansson@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, Kai.Makisara@kolumbus.fi,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bfields@fieldses.org,
        chuck.lever@oracle.com, baolin.wang@linaro.org,
        vbadigan@codeaurora.org, zliua@micron.com, richard.peng@oppo.com,
        chaitanya.kulkarni@wdc.com, guoqing.jiang@cloud.ionos.com,
        stanley.chu@mediatek.com, cang@codeaurora.org,
        asutoshd@codeaurora.org, beanhuo@micron.com, jaegeuk@kernel.org
Subject: [RFC PATCH] blk-core: remove blk_put_request()
Date:   Mon, 22 Feb 2021 13:11:15 -0800
Message-Id: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The function blk_put_request() is just a wrapper to
blk_mq_free_request(), remove the unnecessary wrapper.

Any feedback is welcome on this RFC.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c                   |  6 ------
 block/blk-merge.c                  |  2 +-
 block/bsg-lib.c                    |  4 ++--
 block/bsg.c                        |  4 ++--
 block/scsi_ioctl.c                 |  6 +++---
 drivers/block/paride/pd.c          |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/block/virtio_blk.c         |  2 +-
 drivers/cdrom/cdrom.c              |  4 ++--
 drivers/ide/ide-atapi.c            |  2 +-
 drivers/ide/ide-cd.c               |  4 ++--
 drivers/ide/ide-cd_ioctl.c         |  2 +-
 drivers/ide/ide-devsets.c          |  2 +-
 drivers/ide/ide-disk.c             |  2 +-
 drivers/ide/ide-ioctls.c           |  4 ++--
 drivers/ide/ide-park.c             |  2 +-
 drivers/ide/ide-pm.c               |  4 ++--
 drivers/ide/ide-tape.c             |  2 +-
 drivers/ide/ide-taskfile.c         |  2 +-
 drivers/md/dm-mpath.c              |  2 +-
 drivers/mmc/core/block.c           | 10 +++++-----
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_lib.c            |  2 +-
 drivers/scsi/sg.c                  |  6 +++---
 drivers/scsi/st.c                  |  4 ++--
 drivers/scsi/ufs/ufshcd.c          |  6 +++---
 drivers/target/target_core_pscsi.c |  4 ++--
 fs/nfsd/blocklayout.c              |  4 ++--
 include/linux/blkdev.h             |  1 -
 29 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..1754f5e7cc80 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -642,12 +642,6 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_get_request);
 
-void blk_put_request(struct request *req)
-{
-	blk_mq_free_request(req);
-}
-EXPORT_SYMBOL(blk_put_request);
-
 static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ffb4aa0ea68b..f3493ee243fd 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -845,7 +845,7 @@ int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 
 	free = attempt_merge(q, rq, next);
 	if (free) {
-		blk_put_request(free);
+		blk_mq_free_request(free);
 		return 1;
 	}
 
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 330fede77271..8ea2b33783fb 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -67,7 +67,7 @@ static int bsg_transport_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 
 out_free_bidi_rq:
 	if (job->bidi_rq)
-		blk_put_request(job->bidi_rq);
+		blk_mq_free_request(job->bidi_rq);
 out:
 	kfree(job->request);
 	return ret;
@@ -128,7 +128,7 @@ static void bsg_transport_free_rq(struct request *rq)
 
 	if (job->bidi_rq) {
 		blk_rq_unmap_user(job->bidi_bio);
-		blk_put_request(job->bidi_rq);
+		blk_mq_free_request(job->bidi_rq);
 	}
 
 	kfree(job->request);
diff --git a/block/bsg.c b/block/bsg.c
index bd10922d5cbb..4ddc84aebecf 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -158,7 +158,7 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 
 	ret = q->bsg_dev.ops->fill_hdr(rq, &hdr, mode);
 	if (ret) {
-		blk_put_request(rq);
+		blk_mq_free_request(rq);
 		return ret;
 	}
 
@@ -189,7 +189,7 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 
 out_free_rq:
 	rq->q->bsg_dev.ops->free_rq(rq);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	if (!ret && copy_to_user(uarg, &hdr, sizeof(hdr)))
 		return -EFAULT;
 	return ret;
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 6599bac0a78c..52cd3fd924fc 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -366,7 +366,7 @@ static int sg_io(struct request_queue *q, struct gendisk *bd_disk,
 out_free_cdb:
 	scsi_req_free_cmd(req);
 out_put_request:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	return ret;
 }
 
@@ -509,7 +509,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 	}
 	
 error:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 
 error_free_buffer:
 	kfree(buffer);
@@ -534,7 +534,7 @@ static int __blk_send_generic(struct request_queue *q, struct gendisk *bd_disk,
 	scsi_req(rq)->cmd_len = 6;
 	blk_execute_rq(bd_disk, rq, 0);
 	err = scsi_req(rq)->result ? -EIO : 0;
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 
 	return err;
 }
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 897acda20ac8..381fc0cf0b35 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -782,7 +782,7 @@ static int pd_special_command(struct pd_unit *disk,
 
 	req->func = func;
 	blk_execute_rq(disk->gd, rq, 0);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	return 0;
 }
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index fc4b0f1aa86d..bb8d7ad52550 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -726,7 +726,7 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 	if (scsi_req(rq)->result)
 		ret = -EIO;
 out:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	return ret;
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b0285db7cf4f..691d6d7ab135 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -323,7 +323,7 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	blk_execute_rq(vblk->disk, req, false);
 	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
 out:
-	blk_put_request(req);
+	blk_mq_free_request(req);
 	return err;
 }
 
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 90ad34c6ef8e..9131438da983 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2195,7 +2195,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 
 		ret = blk_rq_map_user(q, rq, NULL, ubuf, len, GFP_KERNEL);
 		if (ret) {
-			blk_put_request(rq);
+			blk_mq_free_request(rq);
 			break;
 		}
 
@@ -2226,7 +2226,7 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 
 		if (blk_rq_unmap_user(bio))
 			ret = -EFAULT;
-		blk_put_request(rq);
+		blk_mq_free_request(rq);
 
 		if (ret)
 			break;
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index a1ce9f5ac3aa..0e8446189d67 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -110,7 +110,7 @@ int ide_queue_pc_tail(ide_drive_t *drive, struct gendisk *disk,
 	blk_execute_rq(disk, rq, 0);
 	error = scsi_req(rq)->result ? -EIO : 0;
 put_req:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	return error;
 }
 EXPORT_SYMBOL_GPL(ide_queue_pc_tail);
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index cffbcc27a34c..c32022a40ce7 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -462,7 +462,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 			error = blk_rq_map_kern(drive->queue, rq, buffer,
 						*bufflen, GFP_NOIO);
 			if (error) {
-				blk_put_request(rq);
+				blk_mq_free_request(rq);
 				return error;
 			}
 		}
@@ -501,7 +501,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 			}
 			--retries;
 		}
-		blk_put_request(rq);
+		blk_mq_free_request(rq);
 		if (delay)
 			ssleep(2);
 	} while (failed && retries >= 0);
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 011eab9c69b7..83920542bdcb 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -301,7 +301,7 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 	rq->rq_flags = RQF_QUIET;
 	blk_execute_rq(cd->disk, rq, 0);
 	ret = scsi_req(rq)->result ? -EIO : 0;
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	/*
 	 * A reset will unlock the door. If it was previously locked,
 	 * lock it again.
diff --git a/drivers/ide/ide-devsets.c b/drivers/ide/ide-devsets.c
index ca1d4b3d3878..3d09a17b0f93 100644
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -175,7 +175,7 @@ int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
 
 	blk_execute_rq(NULL, rq, 0);
 	ret = scsi_req(rq)->result;
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 
 	return ret;
 }
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 8413731c6259..afa94ab8c7e3 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -483,7 +483,7 @@ static int set_multcount(ide_drive_t *drive, int arg)
 	drive->mult_req = arg;
 	drive->special_flags |= IDE_SFLAG_SET_MULTMODE;
 	blk_execute_rq(NULL, rq, 0);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 43fbc37d85c3..8096f3afae12 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -139,7 +139,7 @@ static int ide_cmd_ioctl(ide_drive_t *drive, void __user *argp)
 		ide_req(rq)->type = ATA_PRIV_TASKFILE;
 		blk_execute_rq(NULL, rq, 0);
 		err = scsi_req(rq)->result ? -EIO : 0;
-		blk_put_request(rq);
+		blk_mq_free_request(rq);
 
 		return err;
 	}
@@ -237,7 +237,7 @@ static int generic_drive_reset(ide_drive_t *drive)
 	scsi_req(rq)->cmd[0] = REQ_DRIVE_RESET;
 	blk_execute_rq(NULL, rq, 1);
 	ret = scsi_req(rq)->result;
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	return ret;
 }
 
diff --git a/drivers/ide/ide-park.c b/drivers/ide/ide-park.c
index a80a0f28f7b9..38e7194b69df 100644
--- a/drivers/ide/ide-park.c
+++ b/drivers/ide/ide-park.c
@@ -39,7 +39,7 @@ static void issue_park_cmd(ide_drive_t *drive, unsigned long timeout)
 	ide_req(rq)->special = &timeout;
 	blk_execute_rq(NULL, rq, 1);
 	rc = scsi_req(rq)->result ? -EIO : 0;
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	if (rc)
 		goto out;
 
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index d680b3e3295f..75105188b2b1 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -29,7 +29,7 @@ int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 
 	blk_execute_rq(NULL, rq, 0);
 	ret = scsi_req(rq)->result ? -EIO : 0;
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 
 	if (ret == 0 && ide_port_acpi(hwif)) {
 		/* call ACPI _PS3 only after both devices are suspended */
@@ -84,7 +84,7 @@ int generic_ide_resume(struct device *dev)
 	rqpm.pm_state = PM_EVENT_ON;
 
 	err = ide_pm_execute_rq(rq);
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 
 	if (err == 0 && dev->driver) {
 		struct ide_driver *drv = to_ide_driver(dev->driver);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index fa05e7e7d609..696f175d565d 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -882,7 +882,7 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int size)
 	if (scsi_req(rq)->result == IDE_DRV_ERROR_GENERAL)
 		ret = -EIO;
 out_put:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	return ret;
 }
 
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 6665fc4724b9..b7624e0e9fb1 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -446,7 +446,7 @@ int ide_raw_taskfile(ide_drive_t *drive, struct ide_cmd *cmd, u8 *buf,
 	blk_execute_rq(NULL, rq, 0);
 	error = scsi_req(rq)->result ? -EIO : 0;
 put_req:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 	return error;
 }
 EXPORT_SYMBOL(ide_raw_taskfile);
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index bced42f082b0..4189ddeb305e 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -579,7 +579,7 @@ static void multipath_release_clone(struct request *clone,
 						    clone->io_start_time_ns);
 	}
 
-	blk_put_request(clone);
+	blk_mq_free_request(clone);
 }
 
 /*
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a1d6b68320ae..64e889f702f7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -255,7 +255,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
 	blk_execute_rq(NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
-	blk_put_request(req);
+	blk_mq_free_request(req);
 
 	if (!ret) {
 		pr_info("%s: Locking boot partition ro until next power on\n",
@@ -632,7 +632,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	blk_execute_rq(NULL, req, 0);
 	ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
 	err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
-	blk_put_request(req);
+	blk_mq_free_request(req);
 
 cmd_done:
 	kfree(idata->buf);
@@ -705,7 +705,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	for (i = 0; i < num_of_cmds && !err; i++)
 		err = mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
 
-	blk_put_request(req);
+	blk_mq_free_request(req);
 
 cmd_err:
 	for (i = 0; i < num_of_cmds; i++) {
@@ -2728,7 +2728,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 		*val = ret;
 		ret = 0;
 	}
-	blk_put_request(req);
+	blk_mq_free_request(req);
 
 	return ret;
 }
@@ -2763,7 +2763,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(NULL, req, 0);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
-	blk_put_request(req);
+	blk_mq_free_request(req);
 	if (err) {
 		pr_err("FAILED %d\n", err);
 		goto out_free;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c00f06e9ecb0..9ae8a699b934 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1971,7 +1971,7 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 
 static void eh_lock_door_done(struct request *req, blk_status_t status)
 {
-	blk_put_request(req);
+	blk_mq_free_request(req);
 }
 
 /**
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4d2280658559..48a0a2cbec6b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -288,7 +288,7 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		scsi_normalize_sense(rq->sense, rq->sense_len, sshdr);
 	ret = rq->result;
  out:
-	blk_put_request(req);
+	blk_mq_free_request(req);
 
 	return ret;
 }
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4383d93110f8..7fd52e117737 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -811,7 +811,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 	if (atomic_read(&sdp->detaching)) {
 		if (srp->bio) {
 			scsi_req_free_cmd(scsi_req(srp->rq));
-			blk_put_request(srp->rq);
+			blk_mq_free_request(srp->rq);
 			srp->rq = NULL;
 		}
 
@@ -1407,7 +1407,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	 */
 	srp->rq = NULL;
 	scsi_req_free_cmd(scsi_req(rq));
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 
 	write_lock_irqsave(&sfp->rq_list_lock, iflags);
 	if (unlikely(srp->orphan)) {
@@ -1862,7 +1862,7 @@ sg_finish_rem_req(Sg_request *srp)
 
 	if (srp->rq) {
 		scsi_req_free_cmd(scsi_req(srp->rq));
-		blk_put_request(srp->rq);
+		blk_mq_free_request(srp->rq);
 	}
 
 	if (srp->res_used)
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 841ad2fc369a..4bc4e2318090 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -534,7 +534,7 @@ static void st_scsi_execute_end(struct request *req, blk_status_t status)
 		complete(SRpnt->waiting);
 
 	blk_rq_unmap_user(tmp);
-	blk_put_request(req);
+	blk_mq_free_request(req);
 }
 
 static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
@@ -561,7 +561,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 		err = blk_rq_map_user(req->q, req, mdata, NULL, bufflen,
 				      GFP_KERNEL);
 		if (err) {
-			blk_put_request(req);
+			blk_mq_free_request(req);
 			return DRIVER_ERROR << 24;
 		}
 	}
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index fb32d122f2e3..ff205fd3c555 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2871,7 +2871,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 			err ? "query_complete_err" : "query_complete");
 
 out_put_tag:
-	blk_put_request(req);
+	blk_mq_free_request(req);
 out_unlock:
 	up_read(&hba->clk_scaling_lock);
 	return err;
@@ -6409,7 +6409,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 	__clear_bit(free_slot, &hba->outstanding_tasks);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
-	blk_put_request(req);
+	blk_mq_free_request(req);
 
 	ufshcd_release(hba);
 	return err;
@@ -6584,7 +6584,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	}
 
 out:
-	blk_put_request(req);
+	blk_mq_free_request(req);
 out_unlock:
 	up_read(&hba->clk_scaling_lock);
 	return err;
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 33770e5808ce..3fa30a3d1d81 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1006,7 +1006,7 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 	return 0;
 
 fail_put_request:
-	blk_put_request(req);
+	blk_mq_free_request(req);
 fail:
 	kfree(pt);
 	return ret;
@@ -1061,7 +1061,7 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 		break;
 	}
 
-	blk_put_request(req);
+	blk_mq_free_request(req);
 	kfree(pt);
 }
 
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 1058659a8d31..bd3ecdbeb3fe 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -265,7 +265,7 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
 	len = (buf[2] << 8) + buf[3] + 4;
 	if (len > bufflen) {
 		if (len <= maxlen && retries--) {
-			blk_put_request(rq);
+			blk_mq_free_request(rq);
 			kfree(buf);
 			bufflen = len;
 			goto again;
@@ -308,7 +308,7 @@ static int nfsd4_scsi_identify_device(struct block_device *bdev,
 	}
 
 out_put_request:
-	blk_put_request(rq);
+	blk_mq_free_request(rq);
 out_free_buf:
 	kfree(buf);
 	return error;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c032cfe133c7..ed150b724015 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -914,7 +914,6 @@ extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 blk_qc_t submit_bio_noacct(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
-extern void blk_put_request(struct request *);
 extern struct request *blk_get_request(struct request_queue *, unsigned int op,
 				       blk_mq_req_flags_t flags);
 extern int blk_lld_busy(struct request_queue *q);
-- 
2.22.1

