Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5D479EC1
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhLSBo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhLSBo5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFDC5B80B34
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B92AC36AE9;
        Sun, 19 Dec 2021 01:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878295;
        bh=NFPiGcI5+jhgO7Yw7iIAoTjRnRVhh56UZHrfSFk0oVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcyCinINkHqq8ffam4HxB6MV13VKFdLXsk5dKKgcgtRfRJRwFSvZaQUZr5p3TKzFN
         OI6JIiwnxMS2ud92ePr2jxGn8xHo54RNecMks5wc5H+DBcnUP0MvFn2lJvQKUa2QaP
         5mhpXdXesNT9W+Xq+js4StCvJ9zK+7Hfsr90VKUmbtVUe18RWlJhebGXHczwGVXmYP
         8gdNttCnF85P7gVjdjuitzm7ylynSH1Z3KCnXN7JwUmuRLWX6MESeFJIuYap8Gll0C
         bka35qnR3GjzQivlj4N1Wwcf1PGm6WdZcZFHAhvtII8Vcl3BnUrbk6HVm8Pbs+9rLa
         Ea0QsbvnFlx+w==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/10] nfsd: allow lockd to be forcibly disabled
Date:   Sat, 18 Dec 2021 20:38:02 -0500
Message-Id: <20211219013803.324724-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-9-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
 <20211219013803.324724-9-trondmy@kernel.org>
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
index 80431921e5d7..6815c70b06af 100644
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

