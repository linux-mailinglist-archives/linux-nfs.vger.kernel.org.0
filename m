Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D917BE946
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbjJIS3r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376869AbjJIS3q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:29:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27536B4
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:29:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A62FC433C8;
        Mon,  9 Oct 2023 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876184;
        bh=6nTLJHx2/14yKGDUldzyFSRiFJm32DyRgvE2BstkfHQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LsMwdsD3HfSH3riuWeNtpvT7qSPE7IoJhMjA/zvq+r7JYbam+IOlbXTnVNnObMsDp
         wwfNBneuZuSfYvPJ81/w7eLh30QHaWVA869mhZ62p+/SOw5wLUbMaGIh3vU9P+XOIX
         BpK6kjSFQt3VY/1U5zaFs85veMpcOhx4Km8RnJydkMJn+rUinjzYBKQNuc4KSFCb/Q
         RSGBYi2wfCjY7OSiScqT+cCaxDlASaM/44X/9zdd4NiTOj9c+B+OKXur+O4ein+1hi
         oFQRUZRRkWbqi2SPySHO07V60cvar7efksUuImsz7Z6RVcObi+bDvybyTUl0Mdi3ah
         9jU8snIawvVbw==
Subject: [PATCH v1 1/8] NFSD: Clean up nfsd4_encode_access()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:29:43 -0400
Message-ID: <169687618325.41382.10496558152702883607.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
References: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Convert nfsd4_encode_access() to use modern XDR utility functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5efcd9691e5d..12a1254c5f54 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3904,14 +3904,14 @@ nfsd4_encode_access(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_access *access = &u->access;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
+	__be32 status;
 
-	p = xdr_reserve_space(xdr, 8);
-	if (!p)
-		return nfserr_resource;
-	*p++ = cpu_to_be32(access->ac_supported);
-	*p++ = cpu_to_be32(access->ac_resp_access);
-	return 0;
+	/* supported */
+	status = nfsd4_encode_uint32_t(xdr, access->ac_supported);
+	if (status != nfs_ok)
+		return status;
+	/* access */
+	return nfsd4_encode_uint32_t(xdr, access->ac_resp_access);
 }
 
 static __be32 nfsd4_encode_bind_conn_to_session(struct nfsd4_compoundres *resp, __be32 nfserr,


