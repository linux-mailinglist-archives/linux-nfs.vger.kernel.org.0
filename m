Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70215390869
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhEYSEQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 14:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232409AbhEYSEO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 May 2021 14:04:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6F16140E
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621965763;
        bh=oDB5DFe9KIOCrSJwsuv07OH+9jvtwLa0Qjxnz2In78U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FdqwM/OCjGEaLXc7JXc3J0C5qKvoDrVKNweqLWWANrOllBWct1Fx/TxAiFCRcOr1F
         KeuzPHLFVD5CPVr/7bpIfzDrwJVM9hriiKVoOAKdfQkl8qykz33Cb8wQYjewNKN155
         d57wIhhg8Ek+FtczduPrIOlMp8zidtzJKEz+14NTCmYw518J22bYZjWUQr2SJQ/1Y3
         3qlF+8rYZJEPQ23OQOtoHZZnpznF2+zmrPIjihuPCT6CwGpukYD6rlWEVBivbafZ+9
         +XIdlW24AvGhMwnVIF3d0mLgFugKNOwpf3UIO50oH11E5BW6tH/AcDMTdrhVHgnTtx
         8sLJ0mWLPachA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] NFS: Don't corrupt the value of pg_bytes_written in nfs_do_recoalesce()
Date:   Tue, 25 May 2021 14:02:40 -0400
Message-Id: <20210525180241.261090-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525180241.261090-1-trondmy@kernel.org>
References: <20210525180241.261090-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The value of mirror->pg_bytes_written should only be updated after a
successful attempt to flush out the requests on the list.

Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index d35c84af44e0..daf6658517f4 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1128,17 +1128,16 @@ static void nfs_pageio_doio(struct nfs_pageio_descriptor *desc)
 {
 	struct nfs_pgio_mirror *mirror = nfs_pgio_current_mirror(desc);
 
-
 	if (!list_empty(&mirror->pg_list)) {
 		int error = desc->pg_ops->pg_doio(desc);
 		if (error < 0)
 			desc->pg_error = error;
-		else
+		if (list_empty(&mirror->pg_list)) {
 			mirror->pg_bytes_written += mirror->pg_count;
-	}
-	if (list_empty(&mirror->pg_list)) {
-		mirror->pg_count = 0;
-		mirror->pg_base = 0;
+			mirror->pg_count = 0;
+			mirror->pg_base = 0;
+			mirror->pg_recoalesce = 0;
+		}
 	}
 }
 
@@ -1228,7 +1227,6 @@ static int nfs_do_recoalesce(struct nfs_pageio_descriptor *desc)
 
 	do {
 		list_splice_init(&mirror->pg_list, &head);
-		mirror->pg_bytes_written -= mirror->pg_count;
 		mirror->pg_count = 0;
 		mirror->pg_base = 0;
 		mirror->pg_recoalesce = 0;
-- 
2.31.1

