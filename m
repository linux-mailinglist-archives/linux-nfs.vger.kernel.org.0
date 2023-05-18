Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2C7708726
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjERRqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjERRqQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 13:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4AE10D9
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 10:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F03065159
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 17:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E3EC433D2;
        Thu, 18 May 2023 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431970;
        bh=+UOLD0NJ5wRDTmjdvrWiiMCQm1uRuyCjI8JQo6Kni1I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iPVoAqPaGnKZJha4KLuY1cAuizayiDdrZzEa6fMpp1HgsfS+HYmYCy3Va5u6NLJQs
         2+OAuNY4T8qDqReAus7epa21MUT6qeAu2KqzKIwxZyafJw/A3q8UJ9c6015Uc6KG60
         yK1pp14OUYpU6eEQlYJtOmaosrcmyl6RV6e7BtoHBncTr27K5vqxWiox7IGTEX913e
         kyC7aTl/yw2yWL5uHIP/pR9gXJuWsEMCdKgD2w9BZ7nK8HMNScfjOTWeNUTJxcjXlJ
         y3L0c5fDT82kqKZPQEifZZDA7TTeoX/Fnb+uP47FTk/1qbxLAXqKw6I423ZQcmS7VF
         IqFv6S0X1Ee9Q==
Subject: [PATCH v1 6/6] NFSD: Remove nfsd_readv()
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, dhowells@redhat.com, jlayton@redhat.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 18 May 2023 13:46:09 -0400
Message-ID: <168443196963.516083.11442184693179163969.stgit@klimt.1015granger.net>
In-Reply-To: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
References: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

nfsd_readv()'s consumers now use nfsd_iter_read().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   15 ---------------
 fs/nfsd/vfs.h |    5 -----
 2 files changed, 20 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 13ccd385b308..1053c81f82f1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1024,21 +1024,6 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
-__be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  struct file *file, loff_t offset,
-		  struct kvec *vec, int vlen, unsigned long *count,
-		  u32 *eof)
-{
-	struct iov_iter iter;
-	loff_t ppos = offset;
-	ssize_t host_err;
-
-	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, ITER_DEST, vec, vlen, *count);
-	host_err = vfs_iter_read(file, &iter, &ppos, 0);
-	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
-}
-
 /**
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 6381a2890b0b..a6890ea7b765 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -110,11 +110,6 @@ __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count,
 				u32 *eof);
-__be32		nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				struct file *file, loff_t offset,
-				struct kvec *vec, int vlen,
-				unsigned long *count,
-				u32 *eof);
 __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count, unsigned int base,


