Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E745B435A99
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJUGId (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 02:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUGIc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 02:08:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72883C06161C;
        Wed, 20 Oct 2021 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mwm/ZOmtYGRRyWr/2SOza/GvMW5RB48APrJrzM9W7CI=; b=OWyYVxMNFVphebNZQcMAwa3hX+
        bwdjFj/SQ/c5MwarxVDeENQfnD6RsUhnAK69XEynDW8iJKXGwww5NVTOGQiKLBRxjvtZhEMjg6oyW
        M5xPmsVrVFz0ij+NpGKzaJFso9ZOcNGKLnK3mJ6mf2cLuRPRiWQFNnz2U2E3d+K88a1mB6/a3Anga
        dEuxOlEoJ7BWJM1ak8yPFrvXUKxmOPDXW4Hw7i983+pZwUl+XFv9MBX3fADLOH0COFaURz0fofOOn
        oso0CKmGo5VPHRzWUjVwA23fyZb1mH05hWPwWWe8/BlgGMORVEcKt29ofcJAsZG7kWxR5tks5e27Z
        w/5pZ97Q==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdRDO-006U4C-OJ; Thu, 21 Oct 2021 06:06:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: remove QUEUE_FLAG_SCSI_PASSTHROUGH v3
Date:   Thu, 21 Oct 2021 08:06:00 +0200
Message-Id: <20211021060607.264371-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

this series removes the QUEUE_FLAG_SCSI_PASSTHROUGH and thus the last
remaining SCSI passthrough concept from the block layer.

The changes to support pktcdvd are a bit ugly, but I can't think of
anything better (except for removing the driver entirely).
If we'd want to support packet writing today it would probably live
entirely inside the sr driver.

Changes since v2:
 - s/blk_uniqueue_id/blk_unique_id/g

Changes since v1:
 - use an extra local variable in sd_get_unique_id to make sure we
   always return the right length
 - add an enum and a comment to better document ->get_unique_id
 - spelling fixes

Diffstat:
 block/blk-core.c                   |    9 --
 block/blk-mq-debugfs.c             |    1 
 block/bsg-lib.c                    |   32 +++----
 drivers/block/Kconfig              |    2 
 drivers/block/pktcdvd.c            |    7 +
 drivers/scsi/scsi_bsg.c            |    4 
 drivers/scsi/scsi_error.c          |    2 
 drivers/scsi/scsi_ioctl.c          |    4 
 drivers/scsi/scsi_lib.c            |   27 ++++--
 drivers/scsi/scsi_scan.c           |    1 
 drivers/scsi/sd.c                  |   39 +++++++++
 drivers/scsi/sg.c                  |    4 
 drivers/scsi/sr.c                  |    2 
 drivers/scsi/st.c                  |    2 
 drivers/target/target_core_pscsi.c |    3 
 fs/nfsd/Kconfig                    |    1 
 fs/nfsd/blocklayout.c              |  158 +++++++++----------------------------
 fs/nfsd/nfs4layouts.c              |    5 -
 include/linux/blk-mq.h             |    5 -
 include/linux/blkdev.h             |   14 ++-
 include/scsi/scsi_cmnd.h           |    3 
 21 files changed, 148 insertions(+), 177 deletions(-)
