Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9472130023F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 13:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbhAVK4l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 05:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbhAVJ3Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 04:29:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E66C06178B
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 01:28:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id dj23so5718584edb.13
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e8zlznAImcFn6aUQKKQ/ezvduZl3NWTYoAtSuyukN7E=;
        b=BRbFnfHDIs/smHNgoUrxYDsFF05nDbpo8aSX5PfzleHap763MuKQwDfK8u29Egxixj
         LCg013vU1qCYwBh/SMZ8szaUPk+K5RJooP2EyszdG93GCzNP0+yTdjHxZgJ//gzygcOz
         jArtPCqymk9K81zX3cm4IOjMeFbE06eym3lNUPhR4WZokG/h+vhIOlluYchjHAJe2/wv
         ctoKg+wMd5of+A0178pvtkJUHW891tZo2G4b1lAcikc1QrB/V+fkdJXpi0rQp0EsOl4w
         045fYov7QDjRjW6IQ2u5TVSfVF76TRDw+xRa7zVuj5ORUtWyC7ZzUfDYAr3l4ETfM5CW
         A5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e8zlznAImcFn6aUQKKQ/ezvduZl3NWTYoAtSuyukN7E=;
        b=mSrWHJp9EDepBNHagKm8T20YxlAdwRhHy+Ee/h5eFWH/PVVV9mv4gEAfFUiItVGL87
         cEEyweWqIyxyNwFgcFkMd62uz+RG5VFmFuy3NPo/MjiUmOQWj/p2gu3d/qtkeJGwzd22
         AJnbOvnLfYP4YfejVLl1e9DJXnlNSmUi0uSEqJxCj750QjSXoLzm1g1qwfvmRR5sg4qp
         CNQ53/vURzlQGWR5CFuBFW91n50D37pWdQbf/9y9DqeMlpzZithRc7VZSDeMOLAySIqG
         HcPmHUlGUF9NjasMAyyTSmkAFjg22FCFmV7wF2QG+mGoBebH3yTlfh+24L9UkH7b9l44
         lZmA==
X-Gm-Message-State: AOAM532e/+IyY1gNeHOHTMejPMjGo169Prg2RP2HnARYe1KzLuwLUVOB
        7kzJ3XXqEIWF7lO4LMK0+CEQXA==
X-Google-Smtp-Source: ABdhPJyMaoODmdy8RXoi2rfv+If9xXYUfirTcZFY48nRrUmzOPPhl1zUfZ7bEVx62nyqAu1KqG1gJA==
X-Received: by 2002:a50:bacb:: with SMTP id x69mr2476714ede.39.1611307713947;
        Fri, 22 Jan 2021 01:28:33 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
        by smtp.gmail.com with ESMTPSA id g17sm4684508edb.39.2021.01.22.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 01:28:33 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        hch@infradead.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait and blk_execute_rq
Date:   Fri, 22 Jan 2021 10:28:22 +0100
Message-Id: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

V2 changes:
1. update commit header per Christoph's comment.

Hi Jens,

This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
Also update the comment for blk_execute_rq_nowait.

Thanks,
Guoqing

Guoqing Jiang (2):
  block: remove unnecessary argument from blk_execute_rq_nowait
  block: remove unnecessary argument from blk_execute_rq

 block/blk-exec.c                   | 13 +++++--------
 block/bsg.c                        |  2 +-
 block/scsi_ioctl.c                 |  6 +++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/paride/pd.c          |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/block/sx8.c                |  4 ++--
 drivers/block/virtio_blk.c         |  2 +-
 drivers/cdrom/cdrom.c              |  2 +-
 drivers/ide/ide-atapi.c            |  2 +-
 drivers/ide/ide-cd.c               |  2 +-
 drivers/ide/ide-cd_ioctl.c         |  2 +-
 drivers/ide/ide-devsets.c          |  2 +-
 drivers/ide/ide-disk.c             |  2 +-
 drivers/ide/ide-ioctls.c           |  4 ++--
 drivers/ide/ide-park.c             |  2 +-
 drivers/ide/ide-pm.c               |  4 ++--
 drivers/ide/ide-tape.c             |  2 +-
 drivers/ide/ide-taskfile.c         |  2 +-
 drivers/mmc/core/block.c           | 10 +++++-----
 drivers/nvme/host/core.c           |  8 ++++----
 drivers/nvme/host/lightnvm.c       |  4 ++--
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_lib.c            |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 fs/nfsd/blocklayout.c              |  2 +-
 include/linux/blkdev.h             |  5 ++---
 31 files changed, 50 insertions(+), 56 deletions(-)

-- 
2.17.1

