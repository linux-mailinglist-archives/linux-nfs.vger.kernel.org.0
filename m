Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B26A547E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Feb 2023 09:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjB1Igh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Feb 2023 03:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Ige (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Feb 2023 03:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6FC19F25
        for <linux-nfs@vger.kernel.org>; Tue, 28 Feb 2023 00:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677573349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QAk5HDXijc1Zn+294xz/ng/XWRjBpvunH6owKK8lW6I=;
        b=GqI7qzNmKdPQmFccbBK9Bt4eDEyyKtcuuxxg4n5gcXpmRiL3kZqL7kz96wXanFFnnftSQQ
        /1Xbd7PNV6wud0Vjwri3lAZlGdTr72ny3in46cjU1LRhAe/nK1NkHo+2QR0tQyQ+r5tOhp
        jUGwd6VQnVP2k5MZ2rxaiXsvBLUMD8Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-K2PCY8YfNAiBKsOH-gmx3Q-1; Tue, 28 Feb 2023 03:35:48 -0500
X-MC-Unique: K2PCY8YfNAiBKsOH-gmx3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6B938432AF
        for <linux-nfs@vger.kernel.org>; Tue, 28 Feb 2023 08:35:47 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6CC140EBF6;
        Tue, 28 Feb 2023 08:35:47 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH] [nfs/nfs-utils/rpcbind] rpcbind: avoid dereferencing NULL from realloc()
Date:   Tue, 28 Feb 2023 16:35:44 +0800
Message-Id: <20230228083544.4035733-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2173869

Signed-off-by: Zhi Li <yieli@redhat.com>
---
 src/rpcbind.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/rpcbind.c b/src/rpcbind.c
index ecebe97..6379a4e 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -471,6 +471,8 @@ init_transport(struct netconfig *nconf)
 		nhostsbak = nhosts;
 		nhostsbak++;
 		hosts = realloc(hosts, nhostsbak * sizeof(char *));
+		if (hosts == NULL)
+			errx(1, "Out of memory");
 		if (nhostsbak == 1)
 			hosts[0] = "*";
 		else {
-- 
2.39.0

