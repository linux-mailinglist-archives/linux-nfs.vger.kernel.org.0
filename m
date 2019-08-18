Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE7918B6
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfHRSVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32780 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHRSVI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:08 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so16095764iog.0
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GE+H4lHDFBjgHsBVUQI6N/9/0x4WTrPdZsB9ZY0txw=;
        b=PKIIMkAzmM+7nfQxpJlxc5p8RU3Ssvn4nRr/N3WMMqWJ6WgOJZDkRXZDg1hThUCpub
         QSmtA9o1+qizPkGT6bfaN8RW/qsw0vJqxX7VTGIuMgzYdaG4Euiuz3mud6l7WUvvDjfM
         zEldKnhBHTwTWDYDi4kprHtjyZ2rLwQpJJESPC58ZhcNnldPNoq+BTkkRROW0hFr1Mol
         CFjlKl0d5X7jW02BTT2n8D0K6htf9y5I7bNPNR9q00FjVP3zXpiiO0beIXgweaz+gO+5
         QepoiWO5HOYnhtukxwGrtgMApH2oYOI0Qng7zjAOSP29audv2oIs/v4Mc20zV519OUVj
         cjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GE+H4lHDFBjgHsBVUQI6N/9/0x4WTrPdZsB9ZY0txw=;
        b=DXLY5FQ6iN/h1qiowXis2T8OLP0V5RUBPiFMz2uUm/HZCaVp7AmRLU+EogUx1Sjlym
         sGjMFvJfaUw1M1ocFIamkcykapUFOOba2SYBpnnqKTuMJa4nKNMl5lY2kU7dkNF2FZwn
         yD2qESkztEB0IRwH/sweplNP6x7JRXQ9Kw6scyjeK86gd6EYafNmGh6ukmU/AWDwYoeX
         Ycg4iwuCYNtMCddhuEUI1sWgaDANF/LCJ0dFnjwEGI4Tg1DgwFw8T6/HGbfkQOyLwNRd
         5lz+9M6vnssVMOXDV80fNMfgDy/N/KuK8O/zfQ7r1YUHV6sE9JpYijTEIzD+PgEonx9s
         8dKw==
X-Gm-Message-State: APjAAAUSMrewWfdOpkQFTbgqfzMf0h7ORPaPsf6IqlSa4WR+rGETqBzY
        zJeKK4+WfeaSi8CMrOcbPgbyqTU=
X-Google-Smtp-Source: APXvYqzlVw6WeB0OgDF6XrnUIoX4yaVQgTUmIdvDlFaoC7UNL67DUHiiVgIFyQPcCeHPCVp+hxlL2w==
X-Received: by 2002:a5e:9314:: with SMTP id k20mr22518713iom.235.1566152467018;
        Sun, 18 Aug 2019 11:21:07 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:06 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/16] Cache open file descriptors in knfsd
Date:   Sun, 18 Aug 2019 14:18:43 -0400
Message-Id: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a NFSv3 READ or WRITE request comes in, the first thing knfsd has
to do is open a new file descriptor. While this is often a relatively
inexpensive thing to do for most local filesystems, it is usually less
so for FUSE, clustered or networked filesystems that are being exported
by knfsd.

This set of patches attempts to reduce some of that cost by caching
open file descriptors so that they may be reused by other incoming
READ/WRITE requests for the same file.
One danger when doing this, is that knfsd may end up caching file
descriptors for files that have been unlinked. In order to deal with
this issue, we use fsnotify to monitor the files, and have hooks to
evict those descriptors from the file cache if the i_nlink value
goes to 0.

-------
v2:
- Fix a double semicolon in fs/nfsd/filecache.c
- Adjust changelog for "nfsd: rip out the raparms cache" as per Chuck's
  request.
-------

Jeff Layton (12):
  sunrpc: add a new cache_detail operation for when a cache is flushed
  locks: create a new notifier chain for lease attempts
  nfsd: add a new struct file caching facility to nfsd
  nfsd: hook up nfsd_write to the new nfsd_file cache
  nfsd: hook up nfsd_read to the nfsd_file cache
  nfsd: hook nfsd_commit up to the nfsd_file cache
  nfsd: convert nfs4_file->fi_fds array to use nfsd_files
  nfsd: convert fi_deleg_file and ls_file fields to nfsd_file
  nfsd: hook up nfs4_preprocess_stateid_op to the nfsd_file cache
  nfsd: have nfsd_test_lock use the nfsd_file cache
  nfsd: rip out the raparms cache
  nfsd: close cached files prior to a REMOVE or RENAME that would
    replace target

Trond Myklebust (4):
  notify: export symbols for use by the knfsd file cache
  vfs: Export flush_delayed_fput for use by knfsd.
  nfsd: Fix up some unused variable warnings
  nfsd: Fix the documentation for svcxdr_tmpalloc()

 fs/file_table.c                  |   1 +
 fs/locks.c                       |  61 +++
 fs/nfsd/Kconfig                  |   1 +
 fs/nfsd/Makefile                 |   3 +-
 fs/nfsd/blocklayout.c            |   3 +-
 fs/nfsd/export.c                 |  13 +
 fs/nfsd/filecache.c              | 885 +++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h              |  60 +++
 fs/nfsd/nfs4layouts.c            |  12 +-
 fs/nfsd/nfs4proc.c               |  83 +--
 fs/nfsd/nfs4state.c              | 183 ++++---
 fs/nfsd/nfs4xdr.c                |  31 +-
 fs/nfsd/nfssvc.c                 |  16 +-
 fs/nfsd/state.h                  |  10 +-
 fs/nfsd/trace.h                  | 140 +++++
 fs/nfsd/vfs.c                    | 295 ++++-------
 fs/nfsd/vfs.h                    |   9 +-
 fs/nfsd/xdr4.h                   |  19 +-
 fs/notify/fsnotify.h             |   2 -
 fs/notify/group.c                |   2 +
 fs/notify/mark.c                 |   6 +
 include/linux/fs.h               |   5 +
 include/linux/fsnotify_backend.h |   2 +
 include/linux/sunrpc/cache.h     |   1 +
 net/sunrpc/cache.c               |   3 +
 25 files changed, 1464 insertions(+), 382 deletions(-)
 create mode 100644 fs/nfsd/filecache.c
 create mode 100644 fs/nfsd/filecache.h

-- 
2.21.0

