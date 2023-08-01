Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6776B7E1
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjHAOnP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjHAOmy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 10:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F36173A
        for <linux-nfs@vger.kernel.org>; Tue,  1 Aug 2023 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690900933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAXNvoXv6M5X+c+lZ6mklW87VLV38D/1T9PDh9e6f/U=;
        b=VQeOhauW0RiJqGphnyYnPzWHbOKZX1kCU95oD4dxmyqfAPDH7sEGttxIAxnmvHojvocY8w
        XpglDCWrB6F/eoejPKZxozJtMFJOnkdEjBGyLgF32R1v+WOZ7BgdqgLKXbYlAcspPSKVaM
        V9GBysdJEcZZjhlzjtihSAy+oFzaoBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-Sc_XLSKjOVeM6ts5KlzkiA-1; Tue, 01 Aug 2023 10:42:12 -0400
X-MC-Unique: Sc_XLSKjOVeM6ts5KlzkiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D427381D9EC;
        Tue,  1 Aug 2023 14:42:11 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.8.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C776F7821;
        Tue,  1 Aug 2023 14:42:11 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] rpcb_clnt.c: Eliminate double frees in delete_cache()
Date:   Tue,  1 Aug 2023 10:42:09 -0400
Message-ID: <20230801144209.557175-2-steved@redhat.com>
In-Reply-To: <20230801144209.557175-1-steved@redhat.com>
References: <20230801144209.557175-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Herb Wartens <wartens2@llnl.gov>

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2224666
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/rpcb_clnt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index c0a9e12..68fe69a 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -262,12 +262,15 @@ delete_cache(addr)
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
+			} else {
 				front = cptr->ac_next;
+			}
 			cachesize--;
 			break;
 		}
-- 
2.41.0

