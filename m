Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D04EDB06
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiCaOCk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCaOCk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 10:02:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056D1706C
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 07:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 604BEB81FB8
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 14:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEE3C34110;
        Thu, 31 Mar 2022 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648735250;
        bh=XNbcq8qP3AaGocr3u2a6rJ1M5USL02vQjB/QqftKCyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVumlVUYHaBWGgPF4VjF5THpGWGzfvVt40VgY9KsIRKEH3PVXtBbbZuRRXz/pHCGF
         fdDMni1rGncGyazmSHWsOaEekmRyojW6eRMVZ0F5RJeYPivZ2PoiSSw9obSL2IIITW
         WtU/xQVF17l6uqhcwauaTaxk/v1Md0XsNNUNOr03dRnb+sWq2+gy827PaHxSIakoOU
         UB5WnNFMdI3t7cZcRs33vjHGW/r8SzASGS2Ac2g5FGcIF8pRCab+vw+11yf+P3SHSZ
         j+NYjaDKDpjrmBSgAdmuIxeKYdPDP338djXgEzjrjbxRGnipUO34cXzSfrrIoT0IXL
         P+mDixKuV2s0w==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: Clean up nfsd_file_put()
Date:   Thu, 31 Mar 2022 09:54:02 -0400
Message-Id: <20220331135402.7187-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331135402.7187-1-trondmy@kernel.org>
References: <20220331135402.7187-1-trondmy@kernel.org>
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

Make it a little less racy, by removing the refcount_read() test. Then
remove the redundant 'is_hashed' variable.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9578a6317709..46714a71ec87 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -301,21 +301,14 @@ nfsd_file_put_noref(struct nfsd_file *nf)
 void
 nfsd_file_put(struct nfsd_file *nf)
 {
-	bool is_hashed;
-
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	if (refcount_read(&nf->nf_ref) > 2 || !nf->nf_file) {
-		nfsd_file_put_noref(nf);
-		return;
-	}
-
-	is_hashed = test_bit(NFSD_FILE_HASHED, &nf->nf_flags) != 0;
-	if (!is_hashed) {
+	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0) {
 		nfsd_file_flush(nf);
 		nfsd_file_put_noref(nf);
 	} else {
 		nfsd_file_put_noref(nf);
-		nfsd_file_schedule_laundrette();
+		if (nf->nf_file)
+			nfsd_file_schedule_laundrette();
 	}
 	if (atomic_long_read(&nfsd_filecache_count) >= NFSD_FILE_LRU_LIMIT)
 		nfsd_file_gc();
-- 
2.35.1

