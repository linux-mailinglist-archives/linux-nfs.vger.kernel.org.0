Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA337B48DB
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Oct 2023 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjJARZO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Oct 2023 13:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjJARZO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Oct 2023 13:25:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E25FD9
        for <linux-nfs@vger.kernel.org>; Sun,  1 Oct 2023 10:25:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB8AC433C8;
        Sun,  1 Oct 2023 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696181111;
        bh=z9THaSLh+4LkxfehPRWat3Om/sgsLjT1NL3nJ1KOzbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BK+ShvYQO1zwrz9PeB54NbDV8G9zE/zAlYwsEDMDy7TuWStZVAStr1EwyaeDpRg2r
         qrsbwav0cmLDoaUztsh7EwrPG6FbpvbOFVVjCrKPY+gt0mfhkkX45u64minWagCKBq
         yVQymWeSeM/yMzmb+JrRaPMgzWCaQSb/+m9XR0yfb41qi0dnnr2HwF5L10J3EnvIoF
         yVbnCD71PQrkjzCO4qSaNiYSBOQoe67TxUYXcWOaJg7CWPzl8hHWaQLDmRI9ZcwBYd
         NVfjHOhFYnB1GmQJKUtXnzZsQ8j7erFsEVMCiX+W9baK3sHqRLJjBhrkuT6j1A8rMn
         DfJ+9ft8wM9sA==
Subject: [PATCH RFC 1/2] NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Sun, 01 Oct 2023 13:25:09 -0400
Message-ID: <169618110986.65416.1447879517809565525.stgit@manet.1015granger.net>
In-Reply-To: <169618103606.65416.14867860807492030083.stgit@manet.1015granger.net>
References: <169618103606.65416.14867860807492030083.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

In function ‘export_stats_init’,
    inlined from ‘svc_export_alloc’ at /home/cel/src/linux/server-development/fs/nfsd/export.c:866:6:
/home/cel/src/linux/server-development/fs/nfsd/export.c:337:16: warning: ‘nfsd_percpu_counters_init’ accessing 40 bytes in a region of size 0 [-Wstringop-overflow=]
  337 |         return nfsd_percpu_counters_init(&stats->counter, EXP_STATS_COUNTERS_NUM);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/cel/src/linux/server-development/fs/nfsd/export.c:337:16: note: referencing argument 1 of type ‘struct percpu_counter[0]’
/home/cel/src/linux/server-development/fs/nfsd/stats.h: In function ‘svc_export_alloc’:
/home/cel/src/linux/server-development/fs/nfsd/stats.h:40:5: note: in a call to function ‘nfsd_percpu_counters_init’
   40 | int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/stats.c |    2 +-
 fs/nfsd/stats.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 63797635e1c3..12c299a05433 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -76,7 +76,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
 {
 	int i, err = 0;
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index cf5524e7ca06..a3e9e2f47ec4 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -37,9 +37,9 @@ extern struct nfsd_stats	nfsdstats;
 
 extern struct svc_stat		nfsd_svcstats;
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
 int nfsd_stat_init(void);
 void nfsd_stat_shutdown(void);
 


