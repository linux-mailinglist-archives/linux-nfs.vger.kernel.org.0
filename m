Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23363E20E
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Nov 2022 21:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiK3UbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Nov 2022 15:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiK3Uav (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Nov 2022 15:30:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646BD8E58F
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 12:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA2B61DD5
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 20:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85860C433D7;
        Wed, 30 Nov 2022 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669840249;
        bh=CzpG5MMoQs+TpFz0RYN7IHzmm7qoWtJIXlHgTj++1aE=;
        h=From:To:Cc:Subject:Date:From;
        b=G+eQ/zZv6nZfAn8QYhuaV/d+FMjmt/cFlSHScB1FDRaX/aTZ7+65Z0eiK73PY/uk3
         i1kfDYcv8FP0qn6uxnuG3I489/7NgdgMSpgjP6nbThK+e1TK/W5v9PgvW2myhqkkCw
         LHpvAVJ7ZhC2K0uTEQkQU/pskTpQnEdlrje0oYNTu9fdon1Sg4ZsjfMs+682dtus9u
         Se6LQ3LJ93G/T6v+IF3GxmHAQdlAkAt/TpQJSYkIrmike4gaPJ1W+/0SK0bukyv3Gz
         5RJymKyu8o6qWhYuYocY8MgN8isLuRGBYchcv9tySJ8LLZhHPd9Fmcs1xkvvBBGWLI
         8XuZ5ef4LlXQA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, jlayton@kernel.org, tom@talpey.com
Subject: [PATCH] NFS: Allow very small rsize & wsize again
Date:   Wed, 30 Nov 2022 15:30:47 -0500
Message-Id: <20221130203047.1303804-1-anna@kernel.org>
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

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

940261a19508 introduced nfs_io_size() to clamp the iosize to a multiple
of PAGE_SIZE. This had the unintended side effect of no longer allowing
iosizes less than a page, which could be useful in some situations.

UDP already has an exception that causes it to fall back on the
power-of-two style sizes instead. This patch adds an additional
exception for very small iosizes.

Reported-by: Jeff Layton <jlayton@kernel.org>
Fixes: 940261a19508 ("NFS: Allow setting rsize / wsize to a multiple of PAGE_SIZE")
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/internal.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 647fc3f547cb..ae7d4a8c728c 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -739,12 +739,10 @@ unsigned long nfs_io_size(unsigned long iosize, enum xprt_transports proto)
 		iosize = NFS_DEF_FILE_IO_SIZE;
 	else if (iosize >= NFS_MAX_FILE_IO_SIZE)
 		iosize = NFS_MAX_FILE_IO_SIZE;
-	else
-		iosize = iosize & PAGE_MASK;
 
-	if (proto == XPRT_TRANSPORT_UDP)
+	if (proto == XPRT_TRANSPORT_UDP || iosize < PAGE_SIZE)
 		return nfs_block_bits(iosize, NULL);
-	return iosize;
+	return iosize & PAGE_MASK;
 }
 
 /*
-- 
2.38.1

