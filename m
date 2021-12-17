Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063F14796A0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhLQV5O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:57:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48572 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLQV5N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:57:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AEA8623E7
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 21:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEC4C36AE5;
        Fri, 17 Dec 2021 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778232;
        bh=sAUpDklPWzMrfa3+wbgx/TwNjBqlJn0tl5QkozU70Hc=;
        h=From:To:Cc:Subject:Date:From;
        b=Xat4m48uizAshvb0kXvJmGmgP4aDyx9JtNBv2Ro3V/QZUqths2tvPnBSGs5GBfnUI
         jUkFBwtr8Rq+ePADgeckQ6rO33cShSKl8/NYcVbVN41IBajPqbMONNX5jMSliItYy6
         bJpqOpBB5HYUXUv9PMllmvBeJ8d/crJu+6Fg6Op00C6Pb1ZnYmshYu9X1GQuQ2i9TE
         V92wmeCXrhx1iKOUh8ccQ5/KN8ESeABgUIWMjiEEaUZ7gneuQlWANWEPH4tbrPZE/y
         hGA+d3Ez77YnVyCzHf2cLMA3WcNWGzl63/pgmmXK5eOU3dUNpgtTcamrl2MyyVQ8xy
         CaRqtO1qmjynA==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/9] Assorted patches for knfsd
Date:   Fri, 17 Dec 2021 16:50:37 -0500
Message-Id: <20211217215046.40316-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patchset is mainly for improving support for re-exporting
NFSv4 as NFSv3. However it also includes one generic bugfix for NFSv3 to
allow zero length writes. It also improves the writeback performance by
replacing the rwsem with a lock-free errseq_t-based method.

Jeff Layton (3):
  nfsd: Add errno mapping for EREMOTEIO
  nfsd: Retry once in nfsd_open on an -EOPENSTALE return
  nfsd: allow lockd to be forcibly disabled

Peng Tao (1):
  nfsd: map EBADF

Trond Myklebust (5):
  nfs: Add export support for weak cache consistency attributes
  nfsd: NFSv3 should allow zero length writes
  nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()
  nfsd: Replace use of rwsem with errseq_t
  nfsd: Ignore rpcbind errors on nfsd startup

 fs/nfs/export.c                | 24 ++++++++++
 fs/nfsd/filecache.c            |  1 -
 fs/nfsd/filecache.h            |  1 -
 fs/nfsd/nfs3xdr.c              | 83 ++++++++++++++++++++++-----------
 fs/nfsd/nfs4proc.c             | 18 +++----
 fs/nfsd/nfs4xdr.c              |  6 +--
 fs/nfsd/nfsctl.c               |  7 ++-
 fs/nfsd/nfsd.h                 |  1 +
 fs/nfsd/nfsproc.c              |  3 ++
 fs/nfsd/nfssvc.c               | 29 +++++++++++-
 fs/nfsd/trace.h                | 50 ++++++++++++++++++++
 fs/nfsd/vfs.c                  | 85 +++++++++++++++++++++++-----------
 fs/nfsd/vfs.h                  |  8 ++--
 include/linux/exportfs.h       |  3 ++
 include/linux/sunrpc/svcsock.h |  5 +-
 net/sunrpc/svc.c               |  2 +-
 net/sunrpc/svcsock.c           | 14 +++---
 17 files changed, 257 insertions(+), 83 deletions(-)

-- 
2.33.1

