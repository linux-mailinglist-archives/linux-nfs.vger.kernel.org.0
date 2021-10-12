Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF87742A3CF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 14:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhJLMII (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 08:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhJLMIH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 08:08:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E51C061570;
        Tue, 12 Oct 2021 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jBg7GLG8pnF5vWvA72VBDUBf7fSzexS5co9f5CCx1qw=; b=r2DH7Blp3qrqos1Fbq53dyi5rJ
        wiJ8uFjy5DVHaSdMMf1PiMgpbtcvpVsAwgTkTO66DNHCTvuOPEySJQZKvnn9lgVtYuCFmdp+Nttrw
        WF2JzojxD876m1vEtZLQCpomB1UqnX0mHBMkI6to3T2sd3NAsIz0TkJ7Vzv5N0BPtj7had8vrWYcJ
        aGhladskt1a8a9fLGC9jY2rbFRMVC7Layt1O5lcADf9EnITBFtT2o47OadNXsPjBwsXwO+JOnUJq+
        iS075eJP1obpc94rf+sPPzFxJ6UKWfwmak5rxRSqEJ28f8l/5sz5NjtPliHW65Npz+/184y/kZiM+
        0uT/bhyg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGWV-006TmI-Pq; Tue, 12 Oct 2021 12:05:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: remove QUEUE_FLAG_SCSI_PASSTHROUGH
Date:   Tue, 12 Oct 2021 14:04:38 +0200
Message-Id: <20211012120445.861860-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
 drivers/scsi/sd.c                  |   37 ++++++++
 drivers/scsi/sg.c                  |    4 
 drivers/scsi/sr.c                  |    2 
 drivers/scsi/st.c                  |    2 
 drivers/target/target_core_pscsi.c |    3 
 fs/nfsd/Kconfig                    |    1 
 fs/nfsd/blocklayout.c              |  158 +++++++++----------------------------
 fs/nfsd/nfs4layouts.c              |    5 -
 include/linux/blk-mq.h             |    5 -
 include/linux/blkdev.h             |    4 
 include/scsi/scsi_cmnd.h           |    3 
 21 files changed, 136 insertions(+), 177 deletions(-)
