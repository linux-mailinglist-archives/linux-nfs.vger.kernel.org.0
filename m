Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC92479EBB
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhLSBoz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60846 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhLSBoy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 385A260C8A
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434FDC36AE0;
        Sun, 19 Dec 2021 01:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878293;
        bh=2WBd1a/R+kOPNcrOMAPEOIqxzIKowQ0ajdYxNr1LgLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXZmAqp0AMgH7COo/PEHErYpB7BtfJuLEkllsCgl6oGjH/ipR/gThI4Ye7ViapWPf
         2bBPhl9hwXA1TQNff8opamw7eO5s9K5yIUoit3mRnVyebtj0sKwSuY5XIKg3n6lPBL
         U3lg9zqwN07W6tw+TuHkwxu9g9zSXeTwVqlrdgrefth65Wf6WeKTsGuOlkkr0Vk1/b
         nD0ZM6YD51q/ICECe1tfRAVOK43OcLj2i9NMw548IdPWKaC35w5mK4Nwu1HHUTKRdi
         nA+1Hdx1wNB537hI/4pihe85P9EkL7hXOEpy8Wtv7UsDullocCTF0Q8P2ykSRXKuG+
         gayWY19IvyCZg==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 06/10] nfsd: NFSv3 should allow zero length writes
Date:   Sat, 18 Dec 2021 20:37:59 -0500
Message-Id: <20211219013803.324724-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-6-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
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
index eb9818432149..85e579aa6944 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -967,6 +967,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
+	if (!*cnt)
+		return nfs_ok;
+
 	if (sb->s_export_op)
 		exp_op_flags = sb->s_export_op->flags;
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4292278a9552..72a7822fd257 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1638,7 +1638,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
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

