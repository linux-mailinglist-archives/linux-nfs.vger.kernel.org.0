Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F875A9EF7
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiIASdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiIASdq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 14:33:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A594E7E03E
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 11:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E2B9B81BDF
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 18:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AE3C433D6;
        Thu,  1 Sep 2022 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662057223;
        bh=i62gzEvAtL5qBJpUXgIhWpR6R0f2mKcaU3mjEPTnT8c=;
        h=From:To:Cc:Subject:Date:From;
        b=EeRjhs9FJ0ez+xt7VnapDeIy8BydGK74nwzAZMmH52oU14OX6MRP848tep9xeCGmD
         VZQ4VJT8fSkl7D1jDKHBQY0KnFbipJbNE1MgCqgOT3JIfeIsiMqCj22NHVUyC+aytc
         OkdVydR+ARQO5lGRO/cdDxaozKfDQu1AjG5yj4ONEcJcH3kH7NSIJKt6UxZzCIeD1S
         khkJJKYlecSnKcgHhSG8JU/XaR5uayN1k5H+1rZK2a3Uoj1a39gqBOGmYGbNDD7qCq
         yHTDPhUtE6pEY/pwcu0fLAwpgT5mDYNiaFYusYExubWDeEzMPVdUDY12ToswsdjbEb
         wZX8oqI7BibOg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH 0/1] NFSD: Simplify READ_PLUS
Date:   Thu,  1 Sep 2022 14:33:40 -0400
Message-Id: <20220901183341.1543827-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

When we left off with READ_PLUS, Chuck had suggested reverting the
server to reply with a single NFS4_CONTENT_DATA segment essentially
mimicing how the READ operation behaves. Then, a future sparse read
function can be added and the server modified to support it without
needing to rip out the old READ_PLUS code at the same time.

This patch takes that first step. I was even able to re-use the
nfsd4_encode_readv() function to remove some duplicate code.

Chuck, I tried to add in sparse read support by adding this extra
change. Unfortunately it leads to a bunch of new failing xfstests. Do
you have any thoughts about what might be going on? Is the patch okay
without the splice support?

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index adbff7737c14..e21e6cfd1c6d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4733,6 +4733,7 @@ static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read)
 {
+	bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
 	unsigned long maxcount;
 	struct xdr_stream *xdr = resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
@@ -4747,7 +4748,10 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	maxcount = min_t(unsigned long, read->rd_length,
 			 (xdr->buf->buflen - xdr->buf->len));
 
-	nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+	if (file->f_op->splice_read && splice_ok)
+		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
+	else
+		nfserr = nfsd4_encode_readv(resp, read, file, maxcount)
 	if (nfserr)
 		return nfserr;
 

Thanks,
Anna


Anna Schumaker (1):
  NFSD: Simplify READ_PLUS

 fs/nfsd/nfs4xdr.c | 122 ++++++++--------------------------------------
 1 file changed, 20 insertions(+), 102 deletions(-)

-- 
2.37.2

