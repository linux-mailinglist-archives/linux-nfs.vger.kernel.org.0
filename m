Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728925832F1
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiG0THh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiG0THM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:07:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF565802
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB9D4CE238B
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08D9C433C1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:29 +0000 (UTC)
Subject: [PATCH v2 05/13] NFSD: Reorder the fields in struct nfsd4_op
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:40:28 -0400
Message-ID: <165894722875.11193.2238058528803056154.stgit@manet.1015granger.net>
In-Reply-To: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
References: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
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

Pack the fields to reduce the size of struct nfsd4_op, which is used
an array in struct nfsd4_compoundargs.

sizeof(struct nfsd4_op):
Before: /* size: 672, cachelines: 11, members: 5 */
After:  /* size: 640, cachelines: 10, members: 5 */

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/xdr4.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index f5ad2939e6ee..a36678e3ca0e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -606,8 +606,9 @@ struct nfsd4_copy_notify {
 
 struct nfsd4_op {
 	u32					opnum;
-	const struct nfsd4_operation *		opdesc;
 	__be32					status;
+	const struct nfsd4_operation		*opdesc;
+	struct nfs4_replay			*replay;
 	union nfsd4_op_u {
 		struct nfsd4_access		access;
 		struct nfsd4_close		close;
@@ -671,7 +672,6 @@ struct nfsd4_op {
 		struct nfsd4_listxattrs		listxattrs;
 		struct nfsd4_removexattr	removexattr;
 	} u;
-	struct nfs4_replay *			replay;
 };
 
 bool nfsd4_cache_this_op(struct nfsd4_op *);


