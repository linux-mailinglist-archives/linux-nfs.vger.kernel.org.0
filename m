Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47DC364665
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhDSOsb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 10:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbhDSOsb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 10:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08B08611CE
        for <linux-nfs@vger.kernel.org>; Mon, 19 Apr 2021 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618843681;
        bh=S/4BQn47RBXS/z6C9WL4z+GqX6Vb07vbeLClbH0BmpU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VExfY+1ZzaXDPAiQIow32Woz81LPuBZ/MnhbNH6HQo4KzBTVDWg8EOT0m4fQPHUcK
         Yc9yeJyt3JVAHoR5QwcTJ+rO25wT0uwoPQXuQCaFZM7eEynruE89wrPO4RcIf6tPDv
         ++ROIUigcaLJ6SnZg3lm4LHIERrBhLWOq1WtCm0FjYip3aPZfBR2e8l8kJ4Szpfxbs
         u5nivvey6HakijJxy5o/RAikgcIszFYoWOoo60AdsHiGaS7+EQBjdDPHb9pvaV6YHx
         RbSXaOZWtj8twk6hD3wP25DAhuHdgKIkX8NNvMDHme1Qhh+d2by8aVfznz8lD3pwFT
         iIxrPfdHiU/yw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/4] NFS: Don't discard pNFS layout segments that are marked for return
Date:   Mon, 19 Apr 2021 10:47:57 -0400
Message-Id: <20210419144759.41900-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419144759.41900-1-trondmy@kernel.org>
References: <20210419144759.41900-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the pNFS layout segment is marked with the NFS_LSEG_LAYOUTRETURN
flag, then the assumption is that it has some reporting requirement
to perform through a layoutreturn (e.g. flexfiles layout stats or error
information).

Fixes: e0b7d420f72a ("pNFS: Don't discard layout segments that are marked for return")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 102b66e0bdef..33574f47601f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2468,6 +2468,9 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 
 	assert_spin_locked(&lo->plh_inode->i_lock);
 
+	if (test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
+		tmp_list = &lo->plh_return_segs;
+
 	list_for_each_entry_safe(lseg, next, &lo->plh_segs, pls_list)
 		if (pnfs_match_lseg_recall(lseg, return_range, seq)) {
 			dprintk("%s: marking lseg %p iomode %d "
@@ -2475,6 +2478,8 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				lseg, lseg->pls_range.iomode,
 				lseg->pls_range.offset,
 				lseg->pls_range.length);
+			if (test_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags))
+				tmp_list = &lo->plh_return_segs;
 			if (mark_lseg_invalid(lseg, tmp_list))
 				continue;
 			remaining++;
-- 
2.31.1

