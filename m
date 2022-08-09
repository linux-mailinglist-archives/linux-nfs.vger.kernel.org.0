Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D70958DF53
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbiHISpc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbiHISpJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 14:45:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2122ED74
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 11:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49F76B816A0
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 18:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6BBC433D6
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660069163;
        bh=EfK3XxSFM6YeSXs5Xty1hLuzdclnMmgl6As8wX0fACk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NRCkTiERA8lsqP122hdKErGvBqoZN0KfhITvcw6hBG6eydiIlCpHYoON2v6WLuRxC
         dgtk6CPkg72N6NNTVYrED2uOq0TIcoXZvxnZYfcn5FnCrwYCAhPjeB6+UH0bDNjrar
         g9/6GVOhOGxWFck7sIiSMKSszacn7bqYdixH0rgYcEtbohIY0CRqT9UEx6wHy17I6m
         ViPRqH9VwJ1V5cUiNXbUiLdNq8YE8o9ejGsQMVAOsgMvEZ33dEKSEHjAsCLUeT5r98
         8UjAd3T8/U01G0iSjOxRqg+GisBWOfrjmUxgrxbT4iNg6bCdTl0neG9zAYrgqygTrN
         BQh2k1pUNpcLg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Improve O_DIRECT tracing
Date:   Tue,  9 Aug 2022 14:13:16 -0400
Message-Id: <20220809181317.20348-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809181317.20348-1-trondmy@kernel.org>
References: <20220809181317.20348-1-trondmy@kernel.org>
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

Switch the formatting to match the other NFS tracepoints.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 731eecfdf49a..8e87cf8e5e78 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1597,12 +1597,10 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
 		TP_ARGS(dreq),
 
 		TP_STRUCT__entry(
-			__field(const struct nfs_direct_req *, dreq)
 			__field(dev_t, dev)
 			__field(u64, fileid)
 			__field(u32, fhandle)
-			__field(int, ref)
-			__field(loff_t, io_start)
+			__field(loff_t, offset)
 			__field(ssize_t, count)
 			__field(ssize_t, bytes_left)
 			__field(ssize_t, error)
@@ -1614,12 +1612,10 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			const struct nfs_fh *fh = &nfsi->fh;
 
-			__entry->dreq = dreq;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(fh);
-			__entry->ref = kref_read(&dreq->kref);
-			__entry->io_start = dreq->io_start;
+			__entry->offset = dreq->io_start;
 			__entry->count = dreq->count;
 			__entry->bytes_left = dreq->bytes_left;
 			__entry->error = dreq->error;
@@ -1627,13 +1623,14 @@ DECLARE_EVENT_CLASS(nfs_direct_req_class,
 		),
 
 		TP_printk(
-			"dreq=%p fileid=%02x:%02x:%llu fhandle=0x%08x ref=%d "
-			"io_start=%lld count=%zd bytes_left=%zd error=%zd flags=%s",
-			__entry->dreq, MAJOR(__entry->dev), MINOR(__entry->dev),
+			"error=%zd fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%lld count=%zd bytes_left=%zd flags=%s",
+			__entry->error, MAJOR(__entry->dev),
+			MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
-			__entry->fhandle, __entry->ref,
-			__entry->io_start, __entry->count, __entry->bytes_left,
-			__entry->error, nfs_show_direct_req_flags(__entry->flags)
+			__entry->fhandle, __entry->offset,
+			__entry->count, __entry->bytes_left,
+			nfs_show_direct_req_flags(__entry->flags)
 		)
 );
 
-- 
2.37.1

