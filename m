Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327B653164A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiEWTS2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiEWTR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 15:17:56 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494F85EF5;
        Mon, 23 May 2022 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1653331969; x=1684867969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S2PPCwZ7Z3HQqLKrDfobsSLQViKsWFBnAEfH/7IrugM=;
  b=O2DYnj7rhgb3P3FdK4PObC9fhWNkIXmC07gFdKx3Qd8MkWqyyzeJV8To
   m8QfnrwNL23f6tiG/3vNwgWPBoqcMsnag5km3sIE0Rj18tOAdCs7dwZz/
   wZOd7+Frd7PSu5I/ANTPARHVhkqkd/H7z/catSg8F3M6LMkv/ugMF9G+Z
   s=;
X-IronPort-AV: E=Sophos;i="5.91,246,1647302400"; 
   d="scan'208";a="221822040"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 23 May 2022 18:52:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-7dac3c4d.us-east-1.amazon.com (Postfix) with ESMTPS id 1C77FE4158;
        Mon, 23 May 2022 18:52:45 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Mon, 23 May 2022 18:52:45 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Mon, 23 May 2022 18:52:45 +0000
Received: from dev-dsk-jumaco-1e-78723413.us-east-1.amazon.com (10.189.32.138)
 by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.36 via Frontend Transport; Mon, 23 May 2022 18:52:44 +0000
Received: by dev-dsk-jumaco-1e-78723413.us-east-1.amazon.com (Postfix, from userid 22056925)
        id 9BE784894; Mon, 23 May 2022 18:52:43 +0000 (UTC)
From:   Julian Schroeder 
        <jumaco@dev-dsk-jumaco-1e-78723413.us-east-1.amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <benh@amazon.com>, <alisaidi@amazon.com>, <jumaco@amazon.com>
Subject: [PATCH] nfsd: destroy percpu stats counters after reply cache shutdown
Date:   Mon, 23 May 2022 18:52:26 +0000
Message-ID: <20220523185226.7614-1-jumaco@dev-dsk-jumaco-1e-78723413.us-east-1.amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_ADSP_NXDOMAIN,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Julian Schroeder <jumaco@amazon.com>

Upon nfsd shutdown any pending DRC cache is freed. DRC cache use is
tracked via a percpu counter. In the current code the percpu counter
is destroyed before. If any pending cache is still present,
percpu_counter_add is called with a percpu counter==NULL. This causes
a kernel crash.
The solution is to destroy the percpu counter after the cache is freed.

Fixes: e567b98ce9a4b (“nfsd: protect concurrent access to nfsd stats counters”)
Signed-off-by: Julian Schroeder <jumaco@amazon.com>
---
 fs/nfsd/nfscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 0b3f12aa37ff..7da88bdc0d6c 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -206,7 +206,6 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	struct svc_cacherep	*rp;
 	unsigned int i;
 
-	nfsd_reply_cache_stats_destroy(nn);
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
@@ -217,6 +216,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 									rp, nn);
 		}
 	}
+	nfsd_reply_cache_stats_destroy(nn);
 
 	kvfree(nn->drc_hashtbl);
 	nn->drc_hashtbl = NULL;
-- 
2.32.0

