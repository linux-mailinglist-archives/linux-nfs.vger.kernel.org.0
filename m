Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E695393A7
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbiEaPKI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345532AbiEaPJ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 11:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D2554AB
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 08:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78C9C61343
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 15:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A916C3411D;
        Tue, 31 May 2022 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009794;
        bh=yNj3gF7w+ZKyC/Pz+w9B/AXPCpMkYgDqA82GDwC/lco=;
        h=From:To:Cc:Subject:Date:From;
        b=K6+z/kugyWttGMx7yyESU4TyUiFTqMUa8TO6uUcU8rkTwPeV5ry4tV8SgZZacIFUX
         +ZnBzfbMvoHPqqokZOz/Q/z0ZC9L3tghefcBRYjI0Jnj1VqfsTuMcFUZgwbH0z7kLB
         2gCHdifuMxlUL/oquBN/UD/odqyE+RcnzyoFg7Jh2bYYlvjp34zG7EompaIgMx9GlQ
         wh6qDlP02+Ns1oNQEsnuJe1pNDobwx89xxTon7vfvcmyjh5jc2IaduFDpp+V9Y5A39
         flL+FoZaDr4Cmm7C+7X1WyS84gwE1xXDQgGa8+WXTtJBN0QbbbAHcRK4kxZcUINZOj
         mVCWNQ35Zr6kw==
From:   trondmy@kernel.org
To:     Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNAVAILABLE
Date:   Tue, 31 May 2022 11:03:06 -0400
Message-Id: <20220531150307.6170-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
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

If the server tells us that a pNFS layout is not available for a
specific file, then we should not keep pounding it with further
layoutget requests.

Fixes: 183d9e7b112a ("pnfs: rework LAYOUTGET retry handling")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 68a87be3e6f9..4609e641710e 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2152,6 +2152,12 @@ pnfs_update_layout(struct inode *ino,
 		case -ERECALLCONFLICT:
 		case -EAGAIN:
 			break;
+		case -ENODATA:
+			/* The server returned NFS4ERR_LAYOUTUNAVAILABLE */
+			pnfs_layout_set_fail_bit(
+				lo, pnfs_iomode_to_fail_bit(iomode));
+			lseg = NULL;
+			goto out_put_layout_hdr;
 		default:
 			if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
 				pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
-- 
2.36.1

