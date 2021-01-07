Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BDA2ECA28
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 06:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbhAGFcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 00:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbhAGFcM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Jan 2021 00:32:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 637662158C
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 05:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609997491;
        bh=dR4KKkek4PcK1nALvY8lr+xsqv2YWrCREGjTjjuPBuw=;
        h=From:To:Subject:Date:From;
        b=RH6KSmCXHVw6N0PKaPYg2Lcx+A1mLaHBPTDi4dQE+Qc7LuU+Fp/AS2xzpgBH/CwrL
         BSQj4tqcYBNnIAdYZThPb567QdxS8i7Ff3yqDxgynlTdfFhvSxlCAxiNYwaHBXKgQD
         WqES7rdgqtjXK0IqKSbuaU56hcG8vQXDi1gwBJcksG0UTdJ+KimPUu692ByREj3yGO
         8xzmjw7t9q77/EYlmaMpSM4HsIPyuSKwbY3k5UAVIhIpvCZERn78daBEpmRA51I4V6
         Q/iDp5SLQDHb+z2xjTVV8pVVsfQt/SEN0U+QAJ9lptPk0QLQ5oDnj+rBzNGzDLTJYd
         jOqwK7h/pD9Dw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/7] pNFS: Mark layout for return if return-on-close was not sent
Date:   Thu,  7 Jan 2021 00:31:24 -0500
Message-Id: <20210107053130.20341-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the layout return-on-close failed because the layoutreturn was never
sent, then we should mark the layout for return again.

Fixes: 9c47b18cf722 ("pNFS: Ensure we do clear the return-on-close layout stateid on fatal errors")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 07f59dc8cb2e..e8d08ec6fa86 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1560,12 +1560,19 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 		int ret)
 {
 	struct pnfs_layout_hdr *lo = args->layout;
+	struct inode *inode = args->inode;
 	const nfs4_stateid *arg_stateid = NULL;
 	const nfs4_stateid *res_stateid = NULL;
 	struct nfs4_xdr_opaque_data *ld_private = args->ld_private;
 
 	switch (ret) {
 	case -NFS4ERR_NOMATCHING_LAYOUT:
+		spin_lock(&inode->i_lock);
+		if (pnfs_layout_is_valid(lo) &&
+		    nfs4_stateid_match_other(&args->stateid, &lo->plh_stateid))
+			pnfs_set_plh_return_info(lo, args->range.iomode, 0);
+		pnfs_clear_layoutreturn_waitbit(lo);
+		spin_unlock(&inode->i_lock);
 		break;
 	case 0:
 		if (res->lrs_present)
-- 
2.29.2

