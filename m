Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB955E671F
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIVPb3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiIVPb2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 11:31:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60728FB311;
        Thu, 22 Sep 2022 08:31:25 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYK2J1TMgzHq0J;
        Thu, 22 Sep 2022 23:29:12 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 23:31:22 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 23:31:22 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH 4/5] nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_reply_cache_stats_fops
Date:   Fri, 23 Sep 2022 00:31:55 +0800
Message-ID: <20220922163156.2027440-5-chenxiaosong2@huawei.com>
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

nfsd_net is converted from seq_file->file instead of seq_file->private in
nfsd_reply_cache_stats_show().

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfsd/cache.h    |  2 +-
 fs/nfsd/nfscache.c | 13 +++----------
 fs/nfsd/nfsctl.c   |  9 ++-------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 65c331f75e9c..f21259ead64b 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -84,6 +84,6 @@ int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *);
 void	nfsd_cache_update(struct svc_rqst *, int, __be32 *);
-int	nfsd_reply_cache_stats_open(struct inode *, struct file *);
+int	nfsd_reply_cache_stats_show(struct seq_file *m, void *v);
 
 #endif /* NFSCACHE_H */
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 9b31e1103e7b..3e64a3d50a1c 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -604,9 +604,10 @@ nfsd_cache_append(struct svc_rqst *rqstp, struct kvec *data)
  * scraping this file for info should test the labels to ensure they're
  * getting the correct field.
  */
-static int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
+int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 {
-	struct nfsd_net *nn = m->private;
+	struct nfsd_net *nn = net_generic(file_inode(m->file)->i_sb->s_fs_info,
+					  nfsd_net_id);
 
 	seq_printf(m, "max entries:           %u\n", nn->max_drc_entries);
 	seq_printf(m, "num entries:           %u\n",
@@ -626,11 +627,3 @@ static int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
 }
-
-int nfsd_reply_cache_stats_open(struct inode *inode, struct file *file)
-{
-	struct nfsd_net *nn = net_generic(file_inode(file)->i_sb->s_fs_info,
-								nfsd_net_id);
-
-	return single_open(file, nfsd_reply_cache_stats_show, nn);
-}
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 51360d0bf424..faaedefec94c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -204,12 +204,7 @@ static const struct file_operations pool_stats_operations = {
 	.release	= nfsd_pool_stats_release,
 };
 
-static const struct file_operations reply_cache_stats_operations = {
-	.open		= nfsd_reply_cache_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
 
 static const struct file_operations filecache_ops = {
 	.open		= nfsd_file_cache_stats_open,
@@ -1354,7 +1349,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Threads] = {"threads", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Pool_Threads] = {"pool_threads", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Pool_Stats] = {"pool_stats", &pool_stats_operations, S_IRUGO},
-		[NFSD_Reply_Cache_Stats] = {"reply_cache_stats", &reply_cache_stats_operations, S_IRUGO},
+		[NFSD_Reply_Cache_Stats] = {"reply_cache_stats", &nfsd_reply_cache_stats_fops, S_IRUGO},
 		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
-- 
2.31.1

