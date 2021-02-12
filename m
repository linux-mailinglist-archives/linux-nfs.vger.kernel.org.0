Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D262531A716
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLVuh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhBLVuf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 16:50:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F0E764DD7;
        Fri, 12 Feb 2021 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613166594;
        bh=jlY8SvudMMwEdrQoncRRd18y/pZZSxBu4X2ESFMLdKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfFztLL8mwyWmTMpAaDgiRugj21IcB512iKt0w8SryaSyhNlcAUUFvGEzeJsKkzrI
         qlRGJtpxPgIvIweP05IT+Fvzw0ow4dsC7F0YeCnQKYzyE0WoR/nV4u4xJGMc6jBIuv
         zYW1IwLglfLqxI+W1VVFFxLqJIMYKOXEGTI37CqFZd68Zcc6jR8mBCSgHlO02VwJL/
         zfQEjpgeJQzbYmDjX1eHuasGaNuN/o2JUg+Do0Vytx4Um5I5xspt8aKYbEu03NOVXn
         9qGwrpDDYPOsHbh4cVX/tpnvqLkiMmAVFy7pHd3i/eyPMpDf1zGgmrLPFt62vsjVDC
         zxvR7YfsO5CmQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: 'flags' field should be unsigned in struct nfs_server
Date:   Fri, 12 Feb 2021 16:49:47 -0500
Message-Id: <20210212214949.4408-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212214949.4408-1-trondmy@kernel.org>
References: <20210212214949.4408-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The mount flags are all unsigned integers, so we should not be storing
them in a signed field.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/nfs_fs_sb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 38e60ec742df..962e8313f007 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -142,7 +142,7 @@ struct nfs_server {
 	struct nlm_host		*nlm_host;	/* NLM client handle */
 	struct nfs_iostats __percpu *io_stats;	/* I/O statistics */
 	atomic_long_t		writeback;	/* number of writeback pages */
-	int			flags;		/* various flags */
+	unsigned int		flags;		/* various flags */
 
 /* The following are for internal use only. Also see uapi/linux/nfs_mount.h */
 #define NFS_MOUNT_LOOKUP_CACHE_NONEG	0x10000
-- 
2.29.2

