Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7515E671C
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIVPbZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIVPbY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 11:31:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36161FB312;
        Thu, 22 Sep 2022 08:31:22 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYJzz2wfhzlXJl;
        Thu, 22 Sep 2022 23:27:11 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
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
Subject: [PATCH 0/5] nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE/DEFINE_SHOW_ATTRIBUTE to simplify the code
Date:   Fri, 23 Sep 2022 00:31:51 +0800
Message-ID: <20220922163156.2027440-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Use DEFINE_PROC_SHOW_ATTRIBUTE/DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.

No functional change.

ChenXiaoSong (5):
  nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE to define nfsd_proc_ops
  nfsd: use DEFINE_SHOW_ATTRIBUTE to define export_features_fops and
    supported_enctypes_fops
  nfsd: use DEFINE_SHOW_ATTRIBUTE to define client_info_fops
  nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_reply_cache_stats_fops
  nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_file_cache_stats_fops

 fs/nfsd/cache.h     |  2 +-
 fs/nfsd/filecache.c |  7 +------
 fs/nfsd/filecache.h |  2 +-
 fs/nfsd/nfs4state.c | 14 ++------------
 fs/nfsd/nfscache.c  | 13 +++----------
 fs/nfsd/nfsctl.c    | 46 ++++++++-------------------------------------
 fs/nfsd/stats.c     | 14 ++------------
 7 files changed, 18 insertions(+), 80 deletions(-)

-- 
2.31.1

