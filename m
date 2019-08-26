Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736659D483
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfHZQxt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 12:53:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40031 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHZQxt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 12:53:49 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so38966639ios.7
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpWAmjlHy5+1fLi4QyLuasUyp3uzvNmNttlLw5DWg5k=;
        b=GqZUmM2dMBUUQO0CdGn/gpQPc6nivYx16pzkmekDwbArTsrHbQhKafIupW2K4lUXVJ
         IaT4nGIH//CFLjeKBhK6LUHKxHQaJ2gzSDrleq8d22uekLmOY8izIREObrveAN/EKqy8
         NM/2bU9V1InImPCrgHTf4gbQEvkvLvugbu5UrP/U7fSP6xPHgnGJU9c7PWewP23uB7d5
         rK/A3Ih+YNMU/oEte7SrJuFlOz6xYGncDs1Df5uG3TxWflZIV0gxT8pK1UT+zXjC5JfG
         S6DIVURU1i+yz897MAYAVjodWB4YOMrMZo57baY7UmdELMsNatctXXL9yFO7xRgPdm1M
         8IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpWAmjlHy5+1fLi4QyLuasUyp3uzvNmNttlLw5DWg5k=;
        b=qyKFFZz5bSdrumi3UhcptqLMXQXAYCxbCbrtMDbQ1CuVFMkjUmYFpO+R5+A0mDZaV8
         HFqmPk3lUGDk3b70u44PIxe4edsK34A6kh5XXJ/GWqEelcf3ousp6pQd04GLTkOyC1+7
         9HDRWqgilAEIRQ7WBTCKdZ394LtZhY+tdd/7ORxWp6+K/0R4oNRMveoGu6cTIqnJY6tf
         eYMgT6GLr7dRXjGOdtfNkhEPK+8QIH+Th3iNYe6GIYLl3aObTAYAvN8xYJ5HO+cxP8tg
         kFmLyQwBe8UlBziEQMS8Umt2QYy0seImQZRwxnaAoOsxE9Cmq+KWfAFpiXNfdsaZR4TB
         rVQQ==
X-Gm-Message-State: APjAAAVKv7KioCZigknlVxfeOaaRxXrqIkldt+OM7vFluDKeXwExa+SD
        ReDePwmfdqPoifyVIibD3g==
X-Google-Smtp-Source: APXvYqySTog91U1fskOuq0t2CVFDz71v/GyyU2w2bp7F1sfWCT04PQdousbMwqWCig/kKNOhfOKS1A==
X-Received: by 2002:a02:ac84:: with SMTP id x4mr18150196jan.2.1566838428115;
        Mon, 26 Aug 2019 09:53:48 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u24sm10613490iot.38.2019.08.26.09.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 09:53:47 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Date:   Mon, 26 Aug 2019 12:50:18 -0400
Message-Id: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
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

Trond Myklebust (3):
  nfsd: nfsd_file cache entries should be per net namespace
  nfsd: Support the server resetting the boot verifier
  nfsd: Don't garbage collect files that might contain write errors

 fs/nfsd/export.c    |  2 +-
 fs/nfsd/filecache.c | 76 +++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/filecache.h |  3 +-
 fs/nfsd/netns.h     |  4 +++
 fs/nfsd/nfs3xdr.c   | 13 +++++---
 fs/nfsd/nfs4proc.c  | 14 +++------
 fs/nfsd/nfsctl.c    |  1 +
 fs/nfsd/nfssvc.c    | 32 ++++++++++++++++++-
 8 files changed, 115 insertions(+), 30 deletions(-)

-- 
2.21.0

