Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC77617D8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjGYL7a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjGYL73 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 07:59:29 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32867E4D;
        Tue, 25 Jul 2023 04:59:26 -0700 (PDT)
Received: from localhost.ispras.ru (unknown [10.10.165.8])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2A93040B27AF;
        Tue, 25 Jul 2023 11:59:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2A93040B27AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1690286362;
        bh=qL7bfzyO0lruzgql+X09dRHp5RhT3+UBLqANpsxp8cc=;
        h=From:To:Cc:Subject:Date:From;
        b=o+c+4xJt+pYk+bgb18sacRfT6nffNVdt9jlimu1iTvQlmPlwDqIWJnYCXzoZ+DRbG
         LJYs1lodHDL6dgluLFQNVJgZREfQJFAGdSEGeqo+m5dexbUNaNT20eX76YUKxv9fUX
         FVk1ohgCvJMk/qyxgm/+m8DYggBJN58MrfW2rHYg=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Anna Schumaker <anna@kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] NFSv4.2: fix error handling in nfs42_proc_getxattr
Date:   Tue, 25 Jul 2023 14:58:58 +0300
Message-ID: <20230725115900.23690-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is a slight issue with error handling code inside
nfs42_proc_getxattr(). If page allocating loop fails then we free the
failing page array element which is NULL but __free_page() can't deal with
NULL args.

Found by Linux Verification Center (linuxtesting.org).

Fixes: a1f26739ccdc ("NFSv4.2: improve page handling for GETXATTR")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/nfs/nfs42proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..49f78e23b34c 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1377,7 +1377,6 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 	for (i = 0; i < np; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
 		if (!pages[i]) {
-			np = i + 1;
 			err = -ENOMEM;
 			goto out;
 		}
@@ -1401,8 +1400,8 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 	} while (exception.retry);
 
 out:
-	while (--np >= 0)
-		__free_page(pages[np]);
+	while (--i >= 0)
+		__free_page(pages[i]);
 	kfree(pages);
 
 	return err;
-- 
2.41.0

