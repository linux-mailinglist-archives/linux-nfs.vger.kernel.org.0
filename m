Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995A8607724
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Oct 2022 14:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJUMmU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Oct 2022 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJUMl7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Oct 2022 08:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587257DFA
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666356113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PqnOVYHkZryyX1p0+BUcFBzKM5ph1pZpZeIV39/Xw0w=;
        b=W1i2kESgYbnZQlxQcxtDHjsnVZXT4M10eD1rdheQb9F691vj2ZqobhkWNmJgllTAgflXWX
        yuUjvHiz+KAupUUs0OoOBIlCV8yGQTbz9qZmJM/NbJGvlxKbBuyqOXW68Z/N4bxIxAYDhU
        VkoFma3m7Gpyy5jj4YdToHYA7f/5Gx8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-zS6VNDFPOG-fEyjYCv4dZw-1; Fri, 21 Oct 2022 08:41:52 -0400
X-MC-Unique: zS6VNDFPOG-fEyjYCv4dZw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D9923C0F420
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 12:41:52 +0000 (UTC)
Received: from localhost (unknown [10.66.60.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4FC149BB60;
        Fri, 21 Oct 2022 12:41:51 +0000 (UTC)
From:   Zhi Li <yieli@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Zhi Li <yieli@redhat.com>
Subject: [PATCH] [nfs/nfs-utils] mount.nfs: fix NULL pointer derefernce in nfs_parse_square_bracket
Date:   Fri, 21 Oct 2022 20:41:48 +0800
Message-Id: <20221021124148.4035709-1-yieli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In function nfs_parse_square_bracket, hostname could be NULL,
dereferencing it in free(*hostname) may cause an unexpected segfault.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2136807
Signed-off-by: Zhi Li <yieli@redhat.com>
---
 utils/mount/parse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
index 0d3bcb95..2ade5d5d 100644
--- a/utils/mount/parse_dev.c
+++ b/utils/mount/parse_dev.c
@@ -170,7 +170,8 @@ static int nfs_parse_square_bracket(const char *dev,
 	if (pathname) {
 		*pathname = strndup(cbrace, path_len);
 		if (*pathname == NULL) {
-			free(*hostname);
+			if (hostname)
+				free(*hostname);
 			return nfs_pdn_nomem_err();
 		}
 	}
-- 
2.37.3

