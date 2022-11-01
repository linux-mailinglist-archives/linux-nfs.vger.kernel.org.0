Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA1614D00
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKAOqy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiKAOqy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 10:46:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA211C137
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 07:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0F89B81DE8
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FEAC433D6;
        Tue,  1 Nov 2022 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667314010;
        bh=hR4n/WdwUFH1ht7bOelDcd/wkqhBjpnPe5mAmyEPMgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVicQ/ar3dKXwx+7HddKhWXw2B2oIQruOKiGxwXYmgvsgnS2G5+nrJv918Q+334lw
         A1GZXp3SOSe7zzJxRu3l+p6o+J3vmk4de5UQldM1J8qFSkHeZdlpYd7iIyhXg8VNby
         0lvYka8BsYEpLdkg5HPA7W+NQV5FD8R8Xm6zftMYBqSeofDzaTggdJshZDQCSBLajF
         +gk4/8CSMwa+F6x7z3+S4zwDA8XJn8tbPXIR/D2kC0ocs4TvTvfL5E9KJf92/VYghM
         A/iFtmCayW14gEut9B1sE8XtvrNbGwNEiOalsllmzqwQNi56M/qjXAkqmWdJMPh3h5
         3tI4xndQ7EHnw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/5] nfsd: remove the pages_flushed statistic from filecache
Date:   Tue,  1 Nov 2022 10:46:43 -0400
Message-Id: <20221101144647.136696-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101144647.136696-1-jlayton@kernel.org>
References: <20221101144647.136696-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index b6b957e25dfd..90e62042d6d6 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -34,7 +34,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
-static DEFINE_PER_CPU(unsigned long, nfsd_file_pages_flushed);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
 struct nfsd_fcache_disposal {
@@ -372,7 +371,6 @@ nfsd_file_flush(struct nfsd_file *nf)
 
 	if (!file || !(file->f_mode & FMODE_WRITE))
 		return;
-	this_cpu_add(nfsd_file_pages_flushed, file->f_mapping->nrpages);
 	if (vfs_fsync(file, 1) != 0)
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
@@ -999,7 +997,6 @@ nfsd_file_cache_shutdown(void)
 		per_cpu(nfsd_file_acquisitions, i) = 0;
 		per_cpu(nfsd_file_releases, i) = 0;
 		per_cpu(nfsd_file_total_age, i) = 0;
-		per_cpu(nfsd_file_pages_flushed, i) = 0;
 		per_cpu(nfsd_file_evictions, i) = 0;
 	}
 }
@@ -1213,7 +1210,7 @@ nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 {
-	unsigned long releases = 0, pages_flushed = 0, evictions = 0;
+	unsigned long releases = 0, evictions = 0;
 	unsigned long hits = 0, acquisitions = 0;
 	unsigned int i, count = 0, buckets = 0;
 	unsigned long lru = 0, total_age = 0;
@@ -1241,7 +1238,6 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		releases += per_cpu(nfsd_file_releases, i);
 		total_age += per_cpu(nfsd_file_total_age, i);
 		evictions += per_cpu(nfsd_file_evictions, i);
-		pages_flushed += per_cpu(nfsd_file_pages_flushed, i);
 	}
 
 	seq_printf(m, "total entries: %u\n", count);
@@ -1255,6 +1251,5 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		seq_printf(m, "mean age (ms): %ld\n", total_age / releases);
 	else
 		seq_printf(m, "mean age (ms): -\n");
-	seq_printf(m, "pages flushed: %lu\n", pages_flushed);
 	return 0;
 }
-- 
2.38.1

