Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249B267D2EF
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jan 2023 18:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjAZRVW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Jan 2023 12:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAZRVV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Jan 2023 12:21:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856E1BCF
        for <linux-nfs@vger.kernel.org>; Thu, 26 Jan 2023 09:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A036DB81E71
        for <linux-nfs@vger.kernel.org>; Thu, 26 Jan 2023 17:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC425C433D2;
        Thu, 26 Jan 2023 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674753678;
        bh=lPfAA2NdMEznM5xLOA3+i9j/eVcMjvKNTLEm89N6yLo=;
        h=From:To:Cc:Subject:Date:From;
        b=LF1cgS09u/YRCUZRV2IWsPbV0YaiQem1AabEIPIjdY8l0e4tj2v8cx4h2gIZS7qid
         KaaghQ1SI7jomYVtbV2AB3K3xL1fY+RUkSPQEOgYlk6RA1zpudNZptskkjBz+iBxlO
         sioxz39hJZYTmZwb/A6y1xckKWyT+FePgx7+62+HXV+TBsWYBOR2rx/9ac4bSGmd/n
         10ei1aoBufOyoNLLWqnr+eUdQl14Vn0eMYrSZjrr0vUVRK9MBSdNV7KttvAdm+Xhyv
         dDAazLZDddx2RVUzABBXoK0YYBgluHtwE2jppeHhNOtLwIPeCPe4PyHiczerl5OePi
         pCSj87TZ/Uvug==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: update comment over __nfsd_file_cache_purge
Date:   Thu, 26 Jan 2023 12:21:16 -0500
Message-Id: <20230126172116.198443-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 348ef543c4dc..e232937fea8e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -808,7 +808,8 @@ nfsd_file_cache_init(void)
  * @net: net-namespace to shut down the cache (may be NULL)
  *
  * Walk the nfsd_file cache and close out any that match @net. If @net is NULL,
- * then close out everything. Called when an nfsd instance is being shut down.
+ * then close out everything. Called when an nfsd instance is being shut down,
+ * and when the exports table is flushed.
  */
 static void
 __nfsd_file_cache_purge(struct net *net)
-- 
2.39.1

