Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FD45709F4
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiGKSay (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKSay (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226027CB61
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98234B8112C
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 18:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA4DC385A5;
        Mon, 11 Jul 2022 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657564218;
        bh=eV5RfACFcPUgyHQNa3DtRiysZ+StIc5V6bvBdC+yDUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KU311Q1ZDQfxT4U3YCxEZHr19xmXdKUf8NOep6fXTzbMNXqZfy6axwuWWwxSJw7Ms
         kQ+zAF3NUAn8o7QGOAOLQP+Sp0JjHJ0SAz2ItCn3jH9BR9JigbnvTTCQn+nOxyfFnC
         rJMjjCKM9IVK5pjQ2TjfBuUo/LEReBAwJZyv1a3GrbrZYVSATalzjfgC6i7Vbqe024
         +KxkTSfG9f/JZnwI8O2zrf645UTlLtkMEcgCV+GW047enecw8he30QuEfK08WcvOup
         xAFw/zu7+G4Y2teYztUBXYaG/ZGU68/vFViarFvcbg1MiPQz/K8E2FZ4OQ6iUA2cX/
         ngZPPANk9rcIA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna@kernel.org, "J . Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH 2/2] lockd: fix nlm_close_files
Date:   Mon, 11 Jul 2022 14:30:14 -0400
Message-Id: <20220711183014.15161-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711183014.15161-1-jlayton@kernel.org>
References: <20220711183014.15161-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This loop condition tries a bit too hard to be clever. Just test for
the two indices we care about explicitly.

Cc: J. Bruce Fields <bfields@fieldses.org>
Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svcsubs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index b2f277727469..e1c4617de771 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -283,11 +283,10 @@ nlm_file_inuse(struct nlm_file *file)
 
 static void nlm_close_files(struct nlm_file *file)
 {
-	struct file *f;
-
-	for (f = file->f_file[0]; f <= file->f_file[1]; f++)
-		if (f)
-			nlmsvc_ops->fclose(f);
+	if (file->f_file[O_RDONLY])
+		nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
+	if (file->f_file[O_WRONLY])
+		nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
 }
 
 /*
-- 
2.36.1

