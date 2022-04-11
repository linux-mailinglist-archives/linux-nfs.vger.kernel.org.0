Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBD4FC6DE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiDKVmx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 17:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiDKVmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 17:42:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E36633A39
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 14:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 262A6B818C8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 21:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CA2C385A3;
        Mon, 11 Apr 2022 21:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649713234;
        bh=XDyu0lsurJEAhJLJoQZYLGFV2g+T+Pe+yv9mizVz8CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXdS9NohGJiEVNlCCjWhfekeVVcq0mBvbFhHMzV7tStyMCBxKwmHvU0bRraY6kIYE
         +1NnSdWi7sAJA2rD+5PNzxHA942z6aEJcmIl8FjfrHCeL1YflGi4GHCU8AOCAGu8j6
         OVhJRtwMv695F9CyPLduWkEjNmX20Bycw2aLR+a4NakeSCWWl0R/J7US+ALUQTXixa
         OK3ZobBB9HyuDV0hiCk6WvHRNrj4LXamDdIXkZCSlAGOX6jed3/YqHtGnsyCiFcJxN
         KApxG4hsSI7cke3DqfeFrXykx8VXenoK+DzBjC1qZUPmPDxdpuDbQ1FHEJgCf/dFWy
         MZ3Jn3u06vMrg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH v2 1/5] NFS: Do not report EINTR/ERESTARTSYS as mapping errors
Date:   Mon, 11 Apr 2022 17:33:42 -0400
Message-Id: <20220411213346.762302-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411213346.762302-1-trondmy@kernel.org>
References: <20220411213346.762302-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the attempt to flush data was interrupted due to a local signal, then
just requeue the writes back for I/O.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with generic one")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index e864ac836237..9d3ac6edc901 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1436,7 +1436,7 @@ static void nfs_async_write_error(struct list_head *head, int error)
 	while (!list_empty(head)) {
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
-		if (nfs_error_is_fatal(error))
+		if (nfs_error_is_fatal_on_server(error))
 			nfs_write_error(req, error);
 		else
 			nfs_redirty_request(req);
-- 
2.35.1

