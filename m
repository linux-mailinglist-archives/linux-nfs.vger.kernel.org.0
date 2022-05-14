Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36F55271BA
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiENOOc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiENOOY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5581581B
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D444F60EDA
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E4C34116;
        Sat, 14 May 2022 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652537663;
        bh=ReQRCdjwjHc9eKaBs4b8uOavUQqFl0e0QuDHT3nVK7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6dR8RDjhjBlhWXwjzqwPA4oQ5w6jH+lDorphTejbriPYKlJCn1JPqK+yBbhK8TI1
         MZk08MV3v6RklYN0Yu0f5VAbZKptwYtkKJMIUrQsnRYt5VjhRmcGZIOP+jIpLH7mwE
         zFF9x/aGD73yoglVsi3vlnQ3EEibsJafOBLW0csMfm2ai5uLMpvkCm4ERl9ytWAOhv
         DC4Nbo3vi41PoJy2w02ElYs1rezjby0rsrHIV6k36vJHrK9ghtsrRXPPxzCVKFIukl
         bu2qXebqXQVQ5am26SdLv6j/zmoEYpB/8ruYMony1oc1a7wmFhB+5hhHC0AZeEeiQ3
         0oFe3o+FnNFSw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] pNFS/files: Fall back to I/O through the MDS on non-fatal layout errors
Date:   Sat, 14 May 2022 10:08:13 -0400
Message-Id: <20220514140814.3655-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514140814.3655-3-trondmy@kernel.org>
References: <20220514140814.3655-1-trondmy@kernel.org>
 <20220514140814.3655-2-trondmy@kernel.org>
 <20220514140814.3655-3-trondmy@kernel.org>
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

Only report the error when the server is returning a fatal error, such
as ESTALE, EIO, etc...

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/filelayout/filelayout.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 76deddab0a8f..2b2661582bbe 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -839,7 +839,12 @@ fl_pnfs_update_layout(struct inode *ino,
 
 	lseg = pnfs_update_layout(ino, ctx, pos, count, iomode, strict_iomode,
 				  gfp_flags);
-	if (IS_ERR_OR_NULL(lseg))
+	if (IS_ERR(lseg)) {
+		/* Fall back to MDS on recoverable errors */
+		if (!nfs_error_is_fatal_on_server(PTR_ERR(lseg)))
+			lseg = NULL;
+		goto out;
+	} else if (!lseg)
 		goto out;
 
 	lo = NFS_I(ino)->layout;
-- 
2.36.1

