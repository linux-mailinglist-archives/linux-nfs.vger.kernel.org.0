Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA1613AAC
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 16:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiJaPt2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJaPt1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 11:49:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7311A37
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 08:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 641F4B818D8
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 15:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22FEC433D6;
        Mon, 31 Oct 2022 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667231363;
        bh=mQzenvQnaXYTbA27BA5f4F6/RIkPIoxFeU8rI3BICpM=;
        h=From:To:Cc:Subject:Date:From;
        b=dyszzq02GS8yvPxnwT7xn3MDK++MBGJBHvNTGByGPlJ0NhblA0XiHmGiPpkO9f9ta
         BAb98DkZ6z1JsbRmYTyVhZzrcIvRtBNXDEgyCinRHDLyFouQONf+/ZGC4Ou7YrQnvH
         yO8SdRjs765uTfi+Td5LuKsCjJ6B7v3L5zUVM9yulwItSK5E05HIrDjJCFxYxnqwk0
         UUnV+rKkrDUW6IBuEEQ/7Nwf3RJwbIU99b6PpHPXcYLYOdtlyRC7G59EhQLto/G5Cs
         pne7W6nMEqzGPn+8SDUcXP9i/YyOpCCYdKc7yQNEqsaTsRfClt6J9LTI60o9Y0V37l
         Iuf4Og51IpFPA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2] nfsd: fix net-namespace logic in __nfsd_file_cache_purge
Date:   Mon, 31 Oct 2022 11:49:21 -0400
Message-Id: <20221031154921.500620-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the namespace doesn't match the one in "net", then we'll continue,
but that doesn't cause another rhashtable_walk_next call, so it will
loop infinitely.

Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

The v1 patch applies cleanly to v6.0, but not to Chuck's for-next
branch. This one should be suitable there.
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 98c6b5f51bc8..4a8aa7cd8354 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -890,9 +890,8 @@ __nfsd_file_cache_purge(struct net *net)
 
 		nf = rhashtable_walk_next(&iter);
 		while (!IS_ERR_OR_NULL(nf)) {
-			if (net && nf->nf_net != net)
-				continue;
-			nfsd_file_unhash_and_dispose(nf, &dispose);
+			if (!net || nf->nf_net == net)
+				nfsd_file_unhash_and_dispose(nf, &dispose);
 			nf = rhashtable_walk_next(&iter);
 		}
 
-- 
2.38.1

