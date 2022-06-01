Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5C53AA7E
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbiFAPw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 11:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353707AbiFAPwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 11:52:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF83377DD
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 08:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F1C761500
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 15:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7CEC3411A
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 15:52:23 +0000 (UTC)
Subject: [PATCH] NFSD: Fix potential use-after-free in nfsd_file_put()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 01 Jun 2022 11:52:22 -0400
Message-ID: <165409874221.2508.12828917768712364345.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_file_put_noref() can free @nf, so don't dereference @nf
immediately upon return from nfsd_file_put_noref().

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Fixes: 999397926ab3 ("nfsd: Clean up nfsd_file_put()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d32fcd8ad457..148b25a43caf 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -308,11 +308,12 @@ nfsd_file_put(struct nfsd_file *nf)
 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0) {
 		nfsd_file_flush(nf);
 		nfsd_file_put_noref(nf);
-	} else {
+	} else if (nf->nf_file) {
 		nfsd_file_put_noref(nf);
-		if (nf->nf_file)
-			nfsd_file_schedule_laundrette();
-	}
+		nfsd_file_schedule_laundrette();
+	} else
+		nfsd_file_put_noref(nf);
+
 	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
 		nfsd_file_gc();
 }


