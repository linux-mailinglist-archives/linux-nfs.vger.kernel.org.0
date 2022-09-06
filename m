Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FBD5ADD0E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 03:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiIFBvO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Sep 2022 21:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiIFBvO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Sep 2022 21:51:14 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2936617061;
        Mon,  5 Sep 2022 18:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=W/44+
        IbuOj0a3OaAjCjrnVzWwtelwbjOo0SR89cGwhU=; b=o+C0Hd0hEljP8Tkzu8D39
        hWNgU+uO5Zef8N1ReCL9bXH9isX5fLndzY0LrNlBUd/tOK5iHS1MfRQdDNRakSUy
        8dELgPVkem48nPkLrmyNYoZWMBBs9uLepzhGrBKF4KqEPRXk2ln/OkeWZYeG/lCN
        x9hKMrsvtQy1M53zyOvUUc=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgDX3Kl8pxZjIWD5bA--.39470S2;
        Tue, 06 Sep 2022 09:50:54 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fs/nfs/pnfs_nfs.c: fix spelling typo and syntax error in comment
Date:   Tue,  6 Sep 2022 09:50:27 +0800
Message-Id: <20220906015027.3963386-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDX3Kl8pxZjIWD5bA--.39470S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4ruF4fJw4rur4kAFy7KFg_yoWkArX_GF
        yIv34DWw4UJrs3Aw17Kr4avFyY9FsxKFZ7JF4qqF1ak345G395ZayktFWfAr4DWr48tr95
        Gwn2kryqyrySvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivgB0+1Zcem0tCwAAsK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo and syntax error in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/nfs/pnfs_nfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 657c242a18ff..45a5a66a2e3e 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -374,12 +374,12 @@ pnfs_bucket_search_commit_reqs(struct pnfs_commit_bucket *buckets,
 	return NULL;
 }
 
-/* pnfs_generic_search_commit_reqs - Search lists in @cinfo for the head reqest
+/* pnfs_generic_search_commit_reqs - Search lists in @cinfo for the head request
  *				   for @page
  * @cinfo - commit info for current inode
  * @page - page to search for matching head request
  *
- * Returns a the head request if one is found, otherwise returns NULL.
+ * Returns the head request if one is found, otherwise returns NULL.
  */
 struct nfs_page *
 pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page)
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

