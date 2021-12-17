Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4752A4796A8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhLQV5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhLQV5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:57:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD90C06173E
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 13:57:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A70A4B82AEE
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 21:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F51C36AE9;
        Fri, 17 Dec 2021 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778237;
        bh=IkNzwSFFqwpXdDU6Cocf4WBRXCMmOwJMi5yFIjVVCAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0x+d2UnBStlDyXP8flJZKVJqkczwgxyiLOvLabpUNWMfrRqdexAYjrODOVl5Xbpj
         TiZOJ6teub0aDuJipqCGie3eG181MGqxcnzPWPGgIc+niZRLr45/KH01C9YpuraPfj
         oAUf1UCpNr4uUTfIYz+R/7wEDLZ+zvibwALAAkDneH5u5wEY7vl/Vrf4QZtrEceHiH
         R4ca9EK6gl8JzkdiL5r8zMBsSwbaq4gHpfRiuOvFBTAjEpxr9ntB/gV/UwBHCwEyqU
         L9qeRikp0l1jPMUx/LWwNcVR7KHjhzmygv5jPmBcHJiG2WtGTXWbnnLr2krSUYIVXC
         E81oN9tf6N0dw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/9] nfsd: allow lockd to be forcibly disabled
Date:   Fri, 17 Dec 2021 16:50:45 -0500
Message-Id: <20211217215046.40316-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217215046.40316-8-trondmy@kernel.org>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
 <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org>
 <20211217215046.40316-6-trondmy@kernel.org>
 <20211217215046.40316-7-trondmy@kernel.org>
 <20211217215046.40316-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

In some cases, we may want to use a userland NLM server which will
require that we turn off lockd.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfssvc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ccb59e91011b..7486a6f5fc21 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -340,8 +340,19 @@ static void nfsd_shutdown_generic(void)
 	nfsd_file_cache_shutdown();
 }
 
+/*
+ * Allow admin to disable lockd. This would typically be used to allow (e.g.)
+ * a userspace NLM server of some sort to be used.
+ */
+static bool nfsd_disable_lockd = false;
+module_param(nfsd_disable_lockd, bool, 0644);
+MODULE_PARM_DESC(nfsd_disable_lockd, "Allow lockd to be manually disabled.");
+
 static bool nfsd_needs_lockd(struct nfsd_net *nn)
 {
+	if (nfsd_disable_lockd)
+		return false;
+
 	return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
 }
 
-- 
2.33.1

