Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6645791BB8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjIDQlg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbjIDQlf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 12:41:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77961199
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 09:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 975ADCE0F1B
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 16:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA29C433C7;
        Mon,  4 Sep 2023 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693845688;
        bh=QZCys/k5881DjhsCryhQ5OsonD3f5ANoezrWRzQyySA=;
        h=From:To:Cc:Subject:Date:From;
        b=KsulwJfw1fmnGB81U5dkcZqDDEqBLvSqPnvq59SxngxN4pW8fjzoSqIHrH+/MuzxH
         PXtDijI8vgXfZ1rdaBK+9GdbbOVlHi/ZJ/09yLVMZkMyDPQa7z+uRC7DdnwNKn6sMy
         KqbQyHTZHNQ63BGKdv5KldNEagqa9bNqAmcdWg5/RaS3UAVGb8xCXBYLfYa1ER3NFr
         G2UdLF480AHjYXSOnWv7GIuirzocP2La80bevW6Db6m+58Br300n8M94fcIGRRAxm8
         s+BD1Nf7CkyXtQ6hwL4Vtxi1gPwoEIzwLALnHc64Vd+2JYrKY0LxkivJxX/EwWlFNN
         FzBhbwXqrm0GA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/5] Fix O_DIRECT writeback error paths
Date:   Mon,  4 Sep 2023 12:34:36 -0400
Message-ID: <20230904163441.11950-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In recent tests of the O_DIRECT code, a number of bugs were discovered
in the error codepaths, some of which were shown to result in data
corruption. The tests involved using pNFS flexfiles with 3-way
mirroring, and then shutting down one of the data servers. When the data
was later re-read from the server, it was shown to not match the
original data.

---
v1 - NFS: Fix error handling for O_DIRECT write scheduling
v2 - Fixes for incorrect commit info
     Fixes for O_DIRECT accounting
     O_DIRECT locking issues
     Fix write scheduling issues

Trond Myklebust (5):
  NFS: Fix error handling for O_DIRECT write scheduling
  NFS: Fix O_DIRECT locking issues
  NFS: More O_DIRECT accounting fixes for error paths
  NFS: Use the correct commit info in nfs_join_page_group()
  NFS: More fixes for nfs_direct_write_reschedule_io()

 fs/nfs/direct.c          | 134 +++++++++++++++++++++++++++------------
 fs/nfs/write.c           |  23 +++----
 include/linux/nfs_page.h |   4 +-
 3 files changed, 108 insertions(+), 53 deletions(-)

-- 
2.41.0

