Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3C6F7765
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjEDUtJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjEDUsj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:48:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B2A9EEE
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 355C3639FA
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B097EC4339B;
        Thu,  4 May 2023 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233236;
        bh=rGnQAPW0hli7YcR9MsR+dC1QlJ2Z2SQwhGPkYv86Ef4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cDlMs4VBPhWf2n81c7BLRDZOUFS0n+lMjROZtsO2fpa5Se5HMjUndlgno5j0uLCJ7
         Y8v+LOPciJFGQl9RqkEjycvv1eDf1LxaUdieUcEnYOPp0xlkr6OEs3QdLfENjOnq1V
         Gn3BLHR/Uitz24zU/QTZmAqFV2ZU0iCgrxctN3UnE+3+oTpYiTSb1Ja5mD0yhZmfa5
         7HxIgmHazdkkXHZFUX+MVC1FimEIFhavyOIYlrrsdR6d8OrCLqRqpvrXqZ7XhKIcEi
         LDwE5M9PJmT6ncHEQRdqJY54MQA37kA/R2wkq5l0f5hKZPO6SyYSpqkmp9XpYjMxHO
         /TNodq/RYs/pw==
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 04 May 2023 16:47:14 -0400
Subject: [PATCH 4/6] NFSv4.2: Clean up nfs4_xdr_dec_*xattr() functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-xattr-ctime-v1-4-ac3fc5a00942@Netapp.com>
References: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
In-Reply-To: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771;
 i=Anna.Schumaker@Netapp.com; h=from:subject:message-id;
 bh=tg/4V4l4h13B2lvBoryqNit4MB6JNorpHtTPJFUz8q8=;
 b=owEBbQKS/ZANAwAIAdfLVL+wpUDrAcsmYgBkVBnRLbmwD8Kfp9VYg0TkbluV7cdi0Js2t3DXf
 zsCE2vXxBKJAjMEAAEIAB0WIQSdnkxBOlHtwtTsoSnXy1S/sKVA6wUCZFQZ0QAKCRDXy1S/sKVA
 6/XsD/4zLFIjGupT4jogMmnSt4jzZVf0n3NM01pKwDkvmFiEjo8wptwdyKDdfAzd0PC6alIlNru
 I9tBxk5iYoZzOKBVtNYo2JJ7ekaeNltLMaEgnxwOohVC2XWJvmXE74aAJGTrcxBZVdNbWHQkzfq
 U2PBDo22c6Aq33438Dzoy94fD50Kj85nGtJWlH9wobip9i+VVAc77pmGCkYWt45RZim+fnPgw4m
 G9sRPqr5VkBJYfhdm9ibaOBSEALhnhvTStPFl8GyDls8AFts8TMRYEV0QNWlY19H74MIVLowbJ/
 S/jnyAJluZaaHmXhHPyI5Smfyc39HqpBI1sQ9wq00y17nbdRbfOQjpsEo3ccX/mDW7dQ4cB/0BO
 m6uBJTmoCO7oPIdkEXoPqSRCJHW/NA46j2DPYWFHTfi27keJr81NdA+deWm/GJ06YGdVSLLtwvL
 2kwONfTKOBj0L/HRDa0ggVirhdhbAHnCZMJEB4zyZwGiMokOPaojMnC4NLve4z0MToA7uE45jac
 N6kZfgW1TY1WjvlMQxJy62YJ5IyFyjb+h24LaLvUFk4/0xRvJDIh6ERYLvc6kJ+ptZ+AkkVaGEW
 l498hNypk/cVosg5r78oz4g8lIc994t3cNNapz1LjW9JqKaOcbSHDah3FsPr/mXV8dyH14G3TGl
 dd10PN2XIg9QSPA==
X-Developer-Key: i=Anna.Schumaker@Netapp.com; a=openpgp;
 fpr=9D9E4C413A51EDC2D4ECA129D7CB54BFB0A540EB
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I add commends above each function to match the style of the other
nfs4_xdr_dec_*() functions. I also remove the unnecessary #ifdef
CONFIG_NFS_V4_2 that was added around this code, since we are already in
a v4.2-only file.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 51560c7d468d..1d74135715c5 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1562,7 +1562,9 @@ static int nfs4_xdr_dec_layouterror(struct rpc_rqst *rqstp,
 	return status;
 }
 
-#ifdef CONFIG_NFS_V4_2
+/*
+ * Decode SETXATTR request
+ */
 static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 				 void *data)
 {
@@ -1585,6 +1587,9 @@ static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	return status;
 }
 
+/*
+ * Decode GETXATTR request
+ */
 static int nfs4_xdr_dec_getxattr(struct rpc_rqst *rqstp,
 				 struct xdr_stream *xdr, void *data)
 {
@@ -1606,6 +1611,9 @@ static int nfs4_xdr_dec_getxattr(struct rpc_rqst *rqstp,
 	return status;
 }
 
+/*
+ * Decode LISTXATTR request
+ */
 static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 				   struct xdr_stream *xdr, void *data)
 {
@@ -1629,6 +1637,9 @@ static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 	return status;
 }
 
+/*
+ * Decode REMOVEXATTR request
+ */
 static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
 				    struct xdr_stream *xdr, void *data)
 {
@@ -1650,5 +1661,4 @@ static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
 out:
 	return status;
 }
-#endif
 #endif /* __LINUX_FS_NFS_NFS4_2XDR_H */

-- 
2.40.1

