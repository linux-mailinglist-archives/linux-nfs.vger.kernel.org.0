Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EBC7E821A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjKJS7b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjKJS7U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:59:20 -0500
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA2FC7D4
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699640531; x=1731176531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DKXBVWtB2uTUkhTeBoWHnpZlTs2blWpMAnDBQdnqHnY=;
  b=MnbhvpdToOmR69YNhK6X7+JpC9pal/rNHPKJQifX+0Y86gakoZ1Ju/cX
   t+TIQpPBvsKeeQxlmVlkU41CXxGzmJFL5iUYhFl3UDBnhgitrNdyrl9T5
   7/7Eo7VJZGgZ7aqwOFuQexNLSKovfAJSdk/pE4kA74pnkk4uaoM31DlRE
   E=;
X-IronPort-AV: E=Sophos;i="6.03,291,1694736000"; 
   d="scan'208";a="42719035"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 18:21:06 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 0A43740D6C;
        Fri, 10 Nov 2023 18:21:05 +0000 (UTC)
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:17226]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.5.237:2525] with esmtp (Farcaster)
 id eb015df0-d19a-4ab7-b9a6-2b4640ae4e7b; Fri, 10 Nov 2023 18:21:05 +0000 (UTC)
X-Farcaster-Flow-ID: eb015df0-d19a-4ab7-b9a6-2b4640ae4e7b
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 18:21:05 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 10 Nov 2023 18:21:05 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Fri, 10 Nov 2023 18:21:04 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
        id ACE396C97; Fri, 10 Nov 2023 19:21:04 +0100 (CET)
From:   Mahmoud Adam <mngyadam@amazon.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>
CC:     <neilb@suse.de>, <kolga@netapp.com>, <Dai.Ngo@oracle.com>,
        <tom@talpey.com>, <linux-nfs@vger.kernel.org>,
        Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH] nfsd: fix file memleak on client_opens_relaese
Date:   Fri, 10 Nov 2023 19:21:04 +0100
Message-ID: <20231110182104.23039-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

seq_release should be called to free the allocated seq_file

Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4045c852a450..40415929e2ae 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2804,7 +2804,7 @@ static int client_opens_release(struct inode *inode, struct file *file)

 	/* XXX: alternatively, we could get/drop in seq start/stop */
 	drop_client(clp);
-	return 0;
+	return seq_release(inode, file);
 }

 static const struct file_operations client_states_fops = {
--
2.40.1
