Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CED702E37
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbjEONfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbjEONfr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890A41700
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C89261E7D
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A461C433D2;
        Mon, 15 May 2023 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157745;
        bh=iu1wVW8/NsyM3O19Mr5tQ2W03J8tXtYZw6BE1jN+FPw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LHojIVLiubC1ZvBzJ9FdZeH+imDhjUQRE0+Yo5BKreXf+bqBwtAFgC+11PNAGcHC9
         LvFZYofiDzz9OkgeNj5GsF58DkiquBzMpCG64RiyLK5BSzJ1lpbqDt3gSwIElyWEyt
         RiSYKdCiBtbdl6wyz3TSc7J6CDm0J1gNnzbIbUKRzkfPYGQ9xXroPxohVl9hQa4Vid
         dLL2+KKBJr9ry6NFqeGmWy3/bgokTmfS33LX2rWDW+vR58Dz/TxRWJAVAfQhXtiG3M
         MNk5BKd4NW4ske4kyeEOWFgD+Xz6bnXiG7CwO40CU+bTV5E6StYlqRXRBotM8hBoxF
         AIKyOa+oAxVkw==
Subject: [PATCH 2/3] NFSD: Clean up nfsctl_transaction_write()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:35:44 -0400
Message-ID: <168415774444.9589.17666926104552448905.stgit@manet.1015granger.net>
In-Reply-To: <168415762168.9589.16821927887100606727.stgit@manet.1015granger.net>
References: <168415762168.9589.16821927887100606727.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

For easier readability, follow the common convention:

    if (error)
	handle_error;
    continue_normally;

No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a9bbe6806276..8e69a5c46a4c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -109,12 +109,12 @@ static ssize_t nfsctl_transaction_write(struct file *file, const char __user *bu
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	rv =  write_op[ino](file, data, size);
-	if (rv >= 0) {
-		simple_transaction_set(file, rv);
-		rv = size;
-	}
-	return rv;
+	rv = write_op[ino](file, data, size);
+	if (rv < 0)
+		return rv;
+
+	simple_transaction_set(file, rv);
+	return size;
 }
 
 static ssize_t nfsctl_transaction_read(struct file *file, char __user *buf, size_t size, loff_t *pos)


