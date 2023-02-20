Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5069CCDF
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Feb 2023 14:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjBTNoJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Feb 2023 08:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBTNoG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Feb 2023 08:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545701C7D4
        for <linux-nfs@vger.kernel.org>; Mon, 20 Feb 2023 05:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676900594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2AJtsFPZBKYokV218FEgdDycX+OLdAKiTDvaBJ75Ag=;
        b=DljSATXtcIHLS3F9jLk4V68XWz818iKY3QCXtfLMGfYBpH/kpQj5QqVsGPszROVS9kN1EW
        PPXG8SIvxF55ZVJR93fmBqu8/hklhRFYZTMIBsJxMluAunrKN0NmJVfyEmcp7xXjT0uXLd
        3b6bfsnmvbnxyekBkq15vDvYvM4xfMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-HZx7-_IhNS-Tf16WatBtCQ-1; Mon, 20 Feb 2023 08:43:11 -0500
X-MC-Unique: HZx7-_IhNS-Tf16WatBtCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F05DE100F901;
        Mon, 20 Feb 2023 13:43:10 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFDCE404CD84;
        Mon, 20 Feb 2023 13:43:10 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v11 4/5] NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
Date:   Mon, 20 Feb 2023 08:43:07 -0500
Message-Id: <20230220134308.1193219-5-dwysocha@redhat.com>
In-Reply-To: <20230220134308.1193219-1-dwysocha@redhat.com>
References: <20230220134308.1193219-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The old NFSIOS_FSCACHE counters are no longer accurate or useful with
the conversion to the new netfs API.  The new API does not have a page
based interface, and so the counters in nfs_stat_fscachecounters are
no longer obtainable.  The new netfs the API has extensive statistics
inside /proc/fs/fscache/stats so we no longer need NFS specific fscache
stats.

Note this also removes the 'fsc:' line from /proc/self/mountstats so
it will be a user-visible change.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/iostat.h            | 17 -----------------
 fs/nfs/super.c             | 11 -----------
 include/linux/nfs_iostat.h | 12 ------------
 3 files changed, 40 deletions(-)

diff --git a/fs/nfs/iostat.h b/fs/nfs/iostat.h
index 2ddaab1ac653..5aa776b5a3e7 100644
--- a/fs/nfs/iostat.h
+++ b/fs/nfs/iostat.h
@@ -17,9 +17,6 @@
 
 struct nfs_iostats {
 	unsigned long long	bytes[__NFSIOS_BYTESMAX];
-#ifdef CONFIG_NFS_FSCACHE
-	unsigned long long	fscache[__NFSIOS_FSCACHEMAX];
-#endif
 	unsigned long		events[__NFSIOS_COUNTSMAX];
 } ____cacheline_aligned;
 
@@ -49,20 +46,6 @@ static inline void nfs_add_stats(const struct inode *inode,
 	nfs_add_server_stats(NFS_SERVER(inode), stat, addend);
 }
 
-#ifdef CONFIG_NFS_FSCACHE
-static inline void nfs_add_fscache_stats(struct inode *inode,
-					 enum nfs_stat_fscachecounters stat,
-					 long addend)
-{
-	this_cpu_add(NFS_SERVER(inode)->io_stats->fscache[stat], addend);
-}
-static inline void nfs_inc_fscache_stats(struct inode *inode,
-					 enum nfs_stat_fscachecounters stat)
-{
-	this_cpu_inc(NFS_SERVER(inode)->io_stats->fscache[stat]);
-}
-#endif
-
 static inline struct nfs_iostats __percpu *nfs_alloc_iostats(void)
 {
 	return alloc_percpu(struct nfs_iostats);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 05ae23657527..90796db8c205 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -692,10 +692,6 @@ int nfs_show_stats(struct seq_file *m, struct dentry *root)
 			totals.events[i] += stats->events[i];
 		for (i = 0; i < __NFSIOS_BYTESMAX; i++)
 			totals.bytes[i] += stats->bytes[i];
-#ifdef CONFIG_NFS_FSCACHE
-		for (i = 0; i < __NFSIOS_FSCACHEMAX; i++)
-			totals.fscache[i] += stats->fscache[i];
-#endif
 
 		preempt_enable();
 	}
@@ -706,13 +702,6 @@ int nfs_show_stats(struct seq_file *m, struct dentry *root)
 	seq_puts(m, "\n\tbytes:\t");
 	for (i = 0; i < __NFSIOS_BYTESMAX; i++)
 		seq_printf(m, "%Lu ", totals.bytes[i]);
-#ifdef CONFIG_NFS_FSCACHE
-	if (nfss->options & NFS_OPTION_FSCACHE) {
-		seq_puts(m, "\n\tfsc:\t");
-		for (i = 0; i < __NFSIOS_FSCACHEMAX; i++)
-			seq_printf(m, "%Lu ", totals.fscache[i]);
-	}
-#endif
 	seq_putc(m, '\n');
 
 	rpc_clnt_show_stats(m, nfss->client);
diff --git a/include/linux/nfs_iostat.h b/include/linux/nfs_iostat.h
index 027874c36c88..8d946089d151 100644
--- a/include/linux/nfs_iostat.h
+++ b/include/linux/nfs_iostat.h
@@ -119,16 +119,4 @@ enum nfs_stat_eventcounters {
 	__NFSIOS_COUNTSMAX,
 };
 
-/*
- * NFS local caching servicing counters
- */
-enum nfs_stat_fscachecounters {
-	NFSIOS_FSCACHE_PAGES_READ_OK,
-	NFSIOS_FSCACHE_PAGES_READ_FAIL,
-	NFSIOS_FSCACHE_PAGES_WRITTEN_OK,
-	NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL,
-	NFSIOS_FSCACHE_PAGES_UNCACHED,
-	__NFSIOS_FSCACHEMAX,
-};
-
 #endif	/* _LINUX_NFS_IOSTAT */
-- 
2.31.1

