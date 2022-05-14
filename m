Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AEF5271B9
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiENOOa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiENOOY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D34140F3
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B16EA60F1F
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8439C34116;
        Sat, 14 May 2022 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652537662;
        bh=tD+jDDrzYnCZPzZUM9pTL5opqF2e8+LvWnkSz93e9k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0Hq0m40RmBiRIdEN/TqKOZBxXOre5DsiqrKRwrj0iUJDnqFZHktvFqGszp/DF78e
         pkEG+f3ZSk3Qjn3hXCyXp58HxcsaWLU8qa/nKytvAYxIp7XHkS78xlkXbGdWxdDD3L
         XS6kkwZvOqNyenRSKfGtRcE0mjsJIUe63LFaLV/xjnQDSp6bUlw8XtCER/iyJ5laA4
         +1elGfy4MM/vrPpOpqc2QBLkso9QfFe2tKyN9tiN6bEymBIz2eEI492T+jE+7+zUdZ
         dHcgEQLtu8HvtGM3xyxup0Fl/gq4IzTjP7Oh5uWmKyLLzie5X4MoU53F0bHliuEN55
         rUYt/XuXS6YWw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFSv4/pNFS: Do not fail I/O when we fail to allocate the pNFS layout
Date:   Sat, 14 May 2022 10:08:11 -0400
Message-Id: <20220514140814.3655-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514140814.3655-1-trondmy@kernel.org>
References: <20220514140814.3655-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Commit 587f03deb69b caused pnfs_update_layout() to stop returning ENOMEM
when the memory allocation fails, and hence causes it to fall back to
trying to do I/O through the MDS. There is no guarantee that this will
fare any better. If we're failing the pNFS layout allocation, then we
should just redirty the page and retry later.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Fixes: 587f03deb69b ("pnfs: refactor send_layoutget")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 856c962273c7..68a87be3e6f9 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2000,6 +2000,7 @@ pnfs_update_layout(struct inode *ino,
 	lo = pnfs_find_alloc_layout(ino, ctx, gfp_flags);
 	if (lo == NULL) {
 		spin_unlock(&ino->i_lock);
+		lseg = ERR_PTR(-ENOMEM);
 		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
 				 PNFS_UPDATE_LAYOUT_NOMEM);
 		goto out;
@@ -2128,6 +2129,7 @@ pnfs_update_layout(struct inode *ino,
 
 	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &stateid, &arg, gfp_flags);
 	if (!lgp) {
+		lseg = ERR_PTR(-ENOMEM);
 		trace_pnfs_update_layout(ino, pos, count, iomode, lo, NULL,
 					 PNFS_UPDATE_LAYOUT_NOMEM);
 		nfs_layoutget_end(lo);
-- 
2.36.1

