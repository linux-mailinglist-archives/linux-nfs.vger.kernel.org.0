Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383B362DD4C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbiKQNxi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 08:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiKQNxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 08:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4251C39
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 05:53:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F694B81FB8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 13:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA7C433C1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668693199;
        bh=nskT2tP8NUFzeSciyMIfLU61mc2ruDj9SW1lHSw0PX0=;
        h=From:To:Subject:Date:From;
        b=OEwcX+iWutBdruhAFz20ysu22f5DK2j8ReNaoStT4bgqi46jFPD9+LiT+nPtbPhW/
         gNe1KzSEC+DgDOrOF+UWO0DALA/tecVvdil5w9B6gQILhxO4UdcsDMUiiGMIN2N8JA
         UN2ABWJTkKFDpaYOHMAXJ5YOYfQQ7WixfE0EDwKg5nuOx69hKFOol8TLZhd7JQoe1D
         /OW5SJWXdJrvNAwHP9lVnF6kmJMT2tzrg0Xs6PGjAXwC6jqUrCYinyKyiHw6KmO3yh
         4snmE0FAuS+wFNjEesv3wRujABDTmLVEI/M6Yf+wS5Y1GM8ppsuL+9iNqoqeVVFL/9
         h+dPbV6f5wvnQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix a race in nfs_call_unlink()
Date:   Thu, 17 Nov 2022 08:47:13 -0500
Message-Id: <20221117134713.9069-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We should check that the filehandles match before transferring the
sillyrename data to the newly looked-up dentry in case the name was
reused on the server.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/unlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 9697cd5d2561..150a953a8be9 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -139,6 +139,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 		 */
 		spin_lock(&alias->d_lock);
 		if (d_really_is_positive(alias) &&
+		    !nfs_compare_fh(NFS_FH(inode), NFS_FH(d_inode(alias))) &&
 		    !(alias->d_flags & DCACHE_NFSFS_RENAMED)) {
 			devname_garbage = alias->d_fsdata;
 			alias->d_fsdata = data;
-- 
2.38.1

