Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F532ECA2F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 06:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbhAGFcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 00:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbhAGFcx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Jan 2021 00:32:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B022230FC
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 05:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609997494;
        bh=eCL/i9RusvUBL91JCyUUKmdSuOAuUCTyvSokp8dmNvA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DGlAAKWhKCt0Y3c+dtktNyw4P7SVGuDY2W2M2vTbxN9S7c1zqTQvr7CDuXDd39qps
         x9/l/diW8dnQoojK1BXETOe5S0LBiFlFQcQdSQFqE/nr1FUth/I6THdZXL6w5JEzyt
         b1b1WmWw36mdlVOj1b371NU7cKx3YwG6i8xm1uzAQOHr8m5H4s0Ud1B/iXWj5kYQao
         I+Ayi3h2EzEGc0ekM1x/8eBNpFKG7me7xSaNjqoX7SQ7l4edYi3r7p8MaoA6A9EHvz
         Jl9KyrsZdX5cemoE/R952EnJq3mCuB1T62v53DvZSxOnsd0lgN4+AC5uWiAzSNHWGD
         mQbe5nVp2lwkw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/7] NFS/pNFS: Fix a leak of the layout 'plh_outstanding' counter
Date:   Thu,  7 Jan 2021 00:31:30 -0500
Message-Id: <20210107053130.20341-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107053130.20341-6-trondmy@kernel.org>
References: <20210107053130.20341-1-trondmy@kernel.org>
 <20210107053130.20341-2-trondmy@kernel.org>
 <20210107053130.20341-3-trondmy@kernel.org>
 <20210107053130.20341-4-trondmy@kernel.org>
 <20210107053130.20341-5-trondmy@kernel.org>
 <20210107053130.20341-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we exit _lgopen_prepare_attached() without setting a layout, we will
currently leak the plh_outstanding counter.

Fixes: 411ae722d10a ("pNFS: Wait for stale layoutget calls to complete in pnfs_update_layout()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index fc13a3c8bc48..4f274f21c4ab 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2244,6 +2244,7 @@ static void _lgopen_prepare_attached(struct nfs4_opendata *data,
 					     &rng, GFP_KERNEL);
 	if (!lgp) {
 		pnfs_clear_first_layoutget(lo);
+		nfs_layoutget_end(lo);
 		pnfs_put_layout_hdr(lo);
 		return;
 	}
-- 
2.29.2

