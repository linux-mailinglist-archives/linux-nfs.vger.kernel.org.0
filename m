Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1976B7E3
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjHAOnQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjHAOnC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 10:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F19E9
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690900935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7vwc9at70Qh8LhK9xeX1CaO0kd7ITAuS0LQnI9Pt6BI=;
        b=gG8ZDGHZsiXJhLXIr6udD7/G5Tm1JJpIhzaab3tP3BK4lF+iytiVrgeEN76tmqkRROnCJP
        HAFw5wzqc2HYkcvb6nzRbWsoahyz80KcuMo+N2+GKSt/ZtT+cgMXs7L9Wky5r4xvpKAu7C
        y+MTCwowLf0WIe7QJKWYd8PaNj6nsQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-c11CCN0nPaS-RDzBr2ATtg-1; Tue, 01 Aug 2023 10:42:11 -0400
X-MC-Unique: c11CCN0nPaS-RDzBr2ATtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 851B38030AC;
        Tue,  1 Aug 2023 14:42:11 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.8.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D8F8F784B;
        Tue,  1 Aug 2023 14:42:11 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] rpcb_clnt.c: memory leak in destroy_addr
Date:   Tue,  1 Aug 2023 10:42:08 -0400
Message-ID: <20230801144209.557175-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Herb Wartens <wartens2@llnl.gov>

Null pointers so they are not used again

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2225226
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/rpcb_clnt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index d178d86..c0a9e12 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -104,17 +104,27 @@ destroy_addr(addr)
 {
 	if (addr == NULL)
 		return;
-	if(addr->ac_host != NULL)
+	if (addr->ac_host != NULL) {
 		free(addr->ac_host);
-	if(addr->ac_netid != NULL)
+		addr->ac_host = NULL;
+	}
+	if (addr->ac_netid != NULL) {
 		free(addr->ac_netid);
-	if(addr->ac_uaddr != NULL)
+		addr->ac_netid = NULL;
+	}
+	if (addr->ac_uaddr != NULL) {
 		free(addr->ac_uaddr);
-	if(addr->ac_taddr != NULL) {
-		if(addr->ac_taddr->buf != NULL)
+		addr->ac_uaddr = NULL;
+	}
+	if (addr->ac_taddr != NULL) {
+		if(addr->ac_taddr->buf != NULL) {
 			free(addr->ac_taddr->buf);
+			addr->ac_taddr->buf = NULL;
+		}
+		addr->ac_taddr = NULL;
 	}
 	free(addr);
+	addr = NULL;
 }
 
 /*
-- 
2.41.0

