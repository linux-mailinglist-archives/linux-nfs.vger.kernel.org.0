Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027862D06B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfE1Udc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34578 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfE1Udb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:31 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so3851191iot.1
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VmfjKoBNUiWgK/T6Pa80Mq3mGYp6euf6QuCgFSK473Y=;
        b=BFHRNwOAM+iGcC3SzlqCeATpA1/GGNVQXK22Gz8ayPvAG+pKOkdnGM2joELTSivA6A
         pv7otkkFE2r+mKXVF/MGNzaiHqZ622pfGG4Q+C3wZ7/AkRg5W1uRXiERj5Q/QYkn+glZ
         U5jJCqZMmYPektW6Qp8OjodwxCXl/zQh5ip/l4fdfKAoiDzi3Z3e7qOlAuiRo0V8sUIJ
         Mb5H+8hVhr1HkOAVos5z/OEgJ0z1YwrqDzq6cb7g1p/dc0TwIUCyx8b7m1G5rfnJU5Ke
         3FIXoj46w8Wybpd7bKzvN9jkwjYqqc2DUG1/dm8tYGtu/jy+K6VPe3Dd2yI2L5Ym0y9n
         pQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VmfjKoBNUiWgK/T6Pa80Mq3mGYp6euf6QuCgFSK473Y=;
        b=p7T5zgaZFrlQyDYE0eq/IKfpZgb5ic8QMrhwzuyx+mfGA0rjeawwpcR3NZbCJ6pTr5
         vYLnjxXVz1aX1SNEF5UUrUOMWTh3Rhn1llpbMlprPJcI5xXX46NEZkJPfLiKMsfmNH3H
         rnc7ikXOphVt+dHpqJR/ArJkZ8F9HglY9Cmdq9oz55ZR6DNZINl+Q2Phv1CTsIz3ToDA
         bf9+R89mdZNLl3nUm1egI/4pyaiAY2+EB2gp5B0Rcbrk2lo8yKe6wvKlU5wfazYQWlIR
         /NVkcGTqLTf6fgzZQRUS4/2ayNeTxGtppS346WZTVhvs8XINW89KeJ68VZfj+z5dXVJ2
         pHHw==
X-Gm-Message-State: APjAAAWbxZJxlQA63YX2lcHVNWVgpiDVdNXGkpzp2m2Cfka4kumk3hwy
        UgbGpNxhWFTRdUEuawhuSiyDbXk=
X-Google-Smtp-Source: APXvYqyGw+FQZ94mcecY34q0ybxjuOG9AxMRrd3eKduCSplYMhS1cc/d1cqvUHm4Upav5tchig9TYA==
X-Received: by 2002:a5d:9584:: with SMTP id a4mr180400ioo.283.1559075610607;
        Tue, 28 May 2019 13:33:30 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:30 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/11] Add the "[exports] rootdir" option to nfs.conf
Date:   Tue, 28 May 2019 16:31:11 -0400
Message-Id: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following patchset adds support for the "rootdir" configuration
option for nfsd in the "[exports]" section in /etc/nfs.conf.

If a user sets this option to a valid directory path, then nfsd will
act as if it is confined to a chroot jail based on that directory.
All paths in /etc/exports and the exportfs utility are then resolved
relative to that directory.

Trond Myklebust (11):
  mountd: Ensure we don't share cache file descriptors among processes.
  Add a simple workqueue mechanism
  Allow callers to check mountpoint status using a custom lstat function
  Add utilities for resolving nfsd paths and stat()ing them
  Use xstat() with no synchronisation if available
  Add helpers to read/write to a file through the chrooted thread
  Add a helper to return the real path given an export entry
  Add support for the "[exports] rootdir" nfs.conf option to rpc.mountd
  Add support for the "[exports] rootdir" nfs.conf option to exportfs
  Add a helper for resolving symlinked nfsd paths via realpath()
  Fix up symlinked mount path resolution when "[exports] rootdir" is set

 aclocal/libpthread.m4       |  13 +-
 configure.ac                |   6 +-
 nfs.conf                    |   3 +
 support/export/export.c     |  24 +++
 support/include/Makefile.am |   3 +
 support/include/exportfs.h  |   1 +
 support/include/misc.h      |   7 +-
 support/include/nfsd_path.h |  21 +++
 support/include/nfslib.h    |   1 +
 support/include/workqueue.h |  18 +++
 support/include/xstat.h     |  11 ++
 support/misc/Makefile.am    |   3 +-
 support/misc/mountpoint.c   |   8 +-
 support/misc/nfsd_path.c    | 289 ++++++++++++++++++++++++++++++++++++
 support/misc/workqueue.c    | 228 ++++++++++++++++++++++++++++
 support/misc/xstat.c        | 105 +++++++++++++
 support/nfs/exports.c       |   4 +
 systemd/nfs.conf.man        |  20 ++-
 utils/exportfs/Makefile.am  |   2 +-
 utils/exportfs/exportfs.c   |  11 +-
 utils/mountd/Makefile.am    |   3 +-
 utils/mountd/cache.c        |  63 +++++---
 utils/mountd/mountd.c       |  24 +--
 23 files changed, 819 insertions(+), 49 deletions(-)
 create mode 100644 support/include/nfsd_path.h
 create mode 100644 support/include/workqueue.h
 create mode 100644 support/include/xstat.h
 create mode 100644 support/misc/nfsd_path.c
 create mode 100644 support/misc/workqueue.c
 create mode 100644 support/misc/xstat.c

-- 
2.21.0

