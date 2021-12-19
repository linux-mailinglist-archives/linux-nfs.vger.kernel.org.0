Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B102479EB7
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhLSBov (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60804 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhLSBov (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB73660C61
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF93C36AE0;
        Sun, 19 Dec 2021 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878290;
        bh=QJ7sIgmDl3IDhbt6KXAIAGU76SiehkSHmcVUcJY/WvY=;
        h=From:To:Cc:Subject:Date:From;
        b=C/nakQ5uZtls74VK4Ow+dHOqhqqUryJ3DLL/c1Ezn0OwYdK927hXjAiCeLtf1HJM4
         LKeYkBkmQuJxMvLRrA6HsHLL8YBkNroFGm7Ow1MWDFrcN7CNEvnWhplQjwRqh5j1Hz
         XmDFv5cG+TyVLcmfro5hzQAuL218tXIMsgFQKX41EVsPf/eiS2AE/tYQeR/45pGXO5
         giHBw0vh3KttlOPFmsYeR1zA8GxKAiRd2TpOQeBi0zBO2qKriCSNUJVNyei5Np2Lh7
         IqQUvEN2Loq5zOl0459y/Ef+IMy+P0E0N3Zt0y0H7zvA3a21odxnt8CnZBiWNFYZEJ
         oO9pzCnc7kFmw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/10] Assorted patches for knfsd
Date:   Sat, 18 Dec 2021 20:37:53 -0500
Message-Id: <20211219013803.324724-1-trondmy@kernel.org>
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


- v2: Split patch adding WCC support
  v2: Rebase onto v5.16-rc5

Jeff Layton (3):
  nfsd: Add errno mapping for EREMOTEIO
  nfsd: Retry once in nfsd_open on an -EOPENSTALE return
  nfsd: allow lockd to be forcibly disabled

Peng Tao (1):
  nfsd: map EBADF

Trond Myklebust (6):
  nfsd: Distinguish between required and optional NFSv3 post-op
    attributes
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

