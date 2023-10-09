Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4547BE94E
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377537AbjJISa0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377449AbjJISa0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0282EA3
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BF6C433CA;
        Mon,  9 Oct 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876224;
        bh=5iC+2HNgN2+O5g1Z94x1u1c8//DN+WsNkBXkSLynrY4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JEzuhzJEKaqV4fhmiJBB84Z7+3LGppwLOziZ3wDZ/iINGjUcUC0u+Z4HydTcAUwOD
         3SsVDhkONSN1qHYPYjycJPofdVNLWE1MZLljfDLchld4S+1liYu0lwOkRBy5/MoypQ
         2Cg6naQi4kSL+eZ4WQF+x4I042G42tsf/ytWRV1eVl77OQpoC8U7lLLS6iQCGOrBhe
         Nroc0psKVgUamCCgoA2zb13aL2Q11L21xz4lcTlp/I+dFs/LqqGq4BcRTC3r1CxtTl
         /yaATS6eqiiPLjXYTEdT+/bvPGb02i9sgpvbKnAMltQAm8k/rJEZ5smMEFjNwIf6fT
         U/eiynsYXzcew==
Subject: [PATCH v1 7/8] NFSD: Clean up nfsd4_encode_offset_status()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:30:23 -0400
Message-ID: <169687622307.41382.10145666042189280480.stgit@oracle-102.nfsv4bat.org>
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

Use modern XDR encoder utilities.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fdb7dafa7f27..c87e7c5de592 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5185,14 +5185,15 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_offload_status *os = &u->offload_status;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 8 + 4);
-	if (!p)
+	/* osr_count */
+	nfserr = nfsd4_encode_length4(xdr, os->count);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* osr_complete<1> */
+	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
 		return nfserr_resource;
-	p = xdr_encode_hyper(p, os->count);
-	*p++ = cpu_to_be32(0);
-	return nfserr;
+	return nfs_ok;
 }
 
 static __be32


