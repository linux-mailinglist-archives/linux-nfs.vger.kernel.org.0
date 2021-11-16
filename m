Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38D453562
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhKPPOV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 10:14:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238339AbhKPPNd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Nov 2021 10:13:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA30661BFA
        for <linux-nfs@vger.kernel.org>; Tue, 16 Nov 2021 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637075436;
        bh=s6kdTs693QBPR7CR47rmgMc3/nf2qYg35ARjLCGJN1I=;
        h=From:To:Subject:Date:From;
        b=ta6RtWSiio2c/XFRf5tpocrtU8ovX+2Ec63UJv0KEwtaBsYzGTDnJ8Y1L81BFAaKw
         FLsUd7YLX+9NcAhtfSGDcvGtsMKg5j+F4qc0ruajupExwkxnDnytmr2VvNlEcfMONf
         lTfaD4cUkXoZCz8Cye+NimxGZtFdzuiY1Q7SySvF2CLg4vQ6oh1RJ2j0jMqTOayMzf
         aOycWVdVBKgdjUrIkXg+JLCap88h8gVnTuMZgPqeqjLPZLbtzzyAeQ7/1IE40K7jWf
         aOeixvJNahj302nNGepZ+9PTXOLk4daNv/ljU/2v47XXBJOYeIlTJjHgIRb2ecvR1Z
         JVnX57HFgKskw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv42: Don't fail clone() unless the OP_CLONE operation failed
Date:   Tue, 16 Nov 2021 10:03:48 -0500
Message-Id: <20211116150348.9224-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The failure to retrieve post-op attributes has no bearing on whether or
not the clone operation itself was successful. We must therefore ignore
the return value of decode_getfattr() when looking at the success or
failure of nfs4_xdr_dec_clone().

Fixes: 36022770de6c ("nfs42: add CLONE xdr functions")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index c8bad735e4c1..271e5f92ed01 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1434,8 +1434,7 @@ static int nfs4_xdr_dec_clone(struct rpc_rqst *rqstp,
 	status = decode_clone(xdr);
 	if (status)
 		goto out;
-	status = decode_getfattr(xdr, res->dst_fattr, res->server);
-
+	decode_getfattr(xdr, res->dst_fattr, res->server);
 out:
 	res->rpc_status = status;
 	return status;
-- 
2.33.1

