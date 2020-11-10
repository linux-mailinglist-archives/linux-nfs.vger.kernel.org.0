Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0A2AE40E
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgKJX3X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:29:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbgKJX3X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:29:23 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52558207BB
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050962;
        bh=qCUYhO5IYxLZUSYwh2QuIZ1ptTiACbnbUeP/URbieX4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lHFNosMylRkalx/Xtj5z+1UFB2ASBsA1jRcjAnxHcjUurJ3udO9p6SZBUIn1/Z0aA
         FJH/Q3JYYiIiWV1ZP6s9AL2TN/tzV7FWyv+L0ZFp6CATjHiUSApSFqFqC4N+43rQ1y
         kCxNG7+PCqmcivawbPGV5ab5CT3iWFuzB/qd5vT0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 06/11] NFSv4/pNFS: Use connections to a DS that are all of the same protocol family
Date:   Tue, 10 Nov 2020 18:19:01 -0500
Message-Id: <20201110231906.863446-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110231906.863446-6-trondmy@kernel.org>
References: <20201110231906.863446-1-trondmy@kernel.org>
 <20201110231906.863446-2-trondmy@kernel.org>
 <20201110231906.863446-3-trondmy@kernel.org>
 <20201110231906.863446-4-trondmy@kernel.org>
 <20201110231906.863446-5-trondmy@kernel.org>
 <20201110231906.863446-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the pNFS metadata server advertises multiple addresses for the same
data server, we should try to connect to just one protocol family and
transport type on the assumption that homogeneity will improve performance.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 679767ac258d..7027dac41cc7 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -860,6 +860,9 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 				.addrlen = da->da_addrlen,
 				.servername = clp->cl_hostname,
 			};
+
+			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
+				continue;
 			/* Add this address as an alias */
 			rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
 					rpc_clnt_test_and_add_xprt, NULL);
@@ -920,6 +923,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
+			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
+				continue;
 			/**
 			* Test this address for session trunking and
 			* add as an alias
-- 
2.28.0

