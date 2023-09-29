Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A287B3417
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjI2N7f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2N7f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:59:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58D1AA
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 06:59:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C068C433C8;
        Fri, 29 Sep 2023 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995972;
        bh=NJp3dAaM03Cr5ke8bbeyFNzuK+FgYsXTuo57muJ6o/s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jQieTRjm/21dXtHVCY6VUYv1pjDbS9fia+C3THo6jtPwqZQpq0H/AZ4RZ8LP+CzA9
         0LjIdwiWVh3yH0JILre7CSoizMGLQRLTGGRceivILY4T/NKPp3cou7u+/qC5J7Sb59
         4vKkqZJXKt3zb1NdEbvyYz2bC8SBvRG3tVtoXJpGee7uhnRsD8Udgt/EwARpmv0Nh1
         CaXBhkFQxLqooc5fwrRbkI5xMr3bp3BpzTIz4FJdPasZKsUfvGqsqGba+k4XK75Hw6
         0VAuLyrqiQDHJiQt2hpXjK4qd8zk0APtVFEa00FER9g+oWNEbsmWa9si3NPbrC/kwl
         qkxUZmlwWuZdw==
Subject: [PATCH v1 7/7] NFSD: Clean up nfsd4_encode_open()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 09:59:31 -0400
Message-ID: <169599597122.5622.10402091945865573518.stgit@manet.1015granger.net>
In-Reply-To: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Finish cleaning up nfsd4_encode_open().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f37c370ceded..143efc24551d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4208,20 +4208,23 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_open *open = &u->open;
 	struct xdr_stream *xdr = resp->xdr;
 
+	/* stateid */
 	nfserr = nfsd4_encode_stateid4(xdr, &open->op_stateid);
-	if (nfserr)
+	if (nfserr != nfs_ok)
 		return nfserr;
+	/* cinfo */
 	nfserr = nfsd4_encode_change_info4(xdr, &open->op_cinfo);
-	if (nfserr)
+	if (nfserr != nfs_ok)
 		return nfserr;
-	if (xdr_stream_encode_u32(xdr, open->op_rflags) < 0)
-		return nfserr_resource;
-
+	/* rflags */
+	nfserr = nfsd4_encode_uint32_t(xdr, open->op_rflags);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* attrset */
 	nfserr = nfsd4_encode_bitmap4(xdr, open->op_bmval[0],
 				      open->op_bmval[1], open->op_bmval[2]);
-	if (nfserr)
+	if (nfserr != nfs_ok)
 		return nfserr;
-
 	/* delegation */
 	return nfsd4_encode_open_delegation4(xdr, open);
 }


