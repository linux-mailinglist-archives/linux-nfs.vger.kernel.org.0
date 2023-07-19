Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E498759AED
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 18:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGSQgW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 12:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGSQgV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 12:36:21 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6472100
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 09:36:00 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5hJ62cDMzBRDrQ
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 00:35:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689784516; x=1692376517; bh=QBL7hyJ4zfeX5L8G+qvS4vfiCIR
        +etA4h9MhqkiPafw=; b=Slj9qiZ3y46hHXfivDmg7EEPKxIfa+3207gdi89ZLTW
        7GXHGRKIyrRoneAllnGtC6cVjAq8k6JUVrnqJ1UHih0sRuvu/TTY4eWT4zpKZqMq
        T1A6RXTV9Cq/NCIDszSuTH1Dcf2q9hkMzVC0N58jvoAdcUxwxlHe/2e6rvCERhG0
        xLCXC4EO9LMYeS3y5gzfmcBVkJwlmZhxPiThFrsZ9YCmom1YKRXTXs3nWUom3mGl
        b/MunWox38n47SweZV8v3HbhUovww1kVOJTuepR8MA9z9o4nr0iNM1h1MllSNRF4
        KT/wAh10V2mhjoIMrfhYC/c0o4i9cTArwKrqtBYE3zg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u-qVn8WRowjA for <linux-nfs@vger.kernel.org>;
        Thu, 20 Jul 2023 00:35:16 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5Xsz06wgzBR5CB;
        Wed, 19 Jul 2023 19:00:38 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 19:00:38 +0800
From:   huzhi001@208suo.com
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] filemap: Fix errors in file.c
In-Reply-To: <tencent_405AD96A973A6206087B37AD8032389BA807@qq.com>
References: <tencent_405AD96A973A6206087B37AD8032389BA807@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <0918d0a7d468ab484d075593c35470ad@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following checkpatch errors are removed:
ERROR: "foo * bar" should be "foo *bar"
"foo * bar" should be "foo *bar"

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  fs/nfs/file.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 79b1b3fcd3fc..3f9768810427 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -200,7 +200,7 @@ nfs_file_splice_read(struct file *in, loff_t *ppos, 
struct pipe_inode_info *pipe
  EXPORT_SYMBOL_GPL(nfs_file_splice_read);

  int
-nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
+nfs_file_mmap(struct file *file, struct vm_area_struct *vma)
  {
      struct inode *inode = file_inode(file);
      int    status;
