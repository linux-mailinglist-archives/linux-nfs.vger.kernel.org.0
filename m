Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353A63D58FE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhGZLS4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 07:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233821AbhGZLSx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:18:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 865A960F51
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300761;
        bh=qXwd3cJb/5xBDpij3APgwGOM7MrSLSWKzQ6Qk9V6lq0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Whp9kF0vn6f4E8piPy/HDmKSC6CB2ofbr+PnBbsZ5tBbPnzxCqp7ZAruH/LpRnaxx
         lcNxAjGFR7FTOh4ZToCimWQAmGYKOmj4zKfSyEx+LtgCwBcg+/1y45jtOxGrB3/ccI
         ZXnKls7PUDr9A0Wh6jG++qW/kHAMod5SSiVDNr4/TE6GWtxJWoc6IKCKF+7B66iaWL
         8kfXi8j9sEuK9ZvH1DyTw85TJsEvN8B2xOEX3LPBrAWUmw/eGE0tumMjK5R9nEGbR4
         jr4m3d1TFDFX3H8C21snJVLuGv4A79QMJwDaoizjUWL9R2O28VSoexJZbgWxkXdfqt
         rn5pMHQYX5OJg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4/pNFS: Remove dead code
Date:   Mon, 26 Jul 2021 07:59:20 -0400
Message-Id: <20210726115920.8518-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726115920.8518-1-trondmy@kernel.org>
References: <20210726115920.8518-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since commit 2b28a7bee453 ("fs, nfs: convert
pnfs_layout_hdr.plh_refcount from atomic_t to refcount_t") it has not
been legal to bump a zero refcount, so the code that tries to allow it
if the NFS_LSEG_VALID flag is still set would cause trouble. Luckily,
NFS_LSEG_VALID has its own refcount so we can never hit this bad code
snippet in practice. Remove it to avoid confusion.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 51049499e98f..7c9090a28e5c 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -596,10 +596,6 @@ pnfs_put_lseg(struct pnfs_layout_segment *lseg)
 	inode = lo->plh_inode;
 
 	if (refcount_dec_and_lock(&lseg->pls_refcount, &inode->i_lock)) {
-		if (test_bit(NFS_LSEG_VALID, &lseg->pls_flags)) {
-			spin_unlock(&inode->i_lock);
-			return;
-		}
 		pnfs_get_layout_hdr(lo);
 		pnfs_layout_remove_lseg(lo, lseg);
 		if (pnfs_cache_lseg_for_layoutreturn(lo, lseg))
-- 
2.31.1

