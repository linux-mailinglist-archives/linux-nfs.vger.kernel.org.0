Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665905E671D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiIVPb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 11:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiIVPbY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 11:31:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59BFB317;
        Thu, 22 Sep 2022 08:31:23 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYK0C3gL3zWgvF;
        Thu, 22 Sep 2022 23:27:23 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 23:31:20 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 23:31:19 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH 1/5] nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE to define nfsd_proc_ops
Date:   Fri, 23 Sep 2022 00:31:52 +0800
Message-ID: <20220922163156.2027440-2-chenxiaosong2@huawei.com>
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

Use DEFINE_PROC_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfsd/stats.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index a8c5a02a84f0..777e24e5da33 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -32,7 +32,7 @@ struct svc_stat		nfsd_svcstats = {
 	.program	= &nfsd_program,
 };
 
-static int nfsd_proc_show(struct seq_file *seq, void *v)
+static int nfsd_show(struct seq_file *seq, void *v)
 {
 	int i;
 
@@ -72,17 +72,7 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int nfsd_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nfsd_proc_show, NULL);
-}
-
-static const struct proc_ops nfsd_proc_ops = {
-	.proc_open	= nfsd_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-};
+DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
 int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
 {
-- 
2.31.1

