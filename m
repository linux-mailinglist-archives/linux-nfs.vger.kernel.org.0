Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5027F31A703
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBLVmC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLVmC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 16:42:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 274CC64DD5;
        Fri, 12 Feb 2021 21:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613166080;
        bh=lF6P2LGF13VGwr96xp+tqAYISWF1N6loAv6+GCDjd9c=;
        h=From:To:Cc:Subject:Date:From;
        b=YsRbyACKezUXWmZOeH1urdelfqVjw+m3Zvy4GvHl0Cs3ZZOFKmnVcQtJBXbSnJh9q
         yy/dutm7+94UvpcmfZGMAWgHKZdnVrZzkPQ/8kcF0PtVgfYg4HyeCiEw6Mad6oFR52
         Fg15wukluRSCrBZ4v17SVb51AoOvQJCRJZaB0FpJIPH8AcVxnLY/V2B0zeV3gqR9Gm
         RhqrYdWd382LckwEwJDdWC1fiNB1IzCuIQwhVIDNougBfx4qE7mj4Lz4GIghzdkGpH
         9Af2nr9UB5JpVWDbztDoGZKrZbda4NtAbihXPTFILNPOjineU5HcD4UtmG8DDyTMVh
         gsgJQ669v2XEQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Set the stable writes flag when initialising the super block
Date:   Fri, 12 Feb 2021 16:41:19 -0500
Message-Id: <20210212214119.4234-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We need to wait for outstanding writes on the page to complete before we
can update it.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/fs_context.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index b6be02aa79f0..971a9251c1d9 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1512,6 +1512,8 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->selected_flavor	= RPC_AUTH_MAXFLAVOR;
 		ctx->minorversion	= 0;
 		ctx->need_mount		= true;
+
+		fc->s_iflags		|= SB_I_STABLE_WRITES;
 	}
 	fc->fs_private = ctx;
 	fc->ops = &nfs_fs_context_ops;
-- 
2.29.2

