Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A957E7FD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiGVUJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiGVUIw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:08:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88950B505A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E86ECCE2B0A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD95C341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:08:40 +0000 (UTC)
Subject: [PATCH v1 1/8] NFSD: Optimize nfsd4_encode_operation()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:08:38 -0400
Message-ID: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

write_bytes_to_xdr_buf() is a generic way to place a variable-length
data item in an already-reserved spot in the encoding buffer.
However, it is costly, and here, it is unnecessary because the
data item is fixed in size, the buffer destination address is
always word-aligned, and the destination location is already in
@p.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2acea7792bb2..b52ea7d8313a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5373,8 +5373,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 						so->so_replay.rp_buf, len);
 	}
 status:
-	/* Note that op->status is already in network byte order: */
-	write_bytes_to_xdr_buf(xdr->buf, post_err_offset - 4, &op->status, 4);
+	*p = op->status;
 }
 
 /* 


