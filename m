Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912B776AE2F
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHAJgo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 05:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjHAJgR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 05:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200EE1BF9
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690882421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBySKfhMpW5e5BOzvL+uiOpVyslDNpoO3k4O/PgFgMc=;
        b=Pk2chotHaD7pVpKYfQPpxs39C7dzL+KA9OAEiwsGgnbVRsLrPbu2RoS/4Jpmh9fi9nJc31
        htnF1ZWMDj7MEsicN+TCk9aHAi2bbVolvNkQi4wA3KTxv1+0aPZgoUFr1t1m1KDEXtcK5W
        1v6f4eIkxGdPNyOXPOKa4bJhP8ZFNRs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-gPZOl14YNtag0SxcyP-NYg-1; Tue, 01 Aug 2023 05:33:38 -0400
X-MC-Unique: gPZOl14YNtag0SxcyP-NYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B181D185A78B;
        Tue,  1 Aug 2023 09:33:37 +0000 (UTC)
Received: from localhost (yoyang-vm.hosts.qa.psi.pek2.redhat.com [10.73.149.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19AE9492B03;
        Tue,  1 Aug 2023 09:33:36 +0000 (UTC)
From:   Yongcheng Yang <yoyang@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Herb Wartens <wartens2@llnl.gov>,
        Yongcheng Yang <yoyang@redhat.com>
Subject: [PATCH 1/2] rpcb_clnt.c: fix a possible double free
Date:   Tue,  1 Aug 2023 17:33:09 +0800
Message-Id: <20230801093310.594942-2-yoyang@redhat.com>
In-Reply-To: <20230801093310.594942-1-yoyang@redhat.com>
References: <20230801093310.594942-1-yoyang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
 src/rpcb_clnt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index d178d86..630f9ad 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -252,12 +252,16 @@ delete_cache(addr)
 	for (cptr = front; cptr != NULL; cptr = cptr->ac_next) {
 		if (!memcmp(cptr->ac_taddr->buf, addr->buf, addr->len)) {
 			/* Unlink from cache. We'll destroy it after releasing the mutex. */
-			if (cptr->ac_uaddr)
+			if (cptr->ac_uaddr) {
 				free(cptr->ac_uaddr);
-			if (prevptr)
+				cptr->ac_uaddr = NULL;
+			}
+			if (prevptr) {
 				prevptr->ac_next = cptr->ac_next;
-			else
+			}
+			else {
 				front = cptr->ac_next;
+			}
 			cachesize--;
 			break;
 		}
-- 
2.31.1

