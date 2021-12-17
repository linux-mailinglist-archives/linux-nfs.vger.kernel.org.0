Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7627B4796A3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhLQV5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 16:57:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48624 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLQV5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 16:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC72623EA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 21:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FE4C36AE5;
        Fri, 17 Dec 2021 21:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778235;
        bh=Qoe4yenVzXa2m1jsiUD/mTu8Gvks+yzrcxCq6ohZs5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMd6LyLF+88zKv3QMPTq2meLnhDyqv1kXWjvtgq3I1lIDWx4C55+Nt1Q7w2XPnU1W
         O4mHNV8RMfBGVc+XFZuijjKvCcp7Db6/0K8zpGCapkoCAkn2TLn5wQyUWctyk0EEdi
         E4RSMiJw4CEKM/a9qXOVZUPMZidxfRVFau6D6yNZRHNWy4pEbA9X5xt1aCEOSwEGGP
         IEZHKLXptVsxtU3qim9KtFOMiFT605GaIn7O7fYJ5HSiuftYLoQ2v3MJRe0Vmf8k6D
         pKiooRZBHBqZ71YBiwM9DYbpcQAwfMTLhClr53e5Yc1PvTR3ycpgTJU/fUznczp3Nn
         Gf8myaAEkM1lw==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/9] nfsd: NFSv3 should allow zero length writes
Date:   Fri, 17 Dec 2021 16:50:42 -0500
Message-Id: <20211217215046.40316-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217215046.40316-5-trondmy@kernel.org>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
 <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

According to RFC1813: "If count is 0, the WRITE will succeed
and return a count of 0, barring errors due to permissions checking."

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c    | 3 +++
 net/sunrpc/svc.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4d57befdac6e..38fdfcbb079e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -969,6 +969,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
+	if (!*cnt)
+		return nfs_ok;
+
 	if (sb->s_export_op)
 		exp_op_flags = sb->s_export_op->flags;
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a3bbe5ce4570..d1ccf37a4588 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1692,7 +1692,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp, struct page **pages,
 	 * entirely in rq_arg.pages. In this case, @first is empty.
 	 */
 	i = 0;
-	if (first->iov_len) {
+	if (first->iov_len || !total) {
 		vec[i].iov_base = first->iov_base;
 		vec[i].iov_len = min_t(size_t, total, first->iov_len);
 		total -= vec[i].iov_len;
-- 
2.33.1

