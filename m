Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD68176AE30
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHAJgp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjHAJgS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 05:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B4F2103
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690882424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWpMtrmt8st+MrJaNzJ5PP4QnS/bveMqzXtBPhrPm7E=;
        b=HX53LXmkLGvZzFlX6hzyCMsS+bodybCHoGFBlO+mEiiBvArfYGnIi2LPvsq/vktI7IlnvN
        Jpf6M/7jNPkBO8huKz93U6q0B/xYffxdDN4qkqHJ0+uEtOEYx5bMX5Glq+qBtQNpyr+wOM
        ZtLnU+8zxsFnrU980dCRuWfvCz8aBrY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-5palJKXOPdq_MMQCQLgvTw-1; Tue, 01 Aug 2023 05:33:43 -0400
X-MC-Unique: 5palJKXOPdq_MMQCQLgvTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF93E3813F32;
        Tue,  1 Aug 2023 09:33:42 +0000 (UTC)
Received: from localhost (yoyang-vm.hosts.qa.psi.pek2.redhat.com [10.73.149.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46F4B2166B26;
        Tue,  1 Aug 2023 09:33:41 +0000 (UTC)
From:   Yongcheng Yang <yoyang@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Herb Wartens <wartens2@llnl.gov>,
        Yongcheng Yang <yoyang@redhat.com>
Subject: [PATCH 2/2] rpcb_clnt.c: fix memory leak in destroy_addr
Date:   Tue,  1 Aug 2023 17:33:10 +0800
Message-Id: <20230801093310.594942-3-yoyang@redhat.com>
In-Reply-To: <20230801093310.594942-1-yoyang@redhat.com>
References: <20230801093310.594942-1-yoyang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Herb Wartens <wartens2@llnl.gov>
---
 src/rpcb_clnt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 630f9ad..539b521 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -102,19 +102,31 @@ static void
 destroy_addr(addr)
 	struct address_cache *addr;
 {
-	if (addr == NULL)
+	if (addr == NULL) {
 		return;
-	if(addr->ac_host != NULL)
+	}
+	if(addr->ac_host != NULL) {
 		free(addr->ac_host);
-	if(addr->ac_netid != NULL)
+		addr->ac_host = NULL;
+	}
+	if(addr->ac_netid != NULL) {
 		free(addr->ac_netid);
-	if(addr->ac_uaddr != NULL)
+		addr->ac_netid = NULL;
+	}
+	if(addr->ac_uaddr != NULL) {
 		free(addr->ac_uaddr);
+		addr->ac_uaddr = NULL;
+	}
 	if(addr->ac_taddr != NULL) {
-		if(addr->ac_taddr->buf != NULL)
+		if(addr->ac_taddr->buf != NULL) {
 			free(addr->ac_taddr->buf);
+			addr->ac_taddr->buf = NULL;
+		}
+		free(addr->ac_taddr);
+		addr->ac_taddr = NULL;
 	}
 	free(addr);
+	addr = NULL;
 }
 
 /*
-- 
2.31.1

