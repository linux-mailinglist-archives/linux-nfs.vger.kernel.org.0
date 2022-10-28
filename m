Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0D611A8C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiJ1S5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJ1S5S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:57:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036971ABA3B
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA2F1B82C8D
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 18:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2683C433D7;
        Fri, 28 Oct 2022 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666983435;
        bh=19GN2WutVnfU1eKRekedqCHUhQm55dxuykeR22OypyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7ZHwZ6vvqlN4G1gKYgYg30XUSdqdy/+WKE7bP2yBOEVDdZECUhubFZpPlkUzYod+
         dJThnW6amsBmLxOLDxhofqSti2lFIi9pbx2A8lDDcLw6uPOHCsvKpnW8tGEZBPb/xY
         ptQyxb8tTMuJUqQqBItMcsDSD5TrUmvMhwruVU/1LJgRWYiZZsJ9r4acJy183QssWX
         qNININq0Lad4fipuoM/1PJoejfRGB8V/HFL1e2MjqCDcZR7rPBKAXDnHPuiIxriDMs
         ixEF73CEy1kNCNmvhmYTswByx5hYbptKwWvWG9ZxMCMlQEDfEb2fpZuzZZu2/oD07R
         xF9sk6Lk1eGAA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v3 1/4] nfsd: remove the pages_flushed statistic from filecache
Date:   Fri, 28 Oct 2022 14:57:09 -0400
Message-Id: <20221028185712.79863-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028185712.79863-1-jlayton@kernel.org>
References: <20221028185712.79863-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We're counting mapping->nrpages, but not all of those are necessarily
dirty. We don't really have a simple way to count just the dirty pages,
so just remove this stat since it's not accurate.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 98c6b5f51bc8..f8ebbf7daa18 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -32,7 +32,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
-static DEFINE_PER_CPU(unsigned long, nfsd_file_pages_flushed);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
 struct nfsd_fcache_disposal {
@@ -370,7 +369,6 @@ nfsd_file_flush(struct nfsd_file *nf)
 
 	if (!file || !(file->f_mode & FMODE_WRITE))
 		return;
-	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
 	if (vfs_fsync(file, 1) != 0)
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
@@ -998,7 +996,6 @@ nfsd_file_cache_shutdown(void)
 		per_cpu(nfsd_file_acquisitions, i) = 0;
 		per_cpu(nfsd_file_releases, i) = 0;
 		per_cpu(nfsd_file_total_age, i) = 0;
-		per_cpu(nfsd_file_pages_flushed, i) = 0;
 		per_cpu(nfsd_file_evictions, i) = 0;
 	}
 }
@@ -1212,7 +1209,7 @@ nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 {
-	unsigned long releases = 0, pages_flushed = 0, evictions = 0;
+	unsigned long releases = 0, evictions = 0;
 	unsigned long hits = 0, acquisitions = 0;
 	unsigned int i, count = 0, buckets = 0;
 	unsigned long lru = 0, total_age = 0;
@@ -1240,7 +1237,6 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		releases += per_cpu(nfsd_file_releases, i);
 		total_age += per_cpu(nfsd_file_total_age, i);
 		evictions += per_cpu(nfsd_file_evictions, i);
-		pages_flushed += per_cpu(nfsd_file_pages_flushed, i);
 	}
 
 	seq_printf(m, "total entries: %u\n", count);
@@ -1254,6 +1250,5 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		seq_printf(m, "mean age (ms): %ld\n", total_age / releases);
 	else
 		seq_printf(m, "mean age (ms): -\n");
-	seq_printf(m, "pages flushed: %lu\n", pages_flushed);
 	return 0;
 }
-- 
2.37.3

