Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B267A5BAA
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfIBRG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 13:06:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34934 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfIBRG0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Sep 2019 13:06:26 -0400
Received: by mail-io1-f67.google.com with SMTP id b10so30375610ioj.2
        for <linux-nfs@vger.kernel.org>; Mon, 02 Sep 2019 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wH9Z9oo/s/UjfBmsVcaRfoVuOwnmZdrGzfKvz4txTY8=;
        b=WuNl3acSR+1KP6zwY4p/Ar6fZVfW7fN4xCbJLQ2JgxSV4Db0tYmpqbi03Yafp2p9yR
         wfJxjfaHzIezoWbA8O+7fzNHwtSCXU7O4SCF0/5HQKBCv2qwXz1/WU6FkESWiRlvSs1t
         odKV+RJUrAwES5KApb2+xBNHRDrgMtmQNAPdoIYm/VFNhcU44pDRJ65eYt+XCOSp7u4i
         taE5FgmnXn0VDH00LMoYdFQqQsTLD8iuHFekyinpWLj/QV3ykYYFAosZYY/ZiIPDfVw0
         GVzyepZG4DLd5H8RK6doneUAfZMmAWkGkTYqRYtnNsSWJOpaCAjrZwMijAXWPMFkkvRC
         RcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wH9Z9oo/s/UjfBmsVcaRfoVuOwnmZdrGzfKvz4txTY8=;
        b=osx8TR6BNXpNKd41C4fdBhz8Is/Ce0CZssqe3Pwkow6JFRE2tzj1+Xlc2h+x8+FkYi
         VGXkuprPZltrVgL46VUTocTAZzxlKLhpUtZ9J/rXnOh42avQznzEQ9cXYkjOIrRCBKew
         uWgWuOZW9RpfRFUl1jzBw44tCwoh14l+NBhF2ygpc8sscXPWYMmLgVse6zdsq4hQRSIK
         bYIRXPMHr+jsQ3uvSWJ7AN80vdpmnPD9gNRXRLPbGr6bw5EBZMAFjnVWFDk0iiCgSdj1
         1y0tvWX2XD6BIVGhvtOJfN3WsYibLq0hr107XSL6wn/5iTvVCAk6tZ8nPT4XfsK1VMej
         qdRg==
X-Gm-Message-State: APjAAAVQYzrMd7A0jZTxxgKJO4XeIxU5V8GwQ0p9MteswN/t23/0eRdE
        3tW/xzse87invQebrDD/6Qchxy5KIw==
X-Google-Smtp-Source: APXvYqx/34QtV4KaI+Rf9X+RWEOBK64e9iOnknnzkLIa4rATVthHQCrvc5Ra6aFOe7ObOlhncqyBGA==
X-Received: by 2002:a02:3745:: with SMTP id r66mr32417894jar.23.1567443985595;
        Mon, 02 Sep 2019 10:06:25 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o3sm7655322iob.64.2019.09.02.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 10:06:25 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J.Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/4] Handling NFSv3 I/O errors in knfsd
Date:   Mon,  2 Sep 2019 13:02:54 -0400
Message-Id: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Recently, a number of changes went into the kernel to try to ensure
that I/O errors (specifically write errors) are reported to the
application once and only once. The vehicle for ensuring the errors
are reported is the struct file, which uses the 'f_wb_err' field to
track which errors have been reported.

The problem is that errors are mainly intended to be reported through
fsync(). If the client is doing synchronous writes, then all is well,
but if it is doing unstable writes, then the errors may not be
reported until the client calls COMMIT. If the file cache has
thrown out the struct file, due to memory pressure, or just because
the client took a long while between the last WRITE and the COMMIT,
then the error report may be lost, and the client may just think
its data is safely stored.

Note that the problem is compounded by the fact that NFSv3 is stateless,
so the server never knows that the client may have rebooted, so there
can be no guarantee that a COMMIT will ever be sent.

The following patch set attempts to remedy the situation using 2
strategies:

1) If the inode is dirty, then avoid garbage collecting the file
   from the file cache.
2) If the file is closed, and we see that it would have reported
   an error to COMMIT, then we bump the boot verifier in order to
   ensure the client retransmits all its writes.

Note that if multiple clients were writing to the same file, then
we probably want to bump the boot verifier anyway, since only one
COMMIT will see the error report (because the cached file is also
shared).

So in order to implement the above strategy, we first have to do
the following: split up the file cache to act per net namespace,
since the boot verifier is per net namespace. Then add a helper
to update the boot verifier.

---
v2:
- Add patch to bump the boot verifier on all write/commit errors
- Fix initialisation of 'seq' in nfsd_copy_boot_verifier()

Trond Myklebust (4):
  nfsd: nfsd_file cache entries should be per net namespace
  nfsd: Support the server resetting the boot verifier
  nfsd: Don't garbage collect files that might contain write errors
  nfsd: Reset the boot verifier on all write I/O errors

 fs/nfsd/export.c    |  2 +-
 fs/nfsd/filecache.c | 76 +++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/filecache.h |  3 +-
 fs/nfsd/netns.h     |  4 +++
 fs/nfsd/nfs3xdr.c   | 13 +++++---
 fs/nfsd/nfs4proc.c  | 14 +++------
 fs/nfsd/nfsctl.c    |  1 +
 fs/nfsd/nfssvc.c    | 32 ++++++++++++++++++-
 fs/nfsd/vfs.c       | 19 +++++++++---
 9 files changed, 130 insertions(+), 34 deletions(-)

-- 
2.21.0

