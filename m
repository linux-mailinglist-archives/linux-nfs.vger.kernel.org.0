Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB84BE303
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379988AbiBUQPb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:15:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379990AbiBUQP1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:15:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8623BD4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A796E612A3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6458C340E9
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645460103;
        bh=vC/5XnPpuZR+wTny1xLMXmoRogl78BVquOfa+kkJP70=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ieZBO5U6D2Hb7vVFivkYeoBpHc2FzNTRmAAABGV1Ku+FKHcYamQk0R+JO1NKvA/Ew
         VuD5ncco6Wz9Vr4RtV5XwgzStvrLn1LxClVnR6118BsWN9h0FNf+X9D6ttDvR/NI11
         U0ARwqgPAzazovLs7+9ehPRr75dsw7N+6S9jcsyefqkNG9sAjLzeU3Tw37tTDNZvKs
         FV+eK9gnKlCavWD1ZzDICUCbkLtvEqD7KADb5yeT2yhKyNFMZmjM9vO6+1uNo5uEYl
         6/hTFfsUa1/KPt+qySPT1aN4idai5YFrQRT8gH0fBj1BM7MaKVr4jjf0F9IogZ6ef+
         7RSRxNQAyJ43g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 09/13] NFS: Readdirplus can't help lookup for case insensitive filesystems
Date:   Mon, 21 Feb 2022 11:08:47 -0500
Message-Id: <20220221160851.15508-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221160851.15508-9-trondmy@kernel.org>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
 <20220221160851.15508-7-trondmy@kernel.org>
 <20220221160851.15508-8-trondmy@kernel.org>
 <20220221160851.15508-9-trondmy@kernel.org>
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

If the filesystem is case insensitive, then readdirplus can't help with
cache misses, since it won't return case folded variants of the filename.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c4d962bca9ef..b1e6c56d7e1a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -667,6 +667,8 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
 
 static void nfs_lookup_advise_force_readdirplus(struct inode *dir)
 {
+	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+		return;
 	nfs_readdir_record_entry_cache_miss(dir);
 }
 
-- 
2.35.1

