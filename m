Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C63D3D3AC0
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jul 2021 14:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhGWMQu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jul 2021 08:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235069AbhGWMQu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Jul 2021 08:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E2C560E95
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jul 2021 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627045043;
        bh=9N/BFS30f114Sn58bWSFCNACs0WaD5wNp2ROp9jxiwk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rekaEFMvi9KKbc+Kc93w/RlgUlQ57muaLZ1j9UWceuN2GVgMKmKzqFsp0UnCG6zil
         Xxs1cI6xpuA2BDKmbWIniH+SIpxBKSQE2DQb4t0aqHdhOmB67u52Ra6eJeLXvtkrFC
         xdkR2cGd2eLavNhc39A7M82V0KOnS2rkl3GQgfSEvyUHa9whVeJ3ZAYB00FAC4iPfs
         Esdwhlse8MRaJoVEEczx4Y5SQAcphoqjde2K3AXuFcaUZZGNbNtQBXWQpXyq0pAG/Z
         UvhDaWDwOX11am6h/PGDuXatE/RfrOt7pSsmPF2HIYmY9dDE5yxOPoxgOvr+sjh9EP
         Wul7fTvYdnjmw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4/pnfs: The layout barrier indicate a minimal value for the seqid
Date:   Fri, 23 Jul 2021 08:57:21 -0400
Message-Id: <20210723125721.22572-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723125721.22572-1-trondmy@kernel.org>
References: <20210723125721.22572-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The intention of the layout barrier is to ensure that we do not update
the layout to match an older value than the current expectation. Fix the
test in pnfs_layout_stateid_blocked() to reflect that it is legal for
the seqid of the stateid to match that of the barrier.

Fixes: aa95edf309ef ("NFSv4/pnfs: Fix the layout barrier update")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4e69e4e6c416..4ed4586bc1a2 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1000,7 +1000,7 @@ pnfs_layout_stateid_blocked(const struct pnfs_layout_hdr *lo,
 {
 	u32 seqid = be32_to_cpu(stateid->seqid);
 
-	return !pnfs_seqid_is_newer(seqid, lo->plh_barrier) && lo->plh_barrier;
+	return lo->plh_barrier && pnfs_seqid_is_newer(lo->plh_barrier, seqid);
 }
 
 /* lget is set to 1 if called from inside send_layoutget call chain */
-- 
2.31.1

