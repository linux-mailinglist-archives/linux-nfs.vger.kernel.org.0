Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6614362040
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhDPMvt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 08:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235074AbhDPMvr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 16 Apr 2021 08:51:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B569A6103D
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618577483;
        bh=ijex2z8/kODg4PSt5ZQiK6w+Q97FqhwamqOjaJNPeos=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Si1goF+nSejSEsGwNCnea8g5ezJnN3j9epLbHKpv+gxaDpxv63k2B0HXsyuDXkJAF
         2xwlSnWI0NBsEtjGARrvqukw21rW0P/UPq+toKayI++Z2hOYy/TFvABmDmSXPlTob8
         VZyjcIht1slna51uKOabCMdE0cBEHXIpdx131w/DsUWzjb65gjO9VWM8R0pa8PjHDy
         sNI/v3KZWSQ8BPMJmoy5Kr+f3+atES6crEbDMmZ0S7Fb8QFhSlQQdLwnQU3qsRpxGg
         uLGgHeHhpTwPAgPPb8xdifx1/6+5+7CxE2aurC3Pum15ELEhwGN4o7FVCZ/663/sLd
         no4QU1YSwYaLg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Don't discard pNFS layout segments that are marked for return
Date:   Fri, 16 Apr 2021 08:51:20 -0400
Message-Id: <20210416125121.5753-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416125121.5753-1-trondmy@kernel.org>
References: <20210416125121.5753-1-trondmy@kernel.org>
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
2.30.2

