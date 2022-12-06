Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E74644C83
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 20:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLFT2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 14:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLFT2t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 14:28:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687BA646B
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 11:28:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22A27B81B24
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 19:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A4C433C1
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670354925;
        bh=fVu/ZQtH0hQ6qoLunUy3rBerStkOWAho1XrEXugcHKs=;
        h=From:To:Subject:Date:From;
        b=KiO4l4JoffRCbI4grh7AVDO8C3Syx5NouEWI8ibq1cxYA1qro4RPFxAEPqyAfshc5
         fCJbJOLQIhNZ+B9lmANgL39ld8Wgl9c2dYgIotiO1WpaDwodPfLhI/3ODzvgF3+KGH
         lI/nHQ5oHgaX35omFIjYgnyzg2d2KkJgnnmf56IKTrGY6uhIrGrHXb0H4fYSnXsVAR
         3luf5MNh9iKzQq1C1l/F/K2YrpWoj3NySCcTupYaZTL4TrG1qYas+9d5GLOkxUiG4g
         vl38UvxI6fepzynnGTpOkgbWKCfL9mnzhOilToUZ2QS6ykTP0GUi1cbYPEDR16+nO7
         7+/NDHvbZvg+w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS4.x/pnfs: Fix up logging of layout stateids
Date:   Tue,  6 Dec 2022 14:22:10 -0500
Message-Id: <20221206192210.438502-1-trondmy@kernel.org>
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

If the layout is invalid, then just log a '0' value.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 2cff5901c689..e3fbdc8a98eb 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1815,7 +1815,7 @@ TRACE_EVENT(pnfs_update_layout,
 			__entry->count = count;
 			__entry->iomode = iomode;
 			__entry->reason = reason;
-			if (lo != NULL) {
+			if (lo != NULL && pnfs_layout_is_valid(lo)) {
 				__entry->layoutstateid_seq =
 				be32_to_cpu(lo->plh_stateid.seqid);
 				__entry->layoutstateid_hash =
@@ -1869,7 +1869,7 @@ DECLARE_EVENT_CLASS(pnfs_layout_event,
 			__entry->pos = pos;
 			__entry->count = count;
 			__entry->iomode = iomode;
-			if (lo != NULL) {
+			if (lo != NULL && pnfs_layout_is_valid(lo)) {
 				__entry->layoutstateid_seq =
 				be32_to_cpu(lo->plh_stateid.seqid);
 				__entry->layoutstateid_hash =
-- 
2.38.1

