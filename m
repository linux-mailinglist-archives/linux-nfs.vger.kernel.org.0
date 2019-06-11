Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C973D57B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406804AbfFKS1W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:27:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39257 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406910AbfFKS1U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:27:20 -0400
Received: by mail-it1-f194.google.com with SMTP id j204so6372396ite.4
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvH/0cso8A3UwBYPh96TYfWfzD8lGaGcJa7cZC8pyb8=;
        b=YAvZCSU2bP8LrlJqfSEJI2WcfGgy/n5SkGunFOT/Sz0hvyPUpp2wFd0P2hIqzLiCy+
         8qrsoR8q15VPFsJQjTsCC2q6pL4KYo008A8HeB0IvNTFxTKZRJR0l9yk77SHDOZFcsli
         FqIn6hzMzLlyqeWgJicHGDYr8pO89yR+gO+0MNHfUmqudIAf5yMxbSsETj4+j6jBsYdz
         i07E+l0MvdkCZ4iPmIhZEgjcvryX16uLpZIoO6vI5HC70A/yLnjBO7qUZ5nTG3b2yEjp
         TAvzBfgCdprPitu/VeuD2/GIi5EpZg42lvv9vEN/nlFjEQF7wxdtToJDyla3apoLoCQi
         JZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvH/0cso8A3UwBYPh96TYfWfzD8lGaGcJa7cZC8pyb8=;
        b=FktP6kipkLgOO3OBEt0wOlMstNxC76ETzkiDr92TBXjCkd5qnRdb/Qaq8Fz/ybrfKS
         Tx34pdI2RmB4PoOZQGo1cfhEZP6nxVVlE+wokwo/h0B24ryXIrm2Chw97IzKyaJKxmG9
         GYq/dgOB/dGmKBG6gxu9kPfCb9XuYb+u7I+dCnYaDo5bhqr2igXXzRjSl/WrIq7PUa0j
         Ap7l0AqW6awjyhqXgDdIb5mi+CENxvqWEMdzSE6rgFma2A6pw6sds3vjf3VgJycCsAsN
         CvFwwheI5l9sC+iiEvvNHESPBTue/qhdaY7HARjiw2+Kehn4Xnvezh2AlYJdpaLCjqc2
         x2ZQ==
X-Gm-Message-State: APjAAAWPrLx5wqV43AcN/JN2PI2AHEfpN1/8K9nPItWaH+iGTf7u38Zm
        qK0NOiPLOYTrqyWzfW0whABEDtE=
X-Google-Smtp-Source: APXvYqxm816tj0osi1HBHcSPxRr2cEkr874iyiz5Wenu4+YWcuv0Uu/Jcw7AqQfzlPUUzlcwH+OqWw==
X-Received: by 2002:a02:b47:: with SMTP id 68mr34582916jad.66.1560277639027;
        Tue, 11 Jun 2019 11:27:19 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q9sm4789830iot.80.2019.06.11.11.27.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:27:18 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Cache consistency updates
Date:   Tue, 11 Jun 2019 14:25:08 -0400
Message-Id: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a 'deferred cache invalidation' mode that we can use when we thing
the NFS cache may have been changed on the server, but the file in
question is already open and is cached on the client. In order to avoid
performance issues due to false positive detection of server changes,
we defer invalidating the cache until the file has been closed, and
the cached data is no longer in active use.

Trond Myklebust (3):
  NFS: Fix up ftrace printout of the cache invalidation flags
  NFS: Fix up ftrace logging of nfs_inode flags
  NFS: Add deferred cache invalidation for close-to-open consistency
    violations

 fs/nfs/dir.c           |  4 ++++
 fs/nfs/inode.c         | 15 +++++++++++----
 fs/nfs/nfstrace.h      | 22 ++++++++++++++--------
 include/linux/nfs_fs.h |  2 ++
 4 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.21.0

