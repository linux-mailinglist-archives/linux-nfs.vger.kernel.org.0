Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559C81750EC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCAXZP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:15 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:38568 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAXZP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:15 -0500
Received: by mail-yw1-f50.google.com with SMTP id 10so9482428ywv.5
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tRYjmdyCdLkJBURWnLmo1M6qpfNuc24L7279rJBmO8=;
        b=IJrRzYpj3YV8FRrX8V5HJgo+gZOGciwlmtVKbA5RfRds8Bgy3TOHYF0myt+M7pxeUe
         b6aYovfLVZREIZqXRTXhOuuNCabSKa7uZST9MKlxBn6CA5LiELo3rLDcS3d4MCD2JDtX
         ZR8xP3myZN211Xz/vjQm+90PluxOun0Z0EpqXWnO8AvHVmnPIINIe1q9SoDYcLwFkKUl
         F12IITX+cTCf0DXYSVmIoTG59cfAk936XUmbt/JSk3iXdqnymQ3n29fYJZbKmN/f7FzT
         MxQw/cQZxR0Oi/Tg1jyevMQxuJzUtaKrVeAT32Vj7IVJF1bR3957YbKEvphmrRseCgAn
         5Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tRYjmdyCdLkJBURWnLmo1M6qpfNuc24L7279rJBmO8=;
        b=WGEwxicpE9u9a56BFqNbMTwuNhtduF6mOQ5uKVzLZpf8q3AQW2NvaUrEr/IuCzkfle
         avaWy+BIUHD54DJsYcLURexz2ptJde381d/wLm3c3Kt7dLqMx5P1XCwrTTt/7bgG54Dy
         TBRnXFa1r/ifbRzmi5bMjZLIYGtg8a85eTXuPbcW4FBjv5j9AYD/tY41JfQIBy/UicOn
         KNLERPRF7CbS/PCeHA03yWx3zFFnlM1fpYRDjTCkcj8PGpmdDENSEWhaVyYca1pe28b0
         5P9bBtBLjA+ff29yzXAI3kGKa9bf/Gu1HOQKGbzYR5vq0f4vdSv730BziY6z7Nkd+rOS
         xC0g==
X-Gm-Message-State: APjAAAU6ZS67W451rQhytX1NcIO5V8aDTS0k6XQV9n0zAQIkKtugFAjt
        gbFvLPMU9fw83RYoSXK6iQ==
X-Google-Smtp-Source: APXvYqxzjXa4r2YjRObCSd0TimgsNEFFNxuIKzQwORIKb/U90UGrwHurysKna8B86t3ytB/sC3wbGg==
X-Received: by 2002:a81:449:: with SMTP id 70mr14513722ywe.161.1583105113875;
        Sun, 01 Mar 2020 15:25:13 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:13 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/8] Bugfixes and tracing enhancements for knfsd
Date:   Sun,  1 Mar 2020 18:21:37 -0500
Message-Id: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series fixes an Oops that has been getting in the way of testing
NFSv4.1 in the last few weeks. It adds a number of tracepoints around
the knfsd cache and upcall mechanism in order to help debugging, then
fixes a few races caused by the cache_listeners_exist() mechanism
and goes back to addressing the garbage collection timeouts.

Finally, it fixes the long standing issue that knfsd will drop requests
without dropping the TCP connection, something which violates the NFSv4
protocol.

Trond Myklebust (8):
  nfsd: Don't add locks to closed or closing open stateids
  nfsd: Add tracing to nfsd_set_fh_dentry()
  nfsd: Add tracepoints for exp_find_key() and exp_get_by_name()
  nfsd: Add tracepoints for update of the expkey and export cache
    entries
  nfsd: export upcalls must not return ESTALE when mountd is down
  SUNRPC/cache: Allow garbage collection of invalid cache entries
  sunrpc: Add tracing for cache events
  sunrpc: Drop the connection when the server drops a request

 fs/nfs/dns_resolve.c              |  11 +--
 fs/nfsd/export.c                  |  45 ++++++++---
 fs/nfsd/nfs4idmap.c               |  14 ++++
 fs/nfsd/nfs4state.c               |  73 ++++++++++--------
 fs/nfsd/nfsfh.c                   |  13 +++-
 fs/nfsd/trace.h                   | 122 +++++++++++++++++++++++++++++
 include/linux/sunrpc/cache.h      |   6 +-
 include/trace/events/sunrpc.h     |  33 ++++++++
 net/sunrpc/auth_gss/svcauth_gss.c |  12 +++
 net/sunrpc/cache.c                | 124 +++++++++++++++++-------------
 net/sunrpc/svc_xprt.c             |  10 +++
 net/sunrpc/svcauth_unix.c         |  12 +++
 12 files changed, 370 insertions(+), 105 deletions(-)

-- 
2.24.1

