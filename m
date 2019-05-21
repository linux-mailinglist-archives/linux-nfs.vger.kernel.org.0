Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4624F29
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 14:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEUMtM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 08:49:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35579 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUMtM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 08:49:12 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so4487195ith.0
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtZiIQdBQfgpi96pM0WvJOfoCF5rXUgQzvNDYsUbXSY=;
        b=eS2oYJUDiEKbyjdWXhF0cXAB6nNy0ItxqCDvTRkvWXQgHeKGgdflYZZuqoxcnWXanc
         BfWhdurma5kGYevUkAgoodL0POMW6l1T2i/kMFzBMnKz5HcPUzB1KpCvAZXakH38GqtX
         ZtS/keYt1bdJr9TRSc0XY1vQPbZjwyufGhLhnFQ2OC/0yQsWFjPqJM/jhNGg/inm1rhB
         tEQ4ZE0WM+d645tH56gETBVTuQeaowp5FakB4ilfC2sLOwGrRDcGe0OIbDfSbNAP2AO+
         o5ZXS7tghs1OKwwK2Ru5i03pViz+sJamRnF7Vt8/h77pcJlt+U+8fota8l9gm3ZNR/Vt
         Hs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtZiIQdBQfgpi96pM0WvJOfoCF5rXUgQzvNDYsUbXSY=;
        b=CNd88rDwIcyVXe1XXuqKJAsWfhbYd8eVovw7cB4nUjYXgVgUvbeIZ/cPL4Umo3jZv7
         ps0aAXFd3frFFKvFQfHYVl8zpeFVj6usT8+PgrSeg/IJWTC/h4FbrnIqkmw6sCgo3+fK
         S3/H7MlaalX4/ZfURjhQiVeRNvpL6N+rt7BeNr2n4XYPohg/GWib6oOhzxe61ULoQy3V
         kHjS2uc6RDDHqZ/YIWD98Y6+nyVs5bRcwOK0QbifxJRG7JPnSGaiiBhxmrHYbEoOdO0J
         gBGetvY70RHVfOoGwSiuRFFHdNNOZLK6rj2pdFqwoIBwJmg4nPk3bjCdBS/YHNU++VPw
         BscA==
X-Gm-Message-State: APjAAAXoQ4kt17CFNKlUFYBavBzMIJRERVmLuW5PwAD4dEbAda94c+Qt
        9oVM381YGNrlaKnPYRAh9inuvmk=
X-Google-Smtp-Source: APXvYqyX96mRmPuOQyDbC1DGfCgbiGXZDMoVz0pGs3Ja0kayfxua3MGmU6VzebyWPXw9jj5lEMViJg==
X-Received: by 2002:a05:660c:4c2:: with SMTP id v2mr3753175itk.71.1558442951234;
        Tue, 21 May 2019 05:49:11 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v139sm1693180itb.25.2019.05.21.05.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 05:49:09 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Date:   Tue, 21 May 2019 08:46:54 -0400
Message-Id: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following patchset adds support for the 'root_dir' configuration
option for nfsd in nfs.conf. If a user sets this option to a valid
directory path, then nfsd will act as if it is confined to a chroot
jail based on that directory. All paths in /etc/exporfs and from
exportfs are then resolved relative to that directory.


Trond Myklebust (7):
  mountd: Ensure we don't share cache file descriptors among processes.
  Add a simple workqueue mechanism
  Add utilities for resolving nfsd paths and stat()ing them
  Add a helper to return the real path given an export entry
  Add helpers to read/write to a file through the chrooted thread
  Add support for the nfsd rootdir configuration option to rpc.mountd
  Add support for the nfsd root directory to exportfs

 aclocal/libpthread.m4       |  13 +-
 configure.ac                |   6 +-
 nfs.conf                    |   1 +
 support/export/export.c     |  24 +++
 support/include/Makefile.am |   2 +
 support/include/exportfs.h  |   1 +
 support/include/nfsd_path.h |  17 ++
 support/include/nfslib.h    |   1 +
 support/include/workqueue.h |  22 +++
 support/misc/Makefile.am    |   3 +-
 support/misc/mountpoint.c   |   5 +-
 support/misc/nfsd_path.c    | 175 +++++++++++++++++++++
 support/misc/workqueue.c    | 306 ++++++++++++++++++++++++++++++++++++
 support/nfs/exports.c       |   4 +
 systemd/nfs.conf.man        |   3 +-
 utils/exportfs/Makefile.am  |   2 +-
 utils/exportfs/exportfs.c   |  32 +++-
 utils/mountd/Makefile.am    |   3 +-
 utils/mountd/cache.c        |  79 +++++++---
 utils/mountd/mountd.c       |  13 +-
 utils/nfsd/nfsd.man         |   6 +
 21 files changed, 676 insertions(+), 42 deletions(-)
 create mode 100644 support/include/nfsd_path.h
 create mode 100644 support/include/workqueue.h
 create mode 100644 support/misc/nfsd_path.c
 create mode 100644 support/misc/workqueue.c

-- 
2.21.0

