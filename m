Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE37B0AF4
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjI0RQv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjI0RQu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 13:16:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92EB4
        for <linux-nfs@vger.kernel.org>; Wed, 27 Sep 2023 10:16:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C6CC433C7;
        Wed, 27 Sep 2023 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695835009;
        bh=g2AtvgnV8fSfeYbG23MPY16mH/NIr+YR5s+GRQs1coA=;
        h=Subject:From:To:Cc:Date:From;
        b=sWNIHh8HNIpyuhA1xfbIYBsLEZ7VAI+Z9dnnfybVqsH/3I6Z0XtJbVFXUfRiyEVzY
         T8i5VnQDIT1Xapxp/rn3vZUz6jUEEg81gxNLcfeAOtbCca/HIaBTEryqKWCoYQvAfS
         uuVVMGYOyhEHCT+s8OY5AZPvWcMhfkvryIhnJntSSzX6+FC21P6cLpiif0fRzhL5fT
         3CsUCzPYTRpAIdIOP81BvpAKEu3DfQ+YNxRbIfcSqVjDm863JIlRXt6AIOxjqdgbfY
         B/IxBNqmYXAIV34yxZO/G5LV6zvrItHOAXxdwmf+BHJYWM9j6TAnIddzfQCVGfUzUa
         xtUz15lKS8Ztw==
Subject: [PATCH v1] NFSD: Fix zero NFSv4 READ results when RQ_SPLICE_OK is not
 set
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     =?utf-8?q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>, grawity@gmail.com
Date:   Wed, 27 Sep 2023 13:16:48 -0400
Message-ID: <169583500802.5201.6400721981172612933.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_encode_readv() uses xdr->buf->page_len as a starting point for
the nfsd_iter_read() sink buffer -- page_len is going to be offset
by the parts of the COMPOUND that have already been encoded into
xdr->buf->pages.

However, that value must be captured /before/
xdr_reserve_space_vec() advances page_len by the expected size of
the read payload. Otherwise, the whole front part of the first
page of the payload in the reply will be uninitialized.

Mantas hit this because sec=krb5i forces RQ_SPLICE_OK off, which
invokes the readv part of the nfsd4_encode_read() path. Also,
older Linux NFS clients appear to send shorter READ requests
for files smaller than a page, whereas newer clients just send
page-sized requests and let the server send as many bytes as
are in the file.

Reported-by: Mantas Mikulėnas <grawity@gmail.com>
Closes: https://lore.kernel.org/linux-nfs/f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com/
Fixes: 703d75215555 ("NFSD: Hoist rq_vec preparation into nfsd_read() [step two]")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2e40c74d2f72..92c7dde148a4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4113,6 +4113,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct file *file, unsigned long maxcount)
 {
 	struct xdr_stream *xdr = resp->xdr;
+	unsigned int base = xdr->buf->page_len & ~PAGE_MASK;
 	unsigned int starting_len = xdr->buf->len;
 	__be32 zero = xdr_zero;
 	__be32 nfserr;
@@ -4121,8 +4122,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr_resource;
 
 	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
-				read->rd_offset, &maxcount,
-				xdr->buf->page_len & ~PAGE_MASK,
+				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
 	read->rd_length = maxcount;
 	if (nfserr)


