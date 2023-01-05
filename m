Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67165EA80
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 13:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjAEMPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 07:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjAEMPU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 07:15:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1444C7B
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 04:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50868B81AC6
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 12:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE222C433EF;
        Thu,  5 Jan 2023 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672920917;
        bh=64ox1Dctbnqwo17SUA9JBVAOHUOogbmQ/K52bJnkFSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peUE5QdY+WenaSEZTbR0mpAQHgjmtEWxkp2O3V9blJAc8ROYvbDCpgWp5RlxZY6tF
         RXI5JLRWfm9wTACgAw69rF7Q69ZDadWQ/PnzDEVUXCJ+bxy8iuELEqMCF+J+FbjZCK
         36NOURRIxG9dfnEwp5TGtDYzxF425GYKHzmRHctewBQDvqaoS0wIV4CGieuEkqY2ui
         G85hr9q2OPgQsBEpbYSX9s3t8ai+RFBNxP+nM8tS66vNIcgmLrRb9TbkxzEenYf2HB
         SskWAwMSrPcHOF7UW6GEbF8Q6VAjwwkjs/cvRxo2uUrMz5mS1QRZRKcHRGQM/6OrRw
         ER8k7aFS6gZNg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4/4] nfsd: add some comments to nfsd_file_do_acquire
Date:   Thu,  5 Jan 2023 07:15:12 -0500
Message-Id: <20230105121512.21484-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105121512.21484-1-jlayton@kernel.org>
References: <20230105121512.21484-1-jlayton@kernel.org>
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

David Howells mentioned that he found this bit of code confusing, so
sprinkle in some comments to clarify.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f0ca9501edb2..5724baad09ec 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1105,6 +1105,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	rcu_read_unlock();
 
 	if (nf) {
+		/*
+		 * If the nf is on the LRU then it holds an extra reference
+		 * that must be put if it's removed. It had better not be
+		 * the last one however, since we should hold another.
+		 */
 		if (nfsd_file_lru_remove(nf))
 			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
 		goto wait_for_construction;
-- 
2.39.0

