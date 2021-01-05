Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6832EAE35
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAEP1D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbhAEP1C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Jan 2021 10:27:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B4222C7C
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609860382;
        bh=JjIkLP/dA6Ql9bZFl5VTsjrxoq6BxOOb6ehdJqJMy0I=;
        h=From:To:Subject:Date:From;
        b=U+6UZjlVg+brSH/TZmVydz7zjF+5uboz6Kakk+lilanYIJy/F4Ms6J8Kxh+lUgj3j
         T8oedHl6e6HUkcOH8b/0mJuXvkg9EahHxW4Q+jZBjaqtpSPoArniMkQkfzs6akoCT+
         zVsc/PpQrGjlcRmXy/ELQAz1eL3x3oK8Fo4eq45NYGLwgnaMiRENqhvxU01/PUdD63
         sQ3xdQPUXCekesRoCvkktGMqB+xvcFbsiimu723NQWjbgpKUEM1h+B2po7XJSz10gY
         wtca1Y1uwpENJNuOHn2P1vHtwyLz2xiu59zsrfMRKX3rSvXN/yZdMf/VYIc6Ww2lRq
         8pYbf434cphkQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] pNFS: Mark layout for return if return-on-close was not sent
Date:   Tue,  5 Jan 2021 10:26:17 -0500
Message-Id: <20210105152620.754453-1-trondmy@kernel.org>
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
 fs/nfs/pnfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 07f59dc8cb2e..ccc89fab1802 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1560,12 +1560,18 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
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
+		spin_unlock(&inode->i_lock);
 		break;
 	case 0:
 		if (res->lrs_present)
-- 
2.29.2

