Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52BF5E6722
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiIVPba (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIVPb2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 11:31:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07496FB30F;
        Thu, 22 Sep 2022 08:31:25 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYK032JnVz14S2m;
        Thu, 22 Sep 2022 23:27:15 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 23:31:23 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 23:31:22 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH 5/5] nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_file_cache_stats_fops
Date:   Fri, 23 Sep 2022 00:31:56 +0800
Message-ID: <20220922163156.2027440-6-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922163156.2027440-1-chenxiaosong2@huawei.com>
References: <20220922163156.2027440-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfsd/filecache.c | 7 +------
 fs/nfsd/filecache.h | 2 +-
 fs/nfsd/nfsctl.c    | 9 ++-------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index eeed4ae5b4ad..d5c57360b418 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1212,7 +1212,7 @@ nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * scraping this file for info should test the labels to ensure they're
  * getting the correct field.
  */
-static int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
+int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 {
 	unsigned long releases = 0, pages_flushed = 0, evictions = 0;
 	unsigned long hits = 0, acquisitions = 0;
@@ -1259,8 +1259,3 @@ static int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "pages flushed: %lu\n", pages_flushed);
 	return 0;
 }
-
-int nfsd_file_cache_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nfsd_file_cache_stats_show, NULL);
-}
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 8e8c0c47d67d..357832bac736 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -60,5 +60,5 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
 __be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
-int	nfsd_file_cache_stats_open(struct inode *, struct file *);
+int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index faaedefec94c..e6be0e2a86ac 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -206,12 +206,7 @@ static const struct file_operations pool_stats_operations = {
 
 DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
 
-static const struct file_operations filecache_ops = {
-	.open		= nfsd_file_cache_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nfsd_file_cache_stats);
 
 /*----------------------------------------------------------------------------*/
 /*
@@ -1354,7 +1349,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxConnections] = {"max_connections", &transaction_ops, S_IWUSR|S_IRUGO},
-		[NFSD_Filecache] = {"filecache", &filecache_ops, S_IRUGO},
+		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
 #if defined(CONFIG_SUNRPC_GSS) || defined(CONFIG_SUNRPC_GSS_MODULE)
 		[NFSD_SupportedEnctypes] = {"supported_krb5_enctypes", &supported_enctypes_fops, S_IRUGO},
 #endif /* CONFIG_SUNRPC_GSS or CONFIG_SUNRPC_GSS_MODULE */
-- 
2.31.1

