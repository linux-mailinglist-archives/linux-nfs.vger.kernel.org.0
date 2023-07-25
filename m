Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB257617E0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGYL7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGYL7v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 07:59:51 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73626E7B;
        Tue, 25 Jul 2023 04:59:50 -0700 (PDT)
Received: from localhost.ispras.ru (unknown [10.10.165.8])
        by mail.ispras.ru (Postfix) with ESMTPSA id DD2BF40B27AF;
        Tue, 25 Jul 2023 11:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DD2BF40B27AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1690286389;
        bh=ruOum+VRqfbaR9QtP8uXcTltKn49w9a/H02a8B9VQzg=;
        h=From:To:Cc:Subject:Date:From;
        b=U14zvJHO6elOcBhBxtyQLd1QBk1gUozOihac+FTAT3r1lArX+5hJ0oCmPR0EE+HvB
         w86HcqhIZ/lnVz+ZYkdK0VP5RVIICr2/VL+R/z5vT1bf1aAhzG1dq7KfyMKcm83ovL
         +31KGUXWyIQIoysaXqa3MVMB0VsoCiVV4JC6Oqn8=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] NFSv4: fix out path in __nfs4_get_acl_uncached
Date:   Tue, 25 Jul 2023 14:59:30 +0300
Message-ID: <20230725115933.23784-1-pchelkin@ispras.ru>
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

Another highly rare error case when a page allocating loop (inside
__nfs4_get_acl_uncached, this time) is not properly unwound on error.
Since pages array is allocated being uninitialized, need to free only
lower array indices. NULL checks were useful before commit 62a1573fcf84
("NFSv4 fix acl retrieval over krb5i/krb5p mounts") when the array had
been initialized to zero on stack.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 62a1573fcf84 ("NFSv4 fix acl retrieval over krb5i/krb5p mounts")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/nfs/nfs4proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1a886b58354..08e8381a5e46 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6004,9 +6004,8 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 out_ok:
 	ret = res.acl_len;
 out_free:
-	for (i = 0; i < npages; i++)
-		if (pages[i])
-			__free_page(pages[i]);
+	while (--i >= 0)
+		__free_page(pages[i]);
 	if (res.acl_scratch)
 		__free_page(res.acl_scratch);
 	kfree(pages);
-- 
2.41.0

