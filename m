Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29248652592
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Dec 2022 18:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLTRbg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Dec 2022 12:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTRbf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Dec 2022 12:31:35 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6AC1E2
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 09:31:34 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id l17so6076435vkk.3
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ploh3GTv9AfGvgnhWt/Wp5erHoONYXI+0/PTs1jquI=;
        b=qNv5XhTa0SFoxwnJhEVSF/oZPyz49/xsLRMmvgF/4/sJCWSN/ZWbFCNtW8t1OjSVGI
         VyTSTQK7WO8S8W0rV+3e3Tw6FJ064JMFaXJsWikJJaPcZfo/miP93BBnn8uthhW8hKGK
         MTKQ9dwraFk68E5kRmD42TaQa0RUzoLqMv//duCwHhzntpTa7dO+QeeRvgaJFt1Sd6rI
         Pr6CC9HBNsPnB8EhImseeneEBvwd+pUlF3iik1um2u5A9Ww+HfNvsOFmHt73Bj+z3iVZ
         8uXnVV1EzOPFJw9hNuMBETKSeY5CCYFnMcISWfiab5bpjwsul67omARGsxrK4YH9ldxG
         BNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ploh3GTv9AfGvgnhWt/Wp5erHoONYXI+0/PTs1jquI=;
        b=kdJgW1F8neaZGsgLPt7/mu/14G6YNYz7+DvsK/XVVFNujRlccyjQc8hah2vZ8tBPUk
         huK6fpuKhvj6AQy2KhrIIIWP5gSGi/GOUsE2hUvGeSq93EGO0DABhDHGV5jEngLNbhbg
         zEIbXmva/f/a87TAACKkCv7R1XQ+7NkmBO8GNADmJuzGDWc7EW+xt7MDz4wJiPaPzGzP
         RYpCDRdRpddBSPCXgt50IM9ifjIttai8Ixlzc6xvfpNdfwVU1K9D8OfpwBxwiMz9CZ0C
         W903N1N56RNOrFYtbYqIGX4Ixh2Dg1PYfgc29WdjKWnhglAEEjLx+PZBt5bITjatblyT
         8Ntg==
X-Gm-Message-State: AFqh2koFEisKRC5qMAPlfwWVGcAjwcM5CFqUGMc+tCaRxSVCiwCFDY74
        MLRPRmZPY6jOWfatfuJxeC+4I6nfXrQ=
X-Google-Smtp-Source: AMrXdXsOSBIxx6qcyYlehA5jiLbHO4+Wr7bIg1RZhaFqJS3q2rk0TmGfUZlBkwqCxvzbaNBAr7l7UQ==
X-Received: by 2002:a1f:9481:0:b0:3c1:1866:28d8 with SMTP id w123-20020a1f9481000000b003c1186628d8mr4739233vkd.9.1671557493855;
        Tue, 20 Dec 2022 09:31:33 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:31e3:d2c8:6863:dc26])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006f87d28ea3asm9263193qkp.54.2022.12.20.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:31:32 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] pNFS/filelayout: Fix coalescing test for single DS
Date:   Tue, 20 Dec 2022 12:31:29 -0500
Message-Id: <20221220173129.98009-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When there is a single DS no striping constraints need to be placed on
the IO. When such constraint is applied then buffered reads don't
coalesce to the DS's rsize.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index ad34a33b0737..4974cd18ca46 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -783,6 +783,12 @@ filelayout_alloc_lseg(struct pnfs_layout_hdr *layoutid,
 	return &fl->generic_hdr;
 }
 
+static bool
+filelayout_lseg_is_striped(const struct nfs4_filelayout_segment *flseg)
+{
+	return flseg->num_fh > 1;
+}
+
 /*
  * filelayout_pg_test(). Called by nfs_can_coalesce_requests()
  *
@@ -803,6 +809,8 @@ filelayout_pg_test(struct nfs_pageio_descriptor *pgio, struct nfs_page *prev,
 	size = pnfs_generic_pg_test(pgio, prev, req);
 	if (!size)
 		return 0;
+	else if (!filelayout_lseg_is_striped(FILELAYOUT_LSEG(pgio->pg_lseg)))
+		return size;
 
 	/* see if req and prev are in the same stripe */
 	if (prev) {
-- 
2.31.1

