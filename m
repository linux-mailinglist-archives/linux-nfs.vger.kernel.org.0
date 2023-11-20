Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22B7F0A4A
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 02:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKTBRT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 20:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTBRT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 20:17:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1DD107
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 17:17:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21396C433C8;
        Mon, 20 Nov 2023 01:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700443032;
        bh=Nx49sN8FqQm27Tfby83rI2t+pYBeM74/Q4HQ6/nyn0o=;
        h=Subject:From:To:Cc:Date:From;
        b=s5ScbHa/Et7CcQRAww0Q+HXQADfDKvcax08FRY0G5K/0SZ6M4R111G5IEvo/jTr1g
         YMarLn5zJE1FlSO9f+7Rrrzmrfd30rBiNVYw5646mJzfCUJTG5Nv5Cn9WxdgXVm6in
         YI/+lZlEN5Anx0xO7C2v0ejMZeKYnYfGbk5wH6yTyYMtJ2ZV7ksLim05v+v7NsgLey
         qDpLN8XFiPBNrxj1QooL8CoZYEKFM+Rfg1+asW0X4S40FOT8+Gxzd4zIN05Zo+nD01
         o27Zec3rG+T6oy39zD+Xn+G6BVNmMPxnzepvm9l18swUDjtJRhrqVS4d1z8BBLMV8C
         YUv2kFtSJsNSg==
Subject: [PATCH v1] NFSD: Document lack of f_pos_lock in nfsd_readdir()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Date:   Sun, 19 Nov 2023 20:17:11 -0500
Message-ID: <170044303100.5164.767231155248883501.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Al Viro notes that normal system calls hold f_pos_lock when calling
->iterate_shared and ->llseek; however nfsd_readdir() does not take
that mutex when calling these methods.

It should be safe however because the struct file acquired by
nfsd_readdir() is not visible to other threads.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..87a5953c6bf0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2109,9 +2109,23 @@ static __be32 nfsd_buffered_readdir(struct file *file, struct svc_fh *fhp,
 	return cdp->err;
 }
 
-/*
- * Read entries from a directory.
- * The  NFSv3/4 verifier we ignore for now.
+/**
+ * nfsd_readdir - Read entries from a directory
+ * @rqstp: RPC transaction context
+ * @fhp: NFS file handle of directory to be read
+ * @offsetp: OUT: seek offset of final entry that was read
+ * @cdp: OUT: an eof error value
+ * @func: entry filler actor
+ *
+ * This implementation ignores the NFSv3/4 verifier cookie.
+ *
+ * NB: normal system calls hold file->f_pos_lock when calling
+ * ->iterate_shared and ->llseek, but nfsd_readdir() does not.
+ * Because the struct file acquired here is not visible to other
+ * threads, it's internal state does not need mutex protection.
+ *
+ * Returns nfs_ok on success, otherwise an nfsstat code is
+ * returned.
  */
 __be32
 nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp, 


