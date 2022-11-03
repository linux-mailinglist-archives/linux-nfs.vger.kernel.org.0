Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC82618400
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 17:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKCQRv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKCQRt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 12:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223AC636A
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667492206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfEwbQN1PMM2nsEq/v4tNEXoVx7e18h8ANGJ1MzaO+4=;
        b=alMf3RFcwXe2aEfMII3OHRvJcKO+fTNnZAIq43HInIWIbN2qGs+XQe6TFPKQfdRVohnZiW
        ncMsHlCPj8ozN5h1YoaCNeKNS1cN9IeZKBUSNHXJUgt5dWfdiKPUf14eUVzV1nhfEBcCRy
        /WQNw/hHlKfFXWdAK008+KvucX+Jyd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-x_M75nr_P767Hgd2INms4A-1; Thu, 03 Nov 2022 12:16:42 -0400
X-MC-Unique: x_M75nr_P767Hgd2INms4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DDF780280D;
        Thu,  3 Nov 2022 16:16:41 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.10.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DC801402BDA;
        Thu,  3 Nov 2022 16:16:41 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v10 4/6] NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
Date:   Thu,  3 Nov 2022 12:16:35 -0400
Message-Id: <20221103161637.1725471-5-dwysocha@redhat.com>
In-Reply-To: <20221103161637.1725471-1-dwysocha@redhat.com>
References: <20221103161637.1725471-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index ee66ffdb985e..302148258ff1 100644
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

