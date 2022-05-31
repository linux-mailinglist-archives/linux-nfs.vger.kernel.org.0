Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08B538F1C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245683AbiEaKfF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 06:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiEaKfF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 06:35:05 -0400
Received: from out20-205.mail.aliyun.com (out20-205.mail.aliyun.com [115.124.20.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC495A12
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 03:34:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1622386|-1;BR=01201311R811S28rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0894889-0.00169228-0.908819;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.NwSfrmt_1653993267;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.NwSfrmt_1653993267)
          by smtp.aliyun-inc.com(33.40.85.40);
          Tue, 31 May 2022 18:34:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-nfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH v2] nfsd: serialize filecache garbage collector
Date:   Tue, 31 May 2022 18:34:27 +0800
Message-Id: <20220531103427.47769-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When many(>NFSD_FILE_LRU_THRESHOLD) files are kept as OPEN, such as
xfstests generic/531, nfsd proceses are in CPU high-load state,
and nfsd_file_gc(nfsd filecache garbage collector) waste many CPU times.

concurrency nfsd_file_gc() is almost meaningless, so serialize it.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
Changes since v1:
- add static to 'atomic_t nfsd_file_gc_running'.
  thanks for kernel test robot <lkp@intel.com>

 fs/nfsd/filecache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f172412447f5..28a8f8d6d235 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -471,10 +471,15 @@ nfsd_file_lru_walk_list(struct shrink_control *sc)
 	return ret;
 }
 
+/* concurrency nfsd_file_gc() is almost meaningless, so serialize it. */
+static atomic_t nfsd_file_gc_running = ATOMIC_INIT(0);
 static void
 nfsd_file_gc(void)
 {
-	nfsd_file_lru_walk_list(NULL);
+	if(atomic_cmpxchg(&nfsd_file_gc_running, 0, 1) == 0) {
+		nfsd_file_lru_walk_list(NULL);
+		atomic_set(&nfsd_file_gc_running, 0);
+	}
 }
 
 static void
-- 
2.36.1

