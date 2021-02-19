Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5231F3BC
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 03:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhBSCCw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 21:02:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhBSCCu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Feb 2021 21:02:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2057264ECE;
        Fri, 19 Feb 2021 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613700129;
        bh=rFzCJv/pLnn+cuO8qy59fVvDhgWGkUCpF+7TPf9SEAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Dob8vwsDyJBOJvn/uJ0l9lw4GUQI3lwyOATR8i/DawC4f/FwwarI4HejB71ODwui/
         YeoIVkzYsJ/AfyiiTey2j7e/g5pDuZSwIEhBV7UB0CuKOCxpGpO8Ej8DFse3Ftb039
         +fr61qiAfcrIaFvWaYzY48XwZlsngaOPO3WQXdysWH+tQcjOWQdRnOOV7E1zb532H7
         QZg2nMI3mwUVaa1KAjsIbgrVtaNPa+hdQ9WQrnofMeQW7XHI5IRwTDTCn616DKE52Z
         q3cN7Au2OcqkLfXhMcGkg0R8mD+J51uhkFGfpEmO+r2B8QeYIV4O0+9kv7bsjMSMll
         6eIkZVA8oMVwQ==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Don't keep looking up unhashed files in the nfsd file cache
Date:   Thu, 18 Feb 2021 21:02:07 -0500
Message-Id: <20210219020207.688592-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a file is unhashed, then we're going to reject it anyway and retry,
so make sure we skip it when we're doing the RCU lockless lookup.
This avoids a number of unnecessary nfserr_jukebox returns from
nfsd_file_acquire()

Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 53fcbf79bdca..7629248fdd53 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -898,6 +898,8 @@ nfsd_file_find_locked(struct inode *inode, unsigned int may_flags,
 			continue;
 		if (!nfsd_match_cred(nf->nf_cred, current_cred()))
 			continue;
+		if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
+			continue;
 		if (nfsd_file_get(nf) != NULL)
 			return nf;
 	}
-- 
2.29.2

